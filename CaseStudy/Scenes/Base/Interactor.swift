//
//  Interactor.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 11.05.2021.
//

public class Interactor {
    
    public var service: RestService
    
    public init(_ service: RestService = RestService(backend: .factory(allowsRetry: true))) {
        self.service = service
    }
}
