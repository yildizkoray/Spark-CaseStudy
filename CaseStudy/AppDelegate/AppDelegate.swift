//
//  AppDelegate.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 11.05.2021.
//

import UIKit

@main
public final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    public lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    
    public func application(_ application: UIApplication,
                            didFinishLaunchingWithOptions
                                launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppRouter(with: window!).start()
        return true
    }
}

