//
//  selectCToNextViewController.swift
//  HealthyLife
//
//  Created by qianfeng on 16/9/25.
//  Copyright © 2016年 kimCH. All rights reserved.
//

import UIKit
protocol ComparCodeDelegate:class {
    func ChangeUrlStrCode(str:String!,tag:Int)
}


class selectCToNextViewController: UIViewController,DataProtocolDelegate ,UITableViewDelegate,UITableViewDataSource{
    var tagInt:Int = 0
    let  request = QFRequest()
    var str:String!
    var dataArr   = [selectToNextModle]()
    var tabVC = UITableView()
    var delegate:ComparCodeDelegate?
    var VC = PKViewController()


    
    override func viewDidLoad() {
        super.viewDidLoad()
     let weakself = self
        let strUrl = String.init(format: "http://food.boohee.com/fb/v1/search?page=1&order_asc=desc&q=%@&health_mode=1",str.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)
        request.delegate = weakself
        request.loadRequest(strUrl)
        tabVC = UITableView.init(frame: weakself.view.bounds)

        tabVC.delegate = weakself
        tabVC.dataSource = weakself
        tabVC.registerNib(UINib.init(nibName: "selectToNextCell", bundle: nil), forCellReuseIdentifier: "selectToNextCell")
      weakself.view.addSubview(tabVC)
        tabVC.rowHeight = 100
      self.delegate = self.navigationController?.viewControllers[1] as! PKViewController
        
      
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

extension selectCToNextViewController{


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
        let strUrl = String.init(format: "http://food.boohee.com/fb/v1/foods/%@/brief?token=&user_key=&app_version=2.2",dataArr[indexPath.row].code!)
        self.delegate?.ChangeUrlStrCode(strUrl,tag: self.tagInt)
        self.navigationController?.popToViewController((self.navigationController?.viewControllers[1])!, animated: true)
    }
    


}