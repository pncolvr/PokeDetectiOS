//
//  InterestPointAnnotation.swift
//  PGD
//
//  Created by Pedro Oliveira on 31/07/16.
//  Copyright © 2016 Pedro Oliveira. All rights reserved.
//

import UIKit
import MapKit

class InterestPointAnnotation: MKPointAnnotation {
    enum AnnotatioType {
        case Pokemon
        case Gym
        case Pokestop
    }
    var imageName: String!
}
