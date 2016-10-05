//
//  WSController.swift
//  PGD
//
//  Created by Pedro Oliveira on 27/07/16.
//  Copyright © 2016 Pedro Oliveira. All rights reserved.
//

import UIKit
import MapKit

class WSController: NSObject {
    
    struct Constants {
        static let WSBaseURL = "http://<URL>/pgd/PokeGPSDetectorService.svc/"
        static let Timeout = 30.0
        static let Login = "PerformLogin"
        static let InterestPoints = "GetInterestPoints"
        static let HTTPPost = "POST"
        static let UsernameKey = "username"
        static let PasswordKey = "password"
        static let LatitudeKey = "latitude"
        static let LongitudeKey = "longitude"
    }
    
    func performLogin(username: String, password: String, callback:@escaping (Bool) -> Void) {
        let url = URL(string:Constants.WSBaseURL + Constants.Login)
        let data = [Constants.UsernameKey: username,Constants.PasswordKey: password]
        makeJSONRequest(url: url!, method: Constants.HTTPPost, data: data as [String : AnyObject],
                        errorCallback: { (error) in
                            callback(false)
        }) { (response) in
            let loginResult = LoginParser(response).parse()
            callback(loginResult)
        }
    }
    
    func getInterestPoints(username: String, password: String, coordinate: CLLocation, callback:@escaping (InterestPoints?) -> Void) {
        let url = URL(string:Constants.WSBaseURL + Constants.InterestPoints)
        let data: [String: AnyObject] = [Constants.UsernameKey: username as AnyObject,
                     Constants.PasswordKey: password as AnyObject,
                     Constants.LatitudeKey: coordinate.coordinate.latitude as AnyObject,
                     Constants.LongitudeKey: coordinate.coordinate.longitude as AnyObject]
        makeJSONRequest(url: url!, method: Constants.HTTPPost, data: data, errorCallback: {
            (error) in
                print(error)
                callback(nil)
            
            }) { (response) in
                let parser = MapPointsParser(response)
                let result = InterestPoints(pokemons: parser.getPokemons(), gyms: parser.getGyms(), pokestops: parser.getPokestops())
                callback(result)
        }
    }
    
    private func makeJSONRequest(url: URL, method: String, data: [String: AnyObject], errorCallback:@escaping (String) -> Void, successCallback:@escaping (String) -> Void) {
        do {
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: Constants.Timeout)
            request.httpMethod = method
            request.httpBody = try JSONSerialization.data(withJSONObject: data, options:.prettyPrinted)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
                if error != nil {
                    errorCallback((error?.localizedDescription)!)
                } else {
                    successCallback(String.init(data:data!, encoding: String.Encoding.utf8)!)
                }
            }
            task.resume()
        } catch let error as NSError {
            errorCallback(error.localizedDescription)
        }
    }
    
   }
