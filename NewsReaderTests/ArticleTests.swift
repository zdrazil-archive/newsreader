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
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testArticleInit() {
        let author = "Sarah Buhr"
        let title = "Barbie becomes a hologram version of herself"
        let description = "Yes, after pulling herself out..."
        let url = "https://techcrunch.com/2017/02/17/barbie/"
        let urlToImage = "https://tctechcrunch2011.files.wordpress.com/2017/02/gettyimages-462793345.jpg?w=764&h=400&crop=1"
        let publishedAt = "2017-02-17T23:11:56Z"
        
        let articleData = [ "author": author,
                            "title": title,
                            "description": description,
                            "url": url,
                            "urlToImage": urlToImage,
                            "publishedAt": publishedAt ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: articleData)
            let jsonText = String(data: jsonData, encoding: .utf8)!
            let article = Article(JSONString: jsonText)
            XCTAssert(article?.author == author)
            XCTAssert(article?.title == title)
            XCTAssert(article?.description == description)
            XCTAssert(article?.url == URL(string: url))
            XCTAssert(article?.imageURL == URL(string: urlToImage))
            
            let date = Date()
            XCTAssert(article?.publishedAt == date.stringToISO8601Date(string: publishedAt))
        } catch {
            print("Couldn't convert dict to JSON string")
        }
        

    }
}

