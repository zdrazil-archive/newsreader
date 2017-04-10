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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var previewImage: UIImageView!

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
            titleLabel.text = viewData?.title
            subtitleLabel.text = viewData?.publishedAtString
            self.previewImage.sd_setShowActivityIndicatorView(true)
            self.previewImage.sd_setIndicatorStyle(.gray)
            self.previewImage.sd_setImage(with: viewData?.imageURL, placeholderImage: UIImage(named: "ArticlePlaceholder.png"))
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.frame = CGRect(x: 15, y: 0, width: 83, height: 43.5)

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

