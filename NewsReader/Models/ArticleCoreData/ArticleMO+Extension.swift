//
//  ArticleMO+Extension.swift
//  NewsReader
//
//  Created by Vladimír Zdražil on 30/03/2017.
//  Copyright © 2017 Vladimír Zdražil. All rights reserved.
//

import CoreData

extension ArticleMO {
    
    class func createArticleMOEntity(article: Article,
                                     inManagedObjectContext context: NSManagedObjectContext) -> ArticleMO? {
        if let articleMO = NSEntityDescription.insertNewObject(forEntityName: "ArticleMO",
                                                               into: context) as? ArticleMO {
            articleMO.author = article.author
            articleMO.title = article.title
            articleMO.articleDescription = article.description
            articleMO.url = article.url?.absoluteString
            articleMO.imageURL = article.imageURL?.absoluteString
            articleMO.publishedAt = article.publishedAt as NSDate?
            return articleMO
        }
        return nil
    }
}
