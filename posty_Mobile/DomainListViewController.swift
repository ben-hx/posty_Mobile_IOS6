//
//  DomainListViewController.swift
//  posty_Mobile
//
//  Created by admin on 26.05.15.
//  Copyright (c) 2015 ben-hx. All rights reserved.
//

import UIKit

class DomainListViewController: UITableViewController, UIScrollViewDelegate, TableCellSearchHeaderDelegate {
    
    private struct Consts
    {
        static let CellReuseID = "CellReuseID"
        struct Sagues {
            static let Edit = "EditDomain"
            static let Create = "CreateDomain"
        }
    }
    
    let model = ModelFactory.getDomainRepository()
    var domainList: [Domain] = []
    var domainListUnfiltered: [Domain] = []
    
    private var searchHeader: TableCellSearchHeader?
    
    var showSearchHeader = false {
        didSet {
            if (!oldValue) {
                self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Top)
            }
        }
    }

    func updateDataSource(updateUI: Bool = true) {
        model.getAll().onSuccess{ domainList in
            self.domainList = domainList
            self.domainListUnfiltered = domainList
            if updateUI {
                self.tableView?.reloadData()
            }
        }
    }
    
    func tableCellSearchHeaderSearchTextDidChange(searchHeader: TableCellSearchHeader, searchText: String) {
        if (searchText == "") {
            domainList = domainListUnfiltered
        } else {
            domainList = domainListUnfiltered.filter({ (domain) -> Bool in
                let tmp: NSString = domain.name
                let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
                return range.location != NSNotFound
            })
        }
        self.tableView.reloadData()
        searchHeader.searchBar.becomeFirstResponder()
    }
    
    override func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        updateDataSource()
        showSearchHeader = true
    }
    
    override func viewDidLoad() {
        var nib: UINib
        nib = UINib(nibName: "ViewTableCellSearchHeader", bundle: nil)
        tableView.registerNib(nib, forHeaderFooterViewReuseIdentifier: ViewConsts.ReuseIdentifier.TableCellSearchHeader)
        searchHeader = tableView.dequeueReusableHeaderFooterViewWithIdentifier(ViewConsts.ReuseIdentifier.TableCellSearchHeader) as? TableCellSearchHeader
        searchHeader!.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateDataSource()
        if let frame = navigationController?.navigationBar.frame {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 70, height: frame.height))
            imageView.contentMode = .ScaleAspectFit
            let image = UIImage(named: "postyMobileLogo.png")
            imageView.image = image
            navigationItem.leftBarButtonItem?.customView = imageView
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.domainList.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(Consts.CellReuseID) as! UITableViewCell
        cell.textLabel?.text = self.domainList[indexPath.row].name
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            self.model.delete(self.domainList[indexPath.row].name).onSuccess{ result in
                self.updateDataSource(updateUI: true)
                //self.updateUI()
                //self.updateDataSource(updateUI: false)
                //self.domainList.removeObject(self.domainList[indexPath.row])
                //self.domainListUnfiltered.removeObject(self.domainList[indexPath.row])
                //self.domainList.removeAtIndex(indexPath.row)
                //tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            }
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (showSearchHeader) {
            return searchHeader!.bounds.height
        }
        return CGFloat(0.0)
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Domains"
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return searchHeader
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case Consts.Sagues.Create:
                if let destination = segue.destinationViewController as? DomainCreateController {
                    //destination.saveAction = DomainCreateEditViewController.SaveAction.Create
                }
                
            case Consts.Sagues.Edit:
                if let destination = segue.destinationViewController as? DomainEditController {
                    let indexPath = tableView.indexPathForSelectedRow()!
                    destination.domain = self.domainList[indexPath.row]
                }
            default: break
            }
        }
    }
}
