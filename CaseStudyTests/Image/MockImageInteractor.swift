//
//  MockImageRouter.swift
//  CaseStudyTests
//
//  Created by Koray Yıldız on 14.05.2021.
//

@testable import CaseStudy

public final class MockImageInteractor: Interactor, ImageInteractorProtocol {
    var output: ImageInteractorDelegate?
    
    var invokedServiceSetter = false
    var invokedServiceSetterCount = 0
    var invokedService: RestService?
    var invokedServiceList = [RestService]()
    var invokedServiceGetter = false
    var invokedServiceGetterCount = 0
    var stubbedService: RestService!

    public override var service: RestService {
        set {
            invokedServiceSetter = true
            invokedServiceSetterCount += 1
            invokedService = newValue
            invokedServiceList.append(newValue)
        }
        get {
            invokedServiceGetter = true
            invokedServiceGetterCount += 1
            return stubbedService
        }
    }

    var invokedImage = false
    var invokedImageCount = 0
    var invokedImageParameters: (id: String, Void)?
    var invokedImageParametersList = [(id: String, Void)]()

    public func image(with id: String) {
        invokedImage = true
        invokedImageCount += 1
        invokedImageParameters = (id, ())
        invokedImageParametersList.append((id, ()))
    }

    var invokedCreate = false
    var invokedCreateCount = 0
    var invokedCreateParameters: (title: String, description: String, imageBase64String: String)?
    var invokedCreateParametersList = [(title: String, description: String, imageBase64String: String)]()

    public func create(title: String, description: String, imageBase64String: String) {
        invokedCreate = true
        invokedCreateCount += 1
        invokedCreateParameters = (title, description, imageBase64String)
        invokedCreateParametersList.append((title, description, imageBase64String))
    }

    var invokedUpdate = false
    var invokedUpdateCount = 0
    var invokedUpdateParameters: (id: String, title: String, description: String)?
    var invokedUpdateParametersList = [(id: String, title: String, description: String)]()

    public func update(id: String, title: String, description: String) {
        invokedUpdate = true
        invokedUpdateCount += 1
        invokedUpdateParameters = (id, title, description)
        invokedUpdateParametersList.append((id, title, description))
    }
}
