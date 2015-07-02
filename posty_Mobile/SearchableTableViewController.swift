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
}

class SearchableTableViewController: UITableViewController, UIScrollViewDelegate, TableCellSearchHeaderDelegate {
    
    private var searchHeader: TableCellSearchHeader?
    var listDataSource: SearchableTableViewControllerDataSource?
    
    var showSearchHeader = false {
        didSet {
            if (!oldValue) {
                self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Top)
            }
        }
    }
    
    func tableCellSearchHeaderSearchTextDidChange(searchHeader: TableCellSearchHeader, searchText: String) {
        listDataSource?.searchForText(searchText)
        self.tableView.reloadData()
        searchHeader.searchBar.becomeFirstResponder()
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
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        listDataSource?.updateDataSource(self.tableView)
        if let frame = navigationController?.navigationBar.frame {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 70, height: frame.height))
            imageView.contentMode = .ScaleAspectFit
            let image = UIImage(named: "postyMobileLogo.png")
            imageView.image = image
            navigationItem.leftBarButtonItem?.customView = imageView
        }
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
