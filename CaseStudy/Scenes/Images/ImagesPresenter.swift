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
    var page: Int { get }
    var hasNextPage: Bool { get }
    
    func addBarButtonDidTap()
    func delete(at indexPath: IndexPath)
    func didSelect(at indexPath: IndexPath)
    func image(at indexPath: IndexPath) -> ImagePresentation
    func next()
    func refresh()
}

public final class ImagesPresenter {
    
    private weak var view: ImagesViewProtocol?
    private let router: ImagesRouterProtocol
    private let interactor: ImagesInteractorProtocol
    
    private(set) var presentation: ImagesPresentation = .empty
    
    public var page: Int = .zero
    public var hasNextPage: Bool = false
    
    public init(view: ImagesViewProtocol?, router: ImagesRouterProtocol, interactor: ImagesInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - ImagesPresenterProtocol

extension ImagesPresenter: ImagesPresenterProtocol {
    
    public var numberOfItems: Int {
        return presentation.images.count
    }
    
    public func addBarButtonDidTap() {
        router.navigateToImageViewController(with: nil)
    }
    
    public func didSelect(at indexPath: IndexPath) {
        router.navigateToImageViewController(with: image(at: indexPath).id)
    }
    
    public func image(at indexPath: IndexPath) -> ImagePresentation {
        return presentation.images[indexPath.row]
    }
    
    public func delete(at indexPath: IndexPath) {
        interactor.delete(id: presentation.images[indexPath.row].id)
    }
    
    public func viewDidLoad() {
        view?.prepareTableView()
        view?.prepareAddBarButton()
        view?.setTableViewVisibility(isHidden: true)
        view?.setTitle(with: Constants.title)
    }
    
    public func viewWillAppear() {
        page = .zero
        interactor.images(page: .zero)
    }
    
    public func refresh() {
        page = .zero
        interactor.images(page: .zero)
    }
    
    public func next() {
        interactor.next(page: page)
    }
}

// MARK: - ImagesInteractorDelegate
extension ImagesPresenter: ImagesInteractorDelegate {
    
    public func handleDelete(_ result: NetworkResult<RestObjectResponse<Image>>) {
        switch result {
        case .success(let response):
            guard let index = presentation.images.firstIndex(where: { $0.id == response.data.id }) else { return }
            let indexPath = IndexPath(row: index, section: .zero)
            presentation.images.remove(at: index)
            view?.deleteRow(at: indexPath)
            
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    public func handleImages(_ result: NetworkResult<RestArrayResponse<Image>>) {
        switch result {
        case .success(let response):
            hasNextPage = response.hasNextPage
            page = hasNextPage ? page + 1 : page
            presentation = ImagesPresentation(images: response.data)
            view?.setTableViewVisibility(isHidden: false)
            view?.reloadTableView()
            view?.endRefreshing()
            
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    public func handleNext(_ result: NetworkResult<RestArrayResponse<Image>>) {
        switch result {
        case .success(let response):
            hasNextPage = response.hasNextPage
            page = hasNextPage ? page + 1 : page
            presentation.images.append(contentsOf: response.data.compactMap(ImagePresentation.init))
            view?.reloadTableView()
            
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
