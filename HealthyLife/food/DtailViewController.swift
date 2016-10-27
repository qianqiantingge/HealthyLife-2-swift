//
//  DtailViewController.swift
//  HealthyLife
//
//  Created by qianfeng on 16/9/24.
//  Copyright © 2016年 kimCH. All rights reserved.
//

import UIKit

class DtailViewController: UIViewController,DataProtocolDelegate {
        var page = 1 // 通过刷新或去的
        var value = 1// 是通过点击事件中的 tag 值 传进来的
    var dataArr = [DetailMessageModel]()
    
    var table = UITableView()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.createViews()
        
    
        
    }
    func createViews() -> Void {
        table = UITableView.init(frame: self.view.bounds)
        table.delegate = self
        table.dataSource = self
        table.registerNib(UINib.init(nibName: "detailCell", bundle: nil), forCellReuseIdentifier: "qq")
        table.rowHeight = 100
        self.view.addSubview(table)
    }
    
//    MARK:协议方法
    func didReciveData(data: NSData) {
        let dict = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
        let array = dict!["foods"] as! NSMutableArray
            for dic in array{
                self.dataArr.append(DetailMessageModel.modelWith(dic as! [String : AnyObject]))
       
        
        }
        table.reloadData()
        
    
    }


    override func viewDidDisappear(animated: Bool) {
   
        dataArr.removeAll()
        self.table.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        let request = QFRequest()
        request.delegate = self
        let str = String.init(format:"http://food.boohee.com/fb/v1/foods?kind=group&value=%d&order_by=1&page=%d&order_asc=0&token=&user_key=&app_version=2.2&app_device=Android&os_version=5.1&phone_model=UOOGOU&channel=tencent",value,page)
        request.loadRequest(str)
    }

}
extension DtailViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let str = "qq"
        let cell = tableView.dequeueReusableCellWithIdentifier(str, forIndexPath: indexPath) as? detailCell
     
        cell!.nameL.text = dataArr[indexPath.row].name
        cell!.detailL.text = "\(dataArr[indexPath.row].calory!)千卡/\(dataArr[indexPath.row].weight!)克"
        if dataArr[indexPath.row].thumbImagUrl != nil {
        cell?.iconView.sd_setImageWithURL(NSURL.init(string: (dataArr[indexPath.row].thumbImagUrl!)))
        }
     
        
        return cell!
    }
  

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return dataArr.count
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.table.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.page += 1
            let request = QFRequest()
            request.delegate = self
            let str = String.init(format:"http://food.boohee.com/fb/v1/foods?kind=group&value=%d&order_by=1&page=%d&order_asc=0&token=&user_key=&app_version=2.2",self.value,self.page)
            request.loadRequest(str)
        })
        table.reloadData()
    }
    

}
