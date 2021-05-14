//
//  MockImageCell.swift
//  CaseStudyTests
//
//  Created by Koray Yıldız on 14.05.2021.
//

import CaseStudy

public final class MockImageCell: ImageCellProtocol {

    var invokedPrepareUI = false
    var invokedPrepareUICount = 0

    public func prepareUI() {
        invokedPrepareUI = true
        invokedPrepareUICount += 1
    }

    var invokedConfigure = false
    var invokedConfigureCount = 0
    var invokedConfigureParameters: (presentation: ImagePresentation, Void)?
    var invokedConfigureParametersList = [(presentation: ImagePresentation, Void)]()

    public func configure(with presentation: ImagePresentation) {
        invokedConfigure = true
        invokedConfigureCount += 1
        invokedConfigureParameters = (presentation, ())
        invokedConfigureParametersList.append((presentation, ()))
    }
}
