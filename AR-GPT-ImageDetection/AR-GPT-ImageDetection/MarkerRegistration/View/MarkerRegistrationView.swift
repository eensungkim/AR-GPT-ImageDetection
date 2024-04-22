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
        return stackView
    }()
    private let nameView = Inputview(text: "타이틀")
    private let descriptionView = Inputview(text: "이미지 정의")
    private let additionalInformationView = Inputview(text: "이미지 설명")
    
    private let addButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .systemPink
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        stackView.addArrangedSubview(nameView)
        stackView.addArrangedSubview(typeView)
        stackView.addArrangedSubview(descriptionView)
        stackView.addArrangedSubview(additionalInformationView)
        
        self.addSubview(stackView)
        self.addSubview(addButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            addButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}

final class Inputview: UIStackView {
    let label = UILabel()
    let textField = UITextField()
    
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
    }
}
