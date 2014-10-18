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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var permissions = ["public_profile", "email"]
        
        PFFacebookUtils.logInWithPermissions(permissions, { (user: PFUser!, error: NSError!) -> Void in
            if user == nil {
                NSLog("Uh oh. The user cancelled the Facebook login.")
            }
            else if user.isNew {
                NSLog("User signed up and logged in through Facebook!")
            }
            else {
                NSLog("User logged in through Facebook!")
            }
        })
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

