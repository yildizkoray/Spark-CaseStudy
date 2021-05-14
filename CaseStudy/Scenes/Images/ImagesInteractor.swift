//
//  ImagesInteractor.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 11.05.2021.
//

import Foundation

public protocol ImagesInteractorProtocol: AnyObject {
    func images(page: Int)
    func next(page: Int)
    func delete(id: String)
}

public protocol ImagesInteractorDelegate: AnyObject {
    func handleDelete(_ result: NetworkResult<RestObjectResponse<Image>>)
    func handleImages(_ result: NetworkResult<RestArrayResponse<Image>>)
    func handleNext(_ result: NetworkResult<RestArrayResponse<Image>>)
}

public final class ImagesInteractor: Interactor {
    public weak var output: ImagesInteractorDelegate?
}

// MARK: - ImagesInteractorProtocol
extension ImagesInteractor: ImagesInteractorProtocol {
    
    public func delete(id: String) {
        service.execute(task: DeleteImageTask(id: id), type: RestObjectResponse<Image>.self) { [weak self] response in
            self?.output?.handleDelete(response)
        }
    }
    public func images(page: Int) {
        service.execute(task: GetImagesTask(page: page), type: RestArrayResponse<Image>.self) { [weak self] response in
            self?.output?.handleImages(response)
        }
    }
    
    public func next(page: Int) {
        service.execute(task: GetImagesTask(page: page), type: RestArrayResponse<Image>.self) { [weak self] response in
            self?.output?.handleNext(response)
        }
    }
}
