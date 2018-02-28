//
//  AnchorModel.swift
//  DouYuZB
//
//  Created by BrianShen on 17/4/2.
//  Copyright © 2017年 brianshen. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    
    var room_id : Int = 0           //房间号
    var vertical_src : String?      //房间图片对应的url
    var isVertical : Int = 0        //判断该直播是手机直播还是电脑直播：0（电脑直播）1（手机直播）
    var room_name : String = ""     //房间名称
    var nickname : String = ""      //主播名称
    var online : Int = 0            //在线人数
    var anchor_city : String = ""   //所在城市
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    //当模型中只有部分返回的字典中的键值时，需要重写这个方法
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
