//
//  PokemonParser.swift
//  PGD
//
//  Created by Pedro Oliveira on 30/07/16.
//  Copyright © 2016 Pedro Oliveira. All rights reserved.
//

import UIKit
import MapKit

class PokemonParser: InterestPointParser {
    struct Constants {
        static let Id = "Id"
        static let Latitude = "Latitude"
        static let Longitude = "Longitude"
        static let Name = "Name"
        static let ExpirationDate = "ExpirationDate"
    }
    
    func parse() -> [Pokemon] {
        var parsed = [Pokemon]()
        for i in self.data {
            let latitude = i[Constants.Latitude] as! CLLocationDegrees
            let longitude = i[Constants.Longitude] as! CLLocationDegrees
            let id = i[Constants.Id] as! Int
            let name = i[Constants.Name] as! String
            let expirationTimeInterval = i[Constants.ExpirationDate] as! TimeInterval
            let expirationDate = Date.init(timeIntervalSince1970: expirationTimeInterval/1000)
            parsed.append(Pokemon(latitude: latitude, longitude: longitude, id: id, name: name, expirationDate: expirationDate))
        }
        return parsed
    }
}
