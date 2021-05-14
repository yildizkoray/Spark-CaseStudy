//
//  ImageCellPresenterTests.swift
//  CaseStudyTests
//
//  Created by Koray Yıldız on 14.05.2021.
//

import XCTest
@testable import CaseStudy

public final class ImageCellPresenterTests: XCTestCase {
    private var mockView: MockImageCell!
    private var presenter: ImageCellPresenter!
    private var mockDataProvider: MockDataProvider!
    
    private var imagePresentation: ImagePresentation {
        let images = mockDataProvider.decodeJSON(type: RestArrayResponse<Image>.self, fileName: "Images")
        let randomImage = images.data.first!
        return ImagePresentation(image: randomImage)
    }
    
    public override func setUp() {
        mockDataProvider = MockDataProvider(backend: .factory())
        mockView = MockImageCell()
        presenter = ImageCellPresenter(view: mockView, imagePresentation: imagePresentation)
    }
    
    public override func tearDownWithError() throws {
        mockView = nil
        presenter = nil
    }
    
    func test_load_InvokedRequiredViewMethods() {
        XCTAssertFalse(mockView.invokedPrepareUI)
        XCTAssertFalse(mockView.invokedConfigure)
        XCTAssertNil(mockView.invokedConfigureParameters)
        
        presenter.load()
        
        XCTAssertTrue(mockView.invokedPrepareUI)
        XCTAssertTrue(mockView.invokedConfigure)
        XCTAssertNotNil(mockView.invokedConfigureParameters)
        XCTAssertEqual(mockView.invokedConfigureParameters?.presentation, imagePresentation)
    }
}

