//
//  BasePage.swift
//  CaseStudyUITests
//
//  Created by Koray Yıldız on 15.05.2021.
//

import Foundation
import XCTest

class BasePage {
    var app: XCUIApplication!
    
    required init(with app: XCUIApplication = XCUIApplication()) {
        self.app = app
    }
}
