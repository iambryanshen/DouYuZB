//
//  PageTitleView.swift
//  DouYuZB
//
//  Created by BrianShen on 17/3/29.
//  Copyright © 2017年 brianshen. All rights reserved.
//

import UIKit

// MARK:- 代理方法设置PageContentView
protocol PageTitleViewDelegate : class {
    
    //代理方法
    func pageTitleView(titleView : PageTitleView, selectedIndex index : Int)
}

// MARK:- 定义常量
let kScrollViewLineHeight : CGFloat = 2
let kDarkGrayColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
let kOrangeColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

class PageTitleView: UIView {
    
    // MARK:- 定义属性
    var titles : [String]       //titles数组
    var titleLabelArray : [UILabel] = [UILabel]()  //titleLabel数组
    var currentLabelIndex : Int = 0;        //titleLabel的index
    weak var delegate : PageTitleViewDelegate?
    
    
    // MARK:- 懒加载属性
    lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    lazy var scrollLine : UIView = {
        let scrollLine : UIView = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    // MARK:- 自定义构造函数
    init(frame: CGRect, titles: [String]) {
        
        self.titles = titles
        super.init(frame: frame)
        
        //设置UI界面
        setupUI()
    
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 设置UI界面
extension PageTitleView{
    
    func setupUI(){
        
        //1. 添加scrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //2. 添加title对应的label
        setupTitleLabel()
        
        //3. 添加滚动的滑块
        setupScrollLine()
        
    }
    
    //2. 添加title对应的label
    func setupTitleLabel() {
        
        for (index, title) in titles.enumerated()  {
            
            //1. 创建label
            let titleLabel = UILabel()
            
            //2. 设置label的属性
            titleLabel.tag = index
            titleLabel.text = title
            titleLabel.font = UIFont.systemFont(ofSize: 16.0)//默认17
            titleLabel.textColor = UIColor.darkGray//默认lightGray
            titleLabel.textAlignment = .center
            
            //3. 设置label的frame
            let labelW : CGFloat = frame.width/CGFloat(titles.count)
            let labelH : CGFloat = frame.height - kScrollViewLineHeight
            let labelX : CGFloat = labelW*CGFloat(index)
            let labelY : CGFloat = 0;
            titleLabel.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //4. 给label添加点击手势
            titleLabel.isUserInteractionEnabled = true
            let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.labelClick(tap:)))
            titleLabel.addGestureRecognizer(tap)
            
            //5. 保存label到数组中
            titleLabelArray.append(titleLabel)
            
            //6. 添加label
            scrollView.addSubview(titleLabel)
        }
    }

    //3. 添加滚动的滑块
    func setupScrollLine() {
        
        //拿到第一个titleLabel
        guard let titleLabel = self.titleLabelArray.first else {
            return
        }
        titleLabel.textColor = UIColor.orange
        
        let scrollLineW : CGFloat = titleLabel.frame.width
        let scrollLineH : CGFloat = kScrollViewLineHeight
        let scrollLineX : CGFloat = titleLabel.frame.origin.x
        let scrollLineY : CGFloat = frame.height - kScrollViewLineHeight
        scrollLine.frame = CGRect(x: scrollLineX, y: scrollLineY, width: scrollLineW, height: scrollLineH)
        
        scrollView.addSubview(scrollLine)
    }
}

// MARK:- 监听label的点击
extension PageTitleView {
    
    @objc func labelClick(tap: UITapGestureRecognizer){
        
        //1. 拿到当前label
        guard let titleLabel = tap.view as? UILabel else {
            return
        }
        
        //2. 获取之前的label
        let oldLabel = titleLabelArray[currentLabelIndex]
        
        oldLabel.textColor = UIColor.darkGray
        titleLabel.textColor = UIColor.orange
        
        //3. 保存当前label的tag值
        currentLabelIndex = titleLabel.tag;
        
        //4. 移动scrollViewLine
        let scrollLineX = CGFloat(titleLabel.tag)*scrollLine.frame.width
        UIView.animate(withDuration: 0.3) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        //5. 通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentLabelIndex)
    }
}


// MARK:- 对外暴露的方法
extension PageTitleView {
    
    func setTitleWithContentViewScroll(progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        
        //获取sourceLabel和targetLabel
        let sourceLabel = titleLabelArray[sourceIndex]
        let targetLabel = titleLabelArray[targetIndex]
        
        //1. 设置scrollLine的位置
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX*progress
        
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //2. 设置titleLabel文字颜色渐变
        let colorRange = (kOrangeColor.0 - kDarkGrayColor.0, kOrangeColor.1 - kDarkGrayColor.0, kOrangeColor.1 - kDarkGrayColor.1)
        
        sourceLabel.textColor = UIColor(r: kOrangeColor.0 - colorRange.0 * progress, g: kOrangeColor.1 - colorRange.1 * progress, b: kOrangeColor.2 - colorRange.2 * progress)
        targetLabel.textColor = UIColor(r: kDarkGrayColor.0 + colorRange.0 * progress, g: kDarkGrayColor.1 + colorRange.1 * progress, b: kDarkGrayColor.2 + colorRange.2 * progress)
        
        //当前labelIndex等于目标targetIndex
        currentLabelIndex = targetIndex
    }
}
