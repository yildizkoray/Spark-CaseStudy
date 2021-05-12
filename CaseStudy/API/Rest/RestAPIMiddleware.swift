//
//  RestAPIMiddleware.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 11.05.2021.
//

import Alamofire
import Foundation

public final class RestAPIMiddleware: RequestInterceptor {
    
    public var allowsRetry: Bool
    
    public var timeZone: TimeZone = .autoupdatingCurrent
    public var locale: Locale = .autoupdatingCurrent
    
    public init(allowsRetry: Bool) {
        self.allowsRetry = allowsRetry
    }
    
    public func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Swift.Result<URLRequest, Error>) -> Void)
    {
        var urlRequest = urlRequest
        urlRequest.setValue("IOS", forHTTPHeaderField: "Client-Type")
        
        if let timeZone = timeZone.localizedName(for: .standard, locale: locale) {
            urlRequest.setValue(timeZone, forHTTPHeaderField: "Time-Zone")
        }
        
        completion(.success(urlRequest))
    }
}
