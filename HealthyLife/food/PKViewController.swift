//
//  PKViewController.swift
//  HealthyLife
//
//  Created by qianfeng on 16/9/23.
//  Copyright © 2016年 kimCH. All rights reserved.
//

import UIKit

class PKViewController: UIViewController,ComparCodeDelegate,DataProtocolDelegate {
    var code:String?
    var tagInt:Int = 0
    var button:UIButton!
    var button2:UIButton!
    var botemL:UILabel!
    var dataArr = [PkModel]()
    var tab = UITableView()
    var count = 0
    var dataNutaArr = [nutritionModel]()
    var dataNutaArr1 = [nutritionModel]()
    var array = [String]()
    var array1 = [String]()
    var page = 0
    let path2 = NSHomeDirectory() + "/Documents/12.txt"
    lazy var headerView:UIView = {
        
        let VW = UIView.init(frame: CGRectMake(0, 64, width2, width2/2))
        VW.backgroundColor = UIColor.grayColor()
        return VW
    
    }()
    let selectvc = selectViewController()
    var space = CGFloat(30)
    override func viewWillAppear(animated: Bool) {
        self.view.addSubview(headerView)
        self.createButten()
   
     if   self.tagInt == 2  {
        
      let nur = NSKeyedUnarchiver.unarchiveObjectWithFile(path2) as! [String]
        self.array1 = nur

        
        }
      
             tab.reloadData()
    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(headerView)
        self.createButten()
        NSKeyedArchiver.archiveRootObject(array, toFile: path2)

        

    }
    
    func ChangeUrlStrCode(str: String!,tag:Int) {
        
        self.code = str
        let  request = QFRequest()
        request.delegate = self
        request.loadRequest(code!)
        self.tagInt = tag
  
    }
    
    func didReciveData(data: NSData){
        let dic = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
        let array = dic["nutrition"] as? [AnyObject]
            let PK = PkModel()
        for dic in array!{
            let model = nutritionModel.nurWith(dic as! [String : AnyObject])
            dataNutaArr.append(model)

        }
       
        let thumbImageUrl = dic["thumb_image_url"] as! String
        PK.thumbImageUrl =  thumbImageUrl
        dataArr.append(PK)
        tab.reloadData()

    }
   
    func createButten() -> Void {
            //手写的布局创建button
        let button1 = UIButton.init(type: UIButtonType.System)
        button1.frame = CGRectMake(0, 0, self.headerView.frame.width/10
            ,self.headerView.frame.width/10)
        button1.center.x = headerView.frame.width/2
        button1.center.y = headerView.frame.height/2
        button1.layer.cornerRadius = self.headerView.frame.width/20
        button1.backgroundColor = UIColor.whiteColor()
        button1.setTitle("VS", forState: UIControlState.Normal)
        button1.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        self.headerView.addSubview(button1)
   
       button = UIButton.init(type: UIButtonType.Custom)
        button.frame = CGRectMake(width2-(self.headerView.frame.width/2 + space*3 + self.headerView.frame.width/10), 0, space*3, space*3)
        button.center.y = self.headerView.frame.height/2
        button.setTitle("+", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        button.enabled = true
        button.tag = 1
        button.addTarget(self, action: #selector(self.Click(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        button.backgroundColor = UIColor.whiteColor()
            self.headerView.addSubview(button)
        button2 = UIButton.init(type: UIButtonType.Custom)
        button2.frame = CGRectMake(self.headerView.frame.width/2 + self.headerView.frame.width/10, 0, space*3, space*3)
        button2.center.y = self.headerView.frame.height/2
        button2.backgroundColor = UIColor.whiteColor()
        button2.setTitle("+", forState: UIControlState.Normal)
        button2.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        button2.tag = 2
        button2.addTarget(self, action: #selector(self.Click(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.headerView.addSubview(button2)
        botemL = UILabel.init(frame: CGRectMake(0, self.headerView.frame.height+64, width2, space))
        botemL.text = "营养元素"
        botemL.textAlignment = .Center
        botemL.font = UIFont.systemFontOfSize(15)
        self.view.addSubview(botemL)
        
        if self.code == nil {
            return
        
        } else {
        self.tab = UITableView.init(frame: CGRectMake(5, botemL.frame.origin.y+botemL.frame.height, width2-10,height2-space*4), style: UITableViewStyle.Plain)
                tab.delegate = self
                tab.dataSource = self
            tab.registerNib(UINib.init(nibName: "PKTableViewCell", bundle: nil), forCellReuseIdentifier: "PKTableViewCell1")
        self.view.addSubview(tab)
        
        }
        
        
    }
    func Click(button:UIButton) -> Void {
        selectvc.tag = button.tag
        self.navigationController?.pushViewController(selectvc , animated: true)
        
    }


}

extension PKViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return dataNutaArr.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     let  cell = tableView.dequeueReusableCellWithIdentifier("PKTableViewCell1", forIndexPath: indexPath) as? PKTableViewCell
        let button = self.view.viewWithTag(1) as! UIButton
        let button2 = self.view.viewWithTag(2) as! UIButton
            cell?.titleL.text = dataNutaArr[indexPath.row].name
        
  if  tagInt == 1{
   
    button.sd_setBackgroundImageWithURL(NSURL.init(string:dataArr[0].thumbImageUrl), forState: UIControlState.Normal)
        cell?.detailL.text = dataNutaArr[indexPath.row].value

    
 
  }else {
    button2.sd_setBackgroundImageWithURL(NSURL.init(string:dataArr[0].thumbImageUrl), forState: UIControlState.Normal)
        cell?.contenL.text = dataNutaArr[indexPath.row].value
    
    
        }

          return cell!
    }
    


}