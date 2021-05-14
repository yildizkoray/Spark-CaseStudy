//
//  UIAlertController+Additions.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 14.05.2021.
//

import UIKit

public extension UIAlertController {
    
    class func actionSheet(title: String? = .none, message: String? = .none) -> UIAlertController {
        return .init(title: title, message: message, preferredStyle: .actionSheet)
    }
    
    class func alert(title: String? = .none, message: String? = .none) -> UIAlertController {
        return .init(title: title, message: message, preferredStyle: .alert)
    }
    
    @discardableResult final func addActions(_ actions: UIAlertAction...) -> Self {
        actions.forEach { addAction($0) }
        return self
    }
    
    final func show(onto view: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        view.present(self, animated: animated, completion: completion)
    }
}
