//
//  PreviewViewer.swift
//  NewsReader
//
//  Created by Vladimír Zdražil on 04/04/2017.
//  Copyright © 2017 Vladimír Zdražil. All rights reserved.
//

import SafariServices

struct PreviewViewer {
    static func getSFSafariViewController(url: URL) -> SFSafariViewController {
        let vc = SFSafariViewController(url: url)
        return vc
    }
}
