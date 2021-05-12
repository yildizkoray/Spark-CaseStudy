//
//  Bundle+Additions.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 11.05.2021.
//

import Foundation

public extension Bundle {
    
    func infoDictionaryValue<T>(for key: String) -> T {
        return object(forInfoDictionaryKey: key) as! T
    }
}
