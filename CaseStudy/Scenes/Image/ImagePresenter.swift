//
//  ImagePresenterProtocol.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 13.05.2021.
//

import Foundation

public protocol ImagePresenterDelegate: AnyObject {
    func didSaveImage(image: Image)
    func didUpdateImage(image: Image)
}

public protocol ImagePresenterProtocol: Presenter {
    func update(title: String?, description: String?)
    func save(title: String?, description: String?, imageBase64Data: String?)
}

public final class ImagePresenter {
    private weak var view: ImageViewProtocol?
    private let router: ImageRouterProtocol
    private let interactor: ImageInteractorProtocol
    private weak var delegate: ImagePresenterDelegate?
    
    private let id: String?
    
    public init(view: ImageViewProtocol,
                interactor: ImageInteractorProtocol,
                router: ImageRouterProtocol,
                delegate: ImagePresenterDelegate,
                id: String?) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.id = id
        self.delegate = delegate
    }
}

// MARK: - ImagePresenterProtocol
extension ImagePresenter: ImagePresenterProtocol {
    public func update(title: String?, description: String?) {
        guard let title = title, !title.isEmpty,
              let description = description, !description.isEmpty,
              let id = id else { return }
        interactor.update(id: id, title: title, description: description)
    }
    
    public func save(title: String?, description: String?, imageBase64Data: String?) {
        guard let title = title, !title.isEmpty,
              let description = description, !description.isEmpty,
              let imageBase64Data = imageBase64Data, !imageBase64Data.isEmpty else { return }
        interactor.create(title: title,
                          description: description,
                          imageBase64String: "data:image/jpeg;base64, \(imageBase64Data)")
    }
    
    public func viewDidLoad() {
        view?.prepareUI()
        view?.prepareImagePicker()
        if let id = id {
            interactor.image(with: id)
            view?.prepareUpdateBarButton()
            view?.setChooseButtonVisibility(isHidden: true)
        } else {
            view?.prepareSaveBarButton()
            view?.setChooseButtonVisibility(isHidden: false)
        }
    }
    
    
}

// MARK: - ImageInteractorDelegate
extension ImagePresenter: ImageInteractorDelegate {
    public func handleUpdate(_ result: NetworkResult<RestObjectResponse<Image>>) {
        switch result {
        case .success(let response):
            router.pop(animated: true) { [weak self] in
                self?.delegate?.didUpdateImage(image: response.data)
            }
            
        case .failure(let error):
            print(error.description)
        }
    }
    
    public func handleCreate(_ result: NetworkResult<RestObjectResponse<Image>>) {
        switch result {
        case .success(let response):
            router.pop(animated: true) { [weak self] in
                self?.delegate?.didSaveImage(image: response.data)
            }
            
        case .failure(let error):
            print(error.description)
        }
    }
    
    public func handleImage(_ result: NetworkResult<RestObjectResponse<Image>>) {
        switch result {
        case .success(let response):
            view?.setTitle(with: response.data.title)
            view?.setTitleTextFieldText(text: response.data.title)
            view?.setDescriptionTextViewText(text: response.data.description)
            view?.setImageViewImage(with: response.data.url)
            
        case .failure(let error):
            print(error.description)
        }
    }
}
