//
//  Checker.swift
//  LoginProject
//
//  Created by Gadgetzone on 27/06/21.
//

import Foundation
import UIKit

class Checker {
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
}
