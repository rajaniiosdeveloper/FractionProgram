//
//  IOViewController.swift
//  OneIdentityProject
//
//  Created by Rajani on 04/09/23.
//

import UIKit

class IOViewController: UIViewController {
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var outputTextField: UITextField!
    
    let vm: IOViewModel = IOViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        outputTextField.isEnabled = false
        inputTextField.placeholder = "1/2 * 3&3/4"
        vm.delegate = self
    }
    
    @IBAction func submitAction(_ sender: Any) {
        
        outputTextField.text = ""
        
        guard let text = inputTextField.text , !text.isEmpty else {
            self.showAlertView(title: "Error" , message: "Please add input in this formate (1/2 * 3&3/4)")
            return
        }
        
        vm.performOperation(text: text)
    }
}

extension IOViewController: IOViewModelDelegate {
    
    func showError(message: String) {
        self.showAlertView(title: "Error" , message: message)
    }
    
    func updateOutputResult(value: String) {
        outputTextField.text = value
    }
}
