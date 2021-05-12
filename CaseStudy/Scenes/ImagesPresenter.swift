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
    private let interactor: ImagesInteractorProtocol
    
    public init(view: ImagesViewProtocol?, router: ImagesRouterProtocol, interactor: ImagesInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - ImagesPresenterProtocol

extension ImagesPresenter: ImagesPresenterProtocol {
    
    public func viewDidLoad() {
        view?.setTitle(with: Constants.title)
        interactor.images()
    }
}

// MARK: - ImagesInteractorDelegate
extension ImagesPresenter: ImagesInteractorDelegate {
    public func handleImages(_ result: NetworkResult<RestArrayResponse<Image>>) {
        switch result {
        case .success(let response):
            view?.setTitleLabel(title: response.data.first!.title)
            
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
}
