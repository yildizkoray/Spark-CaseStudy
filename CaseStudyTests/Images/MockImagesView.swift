//
//  MockImagesView.swift
//  CaseStudyTests
//
//  Created by Koray Yıldız on 11.05.2021.
//

import CaseStudy

public final class MockImagesView: ImagesViewProtocol {
    
    var invokedSetTitle = false
    var invokedSetTitleTitle: String? = nil
    public func setTitle(with title: String) {
        invokedSetTitle = true
        invokedSetTitleTitle = title
    }
}
