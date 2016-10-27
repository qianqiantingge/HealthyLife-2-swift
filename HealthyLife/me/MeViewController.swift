////
////  MeViewController.swift
////  HealthyLife
////
////  Created by qianfeng on 16/9/21.
////  Copyright © 2016年 kimCH. All rights reserved.
////
//// 5s    320.0
//     6s   375.0
//        6s plus 414.0
import UIKit

class MeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var space:CGFloat = width2/5.91428571428571
    var headeImage:UIImageView! = nil
    var nickL:UILabel! = nil
    var table = UITableView()
    var nameArr = ["饮食分析","上传食物","我的收藏"]
    var iconArr = ["ping","xiang","shou"]
    lazy var vc:MYLove = {
        
        let vb = MYLove()
       
        return vb
    
    
    }()
    lazy var dataArray: NSMutableArray = {
        
        let path = NSBundle.mainBundle().pathForResource("ListMe", ofType: "plist")
        let array = NSMutableArray.init(contentsOfFile: path!)
        return array!
        
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.automaticallyAdjustsScrollViewInsets = false
        createView()
       
    }
    
    func createView(){
     
        let header = UIImageView.init(frame: CGRectMake(0, 0, width2, 240))
        header.image = UIImage.init(named: "0.jpg")
        
        header.userInteractionEnabled = true
        let imageView1 = UIImageView.init(frame: CGRectMake((header.frame.width-space)/2, (header.frame.height-space)/2,space, space))
        
        imageView1.center.x = width2/2
       
        imageView1.image = UIImage.init(named: "loginHeadImage")
        header.addSubview(imageView1)
        let btn = UIButton.init(frame: CGRectMake((header.frame.width-space)/2, imageView1.frame.origin.y + imageView1.frame.height, space, space/2))
        
        btn.setTitle("登录", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
         btn.addTarget(self, action: #selector(MeViewController.settingBtnClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        btn.center.x = width2/2
        header.addSubview(btn)
        table = UITableView.init(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height), style: UITableViewStyle.Grouped)
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        table.bounces = false
        table.tableHeaderView = header
        table.delegate = self
        table.dataSource = self
        table.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0)
        self.view.addSubview(table)
   

    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        self.table.reloadData()
        
    }
 
    
    
    override func viewDidDisappear(animated: Bool) {
        //         结束推送
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        
    }

}

extension MeViewController{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.dataArray.count

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array = self.dataArray.objectAtIndex(section) as! NSArray
        
        return array.count

    }
    
    func on(){
            let ac = UIAlertController.init(title: nil, message: "控血糖模式开启", preferredStyle:.Alert )
            let action = UIAlertAction.init(title: "减少糖分食物的摄入", style: .Default) { (action) in
                
            }
            ac.addAction(action)
            self.presentViewController(ac, animated: true, completion: nil)
        
    
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

            let cell = UITableViewCell.init(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "qq") as? UITableViewCell
           cell?.selectionStyle = UITableViewCellSelectionStyle.None
      cell?.selectionStyle = UITableViewCellSelectionStyle.None
        if indexPath.section == 0 {
            for i in 0...2{
                let btn = UIButton.init(type: UIButtonType.System)
                btn.frame = CGRectMake(width2/3 * CGFloat(i), 0, width2/3, width2/3*(1/4))
                btn.setImage(UIImage.init(named: iconArr[i])?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Normal)
                btn.addTarget(self, action: #selector(self.Click(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                btn.tag = 50 + i
                
                let lab = UILabel.init(frame: CGRectMake(width2/3 * CGFloat(i), btn.frame.origin.y + btn.frame.height, width2/3,width2/3*(1/4)))
                lab.text = nameArr[i]
                lab.font = UIFont.systemFontOfSize(12)
                lab.textAlignment = .Center
                cell?.contentView.addSubview(btn)
                cell?.contentView.addSubview(lab)
            
            }
        
        }else if indexPath.section == 1{
        
            cell?.textLabel?.text = "控血糖模式"
            cell?.detailTextLabel?.text = "只针对糖尿病患者"
            cell?.textLabel?.font = UIFont.systemFontOfSize(15)
            let Switc = UISwitch.init(frame:CGRectMake ((cell?.detailTextLabel?.frame.width)! + space/2, 0, (cell?.frame.height)!/2, cell!.frame.height/3))
            Switc.center.y = (cell?.center.y)! + 10
            
            Switc.center.x = width2/2
            if Switc.on == false {
                Switc.addTarget(self, action: #selector(self.on), forControlEvents: UIControlEvents.TouchUpInside)
                
            }
            cell?.contentView.addSubview(Switc)
        
        }else if indexPath.section == 2{
                  cell?.accessoryType = .DisclosureIndicator
               cell?.detailTextLabel?.font = UIFont.systemFontOfSize(14)
            if indexPath.row == 0 {
                cell?.detailTextLabel?.text = "点餐"
            }else if indexPath.row == 1 {
                cell?.detailTextLabel?.text = "给我们提个建议"

            }else {
                cell?.detailTextLabel?.text = "分享给朋友"
 
            
            }
        
        
        }
        return cell!
        
       
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 2 {
            if indexPath.row == 0 {
                //         本地推送开始
                let loction = UILocalNotification()
                //                推送的 时间点
                loction.fireDate = NSDate.init(timeIntervalSinceNow:1)
                //                 分钟推送
                loction.repeatInterval = NSCalendarUnit.Hour
                //                 支持255
                loction.alertTitle = "欢迎来到健康生活"
                //                 消息体
                loction.alertBody = "欢迎来到健康生活"
                //      图片和声音
                loction.alertAction = "点餐服务暂未开通"
                loction.alertLaunchImage = "Icon"
                loction.soundName = "sound.caf"
                //         消息附带的消息  不显示出来 只作为业务处理说明或者是依据
                loction.userInfo = ["url":"http://www.baidu.com"]
                //        loction.applicationIconBadgeNumber = 1
                loction.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
                UIApplication.sharedApplication().scheduleLocalNotification(loction)
                
            
            }else{
                let ac = UIAlertController.init(title: "分享", message: "请选择平台", preferredStyle: .ActionSheet)
                let action = UIAlertAction.init(title: "QQ", style: .Default) { (action) in
                }
                ac.addAction(action)
                self.presentViewController(ac, animated: true, completion: nil)
            
            }
        
        }
    }

    func settingBtnClicked(button:UIButton)->Void
    {
        let loginVC = LoginViewController.init()
        loginVC.hidesBottomBarWhenPushed = true
        self.navigationController?.navigationBarHidden = true
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    func Click(Btn:UIButton) -> Void {
        
        if Btn.tag == 52 {
            self.presentViewController(vc, animated: true, completion: nil)
            return
        
        }
      
       
        let ac = UIAlertController.init(title: "分享", message: "请选择平台", preferredStyle: .ActionSheet)
        let action = UIAlertAction.init(title: "QQ", style: .Default) { (action) in
     
        }
        ac.addAction(action)
        self.presentViewController(ac, animated: true, completion: nil)
    }
    
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {

        return space/7
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 1
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 60
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let  view = UIView.init(frame: CGRectMake(0, 0, self.view.frame.size.width, 5))
        view.backgroundColor = UIColor.init(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        return view
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let  view = UIView.init(frame: CGRectMake(0, 0, self.view.frame.size.width, 1))
        view.backgroundColor = UIColor.init(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        return view
    }

}
