//
//  Constants.swift
//  Demo
//
//  Created by Ahmed Karmous on 04/11/2017.
//  Copyright © 2017 Ahmed Karmous. All rights reserved.
//

import Foundation
import UIKit

let APP_DELEGATE = UIApplication.shared.delegate as! AppDelegate
let SPLASH_MININUM_TIME: TimeInterval = 1

//devices size
let IS_IPHONE_4 =  (UIScreen.main.bounds.size.height < 568)
let IS_IPHONE_5 = (UIScreen.main.bounds.size.height == 568)
let IS_IPHONE_6 = (UIScreen.main.bounds.size.height == 667)
let IS_IPHONE_6_PLUS = (UIScreen.main.bounds.size.height == 736)

//Size screen
let SCREEN_WIDTH  = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height


