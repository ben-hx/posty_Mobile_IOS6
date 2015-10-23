//
//  DomainUserListController.swift
//  posty_Mobile
//
//  Created by admin on 29.06.15.
//  Copyright (c) 2015 ben-hx. All rights reserved.
//

import UIKit

class DomainUserListController: SearchableTableViewController, SearchableTableViewControllerDataSource {
    
    private struct Consts
    {
        static let CellReuseID = "CellReuseID"
        struct Sagues {
            static let Edit = "EditUser"
            static let Create = "CreateUser"
        }
    }
    
    var repo: DomainUserRepository?
    var data = FilterableList<DomainUser>()
    var domain: Domain? {
        didSet {
            self.repo = ModelFactory.getDomainUserRepository(domain!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listDataSource = self
        repo?.processDelegate = self
    }
    
    func searchForText(searchText: String) {
        data.search(searchText)
    }
    
    func updateDataSource(tableView: UITableView) {
        repo!.getAll().onSuccess{ userList in
            self.data.reload(userList)
            self.tableView?.reloadData()
        }
    }
    
    func numberOfRows() -> Int {
        return self.data.count()
    }
    
    func cellForRowAtIndexPath(tableView: UITableView, indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(Consts.CellReuseID) as! UITableViewCell
        cell.textLabel?.text = self.data.getAtIndex(indexPath.row)!.name+"@"+domain!.name
        return cell
    }
    
    func deleteAtIndexPath(tableView: UITableView, indexPath: NSIndexPath) {
        let user = self.data.getAtIndex(indexPath.row)
        self.repo!.delete(user!.name).onSuccess{ result in
            self.data.remove(user!)
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
                if let destination = segue.destinationViewController as? DomainUserCreateController {
                    destination.domain = self.domain
                }
            case Consts.Sagues.Edit:
                if let destination = segue.destinationViewController as? DomainEditController {
                    let indexPath = tableView.indexPathForSelectedRow()!
                    //destination.domain = self.data.getAtIndex(indexPath.row)
                }
            default: break
            }
        }
    }
    
}

extension DomainUser: SearchtextFiltable {
    func filter(searchText: String) -> Bool {
        let tmp: NSString = self.name
        let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
        return range.location != NSNotFound
    }
}
