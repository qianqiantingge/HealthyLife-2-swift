//
//  PushViewController.swift
//  HealthyLife
//
//  Created by qianfeng on 16/9/23.
//  Copyright © 2016年 kimCH. All rights reserved.
//

import UIKit

class PushViewController: UIViewController {
    var strUrl:String?
    var saveDic:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let webV = UIWebView.init(frame: self.view.bounds)
        if strUrl == nil {
            return
        
        }
        let url = NSURL.init(string: strUrl!)
        let request = NSURLRequest.init(URL: url!)
        self.view.addSubview(webV)
        webV.loadRequest(request)
        //         保存网址
        saveDic = strUrl!
        let rightButton = UIBarButtonItem.init(image: UIImage.init(named: "redHeart")?.imageWithRenderingMode(.AlwaysOriginal), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.save))
        self.navigationItem.rightBarButtonItem = rightButton
    }
    func save() -> Void {
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setObject(saveDic, forKey: "qq")
        ud.synchronize()
        let act = UIAlertController.init(title: nil, message: "收藏成功", preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.Default) { (act) in
            
        }
        act.addAction(action)
        self.presentViewController(act , animated: true, completion: nil)
        
    }


}
