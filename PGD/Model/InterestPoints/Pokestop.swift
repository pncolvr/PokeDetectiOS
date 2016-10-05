//
//  Pokestop.swift
//  PGD
//
//  Created by Pedro Oliveira on 30/07/16.
//  Copyright © 2016 Pedro Oliveira. All rights reserved.
//

import UIKit
import MapKit

class Pokestop: InterestPoint {
    let expirationDate: Date?
    init(latitude: CLLocationDegrees, longitude: CLLocationDegrees, id: Int, expirationDate: Date?) {
        self.expirationDate = expirationDate
        super.init(id: id, latitude: latitude, longitude: longitude)
    }
}
