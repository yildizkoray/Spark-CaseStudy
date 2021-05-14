//
//  MockImagesInteractor.swift
//  CaseStudyTests
//
//  Created by Koray Yıldız on 14.05.2021.
//

@testable import CaseStudy

public final class MockImagesInteractor: Interactor, ImagesInteractorProtocol {
    var output: ImagesInteractorDelegate?
    var invokedImages = false
    var invokedImagesCount = 0
    var invokedImagesParameters: (page: Int, Void)?
    var invokedImagesParametersList = [(page: Int, Void)]()
    
    public func images(page: Int) {
        service.execute(task: GetImagesTask(page: page), type: RestArrayResponse<Image>.self) { [weak self] response in
            self?.output?.handleImages(response)
        }
       
        invokedImages = true
        invokedImagesCount += 1
        invokedImagesParameters = (page, ())
        invokedImagesParametersList.append((page, ()))
    }
    
    var invokedNext = false
    var invokedNextCount = 0
    var invokedNextParameters: (page: Int, Void)?
    var invokedNextParametersList = [(page: Int, Void)]()
    
    public func next(page: Int) {
        service.execute(task: GetImagesTask(page: page), type: RestArrayResponse<Image>.self) { [weak self] response in
            self?.output?.handleNext(response)
        }
        invokedNext = true
        invokedNextCount += 1
        invokedNextParameters = (page, ())
        invokedNextParametersList.append((page, ()))
    }
    
    var invokedDelete = false
    var invokedDeleteCount = 0
    var invokedDeleteParameters: (id: String, Void)?
    var invokedDeleteParametersList = [(id: String, Void)]()
    
    public func delete(id: String) {
        service.execute(task: DeleteImageTask(id: id), type: RestObjectResponse<Image>.self) { [weak self] response in
            self?.output?.handleDelete(response)
        }
        invokedDelete = true
        invokedDeleteCount += 1
        invokedDeleteParameters = (id, ())
        invokedDeleteParametersList.append((id, ()))
    }
}
