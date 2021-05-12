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

public extension RestResponse {
    
    var isFailure: Bool {
        return !isSuccess
    }
    
    var isSuccess: Bool {
        return error == nil
    }
}
