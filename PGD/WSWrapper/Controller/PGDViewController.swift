//
//  PGDViewController.swift
//  PGD
//
//  Created by Pedro Oliveira on 28/07/16.
//  Copyright © 2016 Pedro Oliveira. All rights reserved.
//

import UIKit

class PGDViewController: UIViewController {

    private struct UserDefaultsKeys {
        static let Username = "com.pncolvr.pgd.username" as String
        static let Password = "com.pncolvr.pgd.password" as String
        static let ShowGyms = "com.pncolvr.pgd.showgyms" as String
        static let ShowStops = "com.pncolvr.pgd.showstops" as String
        static let ShowLures = "com.pncolvr.pgd.showlures" as String
        static let ShowPokemons = "com.pncolvr.pgd.showpokemons" as String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func presentOKAlert(message: String)  {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func storeUsername(_ username: String){
        UserDefaults.standard.set(username ,forKey: UserDefaultsKeys.Username)
    }
    
    func storePassword(_ password: String){
        UserDefaults.standard.set(password ,forKey: UserDefaultsKeys.Password)
    }
    
    func retrievePassword() -> String {
        let defaults = UserDefaults.standard
        if let password = defaults.string(forKey:UserDefaultsKeys.Password) {
            return password
        }
        return ""
    }
    
    func retrieveUsername() -> String {
        let defaults = UserDefaults.standard
        if let username = defaults.string(forKey:UserDefaultsKeys.Username) {
            return username
        }
        return ""
    }
    
    func storeShowGyms(_ show: Bool){
        UserDefaults.standard.set(show ,forKey: retrieveUsername() + UserDefaultsKeys.ShowGyms)
    }
    
    func retrieveShowGyms() -> Bool {
        return UserDefaults.standard.bool(forKey:retrieveUsername() + UserDefaultsKeys.ShowGyms)
    }
    
    func storeShowStops(_ show: Bool){
        UserDefaults.standard.set(show ,forKey: retrieveUsername() + UserDefaultsKeys.ShowStops)
    }
    
    func retrieveShowStops() -> Bool {
        return UserDefaults.standard.bool(forKey:retrieveUsername() + UserDefaultsKeys.ShowStops)
    }
    
    func storeShowLures(_ show: Bool){
        UserDefaults.standard.set(show ,forKey: retrieveUsername() + UserDefaultsKeys.ShowLures)
    }
    
    func retrieveShowLures() -> Bool {
        return UserDefaults.standard.bool(forKey:retrieveUsername() + UserDefaultsKeys.ShowLures)
    }
    
    func storeShowPokemons(_ show: Bool){
        UserDefaults.standard.set(show ,forKey: retrieveUsername() + UserDefaultsKeys.ShowPokemons)
    }
    
    func retrieveShowPokemons() -> Bool {
        return UserDefaults.standard.bool(forKey:retrieveUsername() + UserDefaultsKeys.ShowPokemons)
    }
}
