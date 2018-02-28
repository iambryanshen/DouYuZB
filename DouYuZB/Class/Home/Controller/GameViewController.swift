//
//  GameViewController.swift
//  DouYuZB
//
//  Created by BrianShen on 17/4/7.
//  Copyright © 2017年 brianshen. All rights reserved.
//

import UIKit

fileprivate let kGameCellID = "kGameCellID"

fileprivate let kEdgeMargin : CGFloat = 10
fileprivate let kItemWidth : CGFloat = (kScreenW - 2 * kEdgeMargin) / 3
fileprivate let kItemHeight : CGFloat = kItemWidth * 6 / 5

fileprivate let kHeaderH : CGFloat = 50
fileprivate let kHeaderID : String = "kHeaderID"

fileprivate let kGameViewH : CGFloat = 90

class GameViewController: BaseViewController {
    
    // MARK:- 属性
    fileprivate let gameVM : GameViewModel = GameViewModel()

    // MARK:- 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
    
        //1. 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemWidth, height: kItemHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderH)
        
        //2. 创建collectionView
        let collectionView : UICollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.contentInset = UIEdgeInsets(top: kHeaderH + kGameViewH, left: 0, bottom: 0, right: 0)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        //2.1. 注册控件
        collectionView.register(UINib.init(nibName: "CollectionViewGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionView.register(UINib.init(nibName: "CollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderID)
        
        return collectionView
    }()
    
    fileprivate lazy var topHeaderView : CollectionReusableView = {
    
        let topHeaderView = CollectionReusableView.collectionReusableView()
        topHeaderView.frame = CGRect(x: 0, y: -(kHeaderH + kGameViewH), width: kScreenW, height: kHeaderH)
        topHeaderView.iconImageView.image = UIImage(named: "Img_orange")
        topHeaderView.titleLabel.text = "常见"
        topHeaderView.moreButton.isHidden = true
        return topHeaderView
    }()
    
    fileprivate lazy var gameView : RecommendGameView = {
        
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        
        return gameView
    }()
    
    // MARK:- 系统回调方法
    override func viewDidLoad() {
        super.viewDidLoad()

        print("gameVC = \(navigationController)")
        
        setupUI()
        loadData()
    }
}

// MARK:- 设置UI界面
extension GameViewController {
    override func setupUI() {
        
        contentView = collectionView
        
        //1. 添加collectionView
        view.addSubview(collectionView)
        
        //2. 添加topHeaderView
        collectionView.addSubview(topHeaderView)
        
        //3. 添加gameView
        collectionView.addSubview(gameView)
        
        super.setupUI()
    }
}

// MARK:- 加载数据
extension GameViewController {
    
    func loadData() {
        gameVM.requestData {
            //1. 给全部游戏设置数据
            self.collectionView.reloadData()
            
            //2. 取出前十条数据给gameView设置数据
            self.gameView.groupArray = Array(self.gameVM.gameModelArray[0..<10])
            
            //3. 停止动画
            self.loadDataFinished()
        }
    }
}

// MARK:- UICollectionViewDataSource
extension GameViewController : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.gameModelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionViewGameCell
        
        let gameModel = gameVM.gameModelArray[indexPath.item]
        cell.anchorGroup = gameModel
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderID, for: indexPath) as! CollectionReusableView
        
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.titleLabel.text = "全部"
        headerView.moreButton.isHidden = true
        
        return headerView
    }
}
