//
//  ImageTests.swift
//  CaseStudyUITests
//
//  Created by Koray Yıldız on 15.05.2021.
//

import XCTest

public final class ImageTest: BaseTest {
    
    func testRightButtonTextMustBeUpdateWhenCellTapped() {
        imagesPage
            .tapCell()
            .checkUpdateButtonText(text: "Update")
    }
    
    func testRightButtonTextMustBeSaveWhenAddButtonTapped() {
        imagesPage
            .tapAddButton()
            .checkSaveButtonText(text: "Save")
    }
}
