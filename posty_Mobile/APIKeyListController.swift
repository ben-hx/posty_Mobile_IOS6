//
//  APIKeyListController.swift
//  posty_Mobile
//
//  Created by admin on 29.06.15.
//  Copyright (c) 2015 ben-hx. All rights reserved.
//

import UIKit

class APIKeyListController: SearchableTableViewController, SearchableTableViewControllerDataSource {
    
    private struct Consts
    {
        static let CellReuseID = "CellReuseID"
        struct Sagues {
            static let Edit = "EditAPIKey"
            static let Create = "CreateAPIKey"
        }
    }
    
    let repo = ModelFactory.getAPIKeyRepository()
    var data = FilterableList<APIKey>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listDataSource = self
        if let navBar = navigationController?.navigationBar {
            self.navigationItem.setLeftBarButtonItem(getPostyBarButtonItem(navBar), animated: true)
        }
        repo.processDelegate = self
    }
    
    func searchForText(searchText: String) {
        data.search(searchText)
    }
    
    func updateDataSource(tableView: UITableView) {
        loadingIndicator?.startAnimating()
        repo.getAll().onSuccess{ apiKeyList in
            self.data.reload(apiKeyList)
            self.tableView?.reloadData()
            self.loadingIndicator?.stopAnimating()
        }
    }
    
    func numberOfRows() -> Int {
        return self.data.count()
    }
    
    func cellForRowAtIndexPath(tableView: UITableView, indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(Consts.CellReuseID) as! UITableViewCell
        cell.textLabel?.text = self.data.getAtIndex(indexPath.row)!.token
        return cell
    }
    
    func deleteAtIndexPath(tableView: UITableView, indexPath: NSIndexPath) {
        let apiKey = self.data.getAtIndex(indexPath.row)
        self.repo.delete(apiKey!.token).onSuccess{ result in
            self.data.remove(apiKey!)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    override func addClicked(sender: UIButton) {
        performSegueWithIdentifier(Consts.Sagues.Create, sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case Consts.Sagues.Create:
                if let destination = segue.destinationViewController as? APIKeyCreateController {
                }
            case Consts.Sagues.Edit:
                if let destination = segue.destinationViewController as? APIKeyEditController {
                    let indexPath = tableView.indexPathForSelectedRow()!
                    destination.apiKey = self.data.getAtIndex(indexPath.row)
                }
            default: break
            }
        }
    }
    
}

extension APIKey: SearchtextFiltable {
    func filter(searchText: String) -> Bool {
        let tmp: NSString = self.token
        let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
        return range.location != NSNotFound
    }
}