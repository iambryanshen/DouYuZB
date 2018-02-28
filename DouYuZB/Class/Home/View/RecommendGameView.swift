//
//  RecommendGameView.swift
//  DouYuZB
//
//  Created by BrianShen on 17/4/6.
//  Copyright © 2017年 brianshen. All rights reserved.
//

import UIKit

fileprivate let kGameCellID = "kGameCellID"

class RecommendGameView: UIView {
    
    // MARK:- 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK:- 属性
    var groupArray : [BaseModel]? {
        didSet{
            collectionView.reloadData()
        }
    }
    
    
    // MARK:- 系统回调方法
    override func awakeFromNib() {
        
        //设置该控件不随父控件的拉伸而拉伸
        autoresizingMask = []
        
        //collection相关设置
        collectionView.dataSource = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 80, height: 90)
        
        collectionView.register(UINib.init(nibName: "CollectionViewGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
    }
}

// MARK:- 类方法创建RecommendGameView
extension RecommendGameView {
    
    //类方法创建RecommendGameView
    class func recommendGameView() -> RecommendGameView{
        let recommendGameView = Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
        return recommendGameView
    }
}

extension RecommendGameView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let gameCell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionViewGameCell

        let anchorGroup = groupArray?[indexPath.item]
        gameCell.anchorGroup = anchorGroup
        
        return gameCell
    }
}
