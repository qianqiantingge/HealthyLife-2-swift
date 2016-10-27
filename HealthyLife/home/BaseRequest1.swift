//
//  BaseRequest1.swift
//  HealthyLife
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 kimCH. All rights reserved.
//

import UIKit

class BaseRequest1: NSObject {
    class func getWithURL(url:String!,para:NSDictionary?,callBack:(data:NSData?,error:NSError?)->Void)->Void
    {
        let session = NSURLSession.sharedSession()
        
        let urlStr = NSMutableString.init(string: url)
        if para != nil {
            urlStr.appendString(self.encodeUniCode(self.parasToString(para!)) as String)
            
            
        }
        let request = NSMutableURLRequest.init(URL: (NSURL.init(string: urlStr as String))!)
        request.HTTPMethod = "GET"
        let dataTask = session.dataTaskWithRequest(request) { (data, response, error) in
            
            //            let res:NSHTTPURLResponse = response as! NSHTTPURLResponse
            if data != nil
            {
                callBack(data:data,error:nil)
            }else
            {
                callBack(data:nil,error:error)
            }
        }
        //启动请求任务
        dataTask .resume()
    }
//     传入网址
    class func postWithURL(url:String!,para:NSDictionary?,callBack:(data:NSData?,error:NSError?)->Void)->Void{
        let session = NSURLSession.sharedSession()
        
        let urlStr = NSMutableString.init(string: url)
        if para != nil {
            urlStr.appendString(self.encodeUniCode(self.parasToString(para!)) as String)
        }
        let request = NSMutableURLRequest.init(URL: (NSURL.init(string: urlStr as String))!)
        request.HTTPMethod = "POST"
        let dataTask = session.dataTaskWithRequest(request) { (data, response, error) in
            
            
            if error == nil
            {
                callBack(data:data,error:nil)
            }else
            {
                callBack(data:nil,error:error)
            }
        }
        //启动请求任务
        dataTask .resume()
    }
//     拼接网址
    class func parasToString(para:NSDictionary?)->String
    {
        let paraStr = NSMutableString.init(string: "?")
        for (key,value) in para as! [String :String]
        {
            paraStr.appendFormat("%@=%@&", key,value)
        }
        if paraStr.hasSuffix("&"){
            paraStr.deleteCharactersInRange(NSMakeRange(paraStr.length - 1, 1))
        }
        //将URL中的特殊字符进行转吗
        //        paraStr.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())
        //移除转码
        //        paraStr.stringByRemovingPercentEncoding
        return String(paraStr)
    }
//     转码
    class func encodeUniCode(string:NSString)->NSString
    {
        return string.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())!
    }

}
