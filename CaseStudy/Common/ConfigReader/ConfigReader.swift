//
//  ConfigReader.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 11.05.2021.
//

import Foundation

fileprivate struct Constants {
    
    struct Key {
        static let config = "Config"
    }
}

public final class ConfigReader {
    
    static let shared = ConfigReader()
    
    private let config: [String: Any] = Bundle.main.infoDictionaryValue(for: Constants.Key.config)

    public subscript<E>(key: String, default defaultValue: @autoclosure () -> E) -> E {
      return config[key, default: defaultValue()] as! E
    }

    public subscript(key: String) -> String {
      return self[key, default: .empty]
    }
}
