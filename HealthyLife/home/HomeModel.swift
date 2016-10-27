//
//  HomeModel.swift
//  HealthyLife
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 kimCH. All rights reserved.
//

import UIKit

class HomeModel:JSONModel {
    var title:String!
    var content:String!
    var tail:String!
    var shareLink:String!
    var background:String?
    var source:String!
    var link:String?
    static func modelWith(dic: [String: AnyObject]) -> HomeModel{
        let model = HomeModel()
        model.setValuesForKeysWithDictionary(dic)
        model.shareLink = dic["share_link"] as? String
        return model
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }



}
