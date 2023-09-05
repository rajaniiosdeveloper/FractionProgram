//
//  AlertAction.swift
//  OneIdentityProject
//
//  Created by Rajani on 05/09/23.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlertView(title:String, message:String) {
        // Instantiating UIAlertController
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        
        // Presenting alert controller
        self.present(alertController, animated: true, completion:nil)
    }
}
