//
//  MockImagesRouter.swift
//  CaseStudyTests
//
//  Created by Koray Yıldız on 11.05.2021.
//

import UIKit
import CaseStudy

public final class MockImagesRouter: ImagesRouterProtocol {

    var invokedStart = false
    var invokedStartCount = 0
    var stubbedStartResult: UINavigationController!

    public func start() -> UINavigationController {
        invokedStart = true
        invokedStartCount += 1
        return stubbedStartResult
    }

    var invokedNavigateToImageViewController = false
    var invokedNavigateToImageViewControllerCount = 0
    var invokedNavigateToImageViewControllerParameters: (id: String?, delegate: ImagePresenterDelegate)?
    var invokedNavigateToImageViewControllerParametersList = [(id: String?, delegate: ImagePresenterDelegate)]()

    public func navigateToImageViewController(with id: String?, delegate: ImagePresenterDelegate) {
        invokedNavigateToImageViewController = true
        invokedNavigateToImageViewControllerCount += 1
        invokedNavigateToImageViewControllerParameters = (id, delegate)
        invokedNavigateToImageViewControllerParametersList.append((id, delegate))
    }
}
