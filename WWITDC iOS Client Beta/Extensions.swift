//
//  Extensions.swift
//  WWITDC iOS Client Beta
//
//  Created by Apollonian on 5/3/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

import Foundation
import UIKit

/// Standard User Defaults
let SUD = UserDefaults.standard()
let HasLaunchImage = "hasDynamicImage"
let LaunchImageValidatingDate = "dynamicImageStartDisplayingDate"
let LaunchImageExpiringDate = "dynamicImageStopDisplayingDate"
let LaunchImageHyperlink = "dynamicHyperLink"
let cachesDirectory = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
/// Default File Manager
let DFM = FileManager.default()
let logFilePath = cachesDirectory + "/log.txt"

func log(_ message: String){
    if DFM.fileExists(atPath: logFilePath){
        if let outputStream = NSOutputStream(toFileAtPath: logFilePath, append: true){
            do{
                try outputStream.write(message)
                outputStream.close()
            } catch {
                NSLog("WWITDC iOS Client Beta Log Error")
            }
        }
    }
}

extension UIViewController{
    func cleanUp() {
        if SUD.bool(forKey: HasLaunchImage){
            let imagePath = cachesDirectory + "/launchImage"
            if DFM.fileExists(atPath: imagePath) {
                do {
                    try DFM.removeItem(atPath: imagePath)
                    SUD.set(false, forKey: HasLaunchImage)
                } catch {
                    log("Error when removing launch image\n")
                }
            }
        }
        if DFM.fileExists(atPath: logFilePath){
            do {
                try DFM.removeItem(atPath: logFilePath)
            } catch {
                log("Error when removing launch iamge\n")
            }
        }
    }
}


// Rob - Stack Overflow
// Converted By Apollo to modern Swift style
extension NSOutputStream {
    enum NSOutputStreamError: ErrorProtocol{
        case noBytesWritten
        case noData
    }
    func write(_ string: String, encoding: String.Encoding = String.Encoding.utf8, allowLossyConversion: Bool = true) throws{
        if let data = string.data(using: encoding, allowLossyConversion: allowLossyConversion) {
            var bytes = UnsafePointer<UInt8>((data as NSData).bytes)
            var bytesRemaining = data.count
            var totalBytesWritten = 0
            while bytesRemaining > 0 {
                let bytesWritten = self.write(bytes, maxLength: bytesRemaining)
                if bytesWritten < 0 {
                    throw NSOutputStreamError.noBytesWritten
                }
                bytesRemaining -= bytesWritten
                bytes += bytesWritten
                totalBytesWritten += bytesWritten
            }
        } else {
            throw NSOutputStreamError.noData
        }
    }
}
