//
//  InterestPoint.swift
//  PGD
//
//  Created by Pedro Oliveira on 30/07/16.
//  Copyright © 2016 Pedro Oliveira. All rights reserved.
//

import UIKit
import MapKit

class InterestPoint: NSObject {
    let coordinate: CLLocation!
    let id: Int!
    
    init(id: Int, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        self.id = id
        self.coordinate = CLLocation(latitude: latitude, longitude: longitude)
        super.init()
    }
}
