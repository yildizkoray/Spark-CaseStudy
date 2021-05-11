//
//  ImagesRouter.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 11.05.2021.
//

import UIKit

public protocol ImagesRouterProtocol {
    func start() -> UINavigationController
}

public final class ImagesRouter: Router {
    
    public typealias Controller = ImagesViewController
    
    private weak var navigator: UINavigationController!
}

// MARK: - ImagesRouterProtocol
extension ImagesRouter: ImagesRouterProtocol {
    
    public func start() -> UINavigationController {
        defer { self.navigator = navigator }
        
        let view = createViewController()
        let navigator = UINavigationController(rootViewController: view)
        
        let presenter = ImagesPresenter(view: view, router: self)
        view.presenter = presenter
        
        return navigator
    }
}
