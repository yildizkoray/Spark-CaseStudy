//
//  RestArrayResponse.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 11.05.2021.
//

import Foundation

public struct RestArrayResponse<T: Decodable>: RestResponse {
    
    public typealias Data = [T]
    
    public var data: Data
    public var error: APIError?
    public var meta: RestMetaResponse?
}

public struct RestErrorResponse: APIResponse {
    public var error: APIError?
}
