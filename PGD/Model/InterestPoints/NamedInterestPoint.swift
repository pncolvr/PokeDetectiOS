//
//  NamedInterestPoint.swift
//  PGD
//
//  Created by Pedro Oliveira on 30/07/16.
//  Copyright © 2016 Pedro Oliveira. All rights reserved.
//

import UIKit
import MapKit

class NamedInterestPoint: InterestPoint {
    let name: String!
    
    init(latitude: CLLocationDegrees, longitude: CLLocationDegrees, id: Int, name: String) {
        self.name = name
        super.init(id: id, latitude: latitude, longitude: longitude)
    }
}
