//
//  TerritoryLogTableTableViewController.swift
//  TerritoryManager
//
//  Created by Administrator on 12/3/14.
//  Copyright (c) 2014 PrivateJets. All rights reserved.
//

import UIKit

class TerritoryLogTableTableViewController: UITableViewController {
    
    var currentTerritory:Territory?
    // var currentTerritoryId:String? = ""
    var territoryLogs = [TerritoryLog]()
    var service : TerritoryLogService!


    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return territoryLogs.count
    }
    
    // Additional ViewController method
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var currentTerritoryId = self.currentTerritory?.territoryId
        self.territoryLogs = []
        service = TerritoryLogService()
        service.getTerritoryLog("TerritoryLog", currentTerritoryId: currentTerritoryId!) {
            (response) in
            self.loadTerritoryLogs(response as NSArray)
            
        }
        
        self.title = "Territory \(currentTerritoryId!)"

    }

    func loadTerritoryLogs(territoryLogs:NSArray) {
        
        for territoryLog in territoryLogs {
            var currentTerritoryLog:TerritoryLog = TerritoryLog()
            currentTerritoryLog.territoryId = territoryLog.territoryId
            currentTerritoryLog.checkinDate = territoryLog.checkinDate
            currentTerritoryLog.checkoutDate = territoryLog.checkoutDate
            currentTerritoryLog.publisherId = territoryLog.publisherId
            self.territoryLogs.append(currentTerritoryLog)
            
            // to refresh the UI in Async mode, we need to dispatch the main queue
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
            
        }
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LogCell", forIndexPath: indexPath) as UITableViewCell
        
        let territoryLog = territoryLogs[indexPath.row]
        var mainLabel = ""
        if territoryLog.checkinDate is NSNull {
            mainLabel = "In: " + "XX/XX/XX" +
                "   Out: " + formatDate(territoryLog.checkoutDate!)
        } else {
            mainLabel = "In: " + formatDate((territoryLog.checkinDate! as NSDate)) +
                "   Out: " + formatDate(territoryLog.checkoutDate!)
        }
        

        cell.textLabel?.text = mainLabel
        // cell.detailTextLabel?.text = territory.valueForKey("status") as String?
        cell.detailTextLabel?.text = territoryLog.publisherId
        
        return cell

    }
    
    // Custom function to format the date on the table view
    func formatDate(date:NSDate?) -> String {
        var result = ""
        if date == nil {
            result = ""
        } else {
            // create an NSDateFormatter
            let formatter = NSDateFormatter()
            formatter.dateStyle = NSDateFormatterStyle.ShortStyle
            result = formatter.stringFromDate(date!)
        }
        
        return result
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        var checkinOutVC : CheckInOutViewController = segue.destinationViewController as CheckInOutViewController
        
        checkinOutVC.currentTerritoryId = self.currentTerritory?.territoryId
        checkinOutVC.currentTerritory = currentTerritory
        println("Territory Log for territory id = \(self.currentTerritory?.territoryId)")
        
    }
    

}
