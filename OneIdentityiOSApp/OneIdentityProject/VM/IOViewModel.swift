//
//  IOViewModel.swift
//  OneIdentityProject
//
//  Created by Gudia on 06/09/23.
//

import Foundation

protocol IOViewModelDelegate: AnyObject {
    func showError(message: String)
    func updateOutputResult(value: String)
}

class IOViewModel {
    
    weak var delegate: IOViewModelDelegate?
    
    func performOperation(text: String) {
        
        do {
            let fractionResult = try IOFraction().processFraction(input: text)
            if fractionResult != "0" {
                delegate?.updateOutputResult(value: fractionResult)
            } else {
                delegate?.showError(message: "Please add input in this format (1/2 * 3&3/4)")
            }
        } catch (let error) {
            if let errorRef = error as? IOFractionError {
                delegate?.showError(message: errorRef.errorMessage)
            } else {
                delegate?.showError(message:"some error occured")
            }
        }
    }
}
