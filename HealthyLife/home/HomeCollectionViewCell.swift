//
//  HomeCollectionViewCell.swift
//  HealthyLife
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 kimCH. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backImgView: UIImageView!
    @IBOutlet weak var BotmTailL: UILabel!
    @IBOutlet weak var botmConL: UILabel!
    @IBOutlet weak var BotmTitle: UILabel!
   
    func customWith(model:HomeModel)->Void {
        if model.background != nil {
       
            let background = model.background!
            backImgView.sd_setImageWithURL(NSURL.init(string: background), placeholderImage: UIImage.init(named: "bjkj2.jpg"))

           
        }
          backImgView.backgroundColor = UIColor.grayColor()
            BotmTailL.text = model.tail
            BotmTitle.text = model.source
            botmConL.text = model.content
//            botmConL.sizeToFit()
//            BotmTitle.sizeToFit()
//            BotmTailL.sizeToFit()

    }
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
