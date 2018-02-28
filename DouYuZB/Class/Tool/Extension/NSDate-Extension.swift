
//
//  NSDate-Extension.swift
//  DouYuZB
//
//  Created by BrianShen on 17/4/2.
//  Copyright © 2017年 brianshen. All rights reserved.
//


import UIKit

extension NSDate{
    class func getCurrenTime() -> String{
        let date = NSDate()
        return "\(date.timeIntervalSince1970)"
    }
}
