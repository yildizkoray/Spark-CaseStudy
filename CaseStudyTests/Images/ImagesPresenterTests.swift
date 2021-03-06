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
        XCTAssertEqual(mockView.invokedSetTableViewVisibilityParameters?.isHidden, false)
    }
    
    func test_viewDidLoad_InvokedRequiredInteractorMethods() {
        XCTAssertFalse(mockInteractor.invokedImages)
        XCTAssertEqual(mockInteractor.invokedImagesCount, .zero)
        XCTAssertNil(mockInteractor.invokedImagesParameters)

        presenter.viewDidLoad()

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
        presenter.viewDidLoad()
        presenter.didSelect(at: indexPath)
        
        
        XCTAssertTrue(mockRouter.invokedNavigateToImageViewController)
        XCTAssertEqual(mockRouter.invokedNavigateToImageViewControllerCount, 1)
        XCTAssertNotNil(mockRouter.invokedNavigateToImageViewControllerParameters)
        XCTAssertEqual(mockRouter.invokedNavigateToImageViewControllerParameters?.id, "609e45049795bea6f0c4d129")
    }
    
    func test_delete_InvokedRequiredInteractorMethods() {
        XCTAssertFalse(mockInteractor.invokedDelete)
        XCTAssertEqual(mockInteractor.invokedDeleteCount, .zero)
        XCTAssertNil(mockInteractor.invokedDeleteParameters)


        let indexPath = IndexPath(row: .zero, section: .zero)
        presenter.viewDidLoad()
        mockDataProvider.fileName = "DeletedImage"
        presenter.delete(at: indexPath)



        XCTAssertTrue(mockInteractor.invokedDelete)
        XCTAssertEqual(mockInteractor.invokedDeleteCount, 1)
        XCTAssertNotNil(mockInteractor.invokedDeleteParameters)
        XCTAssertEqual(mockInteractor.invokedDeleteParameters?.id, "609e45049795bea6f0c4d129")
    }
    
    func test_numberOfItems_ShouldBeCorrectValue() {
        presenter.viewDidLoad()
        
        XCTAssertEqual(presenter.numberOfItems, 5, "Mock json has 5 items, but number of items setted different value")
    }
    
    func test_image_ShouldeSelectCorrectItem() {
        let indexPath = IndexPath(row: .zero, section: .zero)
        
        presenter.viewDidLoad()
        
        XCTAssertEqual(presenter.image(at: indexPath), presenter.presentation.images.first)
    }
    
    func test_page_PageNumberIncrease_WhenRequestSucces() {
        XCTAssertEqual(presenter.page, .zero)
        
        presenter.viewDidLoad()
        
        XCTAssertEqual(presenter.page, 1)
    }
    
    func test_page_PageNumberNotIncreased_WhenRequestFailure() {
        XCTAssertEqual(presenter.page, .zero)
        
        mockDataProvider.isError = true
        presenter.viewDidLoad()
        
        XCTAssertEqual(presenter.page, .zero)
    }
    
    func test_page_PageNumberNotIncreasedWhenHasNextPageFalse() {
        XCTAssertEqual(presenter.page, .zero)
        
        mockDataProvider.fileName = "Images_HasNextPage_False"
        presenter.viewDidLoad()
        
        XCTAssertEqual(presenter.page, .zero, "has next page false but page increased")
    }
    
    func test_didSaveImage_InvokedRequiredViewMethods() {
        XCTAssertFalse(mockView.invokedInsertRow)
        XCTAssertNil(mockView.invokedInsertRowParameters)
        
        let images = mockDataProvider.decodeJSON(type: RestArrayResponse<Image>.self, fileName: "Images")
        let savedImage = images.data.randomElement()!
        let indexPath = IndexPath(row: .zero, section: .zero)
        
        presenter.didSaveImage(image: savedImage)
        
        XCTAssertTrue(mockView.invokedInsertRow)
        XCTAssertNotNil(mockView.invokedInsertRowParameters)
        XCTAssertEqual(mockView.invokedInsertRowParameters?.indexPath, indexPath)
    }
    
    func test_didUpdateImage_InvokedRequiredViewMethods() {
        XCTAssertFalse(mockView.invokedInsertRow)
        XCTAssertNil(mockView.invokedInsertRowParameters)
        
        let images = mockDataProvider.decodeJSON(type: RestArrayResponse<Image>.self, fileName: "Images")
        let updatedImage = images.data.randomElement()!
        let indexOfUpdatedImage = images.data.firstIndex { $0.id == updatedImage.id }!
        let indexPath = IndexPath(row: indexOfUpdatedImage, section: .zero)
        
        presenter.viewDidLoad() // or presenter.handleImages(.success(images))
        presenter.didUpdateImage(image: updatedImage)
        
        XCTAssertTrue(mockView.invokedReloadRows)
        XCTAssertNotNil(mockView.invokedReloadRowsParameters)
        XCTAssertEqual(mockView.invokedReloadRowsParameters?.indexPath, indexPath)
    }
}
