//
//  DeleteImageTask.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 13.05.2021.
//

import Alamofire
import Foundation

public struct DeleteImageRequest: Encodable {
    public let assetId: String
}

public struct DeleteImageTask: HTTPTask {
    public var method: HTTPMethod = .post
    public var path: String = "asset-remove"
    public var body: Parameters?
    public var description: String = UUID().uuidString
    
    public init(id: String) {
        body = DeleteImageRequest(assetId: id).parameters()
    }
}
