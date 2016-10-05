//
//  LoginParser.swift
//  PGD
//
//  Created by Pedro Oliveira on 28/07/16.
//  Copyright © 2016 Pedro Oliveira. All rights reserved.
//

import UIKit

class LoginParser: Parser {
    
    struct Constants {
        static let MethodIdentifier = "PerformLoginResult"
    }
    
    func parse() -> Bool {
        if super.responseInternal.isEmpty {
            return false
        }
        if let data = super.getDictionaryFromResponse() {
            return data[Constants.MethodIdentifier] as! Bool
        }
        return false
    }
}
