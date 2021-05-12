//
//  API.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 11.05.2021.
//

import Foundation

public protocol API {
    
    associatedtype Executable
    associatedtype Operation
    
    func execute(task: Operation) throws -> Executable
}
