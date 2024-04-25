//
//  MarkerRegistrationViewController.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/16/24.
//

import UIKit

/// 마커등록뷰컨트롤러
final class MarkerRegistrationViewController: UIViewController {
    
    // MARK: - Properties
    private let markerImageManager: MarkerImageManageable
    weak var delegate: MarkerImageCollectionViewControllerDelegate?
    private var markerImage: MarkerImage?
    
    private let imageViewButton: UIButton = {
        let imageViewButton = UIButton()
        let configuration = UIImage.SymbolConfiguration(pointSize: 1024, weight: .light, scale: .large)
        let skeletonImage = UIImage(systemName: "photo.badge.plus", withConfiguration: configuration)
        imageViewButton.setImage(skeletonImage, for: .normal)
        imageViewButton.imageView?.contentMode = .scaleAspectFit
        return imageViewButton
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
        let addButton = UIButton(type: .system)
        addButton.setTitle("등록", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        addButton.titleLabel?.font = .preferredFont(forTextStyle: .title2)
        addButton.backgroundColor = .systemGray2
        addButton.layer.cornerRadius = 10
        addButton.layer.masksToBounds = true
        addButton.isEnabled = false
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setupMarkerRegistrationView()
        initializeHideKeyboard()
        setTextFieldDelegate()
    }
}

// MARK: - Configuration
extension MarkerRegistrationViewController {
    private func setupMarkerRegistrationView() {
        imageViewButton.addTarget(target, action: #selector(togglePhotoLibrary), for: .touchUpInside)
        addButton.addTarget(target, action: #selector(saveMarkerImage), for: .touchUpInside)
    }
        
    private func initializeHideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        view.addGestureRecognizer(tap)
    }
}

// MARK: - UI
extension MarkerRegistrationViewController {
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        stackView.addArrangedSubview(nameView)
        stackView.addArrangedSubview(descriptionView)
        stackView.addArrangedSubview(additionalInformationView)
        
        view.addSubview(imageViewButton)
        view.addSubview(stackView)
        view.addSubview(addButton)
        
        imageViewButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageViewButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imageViewButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageViewButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            imageViewButton.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.618)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: imageViewButton.bottomAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.85),
        ])
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30),
            addButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            addButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.17)
        ])
    }
}

// MARK: - Methods
extension MarkerRegistrationViewController {
    private func toggleAddButton() {
        guard
            let isNameValid = nameView.textField.text?.isEmpty,
            let isImageValid = imageViewButton.currentImage?.isSymbolImage
        else {
            addButton.isEnabled = false
            return
        }
        
        addButton.isEnabled = !isNameValid && !isImageValid
    }
    
    func setFields(_ markerImage: MarkerImage) {
        guard let image = UIImage(data: markerImage.data) else { return }
        imageViewButton.setImage(image, for: .normal)
        nameView.textField.text = markerImage.name
        descriptionView.textField.text = markerImage.information
        additionalInformationView.textField.text = markerImage.additionalInformation
    }
}

// MARK: - @objc Methods
extension MarkerRegistrationViewController {
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func togglePhotoLibrary() {
        presentImagePicker()
    }
    
    @objc func saveMarkerImage() {
        guard 
            let name = nameView.textField.text,
            let image = imageViewButton.currentImage,
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
        self.dismiss(animated: true)
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

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension MarkerRegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func presentImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            imageViewButton.setImage(selectedImage, for: .normal)
        }
        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
