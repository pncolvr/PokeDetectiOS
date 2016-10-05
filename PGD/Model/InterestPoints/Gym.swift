//
//  Gym.swift
//  PGD
//
//  Created by Pedro Oliveira on 30/07/16.
//  Copyright © 2016 Pedro Oliveira. All rights reserved.
//

import UIKit
import MapKit

class Gym: NamedInterestPoint {
    let prestige: Int!
    init(latitude: CLLocationDegrees, longitude: CLLocationDegrees, id: Int, name: String, prestige: Int) {
        self.prestige = prestige
        super.init(latitude: latitude, longitude: longitude, id: id, name: name)
    }
}
