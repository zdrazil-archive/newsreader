//
//  ArticlesDataManager.swift
//  NewsReader
//
//  Created by Vladimír Zdražil on 02/04/2017.
//  Copyright © 2017 Vladimír Zdražil. All rights reserved.
//

import CoreData
import UIKit

class ArticlesDataManager: NSObject, NSFetchedResultsControllerDelegate {

    var articleSections: [NSFetchedResultsSectionInfo]? {
        return fetchedResultsController.sections
    }

    private let dataController = DataController() {

    }
    //    private let dataController = (UIApplication.shared.delegate as? AppDelegate)?.dataController
    private var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!

    var delegate: ArticlesDataManagerDelegate?

    override init() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ArticleMO")
        // Sort by date
        let dateSort = NSSortDescriptor(key: "publishedAt", ascending: false)
        request.sortDescriptors = [dateSort]

        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: dataController.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)

        super.init()

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


    func controller(controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            break
        case .delete:
            break
        case .move:
            break
        case .update:
            break
        }
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            break
        case .delete:
            break
        case .update:
            break
        case .move:
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
}
