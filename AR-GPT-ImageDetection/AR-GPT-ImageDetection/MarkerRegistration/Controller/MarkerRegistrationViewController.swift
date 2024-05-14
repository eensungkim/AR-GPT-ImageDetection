//
//  MarkerRegistrationViewController.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/16/24.
//

import PhotosUI
import UIKit

/// 마커등록뷰컨트롤러
final class MarkerRegistrationViewController: UIViewController {
    
    // MARK: - Properties
    private let markerImageManager: MarkerImageManageable
    weak var delegate: MarkerImageCollectionViewControllerDelegate?
    private var markerImage: MarkerImage?
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let markerImageView: UIImageView = {
        let configuration = UIImage.SymbolConfiguration(pointSize: 1024, weight: .light, scale: .large)
        let skeletonImage = UIImage(systemName: "photo", withConfiguration: configuration)
        let imageView = UIImageView(image: skeletonImage)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let buttonStackView: UIStackView = {
        let buttonStackView = UIStackView()
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 20
        buttonStackView.distribution = .fillEqually
        return buttonStackView
    }()
    
    private let photoLibraryButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "사진 등록"
        let photoLibraryButton = UIButton(configuration: configuration)
        photoLibraryButton.addTarget(target, action: #selector(tapPhotoLibraryButton), for: .touchUpInside)
        return photoLibraryButton
    }()
    
    private let cameraButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "직접 촬영"
        let cameraButton = UIButton(configuration: configuration)
        cameraButton.addTarget(target, action: #selector(tapCameraButton), for: .touchUpInside)
        return cameraButton
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    private let nameView: InputFieldView = {
        let nameView = InputFieldView(text: "타이틀")
        nameView.textField.placeholder = "두 글자 이상 입력해 주세요."
        return nameView
    }()
    private let descriptionView = InputFieldView(text: "이미지 정의")
    private let additionalInformationView = InputFieldView(text: "이미지 설명")
    
    private let addButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "등록"
        configuration.baseForegroundColor = .systemGray2
        configuration.buttonSize = .large
        let addButton = UIButton(configuration: configuration)
        addButton.addTarget(target, action: #selector(tapAddButton), for: .touchUpInside)
        return addButton
    }()
    
    // MARK: - Life Cycle
    init(markerImageManager: MarkerImageManageable, markerImage: MarkerImage? = nil) {
        self.markerImageManager = markerImageManager
        self.markerImage = markerImage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setupKeyboardObservers()
        initializeHideKeyboard()
        setTextFieldDelegate()
        toggleAddButton()
    }
}

// MARK: - @objc Methods
extension MarkerRegistrationViewController {
    @objc private func showKeyboard() {
        scrollView.scrollRectToVisible(addButton.frame, animated: true)
    }
    
    @objc private func dismissKeyboard() {
        contentView.endEditing(true)
    }
    
    @objc private func tapPhotoLibraryButton() {
        presentPickerViewController()
    }
    
    @objc private func tapCameraButton() {
        presentMarkerImageCaptureViewController()
    }
    
    @objc private func tapAddButton() {
        saveMarkerImage()
        self.dismiss(animated: true)
    }
}

// MARK: - Configuration
extension MarkerRegistrationViewController {
    private func initializeHideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        contentView.addGestureRecognizer(tap)
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
}

// MARK: - Methods
extension MarkerRegistrationViewController {
    private func toggleAddButton() {
        guard
            let isNameValid = nameView.textField.text?.isEmpty,
            let isImageValid = markerImageView.image?.isSymbolImage
        else {
            addButton.isEnabled = false
            return
        }
        
        addButton.isEnabled = !isNameValid && !isImageValid
    }
    
    func setFields(_ markerImage: MarkerImage) {
        do {
            guard let image = UIImage(data: markerImage.data) else {
                throw ImageError.conversionFailure
            }
            markerImageView.image = image
            nameView.textField.text = markerImage.name
            descriptionView.textField.text = markerImage.information
            additionalInformationView.textField.text = markerImage.additionalInformation
        } catch {
            makeAlert(message: error.localizedDescription, confirmAction: nil)
        }
    }
    
    private func saveMarkerImage() {
        guard
            let name = nameView.textField.text,
            let image = markerImageView.image,
            let imageData = image.pngData(),
            let information = descriptionView.textField.text,
            let additionalInformation = additionalInformationView.textField.text
        else { return }
        
        if markerImage != nil {
            markerImage?.update(
                name: name,
                data: imageData,
                information: information,
                additionalInformation: additionalInformation
            )
            guard let marker = markerImage else { return }
            markerImageManager.update(with: marker)
        } else {
            let markerImage = MarkerImage(
                id: UUID(),
                name: name,
                data: imageData,
                information: information,
                additionalInformation: additionalInformation
            )
            _ = MarkerImageMO(markerImage: markerImage, context: markerImageManager.persistentContainer.viewContext)
        }
        markerImageManager.save()
        delegate?.reloadMarkerImages()
    }
}

// MARK: - UI
extension MarkerRegistrationViewController {
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        buttonStackView.addArrangedSubview(photoLibraryButton)
        buttonStackView.addArrangedSubview(cameraButton)
        
        stackView.addArrangedSubview(nameView)
        stackView.addArrangedSubview(descriptionView)
        stackView.addArrangedSubview(additionalInformationView)
        
        contentView.addSubview(markerImageView)
        contentView.addSubview(buttonStackView)
        contentView.addSubview(stackView)
        contentView.addSubview(addButton)
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        markerImageView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            markerImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            markerImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            markerImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            markerImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.618)
        ])
        
        NSLayoutConstraint.activate([
            buttonStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonStackView.topAnchor.constraint(equalTo: markerImageView.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.85),
        ])
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30),
            addButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            addButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.23),
            addButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
}

// MARK: - UITextFieldDelegate
extension MarkerRegistrationViewController: UITextFieldDelegate {
    private func setTextFieldDelegate() {
        nameView.textField.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        toggleAddButton()
        return true
    }
}

// MARK: - PHPickerViewControllerDelegate
extension MarkerRegistrationViewController: PHPickerViewControllerDelegate {
    private func presentPickerViewController() {
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        configuration.filter = .images
        let pickerViewController = PHPickerViewController(configuration: configuration)
        pickerViewController.delegate = self
        present(pickerViewController, animated: true)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        if let itemProvider = results.first?.itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                DispatchQueue.main.async {
                    guard let selectedImage = image as? UIImage else { return }
                    self?.markerImageView.image = selectedImage
                }
            }
        }
        
        picker.dismiss(animated: true)
    }
}

// MARK: - MarkerRegistrationViewControllerDelegate
protocol MarkerRegistrationViewControllerDelegate: AnyObject {
    func setImage(_ image: UIImage)
}

extension MarkerRegistrationViewController: MarkerRegistrationViewControllerDelegate {
    func setImage(_ image: UIImage) {
        markerImageView.image = image
    }
}

extension MarkerRegistrationViewController {
    private func presentMarkerImageCaptureViewController() {
        let markerImageCaptureViewController = MarkerImageCaptureViewController()
        markerImageCaptureViewController.delegate = self
        markerImageCaptureViewController.modalPresentationStyle = .fullScreen
        present(markerImageCaptureViewController, animated: true)
    }
}
