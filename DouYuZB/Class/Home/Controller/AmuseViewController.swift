//
//  AmuseViewController.swift
//  DouYuZB
//
//  Created by BrianShen on 17/4/8.
//  Copyright © 2017年 brianshen. All rights reserved.
//

import UIKit

// MARK:- 定义常量
let kMenuViewH : CGFloat = 200

class AmuseViewController: BaseAnchorViewController {
    
    // MARK:- 懒加载属性
    lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    lazy var amuseMenuView : AmuseMenuView = {
       
        let amuseMenuView = AmuseMenuView.amuseMenuView()
        let frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        amuseMenuView.frame = frame
        return amuseMenuView
    }()
}

extension AmuseViewController {
    
    override func setupUI() {
        super.setupUI()
        
        collectionView.addSubview(amuseMenuView)
        let contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
        collectionView.contentInset = contentInset
    }
}

// MARK:- 请求数据
extension AmuseViewController {
    
    override func loadData() {
        
        //1. 给父类的ViewModel赋值
        baseVM = amuseVM
        
        //2. 请求数据
        amuseVM.requestData {
            
            //刷新collectionView
            self.collectionView.reloadData()
            var temp = self.amuseVM.anchorGroupModelArray
            temp.removeFirst()
            self.amuseMenuView.anchorGroupModelArray = temp
            
            //3. 停止动画
            self.loadDataFinished()
        }
    }
}

