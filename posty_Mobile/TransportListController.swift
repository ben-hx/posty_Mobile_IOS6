//
//  TransportListController.swift
//  posty_Mobile
//
//  Created by admin on 29.06.15.
//  Copyright (c) 2015 ben-hx. All rights reserved.
//

import UIKit

class TransportListController: SearchableTableViewController, SearchableTableViewControllerDataSource {
    
    private struct Consts
    {
        static let CellReuseID = "CellReuseID"
        struct Sagues {
            static let Edit = "EditTransport"
            static let Create = "CreateTransport"
        }
    }
    
    let repo = ModelFactory.getTransportRepository()
    var data = FilterableList<Transport>()
    
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
        repo.getAll().onSuccess{ transportList in
            self.data.reload(transportList)
            self.tableView?.reloadData()
            self.loadingIndicator?.stopAnimating()
        }
    }
    
    func numberOfRows() -> Int {
        return self.data.count()
    }
    
    func cellForRowAtIndexPath(tableView: UITableView, indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(Consts.CellReuseID) as! UITableViewCell
        cell.textLabel?.text = self.data.getAtIndex(indexPath.row)!.name
        return cell
    }
    
    func deleteAtIndexPath(tableView: UITableView, indexPath: NSIndexPath) {
        let transport = self.data.getAtIndex(indexPath.row)
        self.repo.delete(transport!.name).onSuccess{ result in
            self.data.remove(transport!)
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
                if let destination = segue.destinationViewController as? TransportCreateController {
                }
            case Consts.Sagues.Edit:
                if let destination = segue.destinationViewController as? TransportEditController {
                    let indexPath = tableView.indexPathForSelectedRow()!
                    destination.transport = self.data.getAtIndex(indexPath.row)
                }
            default: break
            }
        }
    }
    
}

extension Transport: SearchtextFiltable {
    func filter(searchText: String) -> Bool {
        let tmp: NSString = self.name
        let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
        return range.location != NSNotFound
    }
}
