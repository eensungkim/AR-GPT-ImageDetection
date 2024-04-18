//
//  GPTInformationViewController.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/18/24.
//

import UIKit

final class GPTInformationViewController: UIViewController {
    private let textView: UITextView = {
        let textView = UITextView()
        textView.font = .preferredFont(forTextStyle: .body)
        textView.isEditable = false
        return textView
    }()
    private let loadingIndicatorView = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLoadingIndicator()
    }
}

extension GPTInformationViewController {
    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(loadingIndicatorView)
        view.addSubview(textView)
        
        loadingIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingIndicatorView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            loadingIndicatorView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            textView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.9),
            textView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            textView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    private func configureLoadingIndicator() {
        view.bringSubviewToFront(loadingIndicatorView)
        loadingIndicatorView.startAnimating()
    }
}

extension GPTInformationViewController {
    func setText(_ text: String) {
        loadingIndicatorView.stopAnimating()
        textView.text = text
    }
}
