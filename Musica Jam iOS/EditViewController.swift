//
//  EditViewController.swift
//  Musica Jam iOS
//
//  Created by Dan Hoang on 10/19/14.
//  Copyright (c) 2014 Dan Hoang. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class EditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let captureSession = AVCaptureSession()
    var previewLayer : AVCaptureVideoPreviewLayer?
    var imagePicker : UIImagePickerController!
    var moviePlayerViewController = MPMoviePlayerViewController()
    
    // If we find a device we'll store it here for later use
    var captureDevice : AVCaptureDevice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        captureSession.sessionPreset = AVCaptureSessionPresetHigh
//        
//        let devices = AVCaptureDevice.devices()
//        
//        // Loop through all the capture devices on this phone
//        for device in devices {
//            // Make sure this particular device supports video
//            if (device.hasMediaType(AVMediaTypeVideo)) {
//                // Finally check the position and confirm we've got the back camera
//                if(device.position == AVCaptureDevicePosition.Back) {
//                    captureDevice = device as? AVCaptureDevice
//                    if captureDevice != nil {
//                        println("Capture device found")
//                        beginSession()
//                    }
//                }
//            }
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        println("MEMORY LOW")
    }
    
//    func beginSession() {
//        
//        configureDevice()
//        
//        var err : NSError? = nil
//        captureSession.addInput(AVCaptureDeviceInput(device: captureDevice, error: &err))
//        
//        if err != nil {
//            println("error: \(err?.localizedDescription)")
//        }
//        
//        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//        self.view.layer.addSublayer(previewLayer)
//        previewLayer?.frame = self.view.layer.frame
//        captureSession.startRunning()
//    }
//    
//    func configureDevice() {
//        if let device = captureDevice {
//            device.lockForConfiguration(nil)
//            device.focusMode = .Locked
//            device.unlockForConfiguration()
//        }
//        
//    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            var videoRecorder = UIImagePickerController()
            videoRecorder.delegate = self
            var sourceTypes = UIImagePickerController.availableMediaTypesForSourceType(videoRecorder.sourceType)
            println("Available types for source as camera : \(sourceTypes)")
            videoRecorder.cameraDevice = UIImagePickerControllerCameraDevice.Front
            videoRecorder.sourceType = UIImagePickerControllerSourceType.Camera
//            videoRecorder.mediaTypes = NSArray(object: (NSString)kUTTypeMovie)
            videoRecorder.videoQuality = UIImagePickerControllerQualityType.TypeLow
            videoRecorder.videoMaximumDuration = 120
            self.imagePicker = videoRecorder
            self.presentMoviePlayerViewControllerAnimated(self.moviePlayerViewController)
        }
    }

}
