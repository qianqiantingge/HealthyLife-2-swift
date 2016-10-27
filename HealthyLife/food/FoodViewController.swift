//
//  FoodViewController.swift
//  HealthyLife
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 kimCH. All rights reserved.
//

import UIKit

class FoodViewController: UIViewController,UITextFieldDelegate, UISearchControllerDelegate{
   
 
    var nameArr = ["苹果","香蕉","馒头","红薯","酸奶","米饭","玉米","鸡蛋","豆浆","草莓"]
    var textField:UITextField = UITextField()
    var PkView = UIView()
    lazy var PKController:PKViewController = {
        let vc = PKViewController()
        return vc
    }()
    
    lazy var detaiVC:DtailViewController = {
    
        let vc = DtailViewController()
        return vc
    
    
    }()
    
    lazy var searchVC:SearchViewController = {
    
        let vc = SearchViewController()
        return vc
    
    }()
    
    
 

    var space:CGFloat = 60
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.init(red: 208/255.0, green:  208/255.0, blue:  208/255.0, alpha: 1)
        createViews()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "确定", style: UIBarButtonItemStyle.Done, target:self, action: #selector(self.Cliclk2))
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        
    }
    
    func  Cliclk2() -> Void {
        for obj in nameArr{
            if self.textField.text == obj {
                searchVC.str = obj
                presentViewController(searchVC, animated: true, completion: nil)
            
            }else {
                let act = UIAlertController.init(title: nil, message: "没有此选项", preferredStyle: UIAlertControllerStyle.Alert)
                let action = UIAlertAction.init(title: "输入文字例如：苹果", style: UIAlertActionStyle.Default, handler: nil)
                act.addAction(action)
                self.presentViewController(act, animated: true, completion: nil)
            
            }
        
        }
     
    }

    
        func createViews(){
//         第一步建立搜索的textFidel
        textField = UITextField.init(frame: CGRectMake(0, 0, width2 - 2*space, space/2))
        textField.layer.cornerRadius = 5
        textField.clearButtonMode = .Always
        textField.keyboardType = .EmailAddress
        textField.placeholder = "中文：例如苹果"
        textField.backgroundColor = UIColor.whiteColor()
        self.navigationItem.titleView = textField
        textField.becomeFirstResponder()
     
//         第二步 建立uiview
       PkView = UIView.init(frame: CGRectMake(0, 64, width2, space))
        PkView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(PkView)
        let imageView = UIImageView.init(frame: CGRectMake(space/6, 0, space/2, space/3))
        imageView.image = UIImage.init(named: "good")
        imageView.center.y = space/2
        PkView.addSubview(imageView)
        let label = UILabel.init(frame: CGRectMake(space/3 + space/2, 0, space*2, space/2))
        label.numberOfLines = 0
        label.text = "食物对比"
            label.tag = 10
        label.font = UIFont.systemFontOfSize(14)
        PkView.addSubview(label)
        let labelb = UILabel.init(frame: CGRectMake(space/3 + space/2, space/2, space*3, space/2))
        labelb.numberOfLines = 0
        labelb.text = "食物数据大PK"
        labelb.font = UIFont.systemFontOfSize(12)
        labelb.textColor = UIColor.grayColor()
        PkView.addSubview(labelb)
        let imageView1 = UIImageView.init(frame: CGRectMake(width2-(space/6 + space/2), 0, space/2,  space/2))
        imageView1.image = UIImage.init(named: "moreSettings")
        imageView1.center.y = space/2
        imageView1.userInteractionEnabled = true
        let top = UITapGestureRecognizer.init(target: self, action: #selector(self.TapSigle))
        top.numberOfTapsRequired = 1
        top.numberOfTouchesRequired = 1
        imageView1.addGestureRecognizer(top)
        PkView.addSubview(imageView1)
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSizeMake(width2, (width2)*5/3)
            layout.minimumLineSpacing = space/3
            layout.minimumInteritemSpacing = 0
            layout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
            layout.scrollDirection = .Vertical
            let collectionView = UICollectionView.init(frame: CGRectMake(0,self.space/3+PkView.frame.origin.y+PkView.frame.height, width2, height2-space*2),collectionViewLayout: layout)
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.backgroundColor = UIColor.init(red: 208/255.0, green:  208/255.0, blue:  208/255.0, alpha: 1)
            collectionView.registerNib(UINib.init(nibName: "KindsCell", bundle: nil), forCellWithReuseIdentifier: "KindsCell")
            
            self.view.addSubview(collectionView)

    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
   
      textField.resignFirstResponder()
    }
    
    func TapSigle() -> Void {
        let label = self.view.viewWithTag(10) as! UILabel
        self.navigationItem.title = label.text
        label.textColor = UIColor.init(red: 208/255.0, green: 208/255.0, blue: 208/255.0, alpha: 1)
    
        self.navigationController?.pushViewController(self.PKController, animated: true)
        
    }


}

extension FoodViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("KindsCell", forIndexPath: indexPath) as! KindsCell
        cell.clickBtn.addTarget(self, action: #selector(self.CLick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.click1Btn.addTarget(self, action: #selector(self.CLick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.click2Btn.addTarget(self, action: #selector(self.CLick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.click3Btn.addTarget(self, action: #selector(self.CLick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.click4Btn.addTarget(self, action: #selector(self.CLick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.click5Btn.addTarget(self, action: #selector(self.CLick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.click6Btn.addTarget(self, action: #selector(self.CLick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.click7Btn.addTarget(self, action: #selector(self.CLick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.click8Btn.addTarget(self, action: #selector(self.CLick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.click9Btn.addTarget(self, action: #selector(self.CLick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.click10Btn.addTarget(self, action: #selector(self.CLick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.click11Btn.addTarget(self, action: #selector(self.CLick(_:)), forControlEvents: UIControlEvents.TouchUpInside)

        return cell
    }
    
    func CLick(btn:UIButton){
        detaiVC.value = btn.tag+1
        self.navigationController?.pushViewController(self.detaiVC, animated: true)
    
    
    }



}


