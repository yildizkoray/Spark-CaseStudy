//
//  APIError.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 11.05.2021.
//

import Foundation

public struct APIError: Error, Decodable {
    
    public let code: Int
    public let description: String
    public let status: Int
    
    static let afError = APIError(code: .zero, description: "AFError", status: .zero)
}
