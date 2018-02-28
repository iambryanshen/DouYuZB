//
//  AnchorGroupModel.swift
//  DouYuZB
//
//  Created by BrianShen on 17/4/2.
//  Copyright © 2017年 brianshen. All rights reserved.
//

import UIKit

class AnchorGroupModel: BaseModel {
    
    // MARK:- 定义模型属性
    var room_list : [[String : NSObject]]? {
        //属性监听器，监听属性的改变，拿到属性改变之后的值
        didSet{
            guard let room_list = room_list else {
                return
            }
            for dict in room_list {
                let anchor = AnchorModel(dict: dict)
                Anchors.append(anchor)
            }
        }
    }   //该组中对应的房间信息
    

    var icon_name : String = "home_header_normal"   //该组显示的图标
    lazy var Anchors : [AnchorModel] = [AnchorModel]()        //保存主播信息的模型数组
    
    
    
    //重写KVC方法，在该方法里对属性“room_list”保存的字典主播信息，转换成模型主播信息
    /*
     override func setValuesForKeys(_ keyedValues: [String : Any]) {
     
        if keyedValues.keys.first == "room_list" {
            guard let dataArray = keyedValues.values.first as? [[String : AnyObject]] else {return}
            for dict in dataArray {
                let anchor = Anchor(dict: dict)
                Anchors.append(anchor)
            }
        }
     }*/
}
