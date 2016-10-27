//
//  HomeViewController.swift
//  HealthyLife
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 kimCH. All rights reserved.
//

import UIKit

class HomeViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createViewControllers()

        // Do any additional setup after loading the view.
    }
    func createViewControllers() -> Void {
 
        let proName = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        let path = NSBundle.mainBundle().pathForResource("TabBarList.plist", ofType: nil)
        let plist = NSArray.init(contentsOfFile: path!) as! [[String:String]]
        for dict in plist {
        let name = proName+"."+dict["name"]!
            let vcClass = NSClassFromString(name) as! UIViewController.Type
            let vc = vcClass.init()
            let nc = UINavigationController.init(rootViewController: vc)
            vc.navigationItem.title = dict["title"]
            vc.navigationController?.navigationBar.barTintColor = UIColor.init(red: 250/255.0, green: 190/255.0, blue: 190/255.0, alpha: 1)
           nc.tabBarItem = UITabBarItem.init(title:  dict["title"], image: UIImage.init(named: dict["icon"]!)
                , selectedImage: UIImage.init(named: dict["iconS"]!)!.imageWithRenderingMode(.AlwaysOriginal))
            UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.init(red: 9/255.0, green: 187/255.0, blue: 10/255.0, alpha: 1)], forState: .Selected)
       self.tabBar.barTintColor = UIColor.init(red: 250/255.0, green: 180/255.0, blue: 250/255.0, alpha: 1)
            self.addChildViewController(nc)
    
        
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
