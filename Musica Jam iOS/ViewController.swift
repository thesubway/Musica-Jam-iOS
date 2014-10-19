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
    
    var profileView: UIView!
    var isLoggedIn : Bool!
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
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
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

}

