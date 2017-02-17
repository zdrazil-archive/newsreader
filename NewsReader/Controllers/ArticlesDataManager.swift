//
//  ArticlesDataManager.swift
//  NewsReader
//
//  Created by Vladimír Zdražil on 02/04/2017.
//  Copyright © 2017 Vladimír Zdražil. All rights reserved.
//

import CoreData
import UIKit
import Foundation

class ArticlesDataManager: NSObject, NSFetchedResultsControllerDelegate {

    var articleSections: [NSFetchedResultsSectionInfo]? {
        return fetchedResultsController.sections
    }

    private var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!

    var delegate: ArticlesDataManagerDelegate?

    override init() {
        super.init()

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ArticleMO")
        // Sort by date
        let dateSort = NSSortDescriptor(key: "publishedAt", ascending: false)
        request.sortDescriptors = [dateSort]

        let dataController = ((UIApplication.shared.delegate as? AppDelegate)?.dataController)!
        let moc = dataController.managedObjectContext

        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)


        fetchedResultsController.delegate = self

        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }


    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.dataManagerWillChangeContent(dataManager: self)
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            delegate?.dataManager(dataManager: self, didInsertRowAtIndexPath: newIndexPath!)
        case .delete:
            delegate?.dataManager(dataManager: self, didDeleteRowAtIndexPath: indexPath!)
        case .move:
            break
        case .update:
            break
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.dataManagerDidChangeContent(dataManager: self)
    }

    func objectAt(at: IndexPath) -> NSFetchRequestResult {
        return fetchedResultsController.object(at: at)
    }
}

protocol ArticlesDataManagerDelegate {
    func dataManagerWillChangeContent(dataManager: ArticlesDataManager)
    func dataManagerDidChangeContent(dataManager: ArticlesDataManager)
    func dataManager(dataManager: ArticlesDataManager, didInsertRowAtIndexPath indexPath: IndexPath)
    func dataManager(dataManager: ArticlesDataManager, didDeleteRowAtIndexPath indexPath: IndexPath)
}
