//
//  MarkerRegistrationViewController.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/16/24.
//

import UIKit

final class MarkerRegistrationViewController: UIViewController {
    
    private let markerImageManager = MarkerImageManager(container: MarkerImageCoreData.shared.persistentContainer)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMarkerRegistrationView()
        initializeHideKeyboard()
    }
    
    private func setupMarkerRegistrationView() {
        let markerRegistrationView = MarkerRegistrationView()
        view = markerRegistrationView
        markerRegistrationView.addTarget(self, method: #selector(togglePhotoLibrary))
    }
    
    private func initializeHideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func togglePhotoLibrary() {
        let photoUploadViewController = PhotoUploadViewController()
        self.present(photoUploadViewController, animated: true)
    }
}
