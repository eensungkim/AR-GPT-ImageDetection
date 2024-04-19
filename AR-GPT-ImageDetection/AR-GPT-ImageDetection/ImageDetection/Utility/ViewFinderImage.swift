//
//  ViewFinderImage.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/19/24.
//

import UIKit

struct ViewFinderImage {
    static var viewfinder: UIImage? = {
        let image = UIImage(systemName: "viewfinder")
        let configuration = UIImage.SymbolConfiguration(pointSize: 1000, weight: .ultraLight, scale: .large)
        let largeSymbol = image?.withConfiguration(configuration).withTintColor(.yellow)
        
        guard let pngData = largeSymbol?.pngData(),
           let pngImage = UIImage(data: pngData) else {
            return nil
        }
        
        return pngImage
    }()
}
