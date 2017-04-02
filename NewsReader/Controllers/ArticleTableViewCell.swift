//
//  ArticleTableViewCell.swift
//  NewsReader
//
//  Created by Vladimír Zdražil on 02/04/2017.
//  Copyright © 2017 Vladimír Zdražil. All rights reserved.
//

import UIKit
import sd

class ArticleTableViewCell: UITableViewCell {
    struct ViewData {
        let title: String
        let dateString: String
        let image: UIImage
    }

    var viewData: ViewData? {
        didSet {
            textLabel?.text = viewData?.title
            detailTextLabel?.text = viewData?.dateString
            imageView.
        }
    }
}

extension ArticleTableViewCell.ViewData {
    init(article: Article) {
        self.title = article.title!
        self.dateString = RelativeTimeDateFormatter().stringForDate(date: article.publishedAt!)
        self.image =
    }
}
