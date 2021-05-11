//
//  Presenter.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 11.05.2021.
//

import Foundation

public protocol Presenter {
    
    func viewDidLoad()
    func viewWillAppear()
}

public extension Presenter {
    
    func viewDidLoad() { }
    func viewWillAppear() { }
}
