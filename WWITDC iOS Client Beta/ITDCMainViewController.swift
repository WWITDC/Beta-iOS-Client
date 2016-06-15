//
//  ViewController.swift
//  WWITDC iOS Client Beta
//
//  Created by Apollonian on 5/3/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

import UIKit

class ITDCMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Async to download image
    }

    func downloadDynamicLaunchImage(){
        SUD.set(true, forKey: HasLaunchImage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        cleanUp()
    }
}

