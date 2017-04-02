//
//  ArticlesDownloader.swift
//  NewsReader
//
//  Created by Vladimír Zdražil on 29/03/2017.
//  Copyright © 2017 Vladimír Zdražil. All rights reserved.
//

import Foundation
import CoreData
import Alamofire
import AlamofireObjectMapper

class ArticlesDownloader: NSObject {
    
    func downloadArticles(jsonURL: String) {
        Alamofire.request(jsonURL).responseObject { (response: DataResponse<ArticlesResponse>) in
            
            let articlesResponse = response.result.value
            
            guard articlesResponse?.status == "ok" else {
                return
            }
            self.saveArticlesToCoreData(articles: articlesResponse?.articles)
        }
    }
    
    private func saveArticlesToCoreData(articles: [Article]?) {
        let dataController = (UIApplication.shared.delegate as? AppDelegate)?.dataController
        let moc = dataController?.managedObjectContext
        let privateMOC = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateMOC.parent = moc
        
        guard let articles = articles else {
            return
        }
        
        privateMOC.perform {
            for article in articles {
                _ = ArticleMO.createArticleMOEntity(article: article, inManagedObjectContext: privateMOC)
            }
            do {
                try privateMOC.save()
                moc?.performAndWait {
                    do {
                        try moc?.save()
                    } catch {
                        fatalError("Failure to save context: \(error)")
                    }
                }
            } catch let error {
                print("Failure to save context: \(error)")
            }
        }
    }
}
