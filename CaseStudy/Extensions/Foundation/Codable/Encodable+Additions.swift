//
//  Encodable+Additions.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 13.05.2021.
//

import Foundation

public extension Encodable {
    func parameters() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self),
              let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            return nil
        }
        return dictionary
    }
}
