//
//  Date+Formatter.swift
//  NewsReader
//
//  Created by Vladimír Zdražil on 29/03/2017.
//  Copyright © 2017 Vladimír Zdražil. All rights reserved.
//

import Foundation

extension Date {
    func stringToISO8601Date(string: String) -> Date? {
        guard let date = DateFormatter.ISO8601Formatter.date(from: string) else {
            print("Couldn't convert ISO8601 date string to Date type")
            return nil
        }
        return date
    }
}
