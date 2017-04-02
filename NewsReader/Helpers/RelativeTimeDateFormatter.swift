//
//  RelativeTimeDateFormatter.swift
//  NewsReader
//
//  Created by Vladimír Zdražil on 02/04/2017.
//  Copyright © 2017 Vladimír Zdražil. All rights reserved.
//

import Foundation

struct RelativeTimeDateFormatter {

    func stringForDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.doesRelativeDateFormatting = true

        let relativeTime = dateFormatter.string(from: date)
        return relativeTime
    }
}
