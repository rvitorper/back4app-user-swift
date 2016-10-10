//
//  ViewController.swift
//  BasicUserRegistration-Swift
//
//  Created by Ramon Vitor on 09/10/16.
//  Copyright © 2016 back4app. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var textUsername: UITextField!
    
    @IBOutlet weak var textPassword: UITextField!
    
    func alert(message: NSString, title: NSString) {
        let alert = UIAlertController(title: title as String, message: message as String, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)

    }
    
    @IBAction func login(_ sender: AnyObject) {
        // Retrieving the info from the text fields
        let username = textUsername.text
        let password = textPassword.text
        
        // Defining the user object
        PFUser.logInWithUsername(inBackground: username!, password: password!, block: {(user, error) -> Void in
            if let error = error as NSError? {
                let errorString = error.userInfo["error"] as? NSString
                self.alert(message: errorString!, title: "Error")
            }
            else {
                self.alert(message: "Welcome back!", title: "Login")
            }
        })
    }
    
    @IBAction func register(_ sender: AnyObject) {
        // Retrieving the info from the text fields
        let username = textUsername.text
        let password = textPassword.text
        
        // Defining the user object
        let user = PFUser()
        user.username = username
        user.password = password
        
        // We won't set the email for this example;
        // Just for simplicity
        
        // Signing up using the Parse API
        user.signUpInBackground {
            (success, error) -> Void in
            if let error = error as NSError? {
                let errorString = error.userInfo["error"] as? NSString
                self.alert(message: errorString!, title: "Error")
                
            } else {
                self.alert(message: "Registered successfully", title: "Registering")
            }
        }
    }

}

