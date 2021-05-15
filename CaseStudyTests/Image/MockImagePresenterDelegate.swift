//
//  MockImagePresenterDelegate.swift
//  CaseStudyTests
//
//  Created by Koray Yıldız on 15.05.2021.
//

import CaseStudy

public final class MockImagePresenterDelegate: ImagePresenterDelegate {

    var invokedDidSaveImage = false
    var invokedDidSaveImageCount = 0
    var invokedDidSaveImageParameters: (image: Image, Void)?
    var invokedDidSaveImageParametersList = [(image: Image, Void)]()

    public func didSaveImage(image: Image) {
        invokedDidSaveImage = true
        invokedDidSaveImageCount += 1
        invokedDidSaveImageParameters = (image, ())
        invokedDidSaveImageParametersList.append((image, ()))
    }

    var invokedDidUpdateImage = false
    var invokedDidUpdateImageCount = 0
    var invokedDidUpdateImageParameters: (image: Image, Void)?
    var invokedDidUpdateImageParametersList = [(image: Image, Void)]()

    public func didUpdateImage(image: Image) {
        invokedDidUpdateImage = true
        invokedDidUpdateImageCount += 1
        invokedDidUpdateImageParameters = (image, ())
        invokedDidUpdateImageParametersList.append((image, ()))
    }
}
