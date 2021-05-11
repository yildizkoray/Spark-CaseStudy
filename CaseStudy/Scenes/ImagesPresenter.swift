//
//  ImagesPresenter.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 11.05.2021.
//

import Foundation

private struct Constants {
    static let title = "Images"
}

public protocol ImagesPresenterProtocol: Presenter {
    
}

public final class ImagesPresenter {
    
    private weak var view: ImagesViewProtocol?
    private let router: ImagesRouterProtocol
    
    public init(view: ImagesViewProtocol?, router: ImagesRouterProtocol) {
        self.view = view
        self.router = router
    }
}

// MARK: - ImagesPresenterProtocol

extension ImagesPresenter: ImagesPresenterProtocol {
    
    public func viewDidLoad() {
        view?.setTitle(with: Constants.title)
    }
}
