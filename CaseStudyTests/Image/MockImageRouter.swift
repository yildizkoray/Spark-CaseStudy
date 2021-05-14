//
//  MockImageRouter.swift
//  CaseStudyTests
//
//  Created by Koray Yıldız on 14.05.2021.
//

import UIKit
import CaseStudy

public final class MockImageRouter: ImageRouterProtocol {
    
    var invokedPop = false
    var invokedPopCount = 0
    var invokedPopParameters: (animated: Bool, Void)?
    var invokedPopParametersList = [(animated: Bool, Void)]()
    
    public func pop(animated: Bool) {
        invokedPop = true
        invokedPopCount += 1
        invokedPopParameters = (animated, ())
        invokedPopParametersList.append((animated, ()))
    }
    
    var invokedStart = false
    var invokedStartCount = 0
    var invokedStartParameters: (id: String?, Void)?
    var invokedStartParametersList = [(id: String?, Void)]()
    
    public func start(with id: String?) {
        invokedStart = true
        invokedStartCount += 1
        invokedStartParameters = (id, ())
        invokedStartParametersList.append((id, ()))
    }
}
