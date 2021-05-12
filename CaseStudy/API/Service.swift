//
//  Service.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 11.05.2021.
//

public protocol Service: AnyObject {
    
    associatedtype Backend: API
    
    init(backend: Backend)
    func execute<R: APIResponse>(task: Backend.Operation, type: R.Type, completion: @escaping NetworkCompletion<R>)
}
