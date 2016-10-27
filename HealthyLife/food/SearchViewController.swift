//
//  SearchViewController.swift
//  HealthyLife
//
//  Created by qianfeng on 16/10/1.
//  Copyright © 2016年 kimCH. All rights reserved.
//

import UIKit
 class SearchViewController:  UIViewController,DataProtocolDelegate ,UITableViewDelegate,UITableViewDataSource{
    var tagInt:Int = 0
    let  request = QFRequest()
    var str:String!
    var dataArr   = [selectToNextModle]()
    var tabVC = UITableView()
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let weakself = self
        if str != nil {
        let strUrl = String.init(format: "http://food.boohee.com/fb/v1/search?page=1&order_asc=desc&q=%@&health_mode=1",str.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)
        request.delegate = weakself
        request.loadRequest(strUrl)
        tabVC = UITableView.init(frame: weakself.view.bounds)
        
        tabVC.delegate = weakself
        tabVC.dataSource = weakself
        tabVC.registerNib(UINib.init(nibName: "selectToNextCell", bundle: nil), forCellReuseIdentifier: "selectToNextCell")
        weakself.view.addSubview(tabVC)
        tabVC.rowHeight = 100
            
        }else {
            return
        
        }
            
            
   
        
        
    }
   
  
    
    func didReciveData(data: NSData){
        let dic = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
        let arr = dic["items"] as? NSArray
        for dict in arr! {
            self.dataArr.append(selectToNextModle.custome(dict as? [String : AnyObject]))
            
        }
        tabVC.reloadData()
    }
    
    
}

extension SearchViewController{
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("selectToNextCell", forIndexPath: indexPath) as! selectToNextCell
        
        cell.titleL.text = dataArr[indexPath.row].name
        
        cell.contenL.text = "\(dataArr[indexPath.row].calory)千卡/\(dataArr[indexPath.row].weight)克"
        if dataArr[indexPath.row].thumbImageUrl != nil {
            cell.imageV.sd_setImageWithURL(NSURL.init(string:dataArr[indexPath.row].thumbImageUrl!))
        }
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    



}
