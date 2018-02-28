//
//  CollectionViewCell.swift
//  DouYuZB
//
//  Created by BrianShen on 17/3/31.
//  Copyright © 2017年 brianshen. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewCell: BaseCollectionViewCell {

    
    @IBOutlet weak var roomNameLabel: UILabel!      //房间昵称
    
    override var anchor : AnchorModel? {
        
        didSet{
            super.anchor = anchor
            
            //roomNameLabel
            let roomName = anchor?.room_name
            roomNameLabel.text = roomName
        }
    }
}
