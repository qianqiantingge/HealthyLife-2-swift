
//
//  QFRequest.swift
//  MyNSURLSession
//
//  Created by 赵英奎 on 16/8/23.
//  Copyright © 2016年 赵英奎. All rights reserved.
//

import UIKit

//声明协议
protocol DataProtocolDelegate:NSObjectProtocol {
    func didReciveData(data: NSData)
}


class QFRequest: NSObject {
    
    //声明代理属性
    var delegate: DataProtocolDelegate?
    
    func loadRequest(strUrl: String) {
        //Session网络数据请求
        let session = NSURLSession.sharedSession()
        //将字符串转换成URL网址类型
        let url = NSURL(string: strUrl)
        //将网址封装成网络请求
        let request = NSURLRequest(URL: url!)
        //开始网络请求
        let task = session.dataTaskWithRequest(request) { (data, resp, error) in
//             菊花 不开始
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            if error == nil {
                
                let main = dispatch_get_main_queue()
                dispatch_async(main, { 
                    //这里需要将data传到表格上
                    self.delegate?.didReciveData(data!)
                })
            }else{
                print("网络请求错误")
            
            }
        }
        
//         菊花开始
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        //下载数据
        task.resume()
        
    }
}






