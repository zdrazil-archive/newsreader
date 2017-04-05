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
        let dateString: String?
        let imageURL: URL?
        let articleURL: URL?
        let author: String?
        let description: String?
    }

    var viewData: ViewData? {
        didSet {
            self.titleLabel.text = viewData?.title
            self.authorLabel.text = viewData?.author
            self.dateLabel.text = viewData?.dateString
            self.descriptionLabel.text = viewData?.description

            self.imageView?.sd_setShowActivityIndicatorView(true)
            self.imageView?.sd_setIndicatorStyle(.gray)
            self.imageView?.sd_setImage(with: viewData?.imageURL, placeholderImage: UIImage(named: "ArticlePlaceholder.png"))
        }
    }
}

extension TableSectionHeader.ViewData {
    init(article: ArticleMO) {
        self.title = article.title ?? nil
        let dateFormatter = DateFormatter.RelativeTimeFormatter
        
        if let publishedAt = article.publishedAt {
            self.dateString = dateFormatter.string(from: publishedAt as Date)
        } else {
            self.dateString = nil
        }
        
        if let imageURL = article.imageURL {
            self.imageURL = URL(string: imageURL)
        } else {
            self.imageURL = nil
        }
        
        if let articleURL = article.url {
            self.articleURL = URL(string: articleURL)
        } else {
            self.articleURL = nil
        }

        self.author = article.author
        self.description = article.articleDescription
    }
}


