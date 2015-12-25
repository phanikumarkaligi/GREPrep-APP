//
//  markedList.swift
//  GREPrep
//
//  Created by Deepthi Kaligi on 24/12/2015.
//  Copyright © 2015 TeamTreeHouse. All rights reserved.
//

import UIKit
import CoreData

class markedList: UITableViewController {
    var context : NSManagedObjectContext!
    var model : NSManagedObjectModel!
    var markedListArray :[NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
     // fetch()
     // deleteBatch()
    }

    func fetch() {
        context = CoreDataStack.instance.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "GREList")
        
        do {
            
            let results = try context.executeFetchRequest(fetchRequest)
    
          markedListArray = results as! [NSManagedObject]
          self.tableView.reloadData()
        } catch let error as NSError {
            print("error occured while fetching \(error) \n \(error.debugDescription)")
        }
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return markedListArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("cells", forIndexPath: indexPath) as? UITableViewCell {
            let managedobj = markedListArray[indexPath.row]
           cell.textLabel?.text = managedobj.valueForKey("word") as? String
            cell.detailTextLabel?.text = managedobj.valueForKey("meaning") as? String
            return cell
        }
        
        let cell = UITableViewCell()
            cell.textLabel?.text = "NO RECORD"
            cell.detailTextLabel?.text = "no record"
            return cell
  }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let managedobj = markedListArray[indexPath.row]
        let str = managedobj.valueForKey("meaning") as! String
        print(str)
    NSNotificationCenter.defaultCenter().postNotificationName("onCellTapped", object: nil, userInfo: ["meaning":str])
       
        performSegueWithIdentifier("toDetailVC", sender: str)
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toDetailVC" {
            let dvc = segue.destinationViewController as? detailViewController
            if let poke = sender as? String {
                dvc?.catchingString = poke
            }
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // how to delete data from core data 
    
    func deleteBatch() {
        
        let context = CoreDataStack.instance.managedObjectContext
        let psc = CoreDataStack.instance.persistentStoreCoordinator
        let req = NSFetchRequest(entityName: "GREList")
        let batchReq = NSBatchDeleteRequest(fetchRequest: req)
        
        do {
            try psc.executeRequest(batchReq, withContext: context)
        }catch let error as NSError {
            print("error occured while deleting \(error), \(error.description)")
        }
 }

    override func viewDidAppear(animated: Bool) {

//        tabBarController?.tabBarItem.selectedImage = UIImage(named: "BookmarksFilled")
      // deleteBatch()
       fetch()
       tableView.reloadData()
    }
    
  override  func viewDidDisappear(animated: Bool) {
//    tabBarController?.tabBarItem.selectedImage = UIImage(named: "Bookmarks")

    }
    
    
    
    
    
    
    
}
