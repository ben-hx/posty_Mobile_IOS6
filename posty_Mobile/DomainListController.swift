//
//  DomainListBaseController.swift
//  posty_Mobile
//
//  Created by admin on 29.06.15.
//  Copyright (c) 2015 ben-hx. All rights reserved.
//

import UIKit

class DomainListController: SearchableTableViewController, SearchableTableViewControllerDataSource {
    
    private struct Consts
    {
        static let CellReuseID = "CellReuseID"
        struct Sagues {
            static let Edit = "EditDomain"
            static let Create = "CreateDomain"
        }
    }
    
    let repo = ModelFactory.getDomainRepository()
    var data = FilterableList<Domain>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listDataSource = self
    }
    
    func searchForText(searchText: String) {
        data.search(searchText)
    }
    
    func updateDataSource(tableView: UITableView) {
        repo.getAll().onSuccess{ domainList in
            self.data.reload(domainList)
            self.tableView?.reloadData()
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
        let domain = self.data.getAtIndex(indexPath.row)
        self.repo.delete(domain!.name).onSuccess{ result in
            self.data.remove(domain!)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case Consts.Sagues.Create:
                if let destination = segue.destinationViewController as? DomainCreateController {
                }
            case Consts.Sagues.Edit:
                if let destination = segue.destinationViewController as? DomainEditController {
                    let indexPath = tableView.indexPathForSelectedRow()!
                    destination.domain = self.data.getAtIndex(indexPath.row)
                }
            default: break
            }
        }
    }

}

extension Domain: SearchtextFiltable {
    func filter(searchText: String) -> Bool {
        let tmp: NSString = self.name
        let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
        return range.location != NSNotFound
    }
}
