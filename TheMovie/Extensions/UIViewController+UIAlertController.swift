//
//  UIViewController+UIAlertController.swift
//  TheMovie
//
//  Created by Vu Phong on 24/05/2024.
//

import UIKit

extension UIViewController {
    func displayErrorAlert(errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { action in
            
        }
        alert.addAction(cancelButton)
        self.present(alert, animated: true)
    }
}
