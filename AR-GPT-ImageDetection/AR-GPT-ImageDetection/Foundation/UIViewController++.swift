//
//  UIViewController++.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/29/24.
//

import UIKit

extension UIViewController {
    func makeAlert(title: String? = nil,
                   message: String,
                   confirmAction: ((UIAlertAction) -> Void)?,
                   completion: (() -> Void)? = nil) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let confirm = UIAlertAction(title: "확인", style: .default, handler: confirmAction)
        alertViewController.addAction(confirm)
        
        self.present(alertViewController, animated: true, completion: completion)
    }
}
