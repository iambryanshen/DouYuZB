//
//  AppDelegate.swift
//  DouYuZB
//
//  Created by BrianShen on 17/3/28.
//  Copyright © 2017年 brianshen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
     func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //全局去除tabBar图片渲染
        UITabBar.appearance().tintColor = UIColor.orange;
        
        return true
    }
}

