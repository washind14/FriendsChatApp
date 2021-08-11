//
//  LoginViewController.swift
//  FriendsChatApp
//
//  Created by Desha Washington on 6/30/21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
   
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    // create the alert
                    let alert = UIAlertController(title: "Error logging in", message: e.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                    
            } else {
                    //Navigate to the Login View Controller
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
            }
        }
    }
//    @IBAction func currentWeatherPressed(_ sender: UIBarButtonItem) {
//        currentWeatherPressed = true
//        dismiss(animated: true, completion: nil)
//        }
}
