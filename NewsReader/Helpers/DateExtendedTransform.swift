//
//  DateExtendedTransform.swift
//  NewsReader
//
//  Created by Vladimír Zdražil on 29/03/2017.
//  Copyright © 2017 Vladimír Zdražil. All rights reserved.
//

import Foundation
import ObjectMapper

class DateExtendedTransform: TransformType {
    typealias Object = Date
    typealias JSON = Double
    
    func transformFromJSON(_ value: Any?) -> Date? {
        if let timeStr = value as? String {
            let date = Date()
            return date.stringToISO8601Date(string: timeStr)
        }
        return nil
    }

    func transformToJSON(_ value: Date?) -> Double? {
        if let date = value {
            return Double(date.timeIntervalSince1970)
        }
        return nil
    }
}
