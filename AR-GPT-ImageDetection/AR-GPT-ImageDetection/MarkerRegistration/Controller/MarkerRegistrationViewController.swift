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
    
    private let markerRegistrationView = MarkerRegistrationView()
    
    // MARK: - Life Cycle
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
        setTextFieldDelegate()
    }
}

// MARK: - Configuration
extension MarkerRegistrationViewController {
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
        guard let markerImage = markerRegistrationView.getMarkerImage() else {
            return
        }
        _ = MarkerImageMO(markerImage: markerImage, context: markerImageManager.persistentContainer.viewContext)
        markerImageManager.save()
        delegate?.reloadMarkerImages()
        self.dismiss(animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension MarkerRegistrationViewController: UITextFieldDelegate {
    private func setTextFieldDelegate() {
        markerRegistrationView.setDelegate(self)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        markerRegistrationView.toggleAddButton()
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
            markerRegistrationView.setImage(selectedImage)
        }
        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
