//
//  HTTPHeaders+Additions.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 11.05.2021.
//


import Alamofire

public extension Alamofire.HTTPHeaders {
    
    init(_ dictionary: [String: String]) {
        let headers = dictionary.map { (name, value) in
            Alamofire.HTTPHeader(name: name, value: value)
        }
        self.init(headers)
    }
}
