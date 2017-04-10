//
//  ArticleTableViewControllerTests.swift
//  NewsReader
//
//  Created by Vladimír Zdražil on 05/04/2017.
//  Copyright © 2017 Vladimír Zdražil. All rights reserved.
//

import XCTest
@testable import NewsReader

class ArticleTableViewControllerTests: XCTestCase {
    var systemUnderTest: ArticleTableViewController!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "ArticleFeed", bundle: nil)
        systemUnderTest = storyboard.instantiateViewController(withIdentifier: "ArticleTableViewController") as! ArticleTableViewController

        //load view hierarchy
        _ = systemUnderTest.view
    }

    func testTableViewIsNotNilAfterViewDidLoad() {
        XCTAssertNotNil(systemUnderTest.tableView)
    }

    func testShouldSetTableViewDataSource() {
        XCTAssertNotNil(systemUnderTest.tableView.dataSource)
    }

    func testShouldSetTableViewDelegate() {
        XCTAssertNotNil(systemUnderTest.tableView.delegate)
    }

    func testTableViewUsesCustomCell() {
        let firstCell = systemUnderTest.tableView(systemUnderTest.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssert(firstCell is ArticleTableViewCell)
    }

    func testUsesCustomTableSectionHeader() {
        let previewSection = systemUnderTest.tableView(systemUnderTest.tableView, viewForHeaderInSection: 0)
        XCTAssertNotNil(previewSection is TableSectionHeader)
    }

    override func tearDown() {
    }
}
