//
//  HoboTableViewController.swift
//  HoboApp
//
//  Created by WLD_MBP_20 on 03/11/2015.
//  Copyright (c) 2015 probert. All rights reserved.
//

import UIKit
import Parse

class HoboTableViewController: UITableViewController {

    var hoboArr = [PFObject]()
    
    // MARK: Create new Hobo Object
    
    @IBAction func add(sender: AnyObject) {
     
        if PFUser.currentUser() == nil{
            
            return
        }
        
        let hobo = PFObject(className:"Hobo")
        
        hobo.setObject("THING", forKey: "type")
        hobo.setObject("<h1>A HEADING</h1>", forKey: "heading")
        hobo.setObject("<h1>SUBHEADING</h1>", forKey: "subheading")
        hobo.setObject("<p>COPY</p>", forKey: "copy")
        hobo.setObject(PFUser.currentUser()!, forKey: "parent")
        
        hobo.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                
                // also add Hobo object to the Users relation hobos
                let user = PFUser.currentUser()!
                let relation = user.relationForKey("hobos")
                relation.addObject(hobo)
                
                user.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                    
                    if success {
                        
                        self.loadHobos()
                        
                    }else{
                        
                        print(error?.description)
                    }
                }
                
            } else {
                
                // Oops! what went wrong?
                print(error!.debugDescription)
            }
        }
    }
    
    func loadHobos() {
        
        // load the data
        
        let query = PFQuery(className:"Hobo")
        query.whereKey("parent", equalTo: PFUser.currentUser()!)
        query.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) Hobos.")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        print(object.objectId)
                    }
                }
                
                self.hoboArr = objects!
                // reload data
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    // MARK: Boilerplate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // load the Current Users Hobo objects
        if PFUser.currentUser() != nil{
            
            self.loadHobos()
        }
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: "loadHobos", forControlEvents: .ValueChanged)
        self.tableView.addSubview(self.refreshControl!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return hoboArr.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("hoboCell", forIndexPath: indexPath) 
        let dataObject:PFObject = hoboArr[indexPath.row]
        cell.textLabel?.text = dataObject.objectForKey("heading") as? String
        
        let user:PFUser? = dataObject.objectForKey("parent") as? PFUser
        
        if user != nil {
            
            cell.detailTextLabel?.text = user!.email
        }
        
        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
