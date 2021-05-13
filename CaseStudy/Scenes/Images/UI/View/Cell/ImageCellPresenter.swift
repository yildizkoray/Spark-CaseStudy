//
//  ImageCellPresenter.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 13.05.2021.
//

import Foundation

public protocol ImageCellPresenterProtocol {
    func load()
}

public final class ImageCellPresenter {
    private weak var view: ImageCellProtocol?
    private let imagePresentation: ImagePresentation
    
    public init(view: ImageCellProtocol, imagePresentation: ImagePresentation) {
        self.view = view
        self.imagePresentation = imagePresentation
    }
}

// MARK: - ImageCellPresenterProtocol
extension ImageCellPresenter: ImageCellPresenterProtocol {
    public func load() {
        view?.prepareUI()
        view?.configure(with: imagePresentation)
    }
}
