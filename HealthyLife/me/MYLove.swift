//
//  MYLove.swift
//  HealthyLife
//
//  Created by qianfeng on 16/9/30.
//  Copyright © 2016年 kimCH. All rights reserved.
//

import UIKit

class MYLove: UIViewController {

            override func viewDidLoad() {
            super.viewDidLoad()
            let urlS = NSUserDefaults.standardUserDefaults()
            if  urlS.objectForKey("qq")  != nil {
               let strUrl1 = urlS.objectForKey("qq") as! String
                let webV = UIWebView.init(frame: self.view.bounds)
                self.view.addSubview(webV)
                let url = NSURL.init(string: strUrl1)
                let request = NSURLRequest.init(URL: url!)
                webV.loadRequest(request)
            
            }else {
                let ac = UIAlertController.init(title: nil, message: "收藏", preferredStyle: UIAlertControllerStyle.Alert)
                let action = UIAlertAction.init(title: "您暂时没有收藏", style: UIAlertActionStyle.Default, handler: nil)
                ac.addAction(action)
                self.presentViewController(ac, animated: true, completion: nil)
                
                }
                
          
       
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    


}
