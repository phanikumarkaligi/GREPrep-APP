//
//  detailViewController.swift
//  GREPrep
//
//  Created by Deepthi Kaligi on 25/12/2015.
//  Copyright © 2015 TeamTreeHouse. All rights reserved.
//

import UIKit
import CoreData

class detailViewController: UIViewController {
   var catchingString = ""
    var array : [NSManagedObject] = []
    @IBOutlet weak var lbl : UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "fillTheLabel:", name: "onCellTapped", object: nil)
        lbl.text = catchingString
    }
    
    func fillTheLabel(notification:NSNotification) {
        let dict : Dictionary<String,String> = notification.userInfo as! Dictionary<String,String>
        print(notification.userInfo)
        print("and dictionary is \(dict)")
        
        lbl.text = dict["meaning"]
    }
    
    override func viewDidAppear(animated: Bool) {
        print(catchingString)
       
    }

//    override func viewDidAppear(animated: Bool) {
//       
//   let context = CoreDataStack.instance.managedObjectContext
//    let fetchRequest = NSFetchRequest(entityName: "GREList")
//    fetchRequest.predicate = NSPredicate(format: "name = %@", catchingString)
//    
//        do {
//            array  = try context.executeFetchRequest(fetchRequest) as![NSManagedObject]
//            let obj = array.first
//            lbl.text = obj?.valueForKey("meaning") as? String
//        } catch let error as NSError
//        {
//            print("error occured while fetching \(error)")
//        }
//  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
