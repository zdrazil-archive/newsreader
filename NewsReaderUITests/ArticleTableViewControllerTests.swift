//
//  ArticleTableViewControllerTests.swift
//  NewsReader
//
//  Created by Vladimír Zdražil on 04/04/2017.
//  Copyright © 2017 Vladimír Zdražil. All rights reserved.
//

import XCTest
@testable import NewsReader
@testable import Pods_NewsReader

class ArticleTableViewControllerTests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    private func downloadArticles() {
            let stringURL = "http://testing.vladimirzdrazil.com/techcrunch.json"
            let articlesDownloader = ArticlesDownloader()
            articlesDownloader.downloadArticles(jsonURL: stringURL)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testShowArticleInHeader() {
        let selectedArticle = app.cells.element(boundBy: 1)
        selectedArticle.tap()
        
        app.tables.staticTexts["Khaled \"Tito\" Hamze"].tap()
        app.otherElements["URL"].tap()
        app.buttons["Reader"].tap()
        
    }
    
}
