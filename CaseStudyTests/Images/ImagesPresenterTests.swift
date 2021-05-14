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
    private var mockInteractor: MockImagesInteractor!
    private var presenter: ImagesPresenter!
    private var mockDataProvider: MockDataProvider!
    
    public override func setUp() {
        mockDataProvider = MockDataProvider(backend: .factory())
        mockView = MockImagesView()
        mockRouter = MockImagesRouter()
        mockInteractor = MockImagesInteractor(mockDataProvider)
        presenter = ImagesPresenter(view: mockView, router: mockRouter, interactor: mockInteractor)
        mockInteractor.output = presenter
    }
    
    public override func tearDownWithError() throws {
        mockDataProvider = nil
        mockView = nil
        mockRouter = nil
        mockInteractor = nil
        presenter = nil
    }
    
    func test_viewDidLoad_InvokedRequiredViewMethods() {
        XCTAssertFalse(mockView.invokedPrepareTableView)
        XCTAssertFalse(mockView.invokedPrepareAddBarButton)
        
        XCTAssertFalse(mockView.invokedSetTitle)
        XCTAssertNil(mockView.invokedSetTitleParameters)
        XCTAssertFalse(mockView.invokedSetTableViewVisibility)
        XCTAssertNil(mockView.invokedSetTableViewVisibilityParameters)
        
        presenter.viewDidLoad()
        
        
        XCTAssertTrue(mockView.invokedPrepareTableView)
        XCTAssertTrue(mockView.invokedPrepareAddBarButton)
        
        XCTAssertTrue(mockView.invokedSetTitle)
        XCTAssertNotNil(mockView.invokedSetTitleParameters)
        XCTAssertEqual(mockView.invokedSetTitleParameters?.title, "Images")
        
        XCTAssertTrue(mockView.invokedSetTableViewVisibility)
        XCTAssertNotNil(mockView.invokedSetTableViewVisibilityParameters)
        XCTAssertEqual(mockView.invokedSetTableViewVisibilityParameters?.isHidden, true)
    }
    
    func test_viewWillAppear_InvokedRequiredInteractorMethods() {
        XCTAssertFalse(mockInteractor.invokedImages)
        XCTAssertEqual(mockInteractor.invokedImagesCount, .zero)
        XCTAssertNil(mockInteractor.invokedImagesParameters)
        
        presenter.viewWillAppear()
        
        XCTAssertTrue(mockInteractor.invokedImages)
        XCTAssertEqual(mockInteractor.invokedImagesCount, 1)
        XCTAssertNotNil(mockInteractor.invokedImagesParameters)
        XCTAssertEqual(mockInteractor.invokedImagesParameters?.page, .zero)
    }
    
    func test_addBarButtonDidTap_InvokedRequiredRouterMethods() {
        XCTAssertFalse(mockRouter.invokedNavigateToImageViewController)
        XCTAssertEqual(mockRouter.invokedNavigateToImageViewControllerCount, .zero)
        XCTAssertNil(mockRouter.invokedNavigateToImageViewControllerParameters)
        
        presenter.addBarButtonDidTap()
        
        
        XCTAssertTrue(mockRouter.invokedNavigateToImageViewController)
        XCTAssertEqual(mockRouter.invokedNavigateToImageViewControllerCount, 1)
        XCTAssertNil(mockRouter.invokedNavigateToImageViewControllerParameters?.id)
    }
    
    func test_refresh_InvokedRequiredInteractorMethods() {
        XCTAssertFalse(mockInteractor.invokedImages)
        XCTAssertEqual(mockInteractor.invokedImagesCount, .zero)
        XCTAssertNil(mockInteractor.invokedImagesParameters)
        
        presenter.refresh()
        
        XCTAssertTrue(mockInteractor.invokedImages)
        XCTAssertEqual(mockInteractor.invokedImagesCount, 1)
        XCTAssertNotNil(mockInteractor.invokedImagesParameters)
        XCTAssertEqual(mockInteractor.invokedImagesParameters?.page, .zero)
    }
    
    func test_next_InvokedRequiredInteractorMethods() {
        XCTAssertFalse(mockInteractor.invokedNext)
        XCTAssertEqual(mockInteractor.invokedNextCount, .zero)
        XCTAssertNil(mockInteractor.invokedNextParameters)
        
        presenter.page = 37
        presenter.next()
        
        XCTAssertTrue(mockInteractor.invokedNext)
        XCTAssertEqual(mockInteractor.invokedNextCount, 1)
        XCTAssertNotNil(mockInteractor.invokedNextParameters)
        XCTAssertEqual(mockInteractor.invokedNextParameters?.page, 37)
    }
    
    func test_didSelect_InvokedRequiredRouterMethods() {
        XCTAssertFalse(mockRouter.invokedNavigateToImageViewController)
        XCTAssertEqual(mockRouter.invokedNavigateToImageViewControllerCount, .zero)
        XCTAssertNil(mockRouter.invokedNavigateToImageViewControllerParameters)
        
        
        let indexPath = IndexPath(row: .zero, section: .zero)
        presenter.viewWillAppear()
        presenter.didSelect(at: indexPath)
        
        
        XCTAssertTrue(mockRouter.invokedNavigateToImageViewController)
        XCTAssertEqual(mockRouter.invokedNavigateToImageViewControllerCount, 1)
        XCTAssertNotNil(mockRouter.invokedNavigateToImageViewControllerParameters)
        XCTAssertEqual(mockRouter.invokedNavigateToImageViewControllerParameters?.id, "609e5daf01b14809885040df")
    }
    
    func test_delete_InvokedRequiredRouterMethods() {
        XCTAssertFalse(mockInteractor.invokedDelete)
        XCTAssertEqual(mockInteractor.invokedDeleteCount, .zero)
        XCTAssertNil(mockInteractor.invokedDeleteParameters)


        let indexPath = IndexPath(row: .zero, section: .zero)
        presenter.viewWillAppear()
        mockDataProvider.fileName = "DeletedImage"
        presenter.delete(at: indexPath)



        XCTAssertTrue(mockInteractor.invokedDelete)
        XCTAssertEqual(mockInteractor.invokedDeleteCount, 1)
        XCTAssertNotNil(mockInteractor.invokedDeleteParameters)
        XCTAssertEqual(mockInteractor.invokedDeleteParameters?.id, "609e5daf01b14809885040df")
    }
    
    func test_numberOfItems_InvokedRequiredRouterMethods() {
        presenter.viewWillAppear()
        
        XCTAssertEqual(presenter.numberOfItems, 5)
    }
    
    func test_image_InvokedRequiredRouterMethods() {
        let indexPath = IndexPath(row: .zero, section: .zero)
        
        presenter.viewWillAppear()
        
        XCTAssertEqual(presenter.image(at: indexPath), presenter.presentation.images.first)
    }
    
    func test_page_PageNumberIncreasedWhenRequestSucces() {
        XCTAssertEqual(presenter.page, .zero)
        
        presenter.viewWillAppear()
        
        XCTAssertEqual(presenter.page, 1)
    }
    
    func test_page_PageNumberNotIncreasedWhenRequestFailure() {
        XCTAssertEqual(presenter.page, .zero)
        
        mockDataProvider.isError = true
        presenter.viewWillAppear()
        
        XCTAssertEqual(presenter.page, .zero)
    }
    
    func test_page_PageNumberNotIncreasedWhenHasNextPageFalse() {
        XCTAssertEqual(presenter.page, .zero)
        
        mockDataProvider.fileName = "Images_HasNextPage_False"
        presenter.viewWillAppear()
        
        XCTAssertEqual(presenter.page, .zero, "has next page false but page increased")
    }
}
