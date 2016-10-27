//
//  nutritionModel.swift
//  HealthyLife
//
//  Created by qianfeng on 16/9/30.
//  Copyright © 2016年 kimCH. All rights reserved.
//

import UIKit

class nutritionModel: NSObject, NSCoding{
    
    var prop:String?
    var name:String?
    var value:String?
    var remark:String?
    static func nurWith(dic:[String:AnyObject]) -> nutritionModel {
        let nur  = nutritionModel()
        nur.setValuesForKeysWithDictionary(dic)
       
        return nur
    }
    
    override init() {
        super.init()
    }
    
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    //自定义的类型被归档时，系统自动调用的，对属性进行归档
    func encodeWithCoder(aCoder: NSCoder) -> Void {
        aCoder.encodeObject(prop, forKey: "prop")
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(value, forKey: "value")
        aCoder.encodeObject(remark, forKey: "remark")
        
        
    }
    
    //解档的时候系统自动调用。对属性进行解档
     required init?(coder aDecoder: NSCoder) {
        //如果父类也遵守了NSCoding协议，需要加上父类的解档方法super.init(coder: aDecoder)
        name = aDecoder.decodeObjectForKey("name") as? String
        prop = aDecoder.decodeObjectForKey("prop") as? String
        value = aDecoder.decodeObjectForKey("value") as? String
        remark = aDecoder.decodeObjectForKey("remark") as? String
        
        
    }
    
    required init(dictionary dict: [NSObject : AnyObject]!) throws {
        fatalError("init(dictionary:) has not been implemented")
    }
    
    required init(data: NSData!) throws {
        fatalError("init(data:) has not been implemented")
    }
    

    
}


