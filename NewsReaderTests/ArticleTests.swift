//
//  ArticleTests.swift
//  NewsReader
//
//  Created by Vladimír Zdražil on 29/03/2017.
//  Copyright © 2017 Vladimír Zdražil. All rights reserved.
//

import XCTest
@testable import NewsReader
import ObjectMapper

class ArticleTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testArticleMapsJSON() {
        let json = JSONTestArticle()
        let jsonText = json.jsonText
        let article = Article(JSONString: jsonText)
        XCTAssert(article?.author == json.author)
        XCTAssert(article?.title == json.title)
        XCTAssert(article?.description == json.description)
        XCTAssert(article?.url == URL(string: json.url))
        XCTAssert(article?.imageURL == URL(string: json.urlToImage))

        let dateFormatter = DateFormatter.ISO8601Formatter
        let JSONDate = dateFormatter.date(from: json.publishedAt)
        XCTAssert(article?.publishedAt == JSONDate)
    }
}
