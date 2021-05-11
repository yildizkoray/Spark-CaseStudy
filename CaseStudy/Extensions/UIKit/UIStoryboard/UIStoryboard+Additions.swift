//
//  UIStoryboard+Additions.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 11.05.2021.
//

import UIKit

// MARK: - UIStoryboard + Name

public extension UIStoryboard {
    
    enum Name: String {
        case main
        
        var description: String {
            return rawValue.capitalized
        }
    }
    
    func instantiateViewController<V: UIViewController>(with identifier: String) -> V {
        
        let view = instantiateViewController(identifier: identifier) as! V
        return view
    }
}

// MARK: - UIStoryboard + Load

public final class StoryboardLoader {
    
    static let shared = StoryboardLoader()
    
    private let bundle: Bundle
    private var cache: [String: UIStoryboard]
    
    public init(bundle: Bundle = .main) {
        
        self.bundle = bundle
        self.cache = .empty
        
        handleDidReceiveMemoryWarningNotification()
    }
    
    private func handleDidReceiveMemoryWarningNotification() {
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(removeAllCaches),
            name: UIApplication.didReceiveMemoryWarningNotification,
            object: nil
        )
    }
    
    @objc private func removeAllCaches() {
        
        cache.removeAll()
    }
    
    public func board(with name: UIStoryboard.Name) -> UIStoryboard {
        
        if let board = cache[name.description] {
            return board
        }
        else {
            let board = UIStoryboard(name: name.description, bundle: bundle)
            cache[name.description] = board
            return board
        }
    }
}

// MARK: - Dictionary + Storyboard

fileprivate extension Dictionary {
    
    static var empty: [String: UIStoryboard] {
        return [:]
    }
}
