//
//  RecommendCycleView.swift
//  DouYuZB
//
//  Created by BrianShen on 17/4/5.
//  Copyright © 2017年 brianshen. All rights reserved.
//

import UIKit

let kCycleCell = "kCycleCell"

class RecommendCycleView: UIView {

    // MARK:- xib中的控件
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK:- 属性
    var cycleArray : [CycleModel]?{
        didSet{
            //1. 刷新collectionView
            collectionView.reloadData()
            
            //2. 设置pageControl
            pageControl.numberOfPages = cycleArray?.count ?? 0
            
            //3. 默认滚到中间位置
            let indexPath = IndexPath(item: (cycleArray?.count ?? 0) * 100, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            //4. 定时器
            removeTimer()
            addTimer()
        }
    }
    var timer : Timer?      //定时器
}

// MARK:- RecommendCycleView相关设置
extension RecommendCycleView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //设置该控件不随父控件的拉伸而拉伸
        autoresizingMask = []
        
        //设置数据源
        collectionView.dataSource = self
        
        collectionView.delegate = self
        
        //注册cell
        collectionView.register(UINib.init(nibName: "CollectionViewCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCell)
    }
    
    //类方法创建recommendCycleView
    class func recommendCycleView() -> RecommendCycleView{
        let recommendCycleView = Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
        return recommendCycleView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
    }
}

// MARK:- UICollectionViewDataSource
extension RecommendCycleView : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleArray?.count ?? 0) * 10000//*10000无限轮播处理
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cycleCell : CollectionViewCycleCell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCell, for: indexPath) as! CollectionViewCycleCell
        
        //取出模型数组的模型
        let cycle = cycleArray![indexPath.item % cycleArray!.count]//无限轮播处理
        
        //赋值给cell的模型属性
        cycleCell.cycle = cycle
        
        return cycleCell
    }
}

// MARK:- UICollectionViewDelegate
extension RecommendCycleView : UICollectionViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //1. 获取scrollView的偏移量
        let offsetX = scrollView.contentOffset.x + kScreenW * 0.5
        //2. 计算pageControl的currentPage
        let currentPage = Int(offsetX/kScreenW) % (cycleArray?.count ?? 1)//无限轮播处理
        pageControl.currentPage = currentPage
    }
    
    //开始滚动移除自动滚动
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    
    //结束滚动开始自动滚动
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
}

extension RecommendCycleView {

    //添加定时器
    func addTimer() {
        if #available(iOS 10.0, *) {
            timer = Timer(timeInterval: 3.0, repeats: true, block: { (timer) in
                
                self.setTimerContent()
            })
        } else {
            // Fallback on earlier versions
            timer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.setTimerContent), userInfo: nil, repeats: true)
        }
        RunLoop.main.add(timer!, forMode: RunLoopMode.commonModes)
    }
    
    // MARK:- 定时器轮播
    func setTimerContent() {
        
        //1. 获取滚动偏移量
        var offsetX = self.collectionView.contentOffset.x
        offsetX = offsetX + kScreenW
        
        //2. 滚动到下一个
        self.collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    //移除定时器
    func removeTimer() {
        timer?.invalidate()
        timer = nil
    }
}
