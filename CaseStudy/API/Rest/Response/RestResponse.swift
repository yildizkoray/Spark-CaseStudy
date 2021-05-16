//
//  RestResponse.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 11.05.2021.
//

import Foundation

public protocol RestResponse: APIResponse {
    
    associatedtype Data
    var data: Data { get }
    var meta: RestMetaResponse? { get }
}

public extension RestResponse {
    var hasNextPage: Bool {
        return meta?.nextPage ?? false
    }
}
