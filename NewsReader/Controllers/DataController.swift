//
//  DataController.swift
//  NewsReader
//
//  Created by Vladimír Zdražil on 28/03/2017.
//  Copyright © 2017 Vladimír Zdražil. All rights reserved.
//

import UIKit
import CoreData

class DataController: NSObject {
    
    var managedObjectContext: NSManagedObjectContext
    
    // storeFileLocationURL - The directory the application uses to store the Core Data store file.
    // modelFileName - name of the saved file
    init(modelURL: URL, storeFileLocationURL: URL, modelFileName: String, concurrencyType: NSManagedObjectContextConcurrencyType) dthrows {
        guard let modelURL = Bundle.main.url(forResource: "ArticleModel", withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
        
        guard let storeFileLocationURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            fatalError("Unable to resolve document directory")
        }
        let modelFileName = "ArticleModel.sqlite"
        let concurrencyType = NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType
        
        // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        managedObjectContext = NSManagedObjectContext(concurrencyType: concurrencyType)
        managedObjectContext.persistentStoreCoordinator = psc
        
        super.init()
        
        try createCoreDataFile(psc: psc, docURL: storeFileLocationURL, fileName: modelFileName)
    }
    
    private func createCoreDataFile(psc: NSPersistentStoreCoordinator,
                                    docURL: URL,
                                    fileName: String) throws {
        // Move to a background thread to do some long running work
        DispatchQueue.global(qos: .background).async {
            let storeURL = docURL.appendingPathComponent(fileName)
            do {
                try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
            } catch {
                fatalError("Error migrating store: \(error)")
            }
        }
    }
    
    func saveContext () throws {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
}
