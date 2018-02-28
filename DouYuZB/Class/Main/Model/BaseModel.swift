//
//  BaseModel.swift
//  DouYuZB
//
//  Created by BrianShen on 17/4/8.
//  Copyright © 2017年 brianshen. All rights reserved.
//

import UIKit

class BaseModel: NSObject {
    
    var tag_name : String = ""                      //该组显示的标题
    var icon_url : String = ""                      //该组内容对应的头像
    
    // MARK:- 自定义构造方法
    override init() {
        
    }
    
    //字典转模型
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }

}
