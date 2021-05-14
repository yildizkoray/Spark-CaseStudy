//
//  ImagePresentation.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 12.05.2021.
//

import Foundation

public struct ImagePresentation {
    let id: String
    let title: String
    let description: String
    let url: URL
    
    init(image: Image) {
        id = image.id
        title = image.title
        description = image.description
        url = image.url
    }
}

// MARK: - Equatable
extension ImagePresentation: Equatable {
    public static func ==(lhs: ImagePresentation, rhs: ImagePresentation) -> Bool {
        return lhs.id == rhs.id
    }
}



