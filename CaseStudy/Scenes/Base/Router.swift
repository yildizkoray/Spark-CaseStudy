//
//  Router.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 11.05.2021.
//

import UIKit

public protocol Router {
    
    associatedtype Controller: ViewController
    func createViewController() -> Controller
}

public extension Router where Controller: UIViewController {
    
    func createViewController() -> Controller {
        return Controller.controller()
    }
}
