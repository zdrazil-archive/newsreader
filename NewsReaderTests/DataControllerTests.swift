//
//  DataControllerTests.swift
//  NewsReader
//
//  Created by Vladimír Zdražil on 28/03/2017.
//  Copyright © 2017 Vladimír Zdražil. All rights reserved.
//

import UIKit

import XCTest
import CoreData
import UIKit
@testable import NewsReader

class DataControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCoreDataStackCreated() {
        guard let modelURL = Bundle.main.url(forResource: "ArticleModel", withExtension: "momd") else {
            XCTFail("Error loading model from bundle")
            fatalError("Error loading model from bundle")
        }
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docURL = urls[urls.endIndex-1]
        let fileName = "Model.sqlite"
        do {
            try _ = DataController(modelURL: modelURL, storeFileLocationURL: docURL, modelFileName: fileName, concurrencyType: .mainQueueConcurrencyType)
        } catch {
            XCTFail()
        }
    }
    
    
    func testCoreDataSavesContext() {
        guard let modelURL = Bundle.main.url(forResource: "ArticleModel", withExtension: "momd") else {
            fatalError("Error loading model from bundle")
        }
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docURL = urls[urls.endIndex-1]
        let fileName = "Model.sqlite"
        
        do {
            let dataController = try DataController(modelURL: modelURL, storeFileLocationURL: docURL, modelFileName: fileName, concurrencyType: .mainQueueConcurrencyType)
            do {
                try dataController.saveContext()
            } catch {
                XCTFail()
            }
        } catch {
            XCTFail()
        }
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

