//
//  ArticleTableViewCell.swift
//  NewsReader
//
//  Created by Vladimír Zdražil on 02/04/2017.
//  Copyright © 2017 Vladimír Zdražil. All rights reserved.
//

import UIKit
import SDWebImage

class ArticleTableViewCell: UITableViewCell {
    struct ViewData {
        let title: String?
        let dateString: String?
        let imageURL: URL?
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

extension ArticleTableViewCell.ViewData {
    init(article: ArticleMO) {
        self.title = article.title!
        let dateFormatter = DateFormatter.RelativeTimeFormatter
        self.dateString = dateFormatter.string(from: article.publishedAt! as Date)
        self.imageURL = URL(string: article.imageURL!)
    }
}
