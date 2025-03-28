//
//  ErrorDialog.swift
//  QuizApp-Assignment3
//
//  Created by Umesh Basnet on 20/03/2025.
//

import UIKit


extension UIViewController {
    func showErrorDialogWith( message: String, title: String = "Error", completionHandler: (()->Void)? = nil) {
        let alert = UIAlertController(
            title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            completionHandler?();
        }))

        present(alert, animated: true)
    }
    
    func showConfirmationDialog(title: String,  message: String,  completionHandler: @escaping (Bool)->()) {
        let alert = UIAlertController(
            title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            completionHandler(false)
        }))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            completionHandler(true)
        }))

        present(alert, animated: true)
    }
}
