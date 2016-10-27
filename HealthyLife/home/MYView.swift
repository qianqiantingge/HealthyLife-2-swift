//
//  MYView.swift
//  HealthyLife
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 kimCH. All rights reserved.
//

import UIKit

class MYView: UIView ,UIScrollViewDelegate{
    
    var nameArr: [String]!
    var MYscrollView = UIScrollView()
    var pageContol = UIPageControl()
    
    init(frame: CGRect, arr: [String]?, isTimer: Bool = false) {
        super.init(frame: frame)
        MYscrollView = UIScrollView.init(frame: CGRectMake(0, 0, frame.width, frame.height))
        self.addSubview(MYscrollView)
        if arr == nil {
            return
        }
        nameArr = arr
        nameArr.insert(nameArr[nameArr.count - 1], atIndex: 0)
        nameArr.append(nameArr[1])
        var rect = frame
        for i in 0..<nameArr.count {
            rect.origin.x = frame.size.width * CGFloat(i)
            rect.origin.y = 0
            let iv = UIImageView.init(frame: rect)
            iv.image = UIImage.init(named: nameArr[i])
            MYscrollView.addSubview(iv)
        }
        MYscrollView.contentSize = CGSize.init(width: Int(frame.width) * nameArr.count, height: 0)
        MYscrollView.contentOffset = CGPointMake(frame.width, 0)
        MYscrollView.pagingEnabled = true
        MYscrollView.delegate = self
        self.addSubview(MYscrollView)
        pageContol = UIPageControl.init(frame: CGRectMake(frame.width/2, frame.height-30, frame.width/2, 30))
        pageContol.numberOfPages = nameArr.count-1
        pageContol.currentPageIndicatorTintColor = UIColor.whiteColor()
        pageContol.pageIndicatorTintColor = UIColor.redColor()
        self.addSubview(pageContol)
        if isTimer == false {
            return
        }
        NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(self.timeRun), userInfo: nil, repeats: true)
    }
    
    func timeRun() -> Void {
        var page = Int(MYscrollView.contentOffset.x / self.frame.width)
              page += 1
           pageContol.currentPage = page
        if page == nameArr.count - 1 {
            MYscrollView.contentOffset = CGPointZero
            page = 1
            pageContol.currentPage = 1
        }
        MYscrollView.setContentOffset(CGPointMake(CGFloat(page) * self.frame.width, 0), animated: true)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

  

}
