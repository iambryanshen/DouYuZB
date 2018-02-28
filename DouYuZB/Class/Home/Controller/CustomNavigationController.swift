//
//  CustomNavigationController.swift
//  DouYuZB
//
//  Created by BrianShen on 17/3/29.
//  Copyright © 2017年 brianshen. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //全局设置导航栏背景色
        let navigationBar = UINavigationBar.appearance()
        navigationBar.barTintColor = UIColor.orange
        
        setGesture()
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        //隐藏push出的控制器的tabBar
        viewController.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: animated)
    }
}

// MARK:- 通过运行时机制设置全屏滑动手势
extension CustomNavigationController {
    
    func setGesture() {
        
        //1. 获取系统的pop手势
        guard let systemGesture = interactivePopGestureRecognizer else {return}
        print("gesture=\(systemGesture)")
        print("---------------------------------------------------------------------------------------")
        
        //获取手势添加到的view
        guard let gestureView = systemGesture.view else {return}
        print("gestureView=\(gestureView)")
        print("---------------------------------------------------------------------------------------")
        
        //获取target/action
        //利用运行时机制查看手势所有的属性
        var count : UInt32 = 0
        let attributeAddressArray = class_copyIvarList(UIGestureRecognizer.self,  &count)!//class_copyIvarList返回所有属性的地址数组,因为可选类型不可以当成数组用，需要强制解包
        //遍历数组中的所有的属性
        for i in 0..<count{
            let attributeAddress = attributeAddressArray[Int(i)]//取出每个属性的地址
            let attributeName = ivar_getName(attributeAddress)
            print(String(cString: attributeName!))
        }
        print("---------------------------------------------------------------------------------------")
        
        let targets = systemGesture.value(forKey: "_targets") as? [AnyObject]
        print("target=\(targets)")
        guard let targetObjc = targets?.first else {return}
        print("targetObjc=\(targetObjc)")
        
        print("---------------------------------------------------------------------------------------")
        
        guard let target = targetObjc.value(forKey: "target") else {return}
        print("target=\(target)")
        //guard let action = targetObjc.value(forKey: "action") as? Selector else {return}
        let action = Selector(("handleNavigationTransition:"))
        print("action=\(action)")
        
        let pan = UIPanGestureRecognizer(target: target, action: action)
        gestureView.addGestureRecognizer(pan)
    }
}
