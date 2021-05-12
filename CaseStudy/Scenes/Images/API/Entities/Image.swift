//
//  Image.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 12.05.2021.
//

import Foundation

public struct Image: Decodable {
    let id: String
    let title: String
    let description: String
    let url: URL
    
    enum CodingKeys: String, CodingKey {
        case url = "imageUrl"
        case title
        case id
        case description
    }
}
