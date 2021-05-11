//
//  AppRouter.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 11.05.2021.
//

import UIKit

public final class AppRouter {
    
    private let window: UIWindow!
    
    public init(with window: UIWindow) {
        self.window = window
    }
    
    public func start() {
        window.rootViewController = ImagesRouter().start()
        window.makeKeyAndVisible()
    }
}
