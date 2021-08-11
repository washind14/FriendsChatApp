//
//  SignUpViewController.swift
//  FriendsChatApp
//
//  Created by Desha Washington on 6/30/21.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
             let alert = UIAlertController(title: "Error creating an account", message: e.localizedDescription, preferredStyle: UIAlertController.Style.alert)
             alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
             self.present(alert, animated: true, completion: nil)
                } else {
                    self.performSegue(withIdentifier: K.signUpSegue, sender: self)
                }
            }
        }
    }
}
