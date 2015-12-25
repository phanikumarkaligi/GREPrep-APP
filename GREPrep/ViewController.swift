//
//  ViewController.swift
//  GREPrep
//
//  Created by Deepthi Kaligi on 24/12/2015.
//  Copyright © 2015 TeamTreeHouse. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {

    @IBOutlet weak var wordlbl: UILabel!
    @IBOutlet weak var meaninglbl:UILabel!
    
    
    var words = [String]()
    var meanings = [String]()
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
         model()
      view.backgroundColor = randomColor()
        
    }

 
    func model() {
        
    let wordsPath = NSBundle.mainBundle().pathForResource("wordList", ofType: "plist")
        if   let dict = NSDictionary(contentsOfFile: wordsPath!) as? [String:AnyObject]
        {
            words = dict["wordList"] as! [String]

        }
let meaningsPath = NSBundle.mainBundle().pathForResource("meaningList", ofType: "plist")
        if   let dict = NSDictionary(contentsOfFile: meaningsPath!) as? [String:[String]]
        {
            meanings = dict["meaningLists"]!
            
        }

 }
    
    @IBAction func nextSwiped(sender:UIGestureRecognizer!) {
        if counter < 4814 {
            counter++
            wordlbl.text = words[counter]
            meaninglbl.text = ""
        } else {
            let actionController = UIAlertController(title: "That's All", message: "Hey.. No more Words to Show", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "Done", style: .Default, handler: { (action) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
            })
            actionController.addAction(action)
            presentViewController(actionController, animated: true, completion: nil)
        }
        
       
        view.backgroundColor = randomColor()
    }
    
    @IBAction func previousSwiped(sender:UIGestureRecognizer!) {
        if counter > 0 {
            counter--
            wordlbl.text = words[counter]
            meaninglbl.text = ""
        } else {
            let actionController = UIAlertController(title: "NO Words Before", message: "Hey.. No Words Before Swipe Forward", preferredStyle: UIAlertControllerStyle.Alert)
         let action = UIAlertAction(title: "OK GOT IT", style: .Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
         })
        actionController.addAction(action)
        presentViewController(actionController, animated: true, completion: nil)
   }
        view.backgroundColor = randomColor()
    }
    
    
    @IBAction func showAnswerBtnTapped(sender:UIButton!) {
        meaninglbl.text = meanings[counter]
        
    }
    
    
    @IBAction func markButtonTapped(sender:UIButton!) {
       let context = CoreDataStack.instance.managedObjectContext
        
       let wordEntity = NSEntityDescription.entityForName("GREList", inManagedObjectContext: context)
        
        let request = NSFetchRequest(entityName: "GREList")
        do {
            let results = try context.executeFetchRequest(request) as? [NSManagedObject]
            for result in results! {
        if result.valueForKey("word") as? String == wordlbl.text {
                    return
                }
            }
        } catch let err as NSError {
            print(err)
        }
        
        
        let wordManagedObject = NSManagedObject(entity: wordEntity!, insertIntoManagedObjectContext: context)
        wordManagedObject.setValue(wordlbl.text!, forKey: "word")
        wordManagedObject.setValue(meanings[counter], forKey: "meaning")
      
        do {
            try context.save()
        }catch let error as NSError {
            print("error occured \(error) \n \(error.debugDescription)")
        }
    }
    
    func randomColor() -> UIColor {
        let color = UIColor(hue: CGFloat(arc4random()%256)/256.0, saturation: (CGFloat(arc4random()%128)/256.0)+0.2, brightness: (CGFloat(arc4random()%128)/256.0)+0.5, alpha: 1.0)
        return color
    }
      
    
    
    
    
    
    
}

