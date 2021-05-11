//
//  ViewController.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 11.05.2021.
//

import UIKit

public protocol ViewController {
    
    static var storyboardName: UIStoryboard.Name { get }
}

public extension ViewController where Self: UIViewController {
    
    private static func allocate<V: UIViewController>() -> V {
        guard let identifier = "\(self)".components(separatedBy: "ViewController").first
        else {
            preconditionFailure("Unable to initialize view controller with name: \(self)")
        }
        
        return StoryboardLoader.shared.board(with: storyboardName).instantiateViewController(with: identifier)
    }
    
    static func controller() -> Self {
        return allocate()
    }
}
