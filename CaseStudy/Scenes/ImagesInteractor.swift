//
//  ImagesInteractor.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 11.05.2021.
//

import Foundation

public protocol ImagesInteractorProtocol: AnyObject {
    func images()
}

public protocol ImagesInteractorDelegate: AnyObject {
    func handleImages(_ result: NetworkResult<RestArrayResponse<Image>>)
}

public final class ImagesInteractor: Interactor {
    public weak var output: ImagesInteractorDelegate?
}

extension ImagesInteractor: ImagesInteractorProtocol {
    public func images() {
        service.execute(task: GetImagesTask(), type: RestArrayResponse<Image>.self) { [weak self] response in
            self?.output?.handleImages(response)
        }
    }
}

import Alamofire

public struct GetImagesTask: HTTPTask {
    public var method: HTTPMethod = .get
    
    public var path: String = "assets"
    
    public var description: String = "dasda"
}

public struct Image: Decodable {
    var title: String
}
