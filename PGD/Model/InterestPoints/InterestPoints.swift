//
//  InterestPoints.swift
//  PGD
//
//  Created by Pedro Oliveira on 30/07/16.
//  Copyright © 2016 Pedro Oliveira. All rights reserved.
//

import UIKit

class InterestPoints: NSObject {
    let pokemons: [Pokemon]!
    let gyms: [Gym]!
    let pokestops: [Pokestop]!
    
    init(pokemons: [Pokemon], gyms: [Gym], pokestops: [Pokestop]){
        self.pokemons = pokemons
        self.gyms = gyms
        self.pokestops = pokestops
        super.init()
    }
}
