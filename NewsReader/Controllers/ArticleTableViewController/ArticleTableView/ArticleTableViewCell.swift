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
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var previewImage: UIImageView!

    struct ViewData {
        let title: String?
        let publishedAt: Date?
        let imageURL: URL?

        var publishedAtString: String? {
                let dateFormatter = DateFormatter.RelativeTimeFormatter
                return dateFormatter.unwrappedString(from: publishedAt)
        }
    }

    var viewData: ViewData? {
        didSet {
            titleLabel.text = viewData?.title
            subtitleLabel.text = viewData?.publishedAtString
            self.previewImage.sd_setShowActivityIndicatorView(true)
            self.previewImage.sd_setIndicatorStyle(.gray)
            self.previewImage.sd_setImage(with: viewData?.imageURL,
                                          placeholderImage: #imageLiteral(resourceName: "ArticlePlaceholder"))
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
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
