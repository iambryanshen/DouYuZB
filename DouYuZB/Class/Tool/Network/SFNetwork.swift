//
//  SFNetwork.swift
//  DouYuZB
//
//  Created by BrianShen on 17/4/2.
//  Copyright © 2017年 brianshen. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

class SFNetwork {
    
    //定义类方法，可以通过类名直接调用
    class func requestData(httptype: MethodType, urlString: String, parameters: [String: Any]? = nil, finishedCallback: @escaping (_ result: Any)->()){
        
        let method = httptype == MethodType.GET ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(urlString, method: method, parameters: parameters).responseJSON { (response) in
            
            guard let result = response.result.value else{
                print("网络请求发送失败提示信息:\(response.result.error)")
                return
            }
            finishedCallback(result)
        }
    }
}
