//
//  HomeViewController2.swift
//  HealthyLife
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 kimCH. All rights reserved.
//


import UIKit

class HomeViewController2: UIViewController,DataProtocolDelegate {

    var  collectionView:UICollectionView!
    var loopView:MYView!
    
    var space:CGFloat = 20
    var dataArr = [HomeModel]()
    var page = 777
    let request = QFRequest()
    lazy var webViewVC:PushViewController = {
        let push = PushViewController()
        return push
    
    }()
    var nameArr = ["bjkj1.jpg","bjkj2.jpg","bjkj3.jpg","bjkj4.jpg","bjkj5.jpg","bjkj6.jpg"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
    
//         第一部分轮播视图
        self.automaticallyAdjustsScrollViewInsets = false
        loopView = MYView.init(frame: CGRectMake(0, 64, width2, width2-space*10), arr: nameArr, isTimer: true)
        self.view.addSubview(loopView)
//         第二部分 collectionView 展示
        self.createCollView()
        request.delegate = self
        weak var weakSelf = self
        let str = String.init(format:"http://food.boohee.com/fb/v1/feeds/info?item_id=%d&type=food_news",weakSelf!.page-1)
        request.loadRequest(str)
        let str2 = String.init(format:"http://food.boohee.com/fb/v1/feeds/info?item_id=%d&type=food_news",weakSelf!.page-2)
        request.loadRequest(str2)
        let str3 = String.init(format:"http://food.boohee.com/fb/v1/feeds/info?item_id=%d&type=food_news",weakSelf!.page-3)
        request.loadRequest(str3)
        
        collectionView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
               weak var weakSelf = self
            let urlStr = String.init(format:"http://food.boohee.com/fb/v1/feeds/info?item_id=%d&type=food_news",weakSelf!.page)
            weakSelf!.request.loadRequest(urlStr)
              weakSelf!.page += 1
//            print(weakSelf!.page)
            
        })
        
      collectionView.mj_footer.beginRefreshing()
     
        
    }
     
    func didReciveData(data: NSData) {
        let dict = try! NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! NSDictionary
        let dic = dict as! [String:AnyObject]
        self.dataArr.append(HomeModel.modelWith(dic))
       self.collectionView.reloadData()
        collectionView.mj_footer.endRefreshing()
        
        
        
    }

    func createCollView(){
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(width2-50, (width2-50)*2/3)
        layout.minimumLineSpacing = width2/20
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets.init(top: 5, left: 0, bottom: 5, right: 0)
        layout.scrollDirection = .Vertical
       collectionView = UICollectionView.init(frame: CGRectMake(space, self.loopView.frame.height+64 + space, width2-space*2, height2-space*5),collectionViewLayout:layout)
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.registerNib(UINib.init(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionViewCell")
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.delegate = self
        collectionView.dataSource = self
        self.view.addSubview(collectionView)
        
    }

}

extension HomeViewController2:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("HomeCollectionViewCell", forIndexPath: indexPath) as! HomeCollectionViewCell
      cell.customWith(dataArr[indexPath.row])
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
       webViewVC.strUrl = dataArr[indexPath.row].link
        self.navigationController?.pushViewController(webViewVC, animated: true)
   
        
    }


}
