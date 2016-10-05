//
//  PokestopParser.swift
//  PGD
//
//  Created by Pedro Oliveira on 30/07/16.
//  Copyright © 2016 Pedro Oliveira. All rights reserved.
//

import UIKit
import MapKit

class PokestopParser: InterestPointParser {
    struct Constants {
        static let Id = "PokestopId"
        static let Latitude = "Latitude"
        static let Longitude = "Longitude"
        static let Lure = "Lure"
        static let LureExpirationDate = "ExpirationDateTime"
    }
    
    func parse() -> [Pokestop] {
        var parsed = [Pokestop]()
        for i in self.data {
            let latitude = i[Constants.Latitude] as! CLLocationDegrees
            let longitude = i[Constants.Longitude] as! CLLocationDegrees
            let id = i[Constants.Id] as! Int
            let expirationTimeInterval = i[Constants.Lure]?[Constants.LureExpirationDate] as? TimeInterval
            if expirationTimeInterval != nil {
                let expirationDate = Date.init(timeIntervalSince1970: expirationTimeInterval!/1000)
                parsed.append(Pokestop(latitude: latitude, longitude: longitude, id: id, expirationDate: expirationDate))
            } else {
                parsed.append(Pokestop(latitude: latitude, longitude: longitude, id: id, expirationDate: nil))
            }
            
        }
        return parsed
    }
}
