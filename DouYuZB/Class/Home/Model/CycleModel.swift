//
//  CycleModel.swift
//  DouYuZB
//
//  Created by BrianShen on 17/4/5.
//  Copyright © 2017年 brianshen. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    // MARK:- 模型属性
    var title = ""                  //房间标题
    var pic_url = ""                //展示图片地址
    var room : [String: AnyObject]? {
    
        didSet{
            
            guard let room = room else {return}
            anchor = AnchorModel(dict: room)
        }
    }//主播信息对应房间
    
    var anchor : AnchorModel?
    
    // MARK:- 构造方法
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

}
