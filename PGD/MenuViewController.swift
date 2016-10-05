//
//  MenuViewController.swift
//  PGD
//
//  Created by Pedro Oliveira on 30/07/16.
//  Copyright © 2016 Pedro Oliveira. All rights reserved.
//

import UIKit

class MenuViewController: PGDViewController {
    var interactor:Interactor? = nil
    
    @IBOutlet var pokestopSwitch: UISwitch!
    @IBOutlet var luredSwitch: UISwitch!
    @IBOutlet var pokemonsSwitch: UISwitch!
    @IBOutlet var gymsSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonsSwitch.isOn = retrieveShowPokemons()
        luredSwitch.isOn = retrieveShowLures()
        pokestopSwitch.isOn = retrieveShowStops()
        gymsSwitch.isOn = retrieveShowGyms()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pokestopSwitchValueChanged(_ sender: UISwitch) {
        storeShowStops(pokestopSwitch.isOn)
    }
    
    
    @IBAction func luredSwitchValueChanged(_ sender: UISwitch) {
        storeShowLures(luredSwitch.isOn)
    }
    
    
    @IBAction func gymsSwitchValueChanged(_ sender: UISwitch) {
        storeShowGyms(gymsSwitch.isOn)
    }
    
    @IBAction func pokemonsSwitchValueChanged(_ sender: UISwitch) {
        storeShowPokemons(pokemonsSwitch.isOn)
    }
    
    @IBAction func dismissButtonTouched(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func signoutButtonTouched(_ sender: UIButton) {
        if let controller = self.presentingViewController as? NavigationViewController {
            controller.toLogin()
        }
        
    }
    
    @IBAction func handleGesture(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        let progress = MenuHelper.calculateProgress(
            translationInView: translation,
            viewBounds: view.bounds,
            direction: .Left
        )
        MenuHelper.mapGestureStateToInteractor(
            gestureState: sender.state,
            progress: progress,
            interactor: interactor){
                self.dismiss(animated: true, completion: nil)
            }
        }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
