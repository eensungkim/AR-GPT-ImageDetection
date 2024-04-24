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
    private lazy var markerImages: [MarkerImage] = markerImageManager.fetch()
    
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
    }
}

// MARK: - configuration
extension MarkerImageCollectionViewController {
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
    }
}

// MARK: - @objc Method
extension MarkerImageCollectionViewController {
    @objc func tapAddButton() {
        let markerRegistrationViewController = MarkerRegistrationViewController(markerImageManager: markerImageManager)
        markerRegistrationViewController.delegate = self
        present(markerRegistrationViewController, animated: true)
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
        markerImages = markerImageManager.fetch()
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
}
