//
//  TextImageCreatable.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/22/24.
//

import UIKit

protocol TextImageCreatable {
    func textToImage(drawText text: String, inImage imageSize: CGSize) -> UIImage
}
