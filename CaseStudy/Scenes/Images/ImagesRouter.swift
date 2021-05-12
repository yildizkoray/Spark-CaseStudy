//
//  ImagesRouter.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 11.05.2021.
//

import UIKit

public protocol ImagesRouterProtocol {
    func start() -> UINavigationController
    func navigateToImageViewController(with id: String?)
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
        let interactor = ImagesInteractor()
        
        let presenter = ImagesPresenter(view: view, router: self, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        
        return navigator
    }
    
    public func navigateToImageViewController(with id: String? = nil) {
        print(id ?? .empty)
    }
}
