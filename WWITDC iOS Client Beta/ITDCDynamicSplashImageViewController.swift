//
//  ITDCDynamicSplashImageViewController.swift
//  WWITDC iOS Client Beta
//
//  Created by Apollonian on 5/3/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

import UIKit

class ITDCDynamicSplashImageViewController: UIViewController {

    @IBOutlet weak var dynamicImageView: UIImageView!
    @IBOutlet weak var skipButton: UIButton!

    private var timer = NSTimer()

    override func viewDidLoad() {
        super.viewDidLoad()
        if NSUD.boolForKey(HasLaunchImage) {
            if let image = loadImage(){
                dynamicImageView.image = image
                skipButton.layer.cornerRadius = 5
                skipButton.layer.masksToBounds = true
                skipButton.layer.borderColor = UIColor.grayColor().CGColor
                skipButton.layer.borderWidth = 3
                timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(segueToMain), userInfo: nil, repeats: false)
            }
        } else {
            view.hidden = true
        }
    }

    override func viewDidAppear(animated: Bool) {
        if view.hidden {
            segueToMain()
        } else {
            super.viewDidAppear(animated)
        }
    }

    @IBAction func segueToMain() {
        timer.invalidate()
        performSegueWithIdentifier("SplashToMain", sender: nil)
    }

    private func loadImage() -> UIImage?{
        let imageFilePath = cachesDirectory + "/launchImage"
        let imageData = NSData(contentsOfFile: imageFilePath)
        if let data = imageData{
            let image = UIImage(data: data)
            return image
        }
        return nil
    }
    
}
