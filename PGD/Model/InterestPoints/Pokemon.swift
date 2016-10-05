//
//  Pokemon.swift
//  PGD
//
//  Created by Pedro Oliveira on 30/07/16.
//  Copyright © 2016 Pedro Oliveira. All rights reserved.
//

import UIKit
import MapKit

class Pokemon: NamedInterestPoint {
    let expirationDate: Date!
    
    init(latitude: CLLocationDegrees, longitude: CLLocationDegrees, id: Int, name: String, expirationDate: Date) {
        self.expirationDate = expirationDate
        super.init(latitude: latitude, longitude: longitude, id: id, name: name)
    }
    
}
