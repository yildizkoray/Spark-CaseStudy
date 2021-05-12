//
//  Alamofire.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 11.05.2021.
//

import Alamofire
import Foundation

public extension Alamofire.Session {
    
    convenience init(httpAdditionalHeaders: HTTPHeaders, interceptor: RequestInterceptor?) {
        
        var defaultHTTPHeaders = HTTPHeaders.default
        httpAdditionalHeaders.forEach { defaultHTTPHeaders.update($0) }
        
        defaultHTTPHeaders["Accept"] = "application/json"
        
        let configuration = URLSessionConfiguration.af.default
        
        configuration.headers = defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 45
        configuration.timeoutIntervalForResource = 90
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.urlCache = nil
        
        self.init(configuration: configuration, interceptor: interceptor)
    }
}
