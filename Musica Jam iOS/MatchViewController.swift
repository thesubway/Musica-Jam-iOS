//
//  MatchViewController.swift
//  Musica Jam iOS
//
//  Created by Dan Hoang on 10/19/14.
//  Copyright (c) 2014 Dan Hoang. All rights reserved.
//

import UIKit

class MatchViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var textField : UITextField!
    @IBOutlet var textDisplay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var alert: UIAlertView = UIAlertView()
        alert.title = ""
        alert.message = "You are matched!"
        alert.addButtonWithTitle("Ok")
        alert.show()
        self.textField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.textDisplay.text = self.textField.text
        return true
    }
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
    }

}
