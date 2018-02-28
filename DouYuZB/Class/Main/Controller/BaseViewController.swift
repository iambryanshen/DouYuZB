//
//  BaseViewController.swift
//  DouYuZB
//
//  Created by BrianShen on 17/4/13.
//  Copyright © 2017年 brianshen. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var contentView : UIView?
    
    
    // MARK:- 懒加载imageView
    fileprivate lazy var imageView : UIImageView = {[unowned self] in
       
        let imageView = UIImageView(image: #imageLiteral(resourceName: "img_loading_1"))
        imageView.center = self.view.center
        imageView.animationImages = [#imageLiteral(resourceName: "img_loading_1"), #imageLiteral(resourceName: "img_loading_2"), #imageLiteral(resourceName: "img_loading_3"), #imageLiteral(resourceName: "img_loading_4")]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}

extension BaseViewController {
    
    func setupUI() {
        
        //1. 隐藏contentView
        contentView?.isHidden = true
        
        //2. 添加imageView
        view.addSubview(imageView)
        
        //3. 开始执行动画
        imageView.startAnimating()
        
        //4. 设置view的背景颜色
        view.backgroundColor = UIColor(r: 245.0, g: 245.0, b: 245.0)

    }
    
    func loadDataFinished() {
        
        //1. 停止动画
        imageView.stopAnimating()
        
        //2. 隐藏动画
        imageView.isHidden = true
        
        //3. 显示contentView
        contentView?.isHidden = false
    }
}
