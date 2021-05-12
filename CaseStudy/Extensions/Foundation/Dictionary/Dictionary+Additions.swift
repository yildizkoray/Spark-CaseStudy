//
//  Dictionary+Additiobs.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 11.05.2021.
//


import Alamofire
import Foundation

public extension Dictionary {
    
    static var emptyStringDic: [String: String] {
        return [:]
    }
}

public extension Dictionary where Value == DataRequest {
    
    mutating func cancelAll() {
        values.forEach { $0.cancel() }
        removeAll(keepingCapacity: false)
    }
}
