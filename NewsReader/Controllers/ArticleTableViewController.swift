//
//  ArticleTableViewController.swift
//  NewsReader
//
//  Created by Vladimír Zdražil on 01/04/2017.
//  Copyright © 2017 Vladimír Zdražil. All rights reserved.
//

import UIKit
import SafariServices

class ArticleTableViewController: UITableViewController, ArticlesDataManagerDelegate {

    private let articlesDataManager = ArticlesDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
      
        articlesDataManager.delegate = self

        downloadArticles()
        registerTableSectionHeader()
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
        addGestureRecognizerToHeaderView(cell: cell!)
        setHeaderViewStyle(cell: cell)
        return cell
    }
    
    private func addGestureRecognizerToHeaderView(cell: UITableViewHeaderFooterView) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapPreview(sender:)))
        let header = cell as! TableSectionHeader
        header.headerView.addGestureRecognizer(tap)
    }
    
    private func setHeaderViewStyle(cell: UITableViewHeaderFooterView?) {
        cell?.contentView.backgroundColor = UIColor.white
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showArticleInHeader(atIndexPath: indexPath)
      }
    
    private func showArticleInHeader(atIndexPath: IndexPath) {
        let cell = self.tableView.headerView(forSection: 0)
        let header = cell as! TableSectionHeader
        let article = articlesDataManager.objectAt(at: atIndexPath) as! ArticleMO
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
//        self.navigationController?.navigationBar.setTransparentNavigationBar()
    }
    
    private func downloadArticles() {
        let stringURL = "http://testing.vladimirzdrazil.com/techcrunch.json"
        let articlesDownloader = ArticlesDownloader()
        articlesDownloader.downloadArticles(jsonURL: stringURL)
    }
    
    private func registerTableSectionHeader() {
        let nib = UINib(nibName: "TableSectionHeader", bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: "TableSectionHeader")
    }

    private func addHeaderGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapPreview(sender:)))
        let header = self.tableView.headerView(forSection: 0)
        header?.addGestureRecognizer(tap)
    }
    
    // MARK: - Preview Link
    // Manage tapping on article preview
    @objc fileprivate func tapPreview(sender: UITapGestureRecognizer) {
        showArticle()
    }

    // Open article in a SFSafariViewController
    fileprivate func showArticle() {
        let header = self.tableView.headerView(forSection: 0) as! TableSectionHeader
        guard let url = header.viewData?.articleURL else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }

	// MARK: - Share Button
    @IBAction func share(_ sender: UIBarButtonItem) {
        let header = tableView.headerView(forSection: 0) as! TableSectionHeader
        var sharingItems = [AnyObject]()

        sharingItems.append(header.viewData?.title as AnyObject)
        sharingItems.append(header.viewData?.articleURL as AnyObject)

        let activityViewController = UIActivityViewController(activityItems: sharingItems, applicationActivities: nil)
        activityViewController.popoverPresentationController?.barButtonItem = sender
        self.present(activityViewController, animated: true, completion: nil)
    }
}
