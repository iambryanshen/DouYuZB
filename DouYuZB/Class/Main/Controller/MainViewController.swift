//
//  MainViewController.swift
//  DouYuZB
//
//  Created by BrianShen on 17/3/28.
//  Copyright © 2017年 brianshen. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVC(storyboardName: "Home", title: "首页", image: #imageLiteral(resourceName: "tabHome"), selectedImage: #imageLiteral(resourceName: "tabHomeHL"))
        addChildVC(storyboardName: "Living", title: "直播", image: #imageLiteral(resourceName: "tabLiving"), selectedImage: #imageLiteral(resourceName: "tabLivingHL"))
        addChildVC(storyboardName: "Focus", title: "关注", image: #imageLiteral(resourceName: "tabFocus"), selectedImage: #imageLiteral(resourceName: "tabFocusHL"))
        addChildVC(storyboardName: "Discovery", title: "发现", image: #imageLiteral(resourceName: "tabDiscovery"), selectedImage: #imageLiteral(resourceName: "tabDiscoveryHL"))
        addChildVC(storyboardName: "Mine", title: "我的", image: #imageLiteral(resourceName: "tabMine"), selectedImage: #imageLiteral(resourceName: "tabMineHL"))

    }
    
    //添加子控制器
    private func addChildVC(storyboardName: String, title: String, image: UIImage, selectedImage: UIImage){
        
        //1. 创建子控制器
        let childVC = UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController()!//bundle设为nil,默认从MainBundle加载
        //2. 设置子控制器的属性
        childVC.title = title
        childVC.tabBarItem.image = image
        var selectedImage = selectedImage;
        selectedImage = selectedImage.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        childVC.tabBarItem.selectedImage = selectedImage
        
        //3. 添加子控制器
        addChildViewController(childVC)
    }
}
