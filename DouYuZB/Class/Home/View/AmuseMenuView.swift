//
//  AmuseMenuView.swift
//  DouYuZB
//
//  Created by BrianShen on 17/4/12.
//  Copyright © 2017年 brianshen. All rights reserved.
//

import UIKit

// MARK:- 定义常量
let kMenuCellID : String = "kMenuCellID"

class AmuseMenuView: UIView {
    // MARK:- 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK:- 属性
    var anchorGroupModelArray : [AnchorGroupModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK:- 从xib加载后调用
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "AmuseMenuViewCell", bundle: nil), forCellWithReuseIdentifier: kMenuCellID)
    }
    // MARK:- 布局子控件
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
    }
}

// MARK:- 类方法创建AmuseMenuView
extension AmuseMenuView {
    
    class func amuseMenuView() -> AmuseMenuView {
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
}

// MARK:- UICollectionViewDataSource
extension AmuseMenuView : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if anchorGroupModelArray == nil {
            return 0
        }
        let pageNumber = (anchorGroupModelArray!.count - 1)/8 + 1
        pageControl.numberOfPages = pageNumber
        return pageNumber
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1. 创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuCellID, for: indexPath) as! AmuseMenuViewCell
        //2. 给cell设置数据
        setupCelldataWith(cell: cell, indexPath: indexPath)
        
        //3. 返回cell
        return cell
    }
    
    func setupCelldataWith(cell: AmuseMenuViewCell, indexPath: IndexPath) {
        
        //1.计算开始index 结束index
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        
        if endIndex >= anchorGroupModelArray!.count - 1 {
            endIndex = anchorGroupModelArray!.count - 1
        }
        
        cell.anchorGroupModelArray = Array(anchorGroupModelArray![startIndex...endIndex])
    }
}
