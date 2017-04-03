//
//  ArticleTableViewController.swift
//  NewsReader
//
//  Created by Vladimír Zdražil on 01/04/2017.
//  Copyright © 2017 Vladimír Zdražil. All rights reserved.
//

import UIKit

class ArticleTableViewController: UITableViewController, ArticlesDataManagerDelegate {

    private let articlesDataManager = ArticlesDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        let stringURL = "http://testing.vladimirzdrazil.com/techcrunch.json"
        let articlesDownloader = ArticlesDownloader()
        articlesDownloader.downloadArticles(jsonURL: stringURL)
        articlesDataManager.delegate = self

        let nib = UINib(nibName: "TableSectionHeader", bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: "TableSectionHeader")
        setTheme()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return (articlesDataManager.articleSections?.count)!
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = articlesDataManager.articleSections else {
            fatalError("No sections in fetchedResultsController")
        }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleTableViewCell
        let article = articlesDataManager.objectAt(at: indexPath) as! ArticleMO
        cell.viewData = ArticleTableViewCell.ViewData(article: article)

        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "TableSectionHeader")
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.tableView.headerView(forSection: 0)
        let header = cell as! TableSectionHeader
        let article = articlesDataManager.objectAt(at: indexPath) as! ArticleMO
        header.viewData = TableSectionHeader.ViewData(article: article)
    }

    func dataManagerWillChangeContent(dataManager: ArticlesDataManager) {
        tableView.beginUpdates()
    }

    func dataManagerDidChangeContent(dataManager: ArticlesDataManager) {
        tableView.endUpdates()
    }

    private func setTheme() {
        self.navigationController?.navigationBar.setStatusBarColor()
        self.navigationController?.navigationBar.setTransparentNavigationBar()
    }
//
    @IBAction func share(_ sender: UIBarButtonItem) {
//        let cell = tableView.headerView(forSection: 0)?.contentView.
        let sharingItems = [AnyObject]()

//        sharingItems.append(cell.viewData?.title as AnyObject)
//        sharingItems.append(cell.viewData?.articleURL as AnyObject)

        let activityViewController = UIActivityViewController(activityItems: sharingItems, applicationActivities: nil)
        activityViewController.popoverPresentationController?.barButtonItem = sender
        self.present(activityViewController, animated: true, completion: nil)
    }

}

// MARK: - Preview

// MARK: - Share Button
extension ArticleTableViewController {
}
