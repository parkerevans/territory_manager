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

    @IBOutlet weak var territoryTypePicker: UIPickerView!
    

    @IBOutlet weak var territoryEntry: UITextField!
    
    
    @IBAction func cancelButton(sender: AnyObject) {
        
    }
    
    
    @IBAction func createButton(sender: AnyObject) {
        
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
