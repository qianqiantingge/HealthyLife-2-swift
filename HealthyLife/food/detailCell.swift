//
//  detailCell.swift
//  HealthyLife
//
//  Created by qianfeng on 16/9/24.
//  Copyright © 2016年 kimCH. All rights reserved.
//

import UIKit

class detailCell: UITableViewCell {

    @IBOutlet weak var detailL: UILabel!
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
