//
//  PageContentView.swift
//  DouYuZB
//
//  Created by BrianShen on 17/3/30.
//  Copyright © 2017年 brianshen. All rights reserved.
//

import UIKit

// MARK:- 代理方法通过HomeViewController让titleLabel同步选中
protocol PageContentViewDelegate : class {
    
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}

// MARK:- 定义常量
private let collectionViewCellID = "collectionViewCellID"

// MARK:- 定义类
class PageContentView: UIView {
    
    // MARK:- 定义属性
    fileprivate var childVCs : [UIViewController]
    fileprivate var parentVC : UIViewController?
    fileprivate var startOffsetX : CGFloat = 0
    weak var delegate : PageContentViewDelegate?            //代理
    fileprivate var isForbidScrollDelegate : Bool = false   //禁止ScrollDelegate
    
    // MARK:- 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
    
        //1. 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //2. 创建collectionView
        let collectionView : UICollectionView = UICollectionView(frame: self!.bounds, collectionViewLayout: layout)
        collectionView.bounces = false          //边缘弹回效果
        collectionView.isPagingEnabled = true   //分页效果
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //注册collectionViewCell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionViewCellID)
        
        return collectionView
    }()

    // MARK:- 自定义构造方法
    init(frame: CGRect, childVCs: [UIViewController], parentVC : UIViewController?) {
        
        //把外界传入的控制器保存到属性中
        self.childVCs = childVCs
        self.parentVC = parentVC
        
        super.init(frame: frame)
        
        //设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 设置UI界面
extension PageContentView {
    
    func setupUI() {
        
        for childVC in childVCs {
            self.parentVC?.addChildViewController(childVC)
        }
        
        //添加UICollectionView
        addSubview(collectionView)
    }
}

// MARK:- UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource {
    
    //1. collectionViewCell的个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.childVCs.count;
    }
    
    //2. collectionViewCell的内容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //创建一个collectionViewCell
        let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellID, for: indexPath)
        
        //防止反复添加subView,移除上一次添加的subView
        for view in collectionViewCell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        //设置cell的内容
        let childVC = childVCs[indexPath.item]
        childVC.view.frame = collectionViewCell.contentView.bounds
        collectionViewCell.contentView.addSubview(childVC.view)
        
        return collectionViewCell
    }
}

// MARK:- UICollectionViewDelegate
extension PageContentView : UICollectionViewDelegate{
    
    //开始滑动时调用
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        //如果是滑动调用，则不禁止滑动代理方法
        isForbidScrollDelegate = false
        
        let startOffsetX = scrollView.contentOffset.x
        self.startOffsetX = startOffsetX
    }
    
    //滑动的时候就会调用
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //如果禁止了滑动代理方法，代表是点击事件（点击了label）,则返回
        if isForbidScrollDelegate {
            return
        }
        
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        //当前offsetx
        let currentOffsetX = scrollView.contentOffset.x
        
        //如果是左滑
        if currentOffsetX > startOffsetX{
        
            progress = currentOffsetX/kScreenW - floor(currentOffsetX/kScreenW) //进度
            sourceIndex = Int(currentOffsetX/kScreenW)                          //sourceIndex
            targetIndex = sourceIndex+1                                         //targetIndex
            
            //如果目标index等于总控制器个数
            if targetIndex == childVCs.count {
                targetIndex = childVCs.count-1
            }
            
            //如果完全划过去
            if currentOffsetX - startOffsetX == kScreenW {
                progress = 1
                targetIndex = sourceIndex
            }
            
        }else{//否则是右滑
            
            progress = 1 - (currentOffsetX/kScreenW - floor(currentOffsetX/kScreenW)) //进度
            targetIndex = Int(currentOffsetX/kScreenW)                                //targetIndex
            sourceIndex = targetIndex + 1                                             //sourceIndex
            
            //如果源index等于总控制器个数
            if sourceIndex == childVCs.count {
                sourceIndex = childVCs.count - 1
            }
        }
        
        //通知代理
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

// MARK:- 对外暴露的方法
extension PageContentView {
    
    func setSelectedIndex(selectedIndex: Int) {
        
        //因为是点击了titleLabel，禁止collocationDelegate
        isForbidScrollDelegate = true
        
        //点击了titleLabel设置collectionView的contentOffset
        let offsetX = CGFloat(selectedIndex)*(collectionView.bounds.width)
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
