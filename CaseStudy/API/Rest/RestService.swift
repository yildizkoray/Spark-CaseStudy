//
//  RestService.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 11.05.2021.
//

import Alamofire

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
        
        let operation = try! backend.execute(task: task)
        self.operations[task.description] = operation
        
        operation.responseDecodable(of: R.self) { response in
            switch response.result {
            case .success(let apiResponse):
                if let error = apiResponse.error {
                    completion(.failure(error))
                }
                else {
                    completion(.success(response.value!))
                }
            case .failure:
                completion(.failure(.afError))
            }
        }
    }
    
    public func cancelAll() {
        operations.cancelAll()
    }
    
    deinit { cancelAll() }
}
