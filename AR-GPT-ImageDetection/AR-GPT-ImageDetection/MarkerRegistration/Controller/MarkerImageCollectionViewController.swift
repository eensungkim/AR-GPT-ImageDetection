//
//  MarkerImageCollectionViewController.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/22/24.
//

import UIKit

final class MarkerImageCollectionViewController: UIViewController {
    private let markerImageManager = MarkerImageManager(container: MarkerImageCoreData.shared.persistentContainer)
    private lazy var markerImages: [MarkerImage] = markerImageManager.fetchMarkerImage()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        configureUI()
    }
    
    @objc func tapAddButton() {
        let markerRegistrationViewController = MarkerRegistrationViewController()
        present(markerRegistrationViewController, animated: true)
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
    }
    
    private func configureUI() {
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
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

extension MarkerImageCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return markerImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)
        
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
