//
//  MockDataProvider.swift
//  CaseStudyTests
//
//  Created by Koray Yıldız on 14.05.2021.
//

@testable import CaseStudy
import Foundation

public final class MockDataProvider: RestService {
    var fileName: String = "Images"
    var isError = false
    
    public override func execute<R>(task: HTTPTask, type: R.Type, completion: @escaping NetworkCompletion<R>) where R : APIResponse {
        let result = decodeJSON(type: R.self, fileName: fileName)
        if isError {
            completion(.failure(.afError))
        } else {
            completion(.success(result))
        }
        
    }
    
    public func decodeJSON<T: Decodable>(type: T.Type, fileName: String) -> T {
        let bundle = Bundle(for: MockDataProvider.self)
        let path = bundle.path(forResource: fileName, ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        let decoder = JSONDecoder()
        let result = try! decoder.decode(T.self, from: data)
        return result
    }
}
