//
//  CollectionViewCycleCell.swift
//  DouYuZB
//
//  Created by BrianShen on 17/4/5.
//  Copyright © 2017年 brianshen. All rights reserved.
//

import UIKit

class CollectionViewCycleCell: UICollectionViewCell {
    
    // MARK:- 控件属性
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK:- 模型属性
    var cycle : CycleModel?{
        
        didSet{
            
            titleLabel.text = cycle?.title
            let url = URL.init(string: (cycle?.pic_url)!)
            imageView.kf.setImage(with: url, placeholder: UIImage.init(named: "Img_default"));
        }
    }
}
