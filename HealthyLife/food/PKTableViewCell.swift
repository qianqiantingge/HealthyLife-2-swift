//
//  PKTableViewCell.swift
//  HealthyLife
//
//  Created by qianfeng on 16/9/27.
//  Copyright © 2016年 kimCH. All rights reserved.
//

import UIKit

class PKTableViewCell: UITableViewCell {

    @IBOutlet weak var contenL: UILabel!
    @IBOutlet weak var detailL: UILabel!
    @IBOutlet weak var titleL: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
