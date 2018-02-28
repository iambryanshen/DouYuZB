//
//  RecommendViewController.swift
//  DouYuZB
//
//  Created by BrianShen on 17/3/31.
//  Copyright © 2017年 brianshen. All rights reserved.
//

import UIKit

// MARK:- 定义常量
fileprivate let kItemMargin : CGFloat = 10
fileprivate let kItemW : CGFloat = (kScreenW - kItemMargin*3)/2
fileprivate let kItemH : CGFloat = kItemW * 3/4
fileprivate let kPrettyItemH : CGFloat = kItemW * 4/3

fileprivate let kCycleViewH : CGFloat = kScreenW * 3/8
fileprivate let kGameViewH : CGFloat = 90

// MARK:- 定义类
class RecommendViewController: BaseAnchorViewController {
    
    // MARK:- 定义属性
    let recommendVM : RecommendViewModel = RecommendViewModel()
    
    //懒加载RecommendCycleView
    fileprivate lazy var recommendCycleView : RecommendCycleView = {
    
        let recommendCycleView = RecommendCycleView.recommendCycleView()
        let frame = CGRect(x: 0, y: -kCycleViewH-kGameViewH, width: kScreenW, height: kCycleViewH)
        recommendCycleView.frame = frame
        return recommendCycleView
    }()
    
    //懒加载RecommendGameView
    fileprivate lazy var recommendGameView : RecommendGameView = {
       
        let recommendGameView = RecommendGameView.recommendGameView()
        let frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        recommendGameView.frame = frame
        return recommendGameView
    }()
}

// MARK:- 设置UI界面
extension RecommendViewController {
    
    override func setupUI() {
        super.setupUI()
        
        //1. 将collectionView添加到控制器的view中
        view.addSubview(collectionView)
        
        //2. 设置collectionView内容的内边距
        let contentInset = UIEdgeInsets(top: kCycleViewH+kGameViewH, left: 0, bottom: 0, right: 0)
        collectionView.contentInset = contentInset
        
        //3. 将cycleView添加到collectionView中
        collectionView.addSubview(recommendCycleView)
        
        //4. 将gameView添加到collectionView中
        collectionView.addSubview(recommendGameView)
    }
}

// MARK:- 加载首页数据
extension RecommendViewController {
    override func loadData() {
        
        print("recommendVC = \(navigationController)")
        
        //1. 给父控制器属性赋值
        baseVM = recommendVM
        
        //1. 推荐数据请求
        recommendVM.requestData {
            
            //1. 刷新推荐控制器
            self.collectionView.reloadData()
            
            //2. 把数据传递给RecommendGameView
            var groupArray = self.recommendVM.anchorGroupModelArray
            
            //2.1. 移除头两组数据
            groupArray.removeFirst()
            groupArray.removeFirst()
            
            //2.2. 添加更多组
            let anchorGroup = AnchorGroupModel()
            anchorGroup.tag_name = "更多"
            groupArray.append(anchorGroup)
            
            //2.3. 传递数据
            self.recommendGameView.groupArray = groupArray
            
            //3. 停止动画
            self.loadDataFinished()
        }
        
        //2. 轮播数据请求
        recommendVM.requestCycleData { 
            //把数据传递给RecommendCycleView
            self.recommendCycleView.cycleArray = self.recommendVM.cycleArray
        }
    }
}

// MARK:- UICollectionViewDataSource
extension RecommendViewController {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyViewCell
            cell.anchor = recommendVM.anchorGroupModelArray[indexPath.section].Anchors[indexPath.item]
            return cell
        } else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
}

// MARK:- UICollectionViewDelegateFlowLayout
extension RecommendViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        return CGSize(width: kItemW, height: kItemH)
    }
}
