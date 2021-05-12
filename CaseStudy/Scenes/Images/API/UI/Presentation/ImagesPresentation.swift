//
//  ImagesPresentation.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 13.05.2021.
//

import Foundation

public struct ImagesPresentation {
    let images: [ImagePresentation]
    
    init(images: [Image]) {
        self.images = images.map(ImagePresentation.init)
    }
    
    public static let empty = ImagesPresentation(images: .empty())
}
