//
//  BaseCollectionViewCell.swift
//  DouYuZB
//
//  Created by BrianShen on 17/4/3.
//  Copyright © 2017年 brianshen. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var onlineLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    var anchor : AnchorModel? {
        didSet{
            //1. 校验模型是否有值
            guard let anchor = anchor else {return}
            
            //2. onlineLabel
            let online : Int = anchor.online
            if online >= 10000 {
                onlineLabel.text = "\(Int(online/10000))万在线"
            }else {
                onlineLabel.text = "\(online)在线"
            }
            
            //3. iconImageView
            guard let urlString = anchor.vertical_src else {
                return
            }
            let url = URL(string: urlString)
            iconImageView.kf.setImage(with: url)
            
            //4. nickName
            let nickName = anchor.nickname
            nickNameLabel.text = nickName
        }
    }
}
