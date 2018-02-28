//
//  RecommendViewModel.swift
//  DouYuZB
//
//  Created by BrianShen on 17/4/2.
//  Copyright © 2017年 brianshen. All rights reserved.
//

import UIKit

class RecommendViewModel : BaseViewModel {
    
    // MARK:- 定义属性
    fileprivate lazy var bigDataGroup : AnchorGroupModel = AnchorGroupModel() //创建一个最热房间的组
    fileprivate lazy var prettyGroup : AnchorGroupModel = AnchorGroupModel()  //创建一个颜值房间的组
    lazy var cycleArray : [CycleModel] = [CycleModel]()           //轮播器模型数组
}

extension RecommendViewModel {
    
    //请求推荐数据
    func requestData(finishedCallback: @escaping ()->()) {
        
        let dispatchGroup = DispatchGroup.init()
        let parameters = ["limit": "4", "offset": "0", "time": NSDate.getCurrenTime()]//参数
        
        dispatchGroup.enter()
        //请求0部分（最热）数据
        SFNetwork.requestData(httptype: .POST, urlString: "https://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time": NSDate.getCurrenTime()]) { (result) in
            
            //1. 将返回的response转成字典类型
            guard let result = result as? [String: AnyObject] else{return}
            
            //2. 根据key:data,获取对应的数组(数组中包含字典)
            guard let dataArray = result["data"] as? [[String: AnyObject]] else {return}
            
            //3. 保存数组中的房间模型到最热房间
            self.bigDataGroup.tag_name = "最热"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            //4. 把主播模型添加到最热房间组的主播模型数组中
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.Anchors.append(anchor)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        //请求1部分（颜值）数据
        SFNetwork.requestData(httptype: .GET, urlString: "https://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            
            //1. 将返回的response转成字典类型
            guard let result = result as? [String: AnyObject] else{return}
            
            //2. 根据key:data,获取对应的数组(数组中包含字典)
            guard let dataArray = result["data"] as? [[String: AnyObject]] else {return}

            //3. 保存数组中的房间模型到颜值房间的组中
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "dyla_btn_beauty"

            //4. 把主播模型添加到颜值房间的组中
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.Anchors.append(anchor)
            }
            dispatchGroup.leave()
        }
        
        //请求2-12部分数据
        dispatchGroup.enter()
        loadAnchorData(isNormal: true, urlString: "https://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) {
            dispatchGroup.leave()
        }
        /*
        SFNetwork.requestData(httptype: .POST, urlString: "https://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in

            //1. 将返回的response转成字典类型
            guard let result = result as? [String: AnyObject] else{return}
            
            //2. 根据key:data,获取对应的数组(数组中包含字典)
            guard let dataArray = result["data"] as? [[String: AnyObject]] else{return}
            
            //3. 遍历数组，获取数组中的字典，并转成模型对象
            for dict in dataArray {
                let group = AnchorGroupModel.init(dict: dict)
                self.anchorGroupModelArray.append(group)
                
            }
            dispatchGroup.leave()
        }*/
        
        //队列组最后执行的方法
        dispatchGroup.notify(queue: DispatchQueue.main) {
            
            self.anchorGroupModelArray.insert(self.prettyGroup, at: 0)
            self.anchorGroupModelArray.insert(self.bigDataGroup, at: 0)
            finishedCallback()
        }
    }
    
    //请求无限轮播数据
    func requestCycleData(finishedCallback: @escaping ()->()) {
        
        SFNetwork.requestData(httptype: .GET, urlString: "https://capi.douyucdn.cn/api/v1/slide/6?") { (result) in

            //1. 获取字典数据
            guard let resultDict = result as? [String: AnyObject] else{return}
            
            //2. 根据key(data),获取对应字典数组
            guard let dataArray = resultDict["data"] as? [[String: AnyObject]] else {return}
            
            //3. 遍历字典，转模型
            for dict in dataArray{
                let cycle = CycleModel(dict: dict)
                self.cycleArray.append(cycle)
            }
            finishedCallback()
        }
    }
}
