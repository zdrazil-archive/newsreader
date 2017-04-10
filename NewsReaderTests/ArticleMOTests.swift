//
//  ArticleMOTests.swift
//  NewsReader
//
//  Created by Vladimír Zdražil on 08/04/2017.
//  Copyright © 2017 Vladimír Zdražil. All rights reserved.
//

import XCTest
@testable import NewsReader

class ArticleMOTests: XCTestCase {

    override func setUp() {
        super.setUp()


    }

    override func tearDown() {
        super.tearDown()
    }

    func testCreateArticleMOEntity() {
        let dataController = DataController { }
        let managedObjectContext = dataController.setUpInMemoryManagedObjectContext()

        let json = JSONTestArticle()
        let jsonText = json.jsonText
        guard let article = Article(JSONString: jsonText) else {
            XCTFail()
            return
        }

        guard let articleMO = ArticleMO.createArticleMOEntity(article: article, inManagedObjectContext: managedObjectContext) else {
            XCTFail()
            return
        }

        XCTAssert(articleMO.author == article.author)
        XCTAssert(articleMO.title == article.title)
        XCTAssert(articleMO.articleDescription == article.description)
        XCTAssert(articleMO.url == article.url)
        XCTAssert(articleMO.imageURL == article.imageURL)
        XCTAssert(articleMO.publishedAt == article.publishedAt as NSDate?)
    }
}
