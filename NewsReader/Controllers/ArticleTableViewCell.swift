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
        let publishedAt: Date?
        let imageURL: URL?

        var publishedAtString: String? {
            get {
                let dateFormatter = DateFormatter.RelativeTimeFormatter
                return dateFormatter.unwrappedString(from: publishedAt)
            }
        }
    }

    var viewData: ViewData? {
        didSet {
            textLabel?.text = viewData?.title
            detailTextLabel?.text = viewData?.publishedAtString
            self.imageView?.sd_setShowActivityIndicatorView(true)
            self.imageView?.sd_setIndicatorStyle(.gray)
            self.imageView?.sd_setImage(with: viewData?.imageURL, placeholderImage: UIImage(named: "ArticlePlaceholder.png"))
        }
    }
    
    // Prevent loading wrong image in reused cells, eq. when scrolling
    override func prepareForReuse() {
        super.prepareForReuse()
        // Cancel pending download request
        self.imageView?.sd_cancelCurrentAnimationImagesLoad()
        // Clear out reused image
        self.imageView?.image = nil
    }
}

extension ArticleTableViewCell.ViewData {
    init(article: ArticleMO) {
        self.title = article.title
        self.publishedAt = article.publishedAt as Date?
        self.imageURL = article.imageURL
    }
}

