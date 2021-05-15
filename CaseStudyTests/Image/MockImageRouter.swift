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
    var shouldInvokePopCompletion = false

    public func pop(animated: Bool, completion: @escaping () -> Void) {
        invokedPop = true
        invokedPopCount += 1
        invokedPopParameters = (animated, ())
        invokedPopParametersList.append((animated, ()))
        if shouldInvokePopCompletion {
            completion()
        }
    }

    var invokedStart = false
    var invokedStartCount = 0
    var invokedStartParameters: (id: String?, delegate: ImagePresenterDelegate)?
    var invokedStartParametersList = [(id: String?, delegate: ImagePresenterDelegate)]()

    public func start(with id: String?, delegate: ImagePresenterDelegate) {
        invokedStart = true
        invokedStartCount += 1
        invokedStartParameters = (id, delegate)
        invokedStartParametersList.append((id, delegate))
    }
}
