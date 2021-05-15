//
//  ImagePage.swift
//  CaseStudyUITests
//
//  Created by Koray Yıldız on 15.05.2021.
//

import XCTest

final class ImagePage: BasePage {
    
    lazy var navbarUpdateButton = app.navigationBars.buttons[AppAccessibilityIdenfier.imagePageNavbarUpdateButton.rawValue]
    lazy var navbarSaveButton = app.navigationBars.buttons[AppAccessibilityIdenfier.imagePageNavbarSaveButton.rawValue]
    
    func checkSaveButtonText(text: String) {
        XCTAssertEqual(text, navbarSaveButton.label)
    }
    
    func checkUpdateButtonText(text: String) {
        XCTAssertEqual(text, navbarUpdateButton.label)
    }
}
