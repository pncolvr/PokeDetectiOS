//
//  Parser.swift
//  PGD
//
//  Created by Pedro Oliveira on 28/07/16.
//  Copyright © 2016 Pedro Oliveira. All rights reserved.
//

import UIKit

class Parser: NSObject {
    var responseInternal: String = ""
    
    init(_ response: String) {
        responseInternal = response
        super.init()
    }
    
    internal func getDictionaryFromResponse() -> [String:AnyObject]?{
        if let data = responseInternal.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        return nil
    }

}
