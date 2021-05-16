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
    public let status: Int?
    
    enum CodingKeys: String, CodingKey {
        case code
        case description = "message"
        case status
    }
    
    static let afError = APIError(code: .zero, description: "AFError", status: .zero)
    static let noData = APIError(code: .zero, description: "No Data Errror", status: .zero)
    static let decodingError = APIError(code: .zero, description: "Decoding Error", status: .zero)
    static let operationCreateError = APIError(code: .zero, description: "Operation Create Error", status: .zero)
}
