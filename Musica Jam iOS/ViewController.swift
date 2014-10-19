//
//  ViewController.swift
//  Musica Jam iOS
//
//  Created by Dan Hoang on 10/18/14.
//  Copyright (c) 2014 Dan Hoang. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController {
    
    @IBOutlet var editButton: UIButton!
    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var imageView : UIImageView!
    var profileView: UIView!
    var isLoggedIn = false
    var name : String!
    var number : Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.editButton.hidden = true
        self.isLoggedIn = false
        var permissions = ["public_profile", "email"]
        Parse.setApplicationId("6KdHDtMQFn1MaqvCLRk0qpmHSWyMqd8NLD1dcAuR", clientKey: "cJkJaSsztnUDyR5C1hw1KQqjTvUfQ0XJYiGgjFim")
        
//        var score = PFObject(className: "score")
//        score.setObject("Rob", forKey: "name")
//        score.setObject(95, forKey: "number")
//        score.saveInBackgroundWithBlock {(success: Bool!, error: NSError!) -> Void in
//            if success == true {
//                println("Score created with ID: \(score.objectId)")
//            }
//            else {
//                var alert = UIAlertView()
//                alert.title = "Failure"
//                alert.message = "Score could not be sent:\n\(error)"
//                alert.addButtonWithTitle("OK")
//            }
//        }
        
        PFFacebookUtils.logInWithPermissions(permissions, { (user: PFUser!, error: NSError!) -> Void in
            if user == nil {
                NSLog("User cancelled login.")
                self.authAgain()
            }
            else if user.isNew {
                NSLog("New user signs up, logs in.")
                self.isLoggedIn = true
                self.loadNew()
            }
            else {
                NSLog("User logs in.")
                self.isLoggedIn = true
                self.loadData()
            }
            
        })
    }
    
    func authAgain() {
        var permissions = ["public_profile", "email"]
        PFFacebookUtils.logInWithPermissions(permissions, { (user: PFUser!, error: NSError!) -> Void in
            if user == nil {
                NSLog("User cancelled login.")
            }
            else if user.isNew {
                NSLog("New user signs up, logs in.")
                self.isLoggedIn = true
                self.loadNew()
            }
            else {
                NSLog("User logs in.")
                self.isLoggedIn = true
                self.loadData()
            }
            
        })
    }
    
    func loadData() {
        var request = FBRequest.requestForMe()
        request.startWithCompletionHandler { (connection : FBRequestConnection!, result : AnyObject!, error : NSError!) -> Void in
            
            var userData : NSDictionary = result as NSDictionary
            var facebookID = userData["id"] as String
            var name = userData["name"] as String
            self.name = name
            self.number = facebookID.toInt()
            var gender = userData["gender"] as String
            
            println("name: \(name)")
            println("gender: \(gender)")
            println("id: \(facebookID)")
            //NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
            var pictureURL = NSURL(string: "https://graph.facebook.com/\(facebookID)/picture?type=large&return_ssl_resources=1")
            var imageData : NSData = NSData.dataWithContentsOfURL(pictureURL, options: nil, error: nil)
            self.imageView.image = UIImage(data: imageData)
            self.welcomeLabel.text = "Hello, \(name)"
            
            
            
            /*
            var score = PFObject(className: "score")
            score.setObject("Rob", forKey: "name")
            score.setObject(95, forKey: "number")
            score.saveInBackgroundWithBlock {(success: Bool!, error: NSError!) -> Void in
            if success == true {
            println("Score created with ID: \(score.objectId)")
            }
            else {
            var alert = UIAlertView()
            alert.title = "Failure"
            alert.message = "Score could not be sent:\n\(error)"
            alert.addButtonWithTitle("OK")
            }
            }
            */
        }
        
    }
    func loadNew() {
        var request = FBRequest.requestForMe()
        request.startWithCompletionHandler { (connection : FBRequestConnection!, result : AnyObject!, error : NSError!) -> Void in
            
            var userData : NSDictionary = result as NSDictionary
            var facebookID = userData["id"] as String
            var name = userData["name"] as String
            self.name = name
            self.number = facebookID.toInt()
            var gender = userData["gender"] as String
            
            println("name: \(name)")
            println("gender: \(gender)")
            println("id: \(facebookID)")
            //NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
            var pictureURL = NSURL(string: "https://graph.facebook.com/\(facebookID)/picture?type=large&return_ssl_resources=1")
            var imageData : NSData = NSData.dataWithContentsOfURL(pictureURL, options: nil, error: nil)
            self.imageView.image = UIImage(data: imageData)
            self.welcomeLabel.text = "Hello, \(name)!"
            
            //name, username, pictureURL, town, store those onto parse.
            var score = PFObject(className: "Prfl")
            score.setObject(name, forKey: "name")
            score.setObject(facebookID.toInt(), forKey: "number")
            //            user.setObject(pictureURL, forKey: "pictureURL")
            score.saveInBackgroundWithBlock {(success: Bool!, error: NSError!) -> Void in
                if success == true {
                    println("Score created with ID: \(score.objectId)")
                }
                else {
                    var alert = UIAlertView()
                    alert.title = "Failure"
                    alert.message = "Score could not be sent:\n\(error)"
                    alert.addButtonWithTitle("OK")
                }
            }
            
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func buttonPressed(sender: AnyObject) {
        
        //retrieving some data from parse:
        var query = PFQuery(className: "Prfl")
        query.whereKey("number", equalTo: self.number)
        query.getFirstObjectInBackgroundWithBlock { (score : PFObject!, error: NSError!) -> Void in
            if error == nil {
                println(score.objectForKey("name"))
                //edit the object here:
                //score["name"] = "Robert"
                var editView = self.storyboard?.instantiateViewControllerWithIdentifier("editView") as EditViewController
                self.navigationController?.pushViewController(editView, animated: true)
            }
            else {
                println(error)
            }
        }
//        query.getObjectInBackgroundWithId("eZT80ovU43") {
//            (score : PFObject!, error: NSError!) -> Void in
//            
//        }
        
    }
    
    
    @IBAction func searchPressed(sender: AnyObject) {
        if self.isLoggedIn == true {
            var feedView = self.storyboard?.instantiateViewControllerWithIdentifier("feedView") as FeedViewController
            feedView.number = self.number
            self.navigationController?.pushViewController(feedView, animated: true)
        }
        else {
            println()
        }
    }
    
    @IBAction func logInPressed(sender: AnyObject) {
        dispatch_after(dispatch_time( DISPATCH_TIME_NOW, Int64(0.1 * Double(NSEC_PER_SEC)) ), dispatch_get_main_queue(), {
            if self.isLoggedIn == false {
                println("Please log in or sign up.")
            }
            else if self.isLoggedIn == true {
                println("Hello!")
                self.loadData()
            }
            
        })
    }

}

