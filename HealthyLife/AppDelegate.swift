//
//  AppDelegate.swift
//  HealthyLife
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 kimCH. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder,UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow.init(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        
        window?.rootViewController = HomeViewController()
        window?.makeKeyAndVisible()
        // Override point for customization after application launch.
        self.appleAPNS()
        return true
    }

    func appleAPNS(){
            if UIDevice.currentDevice().systemVersion >= "8.0"{
//  消息推送注册    在6.0 对应的ios 8.0消息是否需要categories：IDFA 是否使用广告
            let setting = UIUserNotificationSettings.init(forTypes: [UIUserNotificationType.Alert,UIUserNotificationType.Sound,UIUserNotificationType.Badge], categories: nil)
// 注册消息的设置     8.0——9.3.5    本地和远程消息都影响
            UIApplication.sharedApplication().registerUserNotificationSettings(setting)
//注册远程消息推送服务
            UIApplication.sharedApplication().registerForRemoteNotifications()
            
        }else {
            UIApplication.sharedApplication().registerForRemoteNotificationTypes([UIRemoteNotificationType.Alert,UIRemoteNotificationType.Badge,UIRemoteNotificationType.Sound])
        }
    
    
    }
    
    
//     接收本地消息的推送
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
    
        let  alert = UIAlertController.init(title: notification.alertTitle, message: notification.alertBody, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction.init(title: notification.alertAction, style: UIAlertActionStyle.Default) { (action) in
            _ = notification.userInfo
        }
        alert.addAction(action)
//        将alert 显示到窗口上
        self.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
//        print("注册成功")
    }
    
    
  
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
//         0  应用即将进入后台    //
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        //        这行代码可以写到 相应的处理位置 如果在活跃状态 状态减一

        
        
    }
    

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

