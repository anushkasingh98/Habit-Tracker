//
//  Utilities.swift
//  customauth
//
//  Created by Christopher Ching on 2019-05-09.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    static func styleTextField(_ textfield:UITextField) {
        
        // Create the bottom line
        let bottomLine = CALayer()

        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        
        let myColor : UIColor = .lavenderPink

        bottomLine.backgroundColor = myColor.cgColor

        // Remove border on text field
        textfield.borderStyle = .none

        // Add the line to the text field
        textfield.layer.addSublayer(bottomLine)
        
//        let myColor : UIColor = .lavenderPink
//
//
//        textfield.layer.borderColor = myColor.cgColor
//        textfield.layer.borderWidth = 1.0
//
//        textfield.layer.cornerRadius = 25.0
        
    }
        
    
    static func styleFilledButton1(_ button:UIButton) {
        
        // Filled rounded corner style
        button.backgroundColor = .warmPurple
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
    static func styleSmallFilledButton(_ button:UIButton) {
        
        //Filled with round corners
        button.backgroundColor = .white
        button.layer.cornerRadius = 15.0
        button.tintColor = UIColor.black
    }
    
    static func styleHollowButton(_ button:UIButton) {
        
        // Hollow rounded corner style
        button.layer.borderWidth = 2
        let color:UIColor = .warmPurple
        button.layer.borderColor = color.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    static func isEmailValid(_ email : String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    
}
