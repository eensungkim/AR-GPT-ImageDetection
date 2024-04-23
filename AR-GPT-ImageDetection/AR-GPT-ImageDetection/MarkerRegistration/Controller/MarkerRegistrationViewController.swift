//
//  MarkerRegistrationViewController.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/16/24.
//

import UIKit

final class MarkerRegistrationViewController: UIViewController {
    
    private let markerImageManager = MarkerImageManager(container: MarkerImageCoreData.shared.persistentContainer)
    private let markerRegistrationView = MarkerRegistrationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMarkerRegistrationView()
        initializeHideKeyboard()
    }
    
    private func setupMarkerRegistrationView() {
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
        presentImagePicker()
    }
}

extension MarkerRegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func presentImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            // 선택된 이미지 처리
        }
        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
