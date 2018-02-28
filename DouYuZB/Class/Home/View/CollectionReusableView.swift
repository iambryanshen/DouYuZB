//
//  CollectionReusableView.swift
//  DouYuZB
//
//  Created by BrianShen on 17/3/31.
//  Copyright © 2017年 brianshen. All rights reserved.
//

import UIKit

class CollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    var anchorGroup : AnchorGroupModel? {
        didSet{
            iconImageView.image = UIImage(named: anchorGroup?.icon_name ?? "home_header_normal")
            titleLabel.text = anchorGroup?.tag_name
        }
    }
    
}

extension CollectionReusableView {
    
    class func collectionReusableView() -> CollectionReusableView{
        return Bundle.main.loadNibNamed("CollectionReusableView", owner: nil, options: nil)?.first as! CollectionReusableView
    }
}
