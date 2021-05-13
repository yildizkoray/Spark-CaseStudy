//
//  GetImageTask.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 13.05.2021.
//

import Alamofire
import Foundation

public struct GetImageTask: HTTPTask {
    public var method: HTTPMethod = .get
    public var path: String = "asset"
    public var queryParameters: [URLQueryItem]
    public var description: String = UUID().uuidString
    
    public init(id: String) {
        queryParameters = [
            URLQueryItem(name: "assetId", value: id)
        ]
    }
}

public struct UpdateImageTask: HTTPTask {
    public var method: HTTPMethod = .post
    public var path: String = "asset-update"
    public var body: Parameters?
    public var description: String = UUID().uuidString
    
    public init(id: String, title: String, description: String) {
        body = UpdateImageRequest(assetId: id, title: title, description: description).parameters()
    }
}

public struct UpdateImageRequest: Encodable {
    let assetId: String
    let title: String
    let description: String
}
