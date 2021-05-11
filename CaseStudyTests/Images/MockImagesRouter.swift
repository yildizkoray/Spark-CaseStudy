//
//  MockImagesRouter.swift
//  CaseStudyTests
//
//  Created by Koray Yıldız on 11.05.2021.
//

import UIKit
import CaseStudy

public final class MockImagesRouter: ImagesRouterProtocol {
    
    public func start() -> UINavigationController {
        return .init()
    }
}
