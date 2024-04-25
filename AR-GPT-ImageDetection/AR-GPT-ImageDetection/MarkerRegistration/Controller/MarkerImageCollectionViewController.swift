//
//  MarkerImageCollectionViewController.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/22/24.
//

import UIKit

protocol MarkerImageCollectionViewControllerDelegate: AnyObject {
    func reloadMarkerImages()
}

/// 등록된 마커이미지를 보여주는 뷰컨트롤러
final class MarkerImageCollectionViewController: UIViewController {
    // MARK: - Properties
    private let markerImageManager = MarkerImageManager.shared
    private lazy var markerImages: [MarkerImage] = markerImageManager.fetchAll()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 110, height: 110)        
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    private lazy var addButton: UIButton = {
        let addButton = UIButton()
        let size = view.bounds.width * 0.10
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: size, weight: .bold, scale: .large)
        let symbolImage = UIImage(systemName: "plus.circle.fill", withConfiguration: symbolConfiguration)?.withTintColor(.systemGray4, renderingMode: .alwaysOriginal)
        addButton.setImage(symbolImage, for: .normal)
        addButton.addTarget(self, action: #selector(tapAddButton), for: .touchUpInside)
        return addButton
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        configureUI()
        addGesture()
    }
}

// MARK: - configuration
extension MarkerImageCollectionViewController {
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
    }
    
    private func addGesture() {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        collectionView.addGestureRecognizer(longPressRecognizer)
    }
}

// MARK: - private Method
extension MarkerImageCollectionViewController {
    private func presentMarkerRegistrationViewController(_ viewController: MarkerRegistrationViewController) {
        viewController.delegate = self
        present(viewController, animated: true)
    }
    
    private func showDeleteConfirmation(for indexPath: IndexPath) {
        let alert = UIAlertController(title: "마커 삭제", message: "마커를 삭제하시겠습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { [weak self] _ in
            guard let id = self?.markerImages[indexPath.item].id else { return }
            self?.markerImageManager.delete(by: id)
            self?.reloadMarkerImages()
        }))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - @objc Method
extension MarkerImageCollectionViewController {
    @objc func tapAddButton() {
        let markerRegistrationViewController = MarkerRegistrationViewController(markerImageManager: markerImageManager)
        presentMarkerRegistrationViewController(markerRegistrationViewController)
    }
    
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let point = gesture.location(in: collectionView)
            if let indexPath = collectionView.indexPathForItem(at: point) {
                showDeleteConfirmation(for: indexPath)
            }
        }
    }
}

// MARK: - UI
extension MarkerImageCollectionViewController {
    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(addButton)
        view.addSubview(collectionView)
        view.bringSubviewToFront(addButton)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
}

// MARK: - MarkerImageCollectionViewControllerDelegate
extension MarkerImageCollectionViewController: MarkerImageCollectionViewControllerDelegate {
    func reloadMarkerImages() {
        markerImages = markerImageManager.fetchAll()
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension MarkerImageCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return markerImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        let imageView = UIImageView(frame: cell.bounds)
        imageView.contentMode = .scaleAspectFit
        
        let markerImage = markerImages[indexPath.item]
        
        if let image = UIImage(data: markerImage.data) {
            imageView.image = image
        } else {
            imageView.image = UIImage(systemName: "photo")
        }
        
        cell.contentView.addSubview(imageView)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let markerImage = markerImages[indexPath.item]
        let markerRegistrationViewController = MarkerRegistrationViewController(markerImageManager: markerImageManager, markerImage: markerImage)
        markerRegistrationViewController.setFields(markerImage)
        presentMarkerRegistrationViewController(markerRegistrationViewController)
    }
}
