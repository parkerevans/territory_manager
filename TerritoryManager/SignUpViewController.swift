//
//  SignUpViewController.swift
//  TerritoryManager
//
//  Created by Administrator on 3/6/15.
//  Copyright (c) 2015 PrivateJets. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    var signupActive = true
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var registerLabel: UILabel!
    
    @IBOutlet weak var congregationIdEntry: UITextField!
    
    @IBOutlet weak var userIdEntry: UITextField!
    
    @IBOutlet weak var userPasswordEntry: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var registerButton: UIButton!
    
    
    
    @IBAction func SignUpLogIn(sender: AnyObject) {
        
        var error = ""
        
        if userIdEntry.text == "" || userPasswordEntry.text == "" || congregationIdEntry.text == "" {
            
            error = "Please enter a username and password and congregation"
            
        }
        
        if error != "" {
            
            displayAlert("Error In Form", error: error)
            
        } else {
        
            displayActivityIndicator()
            
            if signupActive == true {
                
                var user = PFUser()
                user.username = userIdEntry.text
                user.password = userPasswordEntry.text
                
                user.signUpInBackgroundWithBlock {
                    (succeeded: Bool!, signupError: NSError!) -> Void in
                    
                    self.removeActivityIndicator()
                    
                    if signupError == nil  {
                        // Hooray! Let them use the app now.
                        
                        println("signed up")
                        
                        
                    } else {
                        if let errorString = signupError.userInfo?["error"] as? NSString {
                            
                            error = errorString as String
                            
                        } else {
                            
                            error = "Please try again later."
                            
                        }
                        
                        self.displayAlert("Could Not Sign Up", error: error)
                        
                    }
                }
                
            } else {
            
                PFUser.logInWithUsernameInBackground(userIdEntry.text, password:userPasswordEntry.text) {
                    (user: PFUser!, signupError: NSError!) -> Void in
                    
                    
                    self.removeActivityIndicator()
                    
                    if signupError == nil {
                        
                        println("logged in")
                        
                    } else {
                        
                        if let errorString = signupError.userInfo?["error"] as? NSString {
                            
                            error = errorString as String
                            
                        } else {
                            
                            error = "Please try again later."
                            
                        }
                        
                        self.displayAlert("Could Not Log In", error: error)
                        
                    
                    }
                }
            
            
            }
            
        
        
        }

    }
    
    
    @IBAction func registerLoginToggle(sender: AnyObject) {
        
        if signupActive == true {
            
            signupActive = false
            
            titleLabel.text = "Use the form below to log in"
            
            signUpButton.setTitle("Log In", forState: UIControlState.Normal)
            
            registerLabel.text = "Not Registered?"
            
            registerButton.setTitle("Sign Up", forState: UIControlState.Normal)
            
            
        } else {
            
            signupActive = true
            
            titleLabel.text = "Use the form below to sign up"
            
            signUpButton.setTitle("Sign Up", forState: UIControlState.Normal)
            
            registerLabel.text = "Already Registered?"
            
            registerButton.setTitle("Log In", forState: UIControlState.Normal)
            
            
        }

    }
    
    func displayAlert(title:String, error:String) {
        
        var alert = UIAlertController(title: title, message: error, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func displayActivityIndicator() {
        
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
    func removeActivityIndicator() {
        activityIndicator.stopAnimating()
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
