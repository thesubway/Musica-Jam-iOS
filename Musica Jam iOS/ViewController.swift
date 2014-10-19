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
    
    @IBOutlet var imageView : UIImageView!
    var profileView: UIView!
    var isLoggedIn = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isLoggedIn = false
        var permissions = ["public_profile", "email"]
        
        PFFacebookUtils.logInWithPermissions(permissions, { (user: PFUser!, error: NSError!) -> Void in
            if user == nil {
                NSLog("User cancelled login.")
            }
            else if user.isNew {
                NSLog("New user signs up, logs in.")
                self.isLoggedIn = true
            }
            else {
                NSLog("User logs in.")
                self.isLoggedIn = true
            }
        })
    }
    
    
    func loadData() {
        var request = FBRequest.requestForMe()
        request.startWithCompletionHandler { (connection : FBRequestConnection!, result : AnyObject!, error : NSError!) -> Void in
            
            var userData : NSDictionary = result as NSDictionary
            var facebookID = userData["id"] as String
            var name = userData["name"] as String
//            var location = userData["location"]
            var gender = userData["gender"] as String
            
            println("name: \(name)")
            println("gender: \(gender)")
            println("id: \(facebookID)")
            //NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
            var pictureURL = NSURL(string: "https://graph.facebook.com/\(facebookID)/picture?type=large&return_ssl_resources=1")
            var imageData : NSData = NSData.dataWithContentsOfURL(pictureURL, options: nil, error: nil)
            self.imageView.image = UIImage(data: imageData)
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
        if self.isLoggedIn == true {
            var feedView = self.storyboard?.instantiateViewControllerWithIdentifier("feedView") as FeedViewController
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

