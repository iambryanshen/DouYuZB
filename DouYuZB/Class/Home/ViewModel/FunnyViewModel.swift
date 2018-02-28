//
//  FunnyViewModel.swift
//  DouYuZB
//
//  Created by BrianShen on 17/4/13.
//  Copyright © 2017年 brianshen. All rights reserved.
//

import UIKit

class FunnyViewModel: BaseViewModel {

}

extension FunnyViewModel {
    
    func loadFunnyData(finishedCallback: @escaping ()->()) {
        
        loadAnchorData(isNormal: false, urlString: "https://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: ["limit" : 30, "offset" : 0], finishedCallback: finishedCallback)
    }
}
