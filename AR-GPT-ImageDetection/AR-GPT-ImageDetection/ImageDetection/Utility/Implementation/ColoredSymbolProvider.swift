//
//  ColoredSymbolProvider.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/19/24.
//

import UIKit

struct ColoredSymbolProvider: ColoredSymbolProtocol {
    private(set) var viewfinder: UIImage?
    
    init() {
        do {
            try createViewFinder()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    mutating private func createViewFinder() throws {
        let image = UIImage(systemName: "viewfinder")
        let configuration = UIImage.SymbolConfiguration(pointSize: 1000, weight: .ultraLight, scale: .large)
        let largeSymbol = image?.withConfiguration(configuration).withTintColor(.yellow)
        
        guard let pngData = largeSymbol?.pngData(),
              let pngImage = UIImage(data: pngData) else {
            throw ImageError.conversionFailure
        }
        
        self.viewfinder = pngImage
    }
}
