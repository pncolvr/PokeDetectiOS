//
//  UINavigationController+root.swift
//  PGD
//
//  Created by Pedro Oliveira on 30/07/16.
//  Copyright © 2016 Pedro Oliveira. All rights reserved.
//

import Foundation

extension UIViewController {
    func rootViewController() -> UIViewController {
        return self.childViewControllers.first! as UIViewController
    }
}
