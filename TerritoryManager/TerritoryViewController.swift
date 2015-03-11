//
//  TerritoryViewController.swift
//  TerritoryManager
//
//  Created by Hugo Conde on 2/23/15.
//  Copyright (c) 2015 PrivateJets. All rights reserved.
//

import UIKit

class TerritoryViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let territoryTypesData = ["Regular", "Business", "Other"]
    var territories = [Territory]()
    var service : TerritoryService!
    var congregation:String = Settings.congregation.congregationId
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()

    @IBOutlet weak var territoryEntry: UITextField!
    
    @IBOutlet weak var territoryTypePicker: UIPickerView!
    
    
    @IBAction func cancelButton(sender: AnyObject) {
        // self.navigationController?.popToRootViewControllerAnimated(true)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func createButton(sender: AnyObject) {
        let textField = territoryEntry as UITextField
        let statusField = "In"
        let category = territoryTypesData[self.territoryTypePicker.selectedRowInComponent(0)]
        // println("Congregation value in Controller is: \(self.congregation)")
        
        displayActivityIndicator()
        self.territories = []
        self.service = TerritoryService()
        self.service.addTerritory("Territory", id: textField.text.toInt()!, status:statusField, category:category, congregationId:self.congregation)
        
        removeActivityIndicator()

        if self.service.saveError == nil {
            
            displayAlert("Success", message: "Territory \(textField.text) has been saved.")
        
        } else {
            // do something else
            displayAlert("Error When Saving Record", message: self.service.saveError?.userInfo?["error"] as NSString)
        }
        
    }
    
    func displayAlert(title:String, message:String) {
        
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
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
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(pickerView: UIPickerView,
        numberOfRowsInComponent component: Int) -> Int {
            
        return territoryTypesData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return territoryTypesData[row]
    }


}
