//
//  ArticleTableViewController.swift
//  NewsReader
//
//  Created by Vladimír Zdražil on 01/04/2017.
//  Copyright © 2017 Vladimír Zdražil. All rights reserved.
//

import UIKit

class ArticleTableViewController: UITableViewController, ArticlesDataManagerDelegate {

    fileprivate lazy var articlesDataManager = ArticlesDataManager()

    fileprivate var previewSection: TableSectionHeader {
        get {
            return self.tableView.headerView(forSection: 0) as! TableSectionHeader
        }
    }

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


    private func setTheme() {
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.setStatusBarColor()
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

    // MARK: - Share Button
    @IBAction func tapShare(_ sender: UIBarButtonItem) {
        showSharePopup(sender: sender)
    }

    private func showSharePopup(sender: UIBarButtonItem) {
        guard let sharingItems = previewSection.viewData?.sharingItems else {
            return
        }
        let activityViewController = UIActivityViewController(activityItems: sharingItems,
                                                              applicationActivities: nil)
        activityViewController.popoverPresentationController?.barButtonItem = sender
        self.present(activityViewController, animated: true, completion: nil)
    }
}

// MARK: - Table view data source
extension ArticleTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return articlesDataManager.articleSections?.count ?? 1
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
}

// MARK: - Table view delegate
extension ArticleTableViewController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "TableSectionHeader")
        addGestureRecognizerToHeaderView(cell: cell)
        setHeaderViewStyle(cell: cell)
        return cell
    }
    
    private func addGestureRecognizerToHeaderView(cell: UITableViewHeaderFooterView?) {
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
        let article = articlesDataManager.objectAt(at: atIndexPath) as! ArticleMO
        previewSection.viewData = TableSectionHeader.ViewData(article: article)
    }
}

// MARK: - Article data manager delegate
extension ArticleTableViewController {
    func dataManagerWillChangeContent(dataManager: ArticlesDataManager) {
        tableView.beginUpdates()
    }

    func dataManagerDidChangeContent(dataManager: ArticlesDataManager) {
        tableView.endUpdates()
    }

    func dataManager(dataManager: ArticlesDataManager, didInsertRowAtIndexPath indexPath: IndexPath) {
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    func dataManager(dataManager: ArticlesDataManager, didDeleteRowAtIndexPath indexPath: IndexPath) {
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

// MARK: - Link Preview
extension ArticleTableViewController {
    // Manage tapping on article preview
    @objc fileprivate func tapPreview(sender: UITapGestureRecognizer) {
        showArticle()
    }

    // Open article in a SFSafariViewController
    fileprivate func showArticle() {
        guard let url = previewSection.viewData?.articleURL else {
            return
        }
        let vc = PreviewViewer.getSFSafariViewController(url: url)
        present(vc, animated: true)
    }
}


