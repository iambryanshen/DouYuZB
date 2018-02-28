//
//  AmuseViewModel.swift
//  DouYuZB
//
//  Created by BrianShen on 17/4/9.
//  Copyright © 2017年 brianshen. All rights reserved.
//

import UIKit

class AmuseViewModel: BaseViewModel {
    
}

extension AmuseViewModel {
    
    func requestData(finishedCallback: @escaping ()->()) {
        
        loadAnchorData(isNormal: true, urlString: "https://www.douyu.com/api/v1/getHotRoom/2", finishedCallback: finishedCallback)
    }
}
