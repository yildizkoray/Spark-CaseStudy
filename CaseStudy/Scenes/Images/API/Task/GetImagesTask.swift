//
//  GetImagesTask.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 12.05.2021.
//

import Alamofire
import Foundation

public struct GetImagesTask: HTTPTask {
    public var method: HTTPMethod = .get
    public var path: String = "assets"
    public var queryParameters: [URLQueryItem]
    public var description: String = UUID().uuidString
    
    public init(page: Int) {
        queryParameters = [
            URLQueryItem(name: "page", value: "\(page)")
        ]
    }
}
