//
//  BaseTests.swift
//  CaseStudyUITests
//
//  Created by Koray Yıldız on 15.05.2021.
//

import XCTest

public class BaseTest: XCTestCase {
    
    var app: XCUIApplication!
    var basePage: BasePage!
    
    lazy var imagesPage: ImagesPage = {
        return ImagesPage(with: app)
    }()
    
    public override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        basePage = BasePage(with: app)
        
        app.setUpAndLaunch()
    }
    
    public override func tearDownWithError() throws {
        
    }
}

extension XCUIApplication {
    func setUpAndLaunch() {
        launchEnvironment = ["DISABLE_ANIMATIONS": "1"]
        launchArguments += ["UI-Testing"]
        launch()
    }
}
