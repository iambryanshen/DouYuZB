//
//  AmuseMenuViewCell.swift
//  DouYuZB
//
//  Created by BrianShen on 17/4/12.
//  Copyright © 2017年 brianshen. All rights reserved.
//

import UIKit

fileprivate let kGameCellID : String = "kGameCellID"

class AmuseMenuViewCell: UICollectionViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK:- 属性
    var anchorGroupModelArray : [AnchorGroupModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "CollectionViewGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let kItemW = kScreenW/4
        let kItemH = collectionView.bounds.height/2
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
    }
}

extension AmuseMenuViewCell : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return anchorGroupModelArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1. 创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionViewGameCell
        //2. 给cell设置数据
        cell.anchorGroup = anchorGroupModelArray?[indexPath.item]
        //3. 返回cell
        return cell
    }
}
