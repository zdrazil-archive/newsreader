//
//  ArticleMO+Extension.swift
//  NewsReader
//
//  Created by Vladimír Zdražil on 30/03/2017.
//  Copyright © 2017 Vladimír Zdražil. All rights reserved.
//

import CoreData

extension ArticleMO {

    var url: URL? {
        get {
            if let rawURL = self.rawURL {
                return URL(string: rawURL)
            } else {
                return nil
            }
        }
        set {
            self.rawURL = newValue?.absoluteString
        }
    }

    var imageURL: URL? {
        get {
            if let rawImageURL = self.rawImageURL {
                return URL(string: rawImageURL)
            } else {
                return nil
            }
        }
        set {
            self.rawImageURL = newValue?.absoluteString
        }
    }

    class func createArticleMOEntity(article: Article,
                                     inManagedObjectContext context: NSManagedObjectContext) -> ArticleMO? {
        if let articleMO = NSEntityDescription.insertNewObject(forEntityName: "ArticleMO",
                                                               into: context) as? ArticleMO {
            articleMO.author = article.author
            articleMO.title = article.title
            articleMO.articleDescription = article.description
            articleMO.url = article.url
            articleMO.imageURL = article.imageURL
            articleMO.publishedAt = article.publishedAt as NSDate?
            return articleMO
        }
        return nil
    }
}
