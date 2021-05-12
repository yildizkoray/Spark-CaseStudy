//
//  RestObjectResponse.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 11.05.2021.
//

public struct RestObjectResponse<T: Decodable>: RestResponse {
    
    public typealias Data = T
    
    public var data: Data
    public var error: APIError?
    public var meta: RestMetaResponse?
}
