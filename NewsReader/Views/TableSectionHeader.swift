//
//  TableSectionHeader.swift
//  NewsReader
//
//  Created by Vladimír Zdražil on 02/04/2017.
//  Copyright © 2017 Vladimír Zdražil. All rights reserved.
//

import UIKit

class TableSectionHeader: UITableViewHeaderFooterView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

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
            textLabel?.text = viewData?.title
            detailTextLabel?.text = viewData?.dateString
            self.imageView?.sd_setShowActivityIndicatorView(true)
            self.imageView?.sd_setIndicatorStyle(.gray)
            self.imageView?.sd_setImage(with: viewData?.imageURL, placeholderImage: UIImage(named: "ArticlePlaceholder.png"))
        }
    }
}

extension TableSectionHeader.ViewData {
    init(article: Article) {
        self.title = article.title!
        self.dateString = DateFormatter.AbsoluteTimeFormatter.string(from: article.publishedAt!)
        self.imageURL = article.imageURL
        self.articleURL = article.url
        self.author = article.author
        self.description = article.description
    }
}


