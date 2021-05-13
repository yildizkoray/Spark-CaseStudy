//
//  ImageRouter.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 13.05.2021.
//

import UIKit

public protocol ImageRouterProtocol {
    func pop(animated: Bool)
    func start(with id: String?)
}

public final class ImageRouter: Router {
    public typealias Controller = ImageViewController
    
    private weak var navigator: UINavigationController!
    
    public init(navigator: UINavigationController) {
        self.navigator = navigator
    }
}

// MARK: - ImageRouterProtocol
extension ImageRouter: ImageRouterProtocol {
    public func pop(animated: Bool) {
        navigator.popViewController(animated: animated)
    }
    
    public func start(with id: String? = nil) {
        let view = createViewController()
        let interactor = ImageInteractor()
        let presenter = ImagePresenter(view: view, interactor: interactor, router: self, id: id)
        view.presenter = presenter
        interactor.output = presenter
        
        navigator.pushViewController(view, animated: true)
    }
}
