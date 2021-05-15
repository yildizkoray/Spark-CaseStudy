//
//  ImagesPage.swift
//  CaseStudyUITests
//
//  Created by Koray Yıldız on 15.05.2021.
//

import Foundation
import XCTest

final class ImagesPage: BasePage {
    lazy var navigationBars = app.navigationBars
    lazy var addButton = app.buttons[AppAccessibilityIdenfier.addButton.rawValue]
    lazy var cell = app.cells[AppAccessibilityIdenfier.imageCell.rawValue + "2"]
    
    @discardableResult
    func tapAddButton() -> ImagePage {
        addButton.tap()
        return ImagePage(with: app)
    }
    
    @discardableResult
    func tapCell() -> ImagePage {
        cell.tap()
        return ImagePage(with: app)
    }
    
    func checkNavigationTitleIsCorrect(title: String) {
        XCTAssertTrue(navigationBars[title].exists)
    }
}
