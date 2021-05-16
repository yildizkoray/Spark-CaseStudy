//
//  RestService.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 11.05.2021.
//

import Alamofire
import Foundation

public class RestService: Service {
    
    public typealias Backend = RestAPI
    
    public var cancelsPreviousOperations: Bool
    
    private(set) public var backend: RestAPI
    private var operations: [String: DataRequest]
    
    required public init(backend: RestAPI) {
        self.backend = backend
        self.operations = [String: DataRequest]()
        self.cancelsPreviousOperations = true
    }
    
    public func execute<R>(task: HTTPTask, type: R.Type, completion: @escaping NetworkCompletion<R>) where R: APIResponse {
        if self.cancelsPreviousOperations {
            self.operations[task.description]?.cancel()
        }
        
        do {
            let operation = try backend.execute(task: task)
            self.operations[task.description] = operation
            
            operation.response { response in
                switch response.result {
                case .success(let data):
                    guard let data = data else {
                        completion(.failure(.noData))
                        return
                    }
                    do {
                        try JSONDecoder().decode(RestErrorResponse.self, from: data).throwErrorIfFailure()
                        let decodedObject = try JSONDecoder().decode(R.self, from: data)
                        completion(.success(decodedObject))
                    } catch let error {
                        if let apiError = error as? APIError {
                            completion(.failure(apiError))
                        } else {
                            completion(.failure(.decodingError))
                        }
                    }
                case .failure:
                    completion(.failure(.afError))
                    break
                }
            }
        } catch {
            completion(.failure(.operationCreateError))
        }
    }
    
    public func cancelAll() {
        operations.cancelAll()
    }
    
    deinit { cancelAll() }
}
