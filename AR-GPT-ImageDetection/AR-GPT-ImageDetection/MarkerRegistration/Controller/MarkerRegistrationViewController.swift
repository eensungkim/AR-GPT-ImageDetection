//
//  MarkerRegistrationViewController.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/16/24.
//

import UIKit

final class MarkerRegistrationViewController: UIViewController {
    
    private let markerImageManager: MarkerImageManageable
    private let markerRegistrationView = MarkerRegistrationView()
    weak var delegate: MarkerImageCollectionViewControllerDelegate?

    init(markerImageManager: MarkerImageManageable) {
        self.markerImageManager = markerImageManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMarkerRegistrationView()
        initializeHideKeyboard()
    }
    
    private func setupMarkerRegistrationView() {
        view = markerRegistrationView
        markerRegistrationView.addTarget(self)
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
    
    @objc func togglePhotoLibrary() {
        presentImagePicker()
    }
    
    @objc func saveMarkerImage() {
        guard let markerImage = markerRegistrationView.getMarkerImage() else {
            return
        }
        _ = MarkerImageMO(markerImage: markerImage, context: markerImageManager.container.viewContext)
        delegate?.reloadMarkerImages()
        self.dismiss(animated: true)
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
            markerRegistrationView.setImage(selectedImage)
        }
        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
