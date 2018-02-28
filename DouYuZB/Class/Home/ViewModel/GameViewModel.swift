//
//  GameViewModel.swift
//  DouYuZB
//
//  Created by BrianShen on 17/4/8.
//  Copyright © 2017年 brianshen. All rights reserved.
//

import UIKit

class GameViewModel {
    
    // MARK:- 属性
    lazy var gameModelArray : [GameModel] = [GameModel]()
    
    
}

extension GameViewModel{
    
    func requestData(finishedCallback: @escaping ()->()) {
        
        SFNetwork.requestData(httptype: .GET, urlString: "https://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName": "game"]) { (result) in
            
            //先把获取到的数据转成字符串
            guard let result = result as? [String: AnyObject] else {return}
            //再获取key为data的键保存的字典数组
            guard let dataArray = result["data"] as? [[String: AnyObject]] else {return}
            
            //字典数据转模型数据
            for dict in dataArray {
                let gameModel = GameModel.init(dict: dict)
                self.gameModelArray.append(gameModel)
            }
            finishedCallback()
        }
    }
}
