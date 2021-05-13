//
//  ImageInteractor.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 13.05.2021.
//

import Foundation

public protocol ImageInteractorProtocol: AnyObject {
    func image(with id: String)
    func create()
    func update(id: String, title: String, description: String)
}

public protocol ImageInteractorDelegate: AnyObject {
    func handleCreate(_ result: NetworkResult<RestObjectResponse<Image>>)
    func handleImage(_ result: NetworkResult<RestObjectResponse<Image>>)
    func handleUpdate(_ result: NetworkResult<RestObjectResponse<Image>>)
}

public final class ImageInteractor: Interactor {
    public weak var output: ImageInteractorDelegate?
}

// MARK: - ImageInteractorProtocol
extension ImageInteractor: ImageInteractorProtocol {
    
    public func create() {
        service.execute(task: GetImageTask(id: ""), type: RestObjectResponse<Image>.self) { [weak self] response in
            self?.output?.handleImage(response)
        }
    }
    
    public func image(with id: String) {
        service.execute(task: GetImageTask(id: id), type: RestObjectResponse<Image>.self) { [weak self] response in
            self?.output?.handleImage(response)
        }
    }
    
    public func update(id: String, title: String, description: String) {
        let task = UpdateImageTask(id: id, title: title, description: description)
        service.execute(task: task, type: RestObjectResponse<Image>.self) { [weak self] response in
            self?.output?.handleUpdate(response)
        }
    }
}
