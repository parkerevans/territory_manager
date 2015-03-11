//
//  SignUpViewController.swift
//  TerritoryManager
//
//  Created by Administrator on 3/6/15.
//  Copyright (c) 2015 PrivateJets. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var registerLabel: UILabel!
    
    @IBOutlet weak var congregationIdEntry: UITextField!
    
    @IBOutlet weak var userIdEntry: UITextField!
    
    @IBOutlet weak var userPasswordEntry: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var registerButton: UIButton!
    
    
    @IBAction func SignUpLogIn(sender: AnyObject) {
    }
    
    
    @IBAction func registerLoginToggle(sender: AnyObject) {
        
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
