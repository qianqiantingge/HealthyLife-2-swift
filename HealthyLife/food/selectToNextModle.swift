//
//  selectToNextModle.swift
//  HealthyLife
//
//  Created by qianfeng on 16/9/26.
//  Copyright © 2016年 kimCH. All rights reserved.
//

import UIKit

class selectToNextModle: NSObject {
    var id:Int = 0
    var name:String?
    var thumbImageUrl:String?
    var weight:String!
    var calory:String!
    var code:String?
    
    
    static func custome(dict:[String:AnyObject]?)->selectToNextModle{
        let seleC = selectToNextModle()
        seleC.setValuesForKeysWithDictionary(dict!)
        seleC.thumbImageUrl = dict!["thumb_image_url"]! as? String
        seleC.id = dict!["id"] as! Int
        return seleC
    
    
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }


}
