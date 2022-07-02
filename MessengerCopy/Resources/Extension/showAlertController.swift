//
//  showAlertController.swift
//  MessengerCopy
//
//  Created by Paul Torres on 1/07/22.
//

import UIKit
extension UIViewController{
    
    func showAlertCancelError(_ title: String, message: String, accept: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: accept, style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}
