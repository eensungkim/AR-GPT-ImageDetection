//
//  GPTInformationViewController.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/18/24.
//

import UIKit

final class GPTInformationViewController: UIViewController {
    private let textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.font = .preferredFont(forTextStyle: .body)
        textLabel.numberOfLines = 0
        textLabel.lineBreakStrategy = .hangulWordPriority
        return textLabel
    }()
    private let loadingIndicatorView = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        loadingIndicatorView.startAnimating()
    }
}

extension GPTInformationViewController {
    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(loadingIndicatorView)
        view.addSubview(textLabel)
        
        loadingIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingIndicatorView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            loadingIndicatorView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            textLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.9),
            textLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
}

extension GPTInformationViewController {
    func setText(_ text: String) {
        loadingIndicatorView.stopAnimating()
        textLabel.text = text
    }
}
