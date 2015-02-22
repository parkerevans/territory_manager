//
//  TerritoriesTableViewController.swift
//  TerritoryManager
//
//  Created by Administrator on 12/3/14.
//  Copyright (c) 2014 PrivateJets. All rights reserved.
//

import UIKit
import CoreData

/*
// to use SideBar we need to implement its protocol
// class TerritoriesTableViewController: UITableViewController, UITableViewDataSource, SideBarDelegate
*/
class TerritoriesTableViewController: UITableViewController, UITableViewDataSource {
    
    // var sideBar : SideBar = SideBar()
    
    // var names = [String]()
    var territories = [Territory]()
    var service : TerritoryService!
    var congregation:String = Settings.congregation.congregationId

    
    @IBOutlet var territoriesTable: UITableView!
    
    @IBAction func addTerr(sender: AnyObject) {
        
        var alert = UIAlertController(title: "New Territory", message: "Add a new territory number", preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save",
            style: .Default) { (action: UIAlertAction!) -> Void in
                
                let textField = alert.textFields![0] as UITextField
                let statusField = "In"
                let category = "Regular"
                println("Congregation value in Controller is: \(self.congregation)")
                self.territories = []
                self.service = TerritoryService()
                self.service.saveTerritory("Territory", id: textField.text.toInt()!, status:statusField, category:category, congregationId:self.congregation){
                    (response) in
                    self.loadTerritories(response as [Territory])
                }

        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
            style: .Default) { (action: UIAlertAction!) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert, animated: true, completion: nil)
        
        
        // names.append("New Item")
        // territoriesTable.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Implementing SideBar
        // sideBar = SideBar(sourceView: self.view, menuItems: ["first item", "second item", "third item"])
        // sideBar.delegate = self
        */
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Additional ViewController method
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        /*
        // Using Core Data Fetching to load the table
        
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        let fetchRequest = NSFetchRequest(entityName:"Territory")
        
        //3
        var error: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest,error: &error) as[NSManagedObject]?
        
        if let results = fetchedResults {
            territories = results
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        
        */
        
        
        self.territories = []
        service = TerritoryService()
        service.getTerritory("Territory", congregationId: congregation) {
                (response) in
            self.loadTerritories(response as [Territory])
        }
        
        
    }
    
    func loadTerritories(territories:[Territory]) {
        
        for territory in territories {
            var currentTerritory:Territory = Territory()
            currentTerritory.territoryId = territory.territoryId
            currentTerritory.status = territory.status
            currentTerritory.category = territory.category
            currentTerritory.objectId = territory.objectId
            currentTerritory.congregationId = territory.congregationId
            self.territories.append(currentTerritory)
            
            // to refresh the UI in Asyn mode, we need to dispath the main queue
            /*
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
            */
            self.tableView.reloadData()
        }
        

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
        return territories.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TerritoryCell", forIndexPath: indexPath) as UITableViewCell
        if !(territories.isEmpty) {
            println(territories[indexPath.row].territoryId)
            let territory = territories[indexPath.row]
            let toTerritoryIdInt = territory.territoryId!
            cell.textLabel?.text = "\(toTerritoryIdInt)"
            cell.detailTextLabel?.text = territory.status
        }

        return cell
    }
    
    
    // Custom function to save the territory using CoreData
    func saveCoreTerritory(id: String) {
        /* When using Core Data follow these 5 steps
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        let entity =  NSEntityDescription.entityForName("Territory",
            inManagedObjectContext:
            managedContext)
        
        let territory = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext:managedContext)
        
        //3
        territory.setValue(id, forKey: "id")
        territory.setValue("Available", forKey: "status")
        
        //4
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }  
        //5
        territories.append(territory)

        */
        
        // self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    // Implement Customed SideBar Delegation Method
    func sideBarDidSelectButtonAtIndex(index: Int) {
        
        // var alert = UIAlertController(title: "What Option?", message: "Option 1", preferredStyle: .Alert)
        var alert = UIAlertController()
        let okAction = UIAlertAction(title: "OK",
            style: .Default) { (action: UIAlertAction!) -> Void in
        }
        alert.addAction(okAction)
        
        if index == 0 {
            alert.title = "What Option?"
            alert.message = "Option 1"
            presentViewController(alert, animated: true, completion: nil)
            
        } else if index == 1 {
            alert.title = "What Option?"
            alert.message = "Option 2"
            presentViewController(alert, animated: true, completion: nil)
        }
        
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
        
        var indexPath:NSIndexPath = self.tableView.indexPathForSelectedRow()!
        var selectedCell:UITableViewCell = self.tableView.cellForRowAtIndexPath(indexPath)!
        let currentTerritory = territories[indexPath.row] as Territory
        
        var territoryLogVC : TerritoryLogTableTableViewController = segue.destinationViewController as TerritoryLogTableTableViewController
        
        territoryLogVC.currentTerritory = currentTerritory
        
        // println("Object is \(territories[indexPath.row].objectId)")
    }

}
