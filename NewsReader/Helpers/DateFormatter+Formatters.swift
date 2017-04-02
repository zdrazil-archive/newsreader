//
//  DateFormatter+Formatters.swift
//  NewsReader
//
//  Created by Vladimír Zdražil on 29/03/2017.
//  Copyright © 2017 Vladimír Zdražil. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let ISO8601Formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter
    }()

    static let AbsoluteTimeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm dd. MMMM YYYY"
        return dateFormatter
    }()
}
