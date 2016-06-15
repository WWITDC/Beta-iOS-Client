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

    private var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        if SUD.bool(forKey: HasLaunchImage) {
            if let image = loadImage(){
                dynamicImageView.image = image
                skipButton.layer.cornerRadius = 5
                skipButton.layer.masksToBounds = true
                skipButton.layer.borderColor = UIColor.gray().cgColor
                skipButton.layer.borderWidth = 3
                timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(segueToMain), userInfo: nil, repeats: false)
            }
        } else {
            view.isHidden = true
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        if view.isHidden {
            segueToMain()
        } else {
            super.viewDidAppear(animated)
        }
    }

    @IBAction func segueToMain() {
        timer.invalidate()
        performSegue(withIdentifier: "SplashToMain", sender: nil)
    }

    private func loadImage() -> UIImage?{
        let imageFilePath = cachesDirectory + "/launchImage"
        let imageData = try? Data(contentsOf: URL(fileURLWithPath: imageFilePath))
        if let data = imageData{
            let image = UIImage(data: data)
            return image
        }
        return nil
    }
    
}
