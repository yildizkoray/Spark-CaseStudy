//
//  HTTPTask.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 11.05.2021.
//

import Alamofire
import Foundation

private struct Constants {
    struct URLComponents {
        struct Default {
            static let port = 8081
            static let host = "54.78.219.186"
            static let scheme = "http"
        }
    }
}

public protocol HTTPTask: CustomStringConvertible {
    
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    
    var body: Parameters? { get }
    
    var path: String { get }
    var queryParameters: [URLQueryItem] { get }
    
    var encoding: ParameterEncoding { get }
}

public extension HTTPTask {
    
    var encoding: ParameterEncoding {
        switch method {
        case .post, .put:
            return JSONEncoding.default
        default:
            return URLEncoding.default
        }
    }
    
    var headers: [String: String] {
        return .emptyStringDic
    }
    
    var queryParameters: [URLQueryItem] {
        return .empty()
    }
    
    var body: Parameters? {
        return nil
    }
    
    func asURL() throws -> URL {
        var urlComponents = URLComponents()
        urlComponents.host = .HOST
        urlComponents.scheme = .SCHEME
        urlComponents.path = "/api/koray/\(path)"
        urlComponents.queryItems = queryParameters
        urlComponents.port = 8081
        return try urlComponents.asURL()
    }
}

// MARK: - API
public extension String {
    static let HOST = ConfigReader.shared["API_HOST", default: Constants.URLComponents.Default.host]
    static let SCHEME = ConfigReader.shared["API_SCHEME", default: Constants.URLComponents.Default.scheme]
    static let PORT = ConfigReader.shared["API_PORT", default: Constants.URLComponents.Default.port]
}
