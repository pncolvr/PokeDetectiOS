//
//  LoginViewController.swift
//  PGD
//
//  Created by Pedro Oliveira on 26/07/16.
//  Copyright © 2016 Pedro Oliveira. All rights reserved.
//

import UIKit

class LoginViewController: PGDViewController, UITextFieldDelegate {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var activityIndicator: UIView?
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.addTarget(self, action: #selector(LoginViewController.textFieldTextDidChanged(textField:)), for: UIControlEvents.editingChanged)
        passwordTextField.addTarget(self, action: #selector(LoginViewController.textFieldTextDidChanged(textField:)), for: UIControlEvents.editingChanged)
        passwordTextField.delegate = self
        usernameTextField.delegate = self
        
        usernameTextField.text = retrieveUsername()
        passwordTextField.text = retrievePassword()
        
        if passwordTextField.text?.isEmpty == false && usernameTextField.text?.isEmpty == false {
            enableLoginButton()
            loginButton.sendActions(for: UIControlEvents.touchUpInside)
        } else {
            disableLoginButton()
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    private func disableLoginButton() {
        loginButton.isEnabled = false
        loginButton.backgroundColor = UIColor(hex: 0xDA0A1F)
    }
    
    private func enableLoginButton() {
        loginButton?.isEnabled = true
        loginButton?.backgroundColor = UIColor(hex: 0x4183D7)
    }

    func textFieldTextDidChanged(textField: UITextField) {
        if usernameTextField.text!.isEmpty || passwordTextField.text!.isEmpty{
            disableLoginButton()
            loginButton.setTitle("Please type your credentials", for: UIControlState.disabled)
        } else if passwordTextField.text!.characters.count > 15 {
            disableLoginButton()
            loginButton.setTitle("Password <= 15 chars", for: UIControlState.disabled)
        } else {
            enableLoginButton()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTage=textField.tag+1;
        let nextResponder=textField.superview?.viewWithTag(nextTage) as UIResponder!
        
        if (nextResponder != nil){
            nextResponder?.becomeFirstResponder()
            if nextResponder === loginButton {
                loginButton.sendActions(for: UIControlEvents.touchUpInside)
            }
        }
        else
        {
            dismissKeyboard()
        }
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func openForgotPasswordURL(_ sender: UIButton) {
        UIApplication.shared.openURL(URL(string:"https://club.pokemon.com/us/pokemon-trainer-club/forgot-password")!)
    }
    
    @IBAction func performLogin(_ sender: UIButton) {
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        
        WSController().performLogin(username: username, password: password, callback: {loggedin in
            defer {
                self.removeActivityIndicatorView()
            }
            if loggedin {
                DispatchQueue.main.async(execute: {
                    self.storeUsername(username)
                    self.storePassword(password)
                    self.performSegue(withIdentifier:"presentMapViewControllerSegue", sender:sender)
                })
                
            } else {
                self.presentOKAlert(message: "Unable to authenticate, please check your credentials or try again later.")
            }
        })
        self.showActivityIndicatorView(view: self.view)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "presentMapViewControllerSegue") {
            let map = segue.destination.rootViewController() as! MapViewController
            map.username = retrieveUsername()
            map.password = retrievePassword()
        }
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    private func showActivityIndicatorView(view: UIView){
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            self.dismissKeyboard()
            self.activityIndicator = LoadingView(view)
            view.addSubview(self.activityIndicator!)
        }
        
    }
    
    private func removeActivityIndicatorView(){
        DispatchQueue.main.async(execute: {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
           self.activityIndicator?.removeFromSuperview()
        })
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
