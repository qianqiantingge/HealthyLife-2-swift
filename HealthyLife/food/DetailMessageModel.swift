//
//  DetailMessageModel.swift
//  HealthyLife
//
//  Created by qianfeng on 16/9/23.
//  Copyright © 2016年 kimCH. All rights reserved.
//

import UIKit

class DetailMessageModel: JSONModel {
    var id:Int = 0
    var code:String?
    var thumbImagUrl:String?
    var name:String?
    var weight:String?
    var calory:String?
    var fat:String?
    var protein:String?
    var fiberDietary:String?
    var carbohydrate:String?
    var vitaminA:String?
    var thiamine:String?
    var lactoflavn:String?
    var vitaminC:String?
    var vitaminE:String?
    var niacin:String?
    var natrium:String?
    var calcium:String?
    var iron:String?
    var kalium:String?
//    "thumb_image_url" "fiber_dietary"vitamin_a""vitamin_c" "vitamin_e
    
    static func modelWith(dic: [String: AnyObject]) -> DetailMessageModel{
        let model = DetailMessageModel()
        model.setValuesForKeysWithDictionary(dic)
        model.thumbImagUrl = dic["thumb_image_url"] as? String
        model.fiberDietary = dic["fiber_dietary"] as? String
        model.vitaminA = dic["vitamin_a"] as? String
        model.vitaminC = dic["vitamin_c"] as? String
        model.vitaminE = dic["vitamin_e"] as? String
        model.id = (dic["id"] as? Int)!
        return model
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }


}
