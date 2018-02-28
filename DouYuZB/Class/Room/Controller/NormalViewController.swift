//
//  NormalViewController.swift
//  DouYuZB
//
//  Created by BrianShen on 17/4/13.
//  Copyright © 2017年 brianshen. All rights reserved.
//

import UIKit

class NormalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.green
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //隐藏push出的控制器的导航栏
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        //保持系统手势
        //keepGesture()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //显示控制器导航栏
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

//// MARK:- 保持系统手势
//extension NormalViewController : UIGestureRecognizerDelegate{
//    
//    func keepGesture() {
//        //设置隐藏了导航栏的控制器的手势代理
//        navigationController?.interactivePopGestureRecognizer?.delegate = self
//        //启动系统默认滑动返回手势
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
//    }
//}
