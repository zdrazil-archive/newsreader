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

        articlesDataManager.delegate = self

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
        let header = cell as! TableSectionHeader
        header.titleLabel.text = "Ahoj"

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.tableView.headerView(forSection: 0)
        let header = cell as! TableSectionHeader
        header.titleLabel.text = "Test"
//        let article = articlesDataManager.objectAt(at: indexPath) as! ArticleMO

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
}
