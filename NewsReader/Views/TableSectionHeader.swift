//
//  TableSectionHeader.swift
//  NewsReader
//
//  Created by Vladimír Zdražil on 02/04/2017.
//  Copyright © 2017 Vladimír Zdražil. All rights reserved.
//

import UIKit
import SDWebImage

class TableSectionHeader: UITableViewHeaderFooterView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var headerView: UIView!

    struct ViewData {
        let title: String?
        let publishedAt: Date?
        let imageURL: URL?
        let articleURL: URL?
        let author: String?
        let description: String?
        let sharingItems: [AnyObject]?

        var publishedAtString: String? {
            get {
                let dateFormatter = DateFormatter.AbsoluteTimeFormatter
                return dateFormatter.unwrappedString(from: publishedAt)
            }
        }
    }

    var viewData: ViewData? {
        didSet {
            self.titleLabel.text = viewData?.title
            self.authorLabel.text = viewData?.author
            self.dateLabel.text = viewData?.publishedAtString
            self.descriptionLabel.text = viewData?.description

            self.imageView?.sd_setShowActivityIndicatorView(true)
            self.imageView?.sd_setIndicatorStyle(.gray)
            self.imageView?.sd_setImage(with: viewData?.imageURL, placeholderImage: UIImage(named: "ArticlePlaceholder.png"))
        }
    }
}

extension TableSectionHeader.ViewData {
    init(article: ArticleMO) {
        self.title = article.title
        self.publishedAt = article.publishedAt as Date?
        self.imageURL = article.imageURL
        self.articleURL = article.url
        self.author = article.author
        self.description = article.articleDescription

        self.sharingItems = [article.title as AnyObject,
                             article.url as AnyObject]
    }
}


