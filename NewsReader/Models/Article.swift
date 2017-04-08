//
//  Article.swift
//  NewsReader
//
//  Created by Vladimír Zdražil on 29/03/2017.
//  Copyright © 2017 Vladimír Zdražil. All rights reserved.
//

import ObjectMapper

struct Article: Mappable {
    var description: String?
    var author: String?
    var imageURL: URL?
    var publishedAt: Date?
    var title: String?
    var url: URL?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        description <- map["description"]
        author      <- map["author"]
        imageURL    <- (map["urlToImage"], URLTransform())
        publishedAt <- (map["publishedAt"], CustomDateFormatTransform(formatString: "yyyy-MM-dd'T'HH:mm:ssZ"))
        title       <- map["title"]
        url         <- (map["url"], URLTransform())
    }
}
