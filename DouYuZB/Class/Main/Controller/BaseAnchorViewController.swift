//
//  BaseAnchorViewController.swift
//  DouYuZB
//
//  Created by BrianShen on 17/4/11.
//  Copyright © 2017年 brianshen. All rights reserved.
//

import UIKit

// MARK:- 定义常量
fileprivate let kItemMargin : CGFloat = 10
fileprivate let kItemW : CGFloat = (kScreenW - kItemMargin*3)/2
fileprivate let kItemH : CGFloat = kItemW * 3/4
fileprivate let kPrettyItemH : CGFloat = kItemW * 4/3

fileprivate let kCellID : String = "kCellID"
let kPrettyCellID : String = "kPrettyCellID"
fileprivate let kHeaderViewID : String = "kHeaderViewID"
fileprivate let kHeaderViewH : CGFloat = 50

fileprivate let kCycleViewH : CGFloat = kScreenW * 3/8
fileprivate let kGameViewH : CGFloat = 90

class BaseAnchorViewController: BaseViewController {
    
    // MARK:- 自定义属性
    lazy var baseVM : BaseViewModel = BaseViewModel()
    
    // MARK:- 懒加载属性
    lazy var collectionView : UICollectionView = {[unowned self] in
        //1. 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        //2. 创建collectionView
        let collectionView : UICollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]//宽高跟随父控件自动拉伸
        //2.2. 注册collectionView的cell & headerView
        collectionView.register(UINib.init(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kCellID)
        collectionView.register(UINib.init(nibName: "CollectionPrettyViewCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib.init(nibName: "CollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loadData()
    }
}

// MARK:- 设置UI界面
extension BaseAnchorViewController {
    
    override func setupUI() {
        
        contentView = collectionView
        
        view.addSubview(collectionView)
        
        super.setupUI()
    }
}

// MARK:- 请求数据
extension BaseAnchorViewController {
    
    func loadData() {
    }
}

// MARK:- UICollectionViewDataSource
extension BaseAnchorViewController : UICollectionViewDataSource{
    
    //组数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorGroupModelArray.count
    }
    
    //2. 设置组item数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //groupArray的每个元素保存的是一组的主播模型
        let group = baseVM.anchorGroupModelArray[section]
        
        return group.Anchors.count  //一组主播模型的个数
    }
    
    //给每一组的item赋值
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1. 创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellID, for: indexPath) as! CollectionViewCell
        //2. 给cell设置数据
        cell.anchor = baseVM.anchorGroupModelArray[indexPath.section].Anchors[indexPath.item]
        //3. 返回cell
        return cell
    }
    
    //给每一组的headerView赋值
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionReusableView
        headerView.anchorGroup = baseVM.anchorGroupModelArray[indexPath.section]
        return headerView
    }
}

// MARK:- UICollectionViewDelegate
extension BaseAnchorViewController :  UICollectionViewDelegate{
    
    // MARK:- 监控直播的点击
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let anchor = baseVM.anchorGroupModelArray[indexPath.section].Anchors[indexPath.item]
        
        anchor.isVertical == 0 ? pushNormalRoomVC() : pushShowRoomVC()
    }
    
    //弹出正常控制器
    func pushNormalRoomVC() {
        
        let normalVC = NormalViewController()
        print("navigationController= \(navigationController)")
        navigationController?.pushViewController(normalVC, animated: true)
    }
    
    //弹出秀场控制器
    func pushShowRoomVC() {
        
        let showVC = ShowViewController()
        present(showVC, animated: true, completion: nil)
    }
}
