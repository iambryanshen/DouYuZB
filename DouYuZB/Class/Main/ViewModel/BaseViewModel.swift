//
//  BaseViewModel.swift
//  DouYuZB
//
//  Created by BrianShen on 17/4/11.
//  Copyright © 2017年 brianshen. All rights reserved.
//

import UIKit

class BaseViewModel {
    
    // MARK:- 定义属性
    lazy var anchorGroupModelArray : [AnchorGroupModel] = [AnchorGroupModel]()
}

extension BaseViewModel {
    
    func loadAnchorData(isNormal: Bool, urlString: String, parameters: [String: Any]? = nil, finishedCallback: @escaping ()->()) {
        
        SFNetwork.requestData(httptype: .POST, urlString: urlString, parameters: parameters) { (result) in
            
            //1. 对数据进行处理
            guard let result = result as? [String: AnyObject] else {return}
            guard let dataArray = result["data"] as? [[String: AnyObject]] else {return}
            
            if isNormal {
                
                //2. 字典数组转模型数组
                for dict in dataArray {
                    let anchorGroupModel = AnchorGroupModel(dict: dict)
                    self.anchorGroupModelArray.append(anchorGroupModel)
                }
            } else {
                
                let group = AnchorGroupModel()
                //2. 字典数组转模型数组
                for dict in dataArray {
                    
                   group.Anchors.append(AnchorModel(dict: dict))
                }
                self.anchorGroupModelArray.append(group)
            }

            finishedCallback()
        }
    }
}
