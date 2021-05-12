//
//  RestAPI.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 11.05.2021.
//

import Alamofire

public typealias NetworkCompletion<T> = (Result<T, APIError>) -> Void where T: Decodable
public typealias NetworkResult<T> = Result<T, APIError>

public final class RestAPI: API {
    
    public typealias Executable = DataRequest
    public typealias Operation = HTTPTask
    
    private var connector: Session
    
    public lazy var acceptableStatusCodes: [Int] = {
        var acceptableStatusCodes = [Int]()
        acceptableStatusCodes.append(contentsOf: 200...299)
        acceptableStatusCodes.append(contentsOf: 400...499)
        return acceptableStatusCodes
    }()
    
    public init(interceptor: RestAPIMiddleware) {
        self.connector = Session(httpAdditionalHeaders: HTTPHeaders(), interceptor: interceptor)
    }
    
    public class func factory(allowsRetry: Bool = true) -> RestAPI {
        return .init(interceptor: .shared(allowsRetry: allowsRetry))
    }
    
    public func execute(task operation: HTTPTask) throws -> DataRequest {
        return try connector.request(
            operation.asURL(),
            method: operation.method,
            parameters: operation.body,
            encoding: operation.encoding,
            headers: HTTPHeaders(operation.headers)).validate(statusCode: acceptableStatusCodes)
    }
}

public extension RestAPIMiddleware {
    
    private static let retryable = RestAPIMiddleware(allowsRetry: true)
    private static let unretryable = RestAPIMiddleware(allowsRetry: false)
    
    static func shared(allowsRetry: Bool) -> RestAPIMiddleware {
        return allowsRetry ? .retryable : .unretryable
    }
}
