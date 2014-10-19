//
//  MatchViewController.swift
//  Musica Jam iOS
//
//  Created by Dan Hoang on 10/19/14.
//  Copyright (c) 2014 Dan Hoang. All rights reserved.
//

import UIKit

class MatchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var alert: UIAlertView = UIAlertView()
        alert.title = ""
        alert.message = "You are matched!"
        alert.addButtonWithTitle("Ok")
        alert.show()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
