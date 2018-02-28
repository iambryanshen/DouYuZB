//
//  HomeViewController.swift
//  DouYuZB
//
//  Created by BrianShen on 17/3/28.
//  Copyright © 2017年 brianshen. All rights reserved.
//

import UIKit

let kPageTitleViewH : CGFloat = 40;

class HomeViewController: UIViewController {
    
    // MARK:- 懒加载属性
    lazy var pageTitleView : PageTitleView = {[weak self] in
        
        let frame = CGRect(x: 0, y: kStatusBarH+kNavigationBarH, width: kScreenW, height: kPageTitleViewH)
        let titles : [String] = ["推荐", "游戏", "娱乐", "趣玩", "手游"]
        let pageTitleView = PageTitleView(frame: frame, titles: titles)
        pageTitleView.delegate = self
        return pageTitleView
    }()
    
    lazy var pageContentView : PageContentView = {[weak self] in
    
        //设置pageContentView的frame
        let x : CGFloat = 0
        let y : CGFloat = kStatusBarH + kNavigationBarH + kPageTitleViewH
        let width : CGFloat = kScreenW
        let height : CGFloat = kScreenH - kStatusBarH - kNavigationBarH - kPageTitleViewH - kTabBarH
        let frame : CGRect = CGRect(x: x, y: y, width: width, height: height)
        
        //创建子控制器
        var childVCs = [UIViewController]()
        childVCs.append(RecommendViewController())
        childVCs.append(GameViewController())
        childVCs.append(AmuseViewController())
        childVCs.append(FunnyViewController())
        for _ in 0..<1 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVCs.append(vc)
        }
        
        let pageContentView : PageContentView = PageContentView(frame: frame, childVCs: childVCs, parentVC: self)
        pageContentView.delegate = self
        return pageContentView
    }()

    // MARK:- 系统回调方法
    override func viewDidLoad() {
        super.viewDidLoad()

        print("homeVC = \(navigationController)")
        print("\(self.childViewControllers)")
        
        //设置UI
        setupUI()
    }
}

// MARK:- 设置UI界面
extension HomeViewController{
    
    //设置UI
    fileprivate func setupUI(){
        
        //1. 设置导航栏
        setNavigationBar()
        
        //控制器禁止调整scrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        //2. 添加导航栏上pageTitleView
        view.addSubview(pageTitleView)
        
        //3. 添加pageContentView
        view.addSubview(pageContentView)
        

    }
    
    //设置导航栏
    private func setNavigationBar(){
        
        //1. 设置左侧的item
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "logo"))
        
        //2. 设置右侧的item（右边的item不止一个，用rightBarButtonItems（[]：数组））
        let size = CGSize(width: 40, height: 40);
        let historyButton = UIBarButtonItem(image: #imageLiteral(resourceName: "viewHistoryIcon"), highImage: #imageLiteral(resourceName: "viewHistoryIconHL"), size: size)
        let searchButton = UIBarButtonItem(image: #imageLiteral(resourceName: "btn_search"), highImage: #imageLiteral(resourceName: "btn_search_clicked"), size: size)
        let qrcodeButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Image_scan"), highImage: #imageLiteral(resourceName: "Image_scan_click"), size: size)
        navigationItem.rightBarButtonItems = [historyButton, searchButton, qrcodeButton]
    }
}

// MARK:- 遵守PageTitleViewDelegate代理协议
extension HomeViewController : PageTitleViewDelegate {
    
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        
        //调用pageContentView对外暴露的方法
        pageContentView.setSelectedIndex(selectedIndex: index)
    }
}

// MARK:- 遵守PageContentViewDelegate代理协议
extension HomeViewController : PageContentViewDelegate {
    
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        
        //调用pageTitleLabelView对外暴露的方法
        pageTitleView.setTitleWithContentViewScroll(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
