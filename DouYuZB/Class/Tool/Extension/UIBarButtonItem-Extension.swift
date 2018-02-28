//
//  UIBarButtonItem-Extension.swift
//  DouYuZB
//
//  Created by BrianShen on 17/3/28.
//  Copyright © 2017年 brianshen. All rights reserved.
//

import UIKit

//扩展系统类UIBarButtonItem
extension UIBarButtonItem{
    
    
    //类方法创建UIBarButtonItem
    class func creatItem(image: UIImage, highImage: UIImage? = nil, size: CGSize = .zero) -> UIBarButtonItem{
        
        //1. 创建button
        let button = UIButton()
        //2. 一定有正常状态下的图片
        button.setImage(image, for: .normal)
        //3. 高亮图片如果没有则不设置
        if highImage != nil {
            button.setImage(highImage, for: .highlighted)
        }
        //4. 没有设置尺寸，则尺寸自适应
        if size == .zero {
            button.sizeToFit()
        }else {
            button.frame = CGRect(origin: .zero, size: size)
        }
        return UIBarButtonItem(customView: button)
    }
    
    //便利构造函数创建UIBarButtonItem
    convenience init(image: UIImage, highImage: UIImage? = nil, size: CGSize = .zero) {
        
        //1. 创建button
        let button = UIButton()
        //2. 一定有正常状态下的图片
        button.setImage(image, for: .normal)
        //3. 高亮图片如果没有则不设置
        if highImage != nil {
            button.setImage(highImage, for: .highlighted)
        }
        //4. 没有设置尺寸，则尺寸自适应
        if size == .zero {
            button.sizeToFit()
        }else {
            button.frame = CGRect(origin: .zero, size: size)
        }
        //5. 创建UIBarButtonItem
        self.init(customView: button)
    }
}
