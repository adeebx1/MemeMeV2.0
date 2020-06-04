//
//  TopTextdelegate.swift
//  MemeMeV1.0
//
//  Created by Adeeb alsuhaibani on 30/09/1441 AH.
//  Copyright © 1441 Adeebx1. All rights reserved.
//

import Foundation
import UIKit

class TopTextdelegate: NSObject, UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var newText = textField.text! as NSString
        newText = newText.replacingCharacters(in: range, with: string) as NSString
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "TOP" {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
}
