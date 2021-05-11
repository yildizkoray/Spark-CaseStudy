//
//  ImagesPresenterTests.swift
//  CaseStudyTests
//
//  Created by Koray Yıldız on 11.05.2021.
//

import XCTest
@testable import CaseStudy

public final class ImagesPresenterTests: XCTestCase {
    private var mockView: MockImagesView!
    private var mockRouter: MockImagesRouter!
    private var presenter: ImagesPresenter!
    
    public override func setUp() {
        mockView = MockImagesView()
        mockRouter = MockImagesRouter()
        presenter = ImagesPresenter(view: mockView, router: mockRouter)
    }
    
    func test_viewDidLoad_InvokedRequiredViewMethods() {
        XCTAssertFalse(mockView.invokedSetTitle)
        XCTAssertNil(mockView.invokedSetTitleTitle)
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(mockView.invokedSetTitle)
        XCTAssertEqual(mockView.invokedSetTitleTitle, "Images")
    }
}


