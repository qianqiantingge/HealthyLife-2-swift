//
//  selectViewController.swift
//  HealthyLife
//
//  Created by qianfeng on 16/9/25.
//  Copyright © 2016年 kimCH. All rights reserved.
//

import UIKit

class selectViewController: UIViewController 
{
    var nameArr = ["苹果","香蕉","馒头","红薯","酸奶","米饭","玉米","鸡蛋","豆浆","草莓"]
    var tag:Int = 0

    var tabelV = UITableView()

    var space = CGFloat(30)
    override func viewDidLoad() {
            super.viewDidLoad()
        createUITab()
        
    }
    func createUITab(){
        var frame = self.view.bounds
        frame.size.height -= 64
        self.tabelV.delegate = self
        self.tabelV.dataSource = self
        tabelV.frame = frame
        self.view.addSubview(tabelV)
        let TextField = UITextField.init(frame: CGRectMake(space, 0, width2-space*2, space*2))
        TextField.layer.cornerRadius = space/6
        TextField.backgroundColor = UIColor.redColor()
        self.view.addSubview(TextField)
        tabelV.rowHeight = 80
        tabelV.registerNib(UINib.init(nibName: "selectCell", bundle: nil), forCellReuseIdentifier: "selectCell")
    
    
    
    }



}

extension selectViewController:UITableViewDelegate,UITableViewDataSource{

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier("selectCell", forIndexPath: indexPath) as! selectCell
        cell.btnClick1.setTitle(nameArr[indexPath.row] , forState: UIControlState.Normal)
        cell.btnClick1.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        cell.btnClick1.tag = 10
        cell.btnClick2.setTitle(nameArr[nameArr.count-1-indexPath.row] , forState: UIControlState.Normal)
        cell.btnClick2.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        cell.btnClick2.tag = 11
        cell.btnClick1.addTarget(self, action: #selector(self.Click(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.btnClick2.addTarget(self, action: #selector(self.Click(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.backgroundColor =  UIColor.init(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        return cell
        
    }
    
    func Click(sender:UIButton) -> Void {
      let next = selectCToNextViewController()
        next.str = sender.currentTitle

        next.tagInt = self.tag
        self.navigationController?.pushViewController(next, animated: true)
        
  
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArr.count/2
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
 
        let label = UILabel.init()
        if section == 0 {
           label.text = "最近在搜"
        }else {
        label.text = "大家都在搜"
        
        }
          return label
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return space
    }
    
    
  

}
