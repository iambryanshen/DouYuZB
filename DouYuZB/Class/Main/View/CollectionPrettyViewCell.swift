//
//  CollectionPrettyViewCell.swift
//  DouYuZB
//
//  Created by BrianShen on 17/4/1.
//  Copyright © 2017年 brianshen. All rights reserved.
//

import UIKit

class CollectionPrettyViewCell: BaseCollectionViewCell {

    @IBOutlet weak var cityButton: UIButton!    //主播所在城市
    
    override var anchor : AnchorModel? {
        
        didSet{
            super.anchor = anchor

            //5. cityButton
            cityButton.setTitle(anchor?.anchor_city, for: .normal)
        }
    }
}
