//
//  ImageRouter.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 13.05.2021.
//

import UIKit

public protocol ImageRouterProtocol {
    func pop(animated: Bool, completion: @escaping () -> Void)
    func start(with id: String?, delegate: ImagePresenterDelegate)
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
    
    public func pop(animated: Bool, completion: @escaping () -> Void) {
        navigator.popViewController(animated: animated, completion: completion)
    }
    
    public func start(with id: String? = nil, delegate: ImagePresenterDelegate) {
        let view = createViewController()
        let interactor = ImageInteractor()
        let presenter = ImagePresenter(view: view, interactor: interactor, router: self, delegate: delegate, id: id)
        view.presenter = presenter
        interactor.output = presenter
        
        navigator.pushViewController(view, animated: true)
    }
}


// MARK: - UINavigationController
extension UINavigationController {
    
    public func popViewController(animated: Bool, completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: animated)
        CATransaction.commit()
    }
}
