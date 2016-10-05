//
//  GetInterestPointsParser.swift
//  PGD
//
//  Created by Pedro Oliveira on 30/07/16.
//  Copyright © 2016 Pedro Oliveira. All rights reserved.
//

import UIKit

class MapPointsParser: Parser {
    struct Constants {
        static let MethodIdentifier = "GetInterestPointsResult"
        static let Gyms = "Gyms"
        static let Pokemons = "Pokemons"
        static let Pokestops = "Pokestops"
    }
    
    func getPokemons() -> [Pokemon] {
        if super.responseInternal.isEmpty {
            return [Pokemon]()
        }
        if let data = super.getDictionaryFromResponse() {
            if let arrayData = data[Constants.MethodIdentifier]?[Constants.Pokemons] as? [Dictionary<String,AnyObject>]{
                let parser =  PokemonParser(arrayData)
                return parser.parse()
            }
        }
        return [Pokemon]()
    }
    
    func getGyms() -> [Gym] {
        if super.responseInternal.isEmpty {
            return [Gym]()
        }
        if let data = super.getDictionaryFromResponse() {
            if let arrayData = data[Constants.MethodIdentifier]?[Constants.Gyms] as? [Dictionary<String,AnyObject>]{
                let parser =  GymParser(arrayData)
                return parser.parse()
            }
        }
        return [Gym]()
    }
    
    func getPokestops() -> [Pokestop] {
        if super.responseInternal.isEmpty {
            return [Pokestop]()
        }
        if let data = super.getDictionaryFromResponse() {
            if let arrayData = data[Constants.MethodIdentifier]?[Constants.Pokestops] as? [Dictionary<String,AnyObject>]{
                let parser =  PokestopParser(arrayData)
                return parser.parse()
            }
        }
        return [Pokestop]()
    }
    
}
