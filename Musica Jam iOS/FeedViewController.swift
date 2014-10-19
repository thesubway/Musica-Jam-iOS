//
//  FeedViewController.swift
//  Musica Jam iOS
//
//  Created by Dan Hoang on 10/18/14.
//  Copyright (c) 2014 Dan Hoang. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    var profileView: UIView!
    //keep track of the x from center:
    var xFromCenter : CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var viewWidth : CGFloat = self.view.bounds.width * 2 / 3
        var viewHeight : CGFloat = self.view.bounds.height * 2 / 3
        var viewFrame = CGRectMake(self.view.bounds.width / 2 - (viewWidth / 2),self.view.bounds.height / 2 - (viewHeight / 2),viewWidth,viewHeight)
        self.profileView = UIView()
        self.profileView.backgroundColor = UIColor.greenColor()
        self.profileView.frame = viewFrame
        //        label.image = UIImage(named: "")
        //        label.textAlignment = NSTextAlignment.Center
        self.view.addSubview(self.profileView)
        var gesture = UIPanGestureRecognizer(target : self, action: Selector("wasDragged:"))
        self.profileView.addGestureRecognizer(gesture)
        //tell xcode you want to make this interactive:
        self.profileView.userInteractionEnabled = true
    }
    
    func wasDragged(gesture: UIPanGestureRecognizer) {
        //now figure out how much it actually was dragged
        //gives translation in the particular bit of the drag:
        let translation = gesture.translationInView(self.view)
        var label = gesture.view!
        
        var scale = min(100 / abs(xFromCenter), 1)
        
        self.xFromCenter += translation.x
        //add x's center to distance in the horizontal direction, same for y:
        label.center = CGPoint(x: label.center.x + translation.x, y: label.center.y + translation.y)
        //now reset translation back to 0, since it has moved:
        gesture.setTranslation(CGPointZero, inView: self.view)
        var rotation:CGAffineTransform = CGAffineTransformMakeRotation(xFromCenter / 200)
        var stretch : CGAffineTransform = CGAffineTransformScale(rotation, scale, scale)
        label.transform = stretch
        if label.center.x < 100 {
            println("Not Chosen")
        } else if label.center.x > self.view.bounds.width - 100 {
            println("Chosen")
        }
        if gesture.state == UIGestureRecognizerState.Ended {
            xFromCenter = 0
            label.center = CGPointMake(self.view.bounds.width / 2, self.view.bounds.height / 2)
            scale = max(abs(xFromCenter)/100, 1)
            rotation = CGAffineTransformMakeRotation(0)
            stretch = CGAffineTransformScale(rotation, scale, scale)
            label.transform = stretch
        }
        println("Dragged (\(label.center.x),(\(label.center.y)))")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
