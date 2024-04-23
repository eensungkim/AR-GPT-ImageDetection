//
//  MarkerImageCollectionViewController.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/22/24.
//

import UIKit

final class MarkerImageCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    private let markerImageManager = MarkerImageManager(container: MarkerImageCoreData.shared.persistentContainer)
    private lazy var markerImages: [MarkerImage] = markerImageManager.fetchMarkerImage()  // MarkerImage 배열
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)  // 셀 크기 설정
        layout.minimumInteritemSpacing = 10  // 셀 간 간격 설정
        layout.minimumLineSpacing = 10  // 줄 간 간격 설정
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        configureUI()
    }
    
    private func setupCollectionView() {
        // 컬렉션 뷰 설정
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")  // 셀 등록
    }
    
    private func configureUI() {
        // 컬렉션 뷰 추가 및 레이아웃 설정
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    // 컬렉션 뷰 데이터 소스 메서드 구현
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return markerImages.count  // 배열의 항목 수 반환
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)
        
        // 셀에 이미지 추가
        let imageView = UIImageView(frame: cell.bounds)
        imageView.contentMode = .scaleAspectFit
        
        let markerImage = markerImages[indexPath.item]
        
        if let image = UIImage(data: markerImage.data) {
            imageView.image = image  // 이미지 설정
        } else {
            imageView.image = UIImage(systemName: "photo")  // 기본값 설정
        }
        
        cell.contentView.addSubview(imageView)  // 셀에 이미지뷰 추가
        
        return cell
    }
}
