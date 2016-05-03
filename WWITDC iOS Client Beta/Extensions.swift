//
//  Extensions.swift
//  WWITDC iOS Client Beta
//
//  Created by Apollonian on 5/3/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

import Foundation
import UIKit

let NSUD = NSUserDefaults.standardUserDefaults()
let HasLaunchImage = "hasDynamicImage"
let LaunchImageValidatingDate = "dynamicImageStartDisplayingDate"
let LaunchImageExpiringDate = "dynamicImageStopDisplayingDate"
let LaunchImageHyperlink = "dynamicHyperLink"
let cachesDirectory = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)[0]
let publicFileManager = NSFileManager.defaultManager()
let logFilePath = cachesDirectory + "/log.txt"

func log(message: String){
    if publicFileManager.fileExistsAtPath(logFilePath){
        if let outputStream = NSOutputStream(toFileAtPath: logFilePath, append: true){
            outputStream.write(message)
            outputStream.close()
        }
    }
}

extension UIViewController{
    func cleanUp() {
        if NSUD.boolForKey(HasLaunchImage){
            let imagePath = cachesDirectory + "/launchImage"
            if publicFileManager.fileExistsAtPath(imagePath) {
                do {
                    try publicFileManager.removeItemAtPath(imagePath)
                    NSUD.setBool(false, forKey: HasLaunchImage)
                } catch {
                    log("Error when removing launch image\n")
                }
            }
        }
        if publicFileManager.fileExistsAtPath(logFilePath){
            do {
                try publicFileManager.removeItemAtPath(logFilePath)
            } catch {
                log("Error when removing launch iamge\n")
            }
        }
    }
}


// Rob - Stack Overflow
extension NSOutputStream {
    func write(string: String, encoding: NSStringEncoding = NSUTF8StringEncoding, allowLossyConversion: Bool = true) -> Bool{
        if let data = string.dataUsingEncoding(encoding, allowLossyConversion: allowLossyConversion) {
            var bytes = UnsafePointer<UInt8>(data.bytes)
            var bytesRemaining = data.length
            var totalBytesWritten = 0

            while bytesRemaining > 0 {
                let bytesWritten = self.write(bytes, maxLength: bytesRemaining)
                if bytesWritten < 0 {
                    return false
                }

                bytesRemaining -= bytesWritten
                bytes += bytesWritten
                totalBytesWritten += bytesWritten
            }
            return true
        }
        return false
    }
}