//  
//  AppDelegate.swift
//  CareemAssesment
//
//  Created by Rajeel Amjad on 21/10/2019.
//  Copyright © 2019 Rajeel Amjad. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
     
        setupSharedClasses()
       
        return true
    }
}

extension AppDelegate {
    
    /// Use This function to setup all shared classes required at app start.
    fileprivate func setupSharedClasses () {
        // Start monitoring Internet connection
        _ = InternetReachability.shared
    }
}
