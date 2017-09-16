//
//  AppDelegate.swift
//  A-Lang
//
//  Created by Saurabh Gupta on 15/09/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Properties
    
    var window: UIWindow?
    
    // MARK: UIApplicationDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        // TODO: - configure FIRApp
        FirebaseApp.configure()

        window = UIWindow(frame: UIScreen.main.bounds)
        // TODO:- find a better way
        APIManager.shared.getCategories { categories in
            self.window?.rootViewController = UINavigationController(rootViewController: AppLaunchViewController())
                //CategoriesOverviewViewController(with: CategoriesViewModel(with: categories)))// .dummy()))//
            self.window?.makeKeyAndVisible()
        }

        return true
    }
}

