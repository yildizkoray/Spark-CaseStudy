//
//  ImagesInteractor.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 11.05.2021.
//

import Foundation

public protocol ImagesInteractorProtocol: AnyObject {
    func images(page: Int)
    func delete(id: String)
}

public protocol ImagesInteractorDelegate: AnyObject {
    func handleImages(_ result: NetworkResult<RestArrayResponse<Image>>)
    func handleDelete(_ result: NetworkResult<RestObjectResponse<Image>>)
}

public final class ImagesInteractor: Interactor {
    public weak var output: ImagesInteractorDelegate?
}

extension ImagesInteractor: ImagesInteractorProtocol {
    public func images(page: Int) {
        service.execute(task: GetImagesTask(page: page), type: RestArrayResponse<Image>.self) { [weak self] response in
            self?.output?.handleImages(response)
        }
    }
    
    public func delete(id: String) {
        service.execute(task: DeleteImageTask(id: id), type: RestObjectResponse<Image>.self) { [weak self] response in
            self?.output?.handleDelete(response)
        }
    }
}
