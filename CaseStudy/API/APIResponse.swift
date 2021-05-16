//
//  APIResponse.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 11.05.2021.
//

public protocol APIResponse: Decodable {
    
    var error: APIError? { get }
    var isFailure: Bool { get }
    var isSuccess: Bool { get }
}

public extension APIResponse {
    
    func throwErrorIfFailure() throws {
        if isFailure {
            throw error!
        }
    }
    
    var isFailure: Bool {
        return !isSuccess
    }
    
    var isSuccess: Bool {
        return error == nil
    }
}
