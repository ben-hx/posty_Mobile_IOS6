//
//  ListBaseTableViewController.swift
//  posty_Mobile
//
//  Created by admin on 29.06.15.
//  Copyright (c) 2015 ben-hx. All rights reserved.
//

import UIKit

protocol SearchableTableViewControllerDataSource {
    func searchForText(searchText: String)
    func updateDataSource(tableView: UITableView)
    func numberOfRows() -> Int
    func cellForRowAtIndexPath(tableView: UITableView, indexPath: NSIndexPath) -> UITableViewCell
    func deleteAtIndexPath(tableView: UITableView, indexPath: NSIndexPath)
    func addClicked(sender: UIButton)
}

class SearchableTableViewController: UITableViewController, UIScrollViewDelegate, TableCellSearchHeaderDelegate, ActivityIndicatorViewWithEventsDelegate, Processable {
    
    private var searchHeader: TableCellSearchHeader?
    var listDataSource: SearchableTableViewControllerDataSource?
    var loadingIndicator:  ActivityIndicatorViewWithEvents?
    var searchBarButtonItem: UIBarButtonItem?
    var addBarButtonItem: UIBarButtonItem?
    var showSearchHeader = false {
        didSet {
            self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Top)
        }
    }
    
    func tableCellSearchHeaderSearchTextDidChange(searchHeader: TableCellSearchHeader, searchText: String) {
        listDataSource?.searchForText(searchText)
        self.tableView.reloadData()
        searchHeader.searchBar.becomeFirstResponder()
    }
    
    func searchClicked(sender: UIButton) {
        showSearchHeader = !showSearchHeader
    }
    
    func addClicked(sender: UIButton) {
        listDataSource?.addClicked(sender)
    }
    
    override func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        listDataSource?.updateDataSource(self.tableView)
        showSearchHeader = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var nib: UINib
        nib = UINib(nibName: "ViewTableCellSearchHeader", bundle: nil)
        tableView.registerNib(nib, forHeaderFooterViewReuseIdentifier: ViewConsts.ReuseIdentifier.TableCellSearchHeader)
        searchHeader = tableView.dequeueReusableHeaderFooterViewWithIdentifier(ViewConsts.ReuseIdentifier.TableCellSearchHeader) as? TableCellSearchHeader
        searchHeader!.delegate = self
        self.searchBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addClicked:")
        self.addBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: "searchClicked:")
        self.navigationItem.setRightBarButtonItems([searchBarButtonItem!,addBarButtonItem!], animated: true)
        self.loadingIndicator = getActivityIndicatorView()
        self.loadingIndicator?.delegate = self
    }
    
    func didStartAnimating() {
        searchHeader?.enabled = false
        searchBarButtonItem?.enabled = false
        addBarButtonItem?.enabled = false
    }
    
    func didStopAnimating() {
        searchHeader?.enabled = true
        searchBarButtonItem?.enabled = true
        addBarButtonItem?.enabled = true
    }
    
    func beginProcess() {
        self.loadingIndicator?.startAnimating()
    }
    
    func endProcess() {
        self.loadingIndicator?.stopAnimating()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        listDataSource?.updateDataSource(self.tableView)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (listDataSource == nil) {
            return 0
        }
        return listDataSource!.numberOfRows()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (listDataSource == nil) {
            return super.tableView(tableView, cellForRowAtIndexPath: indexPath)
        }
        return listDataSource!.cellForRowAtIndexPath(tableView, indexPath: indexPath)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            listDataSource?.deleteAtIndexPath(tableView, indexPath: indexPath)
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (showSearchHeader) {
            return searchHeader!.bounds.height
        }
        return CGFloat(0.0)
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "List"
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return searchHeader
    }
    
}
