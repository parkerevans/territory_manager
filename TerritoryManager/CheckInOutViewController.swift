//
//  CheckInOutViewController.swift
//  TerritoryManager
//
//  Created by Administrator on 12/18/14.
//  Copyright (c) 2014 PrivateJets. All rights reserved.
//

import UIKit

class CheckInOutViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    
    @IBOutlet weak var publisherPicker: UIPickerView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var currentTerritory:Territory?
    var lastCheckOutDate:AnyObject?
    var service:TerritoryLogService!
    let congregation:String = Settings.congregation.congregationId
    
    let publisherData = ["Tim Cook", "Frank Cordero", "William Conde", "Fran Campbell", "Hugo Conde", "Rita Ferreira", "Gail Muller"]
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return publisherData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return publisherData[row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func saveData(sender: AnyObject) {
        // grab the selected date from the date picker
        var chosenDate = self.datePicker.date
        var checkInDate:AnyObject?
        var checkOutDate:AnyObject?
        var chosenPublisher = publisherData[self.publisherPicker.selectedRowInComponent(0)]
        // println("Selected Publisher is: \(chosenPublisher)")
        
        // create an NSDateFormatter
        // var formatter = NSDateFormatter()
        // formatter.dateFormat = "EEEE"
        // let result = formatter.stringFromDate(chosenDate)
        let null = NSNull()
        var action:String?
        var parent = currentTerritory?.objectId!
        
        if currentTerritory?.status == "In" {
            checkOutDate = chosenDate
            checkInDate = null
            action = "CHECKOUT"
            // println("Checked Out!")
        } else {
            checkInDate = chosenDate
            checkOutDate = lastCheckOutDate
            action = "CHECKIN"
            // println("Checked In")
        }
        
        println("Parent is: \(parent), Current Status is : \(currentTerritory?.status), Check Out Date is: \(checkOutDate)")
        
        // Save the data in Parse.com
        service = TerritoryLogService()
        service.saveTerritoryLog("TerritoryLog",congregationId: congregation, currentTerritoryId: currentTerritory!.territoryId!, checkInDate: checkInDate, checkOutDate: checkOutDate, chosenPublisher: chosenPublisher, parent: parent!, action:action!)
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
    
        // create alert controller
        /*
        let saveAlert = UIAlertController(title: "Date", message: "The date is: \(result)", preferredStyle: UIAlertControllerStyle.Alert)
        
        saveAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
            alertAction in
            println("Territory id is: \(sentTerritoryId)")
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        // show alert
        self.presentViewController(saveAlert, animated: true, completion: nil)
        
        */
        
        
        
    }
    
    @IBAction func cancelData(sender: AnyObject) {
        
        // self.navigationController?.popToRootViewControllerAnimated(true)
        self.dismissViewControllerAnimated(true, completion: nil)
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
