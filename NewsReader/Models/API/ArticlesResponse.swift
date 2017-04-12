//
//  ArticlesResponse.swift
//  NewsReader
//
//  Created by Vladimír Zdražil on 29/03/2017.
//  Copyright © 2017 Vladimír Zdražil. All rights reserved.
//

import ObjectMapper

struct ArticlesResponse: Mappable {
    var status: String?
    var source: String?
    var sortBy: String?
    var articles: [Article]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        status   <- map["status"]
        source   <- map["source"]
        sortBy   <- map["sortBy"]
        articles <- map["articles"]
    }
}
