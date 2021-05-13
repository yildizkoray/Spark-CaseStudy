//
//  CreateImageTask.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 13.05.2021.
//

import Foundation
import Alamofire

public struct CreateImageRequest: Encodable {
    let title: String
    let description: String
    let imageData: String
}


public struct CreateImageTask: HTTPTask {
    public var method: HTTPMethod = .post
    public var path: String = "asset"
    public var body: Parameters?
    public var description: String = UUID().uuidString
    
    public init(title: String, description: String, imageBase64String: String) {
        body = CreateImageRequest(title: title, description: description, imageData: imageBase64String).parameters()
    }
}
