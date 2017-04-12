//
//  JSONTestArticle.swift
//  NewsReader
//
//  Created by Vladimír Zdražil on 08/04/2017.
//  Copyright © 2017 Vladimír Zdražil. All rights reserved.
//
import Foundation

struct JSONTestArticle {
    let jsonText: String
    let author = "Sarah Buhr"
    let title = "Barbie becomes a hologram version of herself"
    let description = "Yes, after pulling herself out..."
    let url = "https://techcrunch.com/2017/02/17/barbie/"
    let urlToImage = "https://tctechcrunch2011.files.wordpress.com/2017/02/gettyimages-462793345.jpg?w=764&h=400&crop=1"
    let publishedAt = "2017-02-17T23:11:56Z"

    init() {

        let articleData = [ "author": author,
                            "title": title,
                            "description": description,
                            "url": url,
                            "urlToImage": urlToImage,
                            "publishedAt": publishedAt ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: articleData)
            jsonText = String(data: jsonData, encoding: .utf8)!
        } catch {
            print("Couldn't convert dict to JSON string")
            jsonText = ""
        }
    }
}
