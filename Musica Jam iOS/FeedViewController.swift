//
//  FeedViewController.swift
//  Musica Jam iOS
//
//  Created by Dan Hoang on 10/18/14.
//  Copyright (c) 2014 Dan Hoang. All rights reserved.
//

import UIKit
import MediaPlayer

class FeedViewController: UIViewController, UIWebViewDelegate {
    let ACTION_MARGIN : CGFloat = 80
    
    var profileView: UIView!
    //keep track of the x from center:
    var xFromCenter : CGFloat = 0
    
    var moviePlayer : MPMoviePlayerController!
    
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
        self.addButtons()
        
        // add movie:
        var movieWidth : CGFloat = self.profileView.bounds.width * 7 / 8
        var movieHeight : CGFloat = self.profileView.bounds.height * 1 / 2
        var movieView = UIWebView()
        //frame: CGRect(x: 20, y: 100, width: movieWidth, height: movieHeight)
        movieView.frame = CGRectMake(self.profileView.bounds.width / 2 - (movieWidth / 2), self.profileView.bounds.height / 2 - (movieHeight / 2), movieWidth, movieHeight)
        movieView.delegate = self
        var request = NSURLRequest(URL: NSURL(string: "http://www.youtube.com/embed/YUivpcGc9Qs"))
        movieView.loadRequest(request)
        self.profileView.addSubview(movieView)
        
        // add name:
        var nameLabel = UILabel()
        //x, y, width, height
        var nameWidth : CGFloat = 70; var nameHeight : CGFloat = 20
        nameLabel.frame = CGRectMake(self.profileView.bounds.width / 2 - (nameWidth / 2), nameHeight, nameWidth, nameHeight)
        nameLabel.text = "Daniel"
        nameLabel.layer.borderColor = UIColor.redColor().CGColor
        nameLabel.layer.borderWidth = 1
        nameLabel.backgroundColor = UIColor.redColor()
        println("name frame: \(nameLabel.frame)")
        self.profileView.addSubview(nameLabel)
    }
    
    func addButtons() {
//        var buttonWidth : CGFloat = self.profileView.bounds.width * 1 / 4
//        var buttonHeight : CGFloat = self.profileView.bounds.height * 1 / 4
        var noButton = UIButton()
        noButton.addTarget(self, action: Selector("sayNo"), forControlEvents: .TouchUpInside)
        noButton.frame = CGRectMake(self.profileView.bounds.width * 1 / 8, self.profileView.bounds.height * 7 / 8, 50, 50)
        noButton.backgroundColor = UIColor.blackColor()
        noButton.setTitle("X", forState: UIControlState.Normal)
        self.profileView.addSubview(noButton)
        
        //now for second button:
        var yesButton = UIButton()
        yesButton.addTarget(self, action: Selector("sayYes"), forControlEvents: .TouchUpInside)
        yesButton.frame = CGRectMake(self.profileView.bounds.width * 7 / 8, self.profileView.bounds.height * 7 / 8, 50, 50)
        yesButton.backgroundColor = UIColor.blackColor()
        yesButton.setTitle("√", forState: UIControlState.Normal)
        self.profileView.addSubview(yesButton)
    }
    
    func sayNo() {
        println("No pressed")
    }
    func sayYes() {
        println("Yes pressed")
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
            if (self.xFromCenter > ACTION_MARGIN)
            {
                self.rightAction()
            }
            else if (xFromCenter < -ACTION_MARGIN)
            {
                self.leftAction()
            }
            else
            {
                
            }
            UIView.animateWithDuration(0.15, animations:
                {
                    println(self.xFromCenter)
                    self.xFromCenter = 0
                    label.center = CGPointMake(self.view.bounds.width / 2, self.view.bounds.height / 2)
                    scale = max(abs(self.xFromCenter)/100, 1)
                    rotation = CGAffineTransformMakeRotation(0)
                    stretch = CGAffineTransformScale(rotation, scale, scale)
                    label.transform = stretch
            })
        }
//        println("Dragged (\(label.center.x),(\(label.center.y)))")
    }
    
    func afterSwipeAction()
    {
        
    }
    
    func rightAction() {
        
    }
    func leftAction() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
