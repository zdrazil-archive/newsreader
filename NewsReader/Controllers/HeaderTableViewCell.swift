//
//  HeaderTableViewCell.swift
//  NewsReader
//
//  Created by Vladimír Zdražil on 02/04/2017.
//  Copyright © 2017 Vladimír Zdražil. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
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

extension HeaderTableViewCell.ViewData {
    init(article: Article) {
        self.title = article.title!
        self.dateString = DateFormatter.AbsoluteTimeFormatter.string(from: article.publishedAt!)
        self.imageURL = article.imageURL
        self.articleURL = article.url
        self.author = article.author
        self.description = article.description
    }
}
