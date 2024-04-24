//
//  MarkerRegistrationView.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/22/24.
//

import UIKit

/// 마커 등록 기능을 표현하는 뷰
final class MarkerRegistrationView: UIView {
    // MARK: - Properties
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
    private let nameView: InputView = {
        let nameView = InputView(text: "타이틀")
        nameView.textField.placeholder = "두 글자 이상 입력해 주세요."
        return nameView
    }()
    private let descriptionView = InputView(text: "이미지 정의")
    private let additionalInformationView = InputView(text: "이미지 설명")
    
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
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .systemGray6
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public Methods
extension MarkerRegistrationView {
    func setDelegate(_ delegate: UITextFieldDelegate) {
        nameView.textField.delegate = delegate
    }
    
    func toggleAddButton() {
        guard
            let isNameValid = nameView.textField.text?.isEmpty,
            let isImageValid = imageViewButton.currentImage?.isSymbolImage
        else {
            addButton.isEnabled = false
            return
        }
        
        addButton.isEnabled = !isNameValid && !isImageValid
    }
    
    func addTarget(_ target: Any) {
        imageViewButton.addTarget(target, action: #selector(MarkerRegistrationViewController.togglePhotoLibrary), for: .touchUpInside)
        addButton.addTarget(target, action: #selector(MarkerRegistrationViewController.saveMarkerImage), for: .touchUpInside)
    }
    
    func setImage(_ image: UIImage) {
        imageViewButton.setImage(image, for: .normal)
    }
    
    func getMarkerImage() -> MarkerImage? {
        guard let name = nameView.textField.text,
              let data = imageViewButton.currentImage?.resizeImage(toWidth: 512)?.pngData(),
              let description = descriptionView.textField.text,
              let additionalInformation = additionalInformationView.textField.text else {
            return nil
        }
        
        return MarkerImage(
            id: UUID(),
            name: name,
            data: data,
            description: description,
            additionalInformation: additionalInformation
        )
    }
}

// MARK: - UI
extension MarkerRegistrationView {
    private func configureUI() {
        stackView.addArrangedSubview(nameView)
        stackView.addArrangedSubview(descriptionView)
        stackView.addArrangedSubview(additionalInformationView)
        
        self.addSubview(imageViewButton)
        self.addSubview(stackView)
        self.addSubview(addButton)
        
        imageViewButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageViewButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            imageViewButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageViewButton.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor),
            imageViewButton.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.618)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: imageViewButton.bottomAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.85),
        ])
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30),
            addButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            addButton.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.17)
        ])
    }
}

/// UILabel + UITextField 가 조합된 스택뷰
final class InputView: UIStackView {
    let label = UILabel()
    let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    init(text: String) {
        label.text = text
        super.init(frame: CGRect.zero)
        
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.axis = .horizontal
        self.alignment = .fill
        self.distribution = .fillProportionally
        
        self.addArrangedSubview(label)
        self.addArrangedSubview(textField)
        
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3)
        ])
    }
}
