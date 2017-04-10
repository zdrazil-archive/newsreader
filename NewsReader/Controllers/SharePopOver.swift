//
//  SharePopUp.swift
//  NewsReader
//
//  Created by Vladimír Zdražil on 04/04/2017.
//  Copyright © 2017 Vladimír Zdražil. All rights reserved.
//

import UIKit

struct SharePopUp {
    var activityViewController: UIActivityViewController?
    
    init(sender: UIBarButtonItem, header: TableSectionHeader) {
        let sharingItems = getSharingItems(header: header)
        self.activityViewController = getActivityViewController(sender: sender, sharingItems: sharingItems)
    }
    
    private func getActivityViewController(sender: UIBarButtonItem, sharingItems: [AnyObject]) -> UIActivityViewController {

        let activityViewController = UIActivityViewController(activityItems: sharingItems, applicationActivities: nil)
        activityViewController.popoverPresentationController?.barButtonItem = sender
        
        return activityViewController
    }
    
    private func getSharingItems(header: TableSectionHeader) -> [AnyObject] {
        var sharingItems = [AnyObject]()
        sharingItems.append(header.viewData?.title as AnyObject)
        sharingItems.append(header.viewData?.articleURL as AnyObject)
        return sharingItems
    }

}


