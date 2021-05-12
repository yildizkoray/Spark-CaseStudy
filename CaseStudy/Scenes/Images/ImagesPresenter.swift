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
    var numberOfItems: Int { get }
    
    func didSelectItem(at indexPath: IndexPath)
    func image(at indexPath: IndexPath) -> ImagePresentation
}

public final class ImagesPresenter {
    
    private weak var view: ImagesViewProtocol?
    private let router: ImagesRouterProtocol
    private let interactor: ImagesInteractorProtocol
    
    var images: ImagesPresentation = .empty {
        didSet {
            view?.reloadTableView()
        }
    }
    
    private var page: Int = .zero
    
    public init(view: ImagesViewProtocol?, router: ImagesRouterProtocol, interactor: ImagesInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - ImagesPresenterProtocol

extension ImagesPresenter: ImagesPresenterProtocol {
    
    public var numberOfItems: Int {
        return images.images.count
    }
    
    public func didSelectItem(at indexPath: IndexPath) {
        router.navigateToImageViewController(with: image(at: indexPath).id)
    }
    
    public func image(at indexPath: IndexPath) -> ImagePresentation {
        return images.images[indexPath.row]
    }
    
    public func viewDidLoad() {
        view?.prepareTableView()
        view?.setTitle(with: Constants.title)
        interactor.images(page: page)
    }
}

// MARK: - ImagesInteractorDelegate
extension ImagesPresenter: ImagesInteractorDelegate {
    public func handleImages(_ result: NetworkResult<RestArrayResponse<Image>>) {
        switch result {
        case .success(let response):
            page = response.hasNextPage ? page + 1 : page
            images = ImagesPresentation(images: response.data)
            
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
}
