//
//  CollectionViewGameCell.swift
//  DouYuZB
//
//  Created by BrianShen on 17/4/6.
//  Copyright © 2017年 brianshen. All rights reserved.
//

import UIKit

class CollectionViewGameCell: UICollectionViewCell {
    
    // MARK:- 控件属性
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK:- 属性
    var anchorGroup : BaseModel?{
        didSet{
            
            //删除第一个和第二个数据
            titleLabel.text = anchorGroup?.tag_name
            let url = URL(string: anchorGroup?.icon_url ?? "")
            imageView.kf.setImage(with: url)
        }
    }
    
    // MARK:- 系统回调方法
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imageView.layer.cornerRadius = imageView.bounds.width/2
        imageView.layer.masksToBounds = true
    }

}
