//
//  MockImageRouter.swift
//  CaseStudyTests
//
//  Created by Koray Yıldız on 14.05.2021.
//

import XCTest
@testable import CaseStudy

public final class ImagePresenterTests: XCTestCase {
    private var mockView: MockImageView!
    private var mockRouter: MockImageRouter!
    private var mockInteractor: MockImageInteractor!
    private var presenter: ImagePresenter!
    private var mockDataProvider: MockDataProvider!
    
    public override func setUp() {
        reCreate()
    }
    
    func reCreate(id: String? = nil) {
        mockDataProvider = MockDataProvider(backend: .factory())
        mockView = MockImageView()
        mockRouter = MockImageRouter()
        mockInteractor = MockImageInteractor(mockDataProvider)
        presenter = ImagePresenter(view: mockView,
                                   interactor: mockInteractor,
                                   router: mockRouter,
                                   id: id)
        mockInteractor.output = presenter
    }
    
    public override func tearDownWithError() throws {
        mockDataProvider = nil
        mockView = nil
        mockRouter = nil
        mockInteractor = nil
        presenter = nil
    }
    
    func test_viewDidLoad_ID_Null_InvokedRequiredMethods() {
        XCTAssertFalse(mockView.invokedPrepareImagePicker)
        XCTAssertFalse(mockView.invokedPrepareUI)
        XCTAssertFalse(mockView.invokedPrepareSaveBarButton)
        XCTAssertFalse(mockView.invokedSetChooseButtonVisibility)
        XCTAssertNil(mockView.invokedSetChooseButtonVisibilityParameters)
        XCTAssertFalse(mockView.invokedPrepareUpdateBarButton)
        XCTAssertFalse(mockInteractor.invokedImage)
        
        presenter.viewDidLoad()
        
        
        XCTAssertTrue(mockView.invokedPrepareImagePicker)
        XCTAssertTrue(mockView.invokedPrepareUI)
        XCTAssertTrue(mockView.invokedPrepareSaveBarButton)
        XCTAssertTrue(mockView.invokedSetChooseButtonVisibility)
        XCTAssertNotNil(mockView.invokedSetChooseButtonVisibilityParameters)
        XCTAssertFalse(mockView.invokedSetChooseButtonVisibilityParameters!.isHidden)
        XCTAssertFalse(mockView.invokedPrepareUpdateBarButton)
        XCTAssertFalse(mockInteractor.invokedImage)
    }
    
    func test_viewDidLoad_ID_NotNull_InvokedRequiredMethods() {
        XCTAssertFalse(mockView.invokedPrepareImagePicker)
        XCTAssertFalse(mockView.invokedPrepareUI)
        XCTAssertFalse(mockView.invokedPrepareSaveBarButton)
        XCTAssertFalse(mockView.invokedSetChooseButtonVisibility)
        XCTAssertNil(mockView.invokedSetChooseButtonVisibilityParameters)
        XCTAssertFalse(mockView.invokedPrepareUpdateBarButton)
        XCTAssertFalse(mockInteractor.invokedImage)
        XCTAssertEqual(mockInteractor.invokedImageCount, .zero)
        
        reCreate(id: "609e5daf01b14809885040df")
        presenter.viewDidLoad()
        
        XCTAssertTrue(mockView.invokedPrepareImagePicker)
        XCTAssertTrue(mockView.invokedPrepareUI)
        XCTAssertFalse(mockView.invokedPrepareSaveBarButton)
        XCTAssertTrue(mockView.invokedSetChooseButtonVisibility)
        XCTAssertNotNil(mockView.invokedSetChooseButtonVisibilityParameters)
        XCTAssertTrue(mockView.invokedSetChooseButtonVisibilityParameters!.isHidden)
        XCTAssertTrue(mockView.invokedPrepareUpdateBarButton)
        XCTAssertTrue(mockInteractor.invokedImage)
        XCTAssertEqual(mockInteractor.invokedImageCount, 1)
    }
    
    func test_update_ID_Null_InvokedRequiredInteractorMethods() {
        XCTAssertFalse(mockInteractor.invokedUpdate)
        XCTAssertNil(mockInteractor.invokedUpdateParameters)
        XCTAssertEqual(mockInteractor.invokedUpdateCount, .zero)
        
        presenter.update(title: "Test", description: "Test")
        
        
        XCTAssertFalse(mockInteractor.invokedUpdate)
        XCTAssertNil(mockInteractor.invokedUpdateParameters)
        XCTAssertEqual(mockInteractor.invokedUpdateCount, .zero)
    }
    
    func test_update_ID_NotNull_InvokedRequiredInteractorMethods() {
        XCTAssertFalse(mockInteractor.invokedUpdate)
        XCTAssertNil(mockInteractor.invokedUpdateParameters)
        XCTAssertEqual(mockInteractor.invokedUpdateCount, .zero)
        
        reCreate(id: "609e5daf01b14809885040df")
        presenter.update(title: "Test", description: "Trial")
        
        
        XCTAssertTrue(mockInteractor.invokedUpdate)
        XCTAssertNotNil(mockInteractor.invokedUpdateParameters)
        XCTAssertEqual(mockInteractor.invokedUpdateCount, 1)
        XCTAssertEqual(mockInteractor.invokedUpdateParameters?.title, "Test")
        XCTAssertEqual(mockInteractor.invokedUpdateParameters?.description, "Trial")
    }
    
    func test_update_Title_Null_InvokedRequiredInteractorMethods() {
        XCTAssertFalse(mockInteractor.invokedUpdate)
        XCTAssertNil(mockInteractor.invokedUpdateParameters)
        XCTAssertEqual(mockInteractor.invokedUpdateCount, .zero)
        
        reCreate(id: "609e5daf01b14809885040df")
        presenter.update(title: nil, description: "Test")
        
        
        XCTAssertFalse(mockInteractor.invokedUpdate)
        XCTAssertNil(mockInteractor.invokedUpdateParameters)
        XCTAssertEqual(mockInteractor.invokedUpdateCount, .zero)
    }
    
    func test_update_Title_Empty_InvokedRequiredInteractorMethods() {
        XCTAssertFalse(mockInteractor.invokedUpdate)
        XCTAssertNil(mockInteractor.invokedUpdateParameters)
        XCTAssertEqual(mockInteractor.invokedUpdateCount, .zero)
        
        reCreate(id: "609e5daf01b14809885040df")
        presenter.update(title: "", description: "Test")
        
        
        XCTAssertFalse(mockInteractor.invokedUpdate)
        XCTAssertNil(mockInteractor.invokedUpdateParameters)
        XCTAssertEqual(mockInteractor.invokedUpdateCount, .zero)
    }
    
    func test_update_Description_Null_InvokedRequiredInteractorMethods() {
        XCTAssertFalse(mockInteractor.invokedUpdate)
        XCTAssertNil(mockInteractor.invokedUpdateParameters)
        XCTAssertEqual(mockInteractor.invokedUpdateCount, .zero)
        
        reCreate(id: "609e5daf01b14809885040df")
        presenter.update(title: "Trial", description: "")
        
        
        XCTAssertFalse(mockInteractor.invokedUpdate)
        XCTAssertNil(mockInteractor.invokedUpdateParameters)
        XCTAssertEqual(mockInteractor.invokedUpdateCount, .zero)
    }
    
    func test_update_Description_Empty_InvokedRequiredInteractorMethods() {
        XCTAssertFalse(mockInteractor.invokedUpdate)
        XCTAssertNil(mockInteractor.invokedUpdateParameters)
        XCTAssertEqual(mockInteractor.invokedUpdateCount, .zero)
        
        reCreate(id: "609e5daf01b14809885040df")
        presenter.update(title: "Test", description: "")
        
        
        XCTAssertFalse(mockInteractor.invokedUpdate)
        XCTAssertNil(mockInteractor.invokedUpdateParameters)
        XCTAssertEqual(mockInteractor.invokedUpdateCount, .zero)
    }
    
    func test_save_Title_Null_InvokedRequiredInteractorMethods() {
        XCTAssertFalse(mockInteractor.invokedCreate)
        XCTAssertNil(mockInteractor.invokedCreateParameters)
        XCTAssertEqual(mockInteractor.invokedCreateCount, .zero)
        
        presenter.save(title: nil, description: "Test", imageBase64Data: "Base64")
        
        XCTAssertFalse(mockInteractor.invokedCreate)
        XCTAssertNil(mockInteractor.invokedCreateParameters)
        XCTAssertEqual(mockInteractor.invokedCreateCount, .zero)
    }
    
    func test_save_Title_Empty_InvokedRequiredInteractorMethods() {
        XCTAssertFalse(mockInteractor.invokedCreate)
        XCTAssertNil(mockInteractor.invokedCreateParameters)
        XCTAssertEqual(mockInteractor.invokedCreateCount, .zero)
        
        presenter.save(title: .empty, description: "Test", imageBase64Data: "Base64")
        
        XCTAssertFalse(mockInteractor.invokedCreate)
        XCTAssertNil(mockInteractor.invokedCreateParameters)
        XCTAssertEqual(mockInteractor.invokedCreateCount, .zero)
    }
    
    func test_save_Description_Null_InvokedRequiredInteractorMethods() {
        XCTAssertFalse(mockInteractor.invokedCreate)
        XCTAssertNil(mockInteractor.invokedCreateParameters)
        XCTAssertEqual(mockInteractor.invokedCreateCount, .zero)
        
        presenter.save(title: "Test", description: nil, imageBase64Data: "Base64")
        
        
        XCTAssertFalse(mockInteractor.invokedCreate)
        XCTAssertNil(mockInteractor.invokedCreateParameters)
        XCTAssertEqual(mockInteractor.invokedCreateCount, .zero)
    }
    
    func test_save_Description_Empty_InvokedRequiredInteractorMethods() {
        XCTAssertFalse(mockInteractor.invokedCreate)
        XCTAssertNil(mockInteractor.invokedCreateParameters)
        XCTAssertEqual(mockInteractor.invokedCreateCount, .zero)
        
        presenter.save(title: "Test", description: .empty, imageBase64Data: "Base64")
        
        XCTAssertFalse(mockInteractor.invokedCreate)
        XCTAssertNil(mockInteractor.invokedCreateParameters)
        XCTAssertEqual(mockInteractor.invokedCreateCount, .zero)
    }
    
    
    func test_save_ImageBase64Data_Null_InvokedRequiredInteractorMethods() {
        XCTAssertFalse(mockInteractor.invokedCreate)
        XCTAssertNil(mockInteractor.invokedCreateParameters)
        XCTAssertEqual(mockInteractor.invokedCreateCount, .zero)
        
        presenter.save(title: "Test", description: "Trial", imageBase64Data: nil)
        
        
        XCTAssertFalse(mockInteractor.invokedCreate)
        XCTAssertNil(mockInteractor.invokedCreateParameters)
        XCTAssertEqual(mockInteractor.invokedCreateCount, .zero)
    }
    
    func test_save_ImageBase64Data_Empty_InvokedRequiredInteractorMethods() {
        XCTAssertFalse(mockInteractor.invokedCreate)
        XCTAssertNil(mockInteractor.invokedCreateParameters)
        XCTAssertEqual(mockInteractor.invokedCreateCount, .zero)
        
        presenter.save(title: "Test", description: "Trial", imageBase64Data: .empty)
        
        XCTAssertFalse(mockInteractor.invokedCreate)
        XCTAssertNil(mockInteractor.invokedCreateParameters)
        XCTAssertEqual(mockInteractor.invokedCreateCount, .zero)
    }
    
    func test_handleUpdate_Succes_InvokedRequiredRouterMethods() {
        XCTAssertFalse(mockRouter.invokedPop)
        XCTAssertNil(mockRouter.invokedPopParameters)
        XCTAssertEqual(mockRouter.invokedPopCount, .zero)
        
        let updatedImage = mockDataProvider.decodeJSON(type: RestObjectResponse<Image>.self, fileName: "UpdatedImage")
        presenter.handleUpdate(.success(updatedImage))
        
        XCTAssertTrue(mockRouter.invokedPop)
        XCTAssertNotNil(mockRouter.invokedPopParameters)
        XCTAssertEqual(mockRouter.invokedPopCount, 1)
    }
    
    func test_handleUpdate_Failure_InvokedRequiredRouterMethods() {
        XCTAssertFalse(mockRouter.invokedPop)
        XCTAssertNil(mockRouter.invokedPopParameters)
        XCTAssertEqual(mockRouter.invokedPopCount, .zero)
        
        presenter.handleUpdate(.failure(.afError))
        
        XCTAssertFalse(mockRouter.invokedPop)
        XCTAssertNil(mockRouter.invokedPopParameters)
        XCTAssertEqual(mockRouter.invokedPopCount, .zero)
    }
    
    func test_handleCreate_Succes_InvokedRequiredRouterMethods() {
        XCTAssertFalse(mockRouter.invokedPop)
        XCTAssertNil(mockRouter.invokedPopParameters)
        XCTAssertEqual(mockRouter.invokedPopCount, .zero)
        
        let updatedImage = mockDataProvider.decodeJSON(type: RestObjectResponse<Image>.self, fileName: "CreatedImage")
        presenter.handleCreate(.success(updatedImage))
        
        XCTAssertTrue(mockRouter.invokedPop)
        XCTAssertNotNil(mockRouter.invokedPopParameters)
        XCTAssertEqual(mockRouter.invokedPopCount, 1)
    }
    
    func test_handleCreate_Failure_InvokedRequiredRouterMethods() {
        XCTAssertFalse(mockRouter.invokedPop)
        XCTAssertNil(mockRouter.invokedPopParameters)
        XCTAssertEqual(mockRouter.invokedPopCount, .zero)
        
        presenter.handleCreate(.failure(.afError))
        
        XCTAssertFalse(mockRouter.invokedPop)
        XCTAssertNil(mockRouter.invokedPopParameters)
        XCTAssertEqual(mockRouter.invokedPopCount, .zero)
    }
    
    func test_handleImage_Success_InvokedRequiredViewMethods() {
        XCTAssertFalse(mockView.invokedSetTitle)
        XCTAssertNil(mockView.invokedSetTitleParameters)
        
        XCTAssertFalse(mockView.invokedSetImageViewImage)
        XCTAssertNil(mockView.invokedSetImageViewImageParameters)
        
        XCTAssertFalse(mockView.invokedSetTitleTextFieldText)
        XCTAssertNil(mockView.invokedSetTitleTextFieldTextParameters)
        
        XCTAssertFalse(mockView.invokedSetDescriptionTextViewText)
        XCTAssertNil(mockView.invokedSetDescriptionTextViewTextParameters)
        
        let updatedImage = mockDataProvider.decodeJSON(type: RestObjectResponse<Image>.self, fileName: "UpdatedImage")
        presenter.handleImage(.success(updatedImage))
        //        presenter.handleImage(.failure(.afError)) -> We can test our unit tests :)
        
        
        XCTAssertTrue(mockView.invokedSetTitle)
        XCTAssertNotNil(mockView.invokedSetTitleParameters)
        XCTAssertEqual(mockView.invokedSetTitleParameters?.title, updatedImage.data.title)
        
        XCTAssertTrue(mockView.invokedSetImageViewImage)
        XCTAssertNotNil(mockView.invokedSetImageViewImageParameters)
        XCTAssertEqual(mockView.invokedSetImageViewImageParameters?.url, updatedImage.data.url)
        
        XCTAssertTrue(mockView.invokedSetTitleTextFieldText)
        XCTAssertNotNil(mockView.invokedSetTitleTextFieldTextParameters)
        
        XCTAssertTrue(mockView.invokedSetDescriptionTextViewText)
        XCTAssertNotNil(mockView.invokedSetDescriptionTextViewTextParameters)
        XCTAssertEqual(mockView.invokedSetDescriptionTextViewTextParameters?.text, updatedImage.data.description)
    }
    
    func test_handleImage_Failure_InvokedRequiredViewMethods() {
        XCTAssertFalse(mockView.invokedSetTitle)
        XCTAssertNil(mockView.invokedSetTitleParameters)
        
        XCTAssertFalse(mockView.invokedSetImageViewImage)
        XCTAssertNil(mockView.invokedSetImageViewImageParameters)
        
        XCTAssertFalse(mockView.invokedSetTitleTextFieldText)
        XCTAssertNil(mockView.invokedSetTitleTextFieldTextParameters)
        
        XCTAssertFalse(mockView.invokedSetDescriptionTextViewText)
        XCTAssertNil(mockView.invokedSetDescriptionTextViewTextParameters)
        
        presenter.handleImage(.failure(.afError))
        
        XCTAssertFalse(mockView.invokedSetTitle)
        XCTAssertNil(mockView.invokedSetTitleParameters)
        
        XCTAssertFalse(mockView.invokedSetImageViewImage)
        XCTAssertNil(mockView.invokedSetImageViewImageParameters)
        
        XCTAssertFalse(mockView.invokedSetTitleTextFieldText)
        XCTAssertNil(mockView.invokedSetTitleTextFieldTextParameters)
        
        XCTAssertFalse(mockView.invokedSetDescriptionTextViewText)
        XCTAssertNil(mockView.invokedSetDescriptionTextViewTextParameters)
    }
}

