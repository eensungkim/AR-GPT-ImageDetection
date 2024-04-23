//
//  MarkerRegistrationView.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/22/24.
//

import UIKit

final class MarkerRegistrationView: UIView {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    private let nameView = Inputview(text: "타이틀")
    private let descriptionView = Inputview(text: "이미지 정의")
    private let additionalInformationView = Inputview(text: "이미지 설명")
    
    private let addButton: UIButton = {
        let addButton = UIButton()
        addButton.setTitle("등록", for: .normal)
        addButton.setTitleColor(.black, for: .normal)
        addButton.setImage(UIImage(systemName: "doc.fill.badge.plus"), for: .normal)
        return addButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .systemGray6
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        stackView.addArrangedSubview(nameView)
        stackView.addArrangedSubview(descriptionView)
        stackView.addArrangedSubview(additionalInformationView)
        
        self.addSubview(stackView)
        self.addSubview(addButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.85),
        ])
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30),
            addButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    func addTarget(_ target: Any, method: Selector) {
        addButton.addTarget(target, action: method, for: .touchUpInside)
    }
}

final class Inputview: UIStackView {
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
