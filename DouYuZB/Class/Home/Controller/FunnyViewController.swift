//
//  FunnyViewController.swift
//  DouYuZB
//
//  Created by BrianShen on 17/4/13.
//  Copyright © 2017年 brianshen. All rights reserved.
//

import UIKit

// MARK:- 定义常量
let kTopMargin : CGFloat = 10

class FunnyViewController: BaseAnchorViewController {

    lazy var funnyVM : FunnyViewModel = FunnyViewModel()
}

extension FunnyViewController {
    
    override func setupUI() {
        super.setupUI()
        
        //重写layout布局，去掉headerView
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: 0, bottom: 0, right: 0)
    }
}

extension FunnyViewController {
    
    //重写父类方法加载数据
    override func loadData() {
        
        baseVM = funnyVM
        
        funnyVM.loadFunnyData {
            self.collectionView.reloadData()
            
            //3. 停止动画
            self.loadDataFinished()
        }
    }
}
