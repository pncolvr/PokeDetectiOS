//
//  GymParser.swift
//  PGD
//
//  Created by Pedro Oliveira on 30/07/16.
//  Copyright © 2016 Pedro Oliveira. All rights reserved.
//

import UIKit
import MapKit

class GymParser: InterestPointParser {
    struct Constants {
        static let Id = "GymId"
        static let Latitude = "Latitude"
        static let Longitude = "Longitude"
        static let Name = "TeamName"
        static let Prestige = "Prestige"
    }
    
    func parse() -> [Gym] {
        var parsed = [Gym]()
        for i in self.data {
            let latitude = i[Constants.Latitude] as! CLLocationDegrees
            let longitude = i[Constants.Longitude] as! CLLocationDegrees
            let id = i[Constants.Id] as! Int
            let name = i[Constants.Name] as! String
            let prestige = i[Constants.Prestige] as! Int
            parsed.append(Gym(latitude: latitude, longitude: longitude, id: id, name: name, prestige: prestige))
        }
        return parsed
    }

}
