//
//  Utilities.swift
//  Demo
//
//  Created by Ahmed Karmous on 04/11/2017.
//  Copyright © 2017 Ahmed Karmous. All rights reserved.
//

import UIKit
import CoreFoundation

class Utilities: NSObject {
    
    struct Singleton {
        static let instance = Utilities()
    }
    
    class var sharedInstance: Utilities {
        return Singleton.instance
    }
    
    static func getStringFromDate(_ date : Date, format : String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "fr-FR")
        dateFormatter.timeZone = NSTimeZone(name: "UTC+1") as TimeZone!
        let stringDate = dateFormatter.string(from: date)
        return stringDate
    }
    
}
