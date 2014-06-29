//
//  AppDelegate.swift
//  Hawking
//
//  Created by Alex Zimin on 28/06/14.
//  Copyright (c) 2014 CocoaHeadsMsk. All rights reserved.
//

import UIKit
import Grabber

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UITabBarControllerDelegate {
                            
    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        // Override point for customization after application launch.
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
        
        apperance();
        openStartLent();
        
        Grabber().grabArticle(url: "https://schani.wordpress.com/2014/06/11/associated-types-considered-weird/",
            success: {data in
                println("Title: "+data.title)
                println("Content: "+data.content)
            }, failure: { error in
                print("Error: ")
                print(error)
            })
        
        Grabber().grabArticle(url: "http://habrahabr.ru/post/227455/",
            success: {data in
                println("Title: "+data.title)
                println("Content: "+data.content)
            }, failure: { error in
                print("Error: ")
                print(error)
            })
        
        Grabber().grabArticle(url: "http://lenta.ru/news/2014/06/29/train/",
            success: {data in
                println("Title: "+data.title)
                println("Content: "+data.content)
            }, failure: { error in
                print("Error: ")
                print(error)
            })
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
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

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func openStartLent() {
        let lentVc = LentViewController(nibName: "LentViewController", bundle: nil)
        lentVc.isFave = false
        let nVC = UINavigationController(rootViewController: lentVc)
        setTabBarImages(nVC.tabBarItem, firstImageName: "LentTabS", secondImageName: "LentTab")
        nVC.title = "Lent"
        
        let faveVC = LentViewController(nibName: "LentViewController", bundle: nil)
        lentVc.isFave = true
        let nVC2 = UINavigationController(rootViewController: faveVC)
        setTabBarImages(nVC2.tabBarItem, firstImageName: "FaveTabS", secondImageName: "FaveTab")
        nVC2.title = "Fave"
        
        let settingsVC = SettingsViewController(nibName: "SettingsViewController", bundle: nil)
        let nVC3 = UINavigationController(rootViewController: settingsVC)
        setTabBarImages(nVC3.tabBarItem, firstImageName: "SettingsTabS", secondImageName: "SettingsTab")
        nVC3.title = "Settings"
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([nVC, nVC2, nVC3], animated: true)
        tabBarController.selectedIndex = 0
        
        self.window!.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
    }
    
    func setTabBarImages(tabBar: UITabBarItem, firstImageName: String, secondImageName: String) {
        tabBar.setFinishedSelectedImage(UIImage(named: firstImageName).imageWithOverlayColor(UIColor.mainColor()), withFinishedUnselectedImage: (UIImage(named: secondImageName).imageWithOverlayColor(UIColor.lightGrayColor())))
    }
    
    func apperance() {
        UIBarButtonItem.appearance().tintColor = UIColor.mainColor()
        
        UINavigationBar.appearance().barTintColor = UIColor.mainColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), UITextAttributeTextColor : UIColor.whiteColor()];
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        
        UITabBar.appearance().tintColor = UIColor.mainColor()
        UITabBar.appearance().selectedImageTintColor = UIColor.mainColor()
    }

}


