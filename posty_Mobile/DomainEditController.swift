//
//  DomainEditController.swift
//  posty_Mobile
//
//  Created by admin on 22.06.15.
//  Copyright (c) 2015 ben-hx. All rights reserved.
//

import UIKit
import BrightFutures

class DomainEditController: SaveableTableViewController, TableCellTextFieldAddButtonDelegate {
    
    private struct Consts
    {
        
        struct Sections {
            struct General {
                static let Id = 0
                static let HeaderTitle = "General"
            }
            struct User {
                static let Id = 1
                static let HeaderTitle = "Edit Users"
                static let HeaderAddCellReuseID = "UserHeaderAddCellReuseID"
            }
            struct Aliasse {
                static let Id = 2
                static let HeaderTitle = "Aliase"
                static let AddTextFieldPlaceHolder = "examplealias.com"
                static let HeaderAddCellReuseID = "AliasHeaderAddCellReuseID"
                static let CellReuseID = "AliasCellReuseID"
            }
        }
        struct Sagues {
            static let EditUsers = "EditUsers"
        }
    }
    
    var tfName: UITextField?
    var whileAliasCreating = false {
        didSet {
            self.tableView?.reloadSections(NSIndexSet(index: Consts.Sections.Aliasse.Id), withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    let domainRepo = ModelFactory.getDomainRepository()
    var aliasRepo: DomainAliasRepository?
    var domainAliasList: [DomainAlias] = []
    var domain: Domain? {
        didSet {
            aliasRepo = ModelFactory.getDomainAliasRepository(domain!)
            aliasRepo?.processDelegate = self
            updateUI()
        }
    }
    
    override func saveClicked(sender: UIBarButtonItem) {
        if (domain != nil && tfName != nil) {
            var oldName = domain!.name
            domain!.name = tfName!.text
            domainRepo.update(oldName, domain: domain!).onSuccess{ result in
                navigationController?.popViewControllerAnimated(true)
            }.onFailure() { error in
                self.presentAlert("Error while updating the Domain", message: error.localizedDescription)
                self.domain!.name = oldName
            }
        }
    }
    
    func updateUI() {
        aliasRepo?.getAll().onSuccess{ list in
            self.domainAliasList = list
            self.tableView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var nib: UINib
        nib = UINib(nibName: "ViewTableCellLabelTextfield", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: ViewConsts.ReuseIdentifier.TableCellLabelTextfield)
        nib = UINib(nibName: "ViewTableCellTextFieldAddButton", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: ViewConsts.ReuseIdentifier.TableCellTextFieldAddButton)
        self.domainRepo.processDelegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == Consts.Sections.General.Id)  {
            return Consts.Sections.General.HeaderTitle
        } else if (section == Consts.Sections.User.Id) {
            return Consts.Sections.User.HeaderTitle
        }
        return Consts.Sections.Aliasse.HeaderTitle
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (section == Consts.Sections.Aliasse.Id)  {
            var header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(Consts.Sections.Aliasse.HeaderAddCellReuseID) as? UITableViewHeaderFooterView
            if header == nil {
                header = UITableViewHeaderFooterView(reuseIdentifier: Consts.Sections.Aliasse.HeaderAddCellReuseID)
            }
            let button = UIButton.buttonWithType(UIButtonType.System) as! UIButton
            button.addTarget(self, action: "addAlias:", forControlEvents:.TouchUpInside)
            button.setTranslatesAutoresizingMaskIntoConstraints(false)
            button.setTitle("+", forState: .Normal)
            header?.contentView.addSubview(button)
            let trailingMargin = NSLayoutConstraint(item:button, attribute: NSLayoutAttribute.TrailingMargin, relatedBy: NSLayoutRelation.Equal,
                toItem: header?.contentView, attribute: NSLayoutAttribute.RightMargin, multiplier: 1, constant: 0 )
            header?.contentView.addConstraint(trailingMargin);
            let constY = NSLayoutConstraint(item:button, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: header?.contentView, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0 )
            header?.contentView.addConstraint(constY)
            return header
        } else if (section == Consts.Sections.User.Id)  {
            var header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(Consts.Sections.User.HeaderAddCellReuseID) as? UITableViewHeaderFooterView
            if header == nil {
                header = UITableViewHeaderFooterView(reuseIdentifier: Consts.Sections.User.HeaderAddCellReuseID)
            }
            let button = UIButton.buttonWithType(UIButtonType.System) as! UIButton
            button.addTarget(self, action: "editUsers:", forControlEvents:.TouchUpInside)
            button.setTranslatesAutoresizingMaskIntoConstraints(false)
            button.setTitle(">", forState: .Normal)
            header?.contentView.addSubview(button)
            let trailingMargin = NSLayoutConstraint(item:button, attribute: NSLayoutAttribute.TrailingMargin, relatedBy: NSLayoutRelation.Equal,
                toItem: header?.contentView, attribute: NSLayoutAttribute.RightMargin, multiplier: 1, constant: 0 )
            header?.contentView.addConstraint(trailingMargin);
            let constY = NSLayoutConstraint(item:button, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: header?.contentView, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0 )
            header?.contentView.addConstraint(constY)           
            return header
        }
        return super.tableView(tableView, viewForHeaderInSection: section)
    }
    
    
    func handleTap(sender: UITapGestureRecognizer? = nil) {
       print("hllo")
    }
    
    func addAlias(sender: UIButton) {
        whileAliasCreating = !whileAliasCreating
    }
    
    func editUsers(sender: UIButton) {
        performSegueWithIdentifier(Consts.Sagues.EditUsers, sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case Consts.Sagues.EditUsers:
                if let destination = segue.destinationViewController as? DomainUserListController {
                    destination.domain = self.domain
                }
            default: break
            }
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == Consts.Sections.General.Id)  {
            return 1
        } else if (section == Consts.Sections.User.Id) {
            return 0
        } else if (section == Consts.Sections.Aliasse.Id)  {
            if (whileAliasCreating) {
                return self.domainAliasList.count+1
            }
            return self.domainAliasList.count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        var allowedSection = indexPath.section == Consts.Sections.Aliasse.Id
        var allowedRows = whileAliasCreating && indexPath.row > 0 || !whileAliasCreating
        return allowedSection && allowedRows
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.section == Consts.Sections.Aliasse.Id)  {
            if editingStyle == UITableViewCellEditingStyle.Delete {
                var rowDecrementor = (whileAliasCreating) ? 1 : 0;
                self.aliasRepo?.delete(self.domainAliasList[indexPath.row-rowDecrementor].name).onSuccess{ result in
                    self.domainAliasList.removeAtIndex(indexPath.row-rowDecrementor)
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                }.onFailure() { error in
                    self.presentAlert("Error while deleting the Domain-Alias", message: error.localizedDescription)
                }
            }
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.section == Consts.Sections.General.Id)  {
            var cell = tableView.dequeueReusableCellWithIdentifier(ViewConsts.ReuseIdentifier.TableCellLabelTextfield) as! TableCellLabelTextfield
            cell.label.text = "Name:"
            cell.textField.text = self.domain!.name
            tfName = cell.textField
            return cell
        }
        else if (indexPath.section == Consts.Sections.Aliasse.Id)  {
            var rowDecrementor = (whileAliasCreating) ? 1 : 0;
            if (whileAliasCreating && indexPath.row == 0) {
                var cell = tableView.dequeueReusableCellWithIdentifier(ViewConsts.ReuseIdentifier.TableCellTextFieldAddButton) as! TableCellTextFieldAddButton
                cell.delegate = self
                cell.textField.placeholder = Consts.Sections.Aliasse.AddTextFieldPlaceHolder
                return cell
            }
            var cell = tableView.dequeueReusableCellWithIdentifier(Consts.Sections.Aliasse.CellReuseID) as! UITableViewCell
            cell.textLabel?.text = self.domainAliasList[indexPath.row-rowDecrementor].name
            return cell
        }
        return super.tableView(tableView, cellForRowAtIndexPath: indexPath)
    }
    
    //MARK: UITableCellTextFieldButtonDelegate
    
    func tableCellTextFieldAddButtonDidClickButton(cell: TableCellTextFieldAddButton, sender: UIButton, textField: UITextField) {
        aliasRepo?.create(DomainAlias(name: textField.text)!).onSuccess{ result in
            self.whileAliasCreating = false
            textField.text = ""
            self.updateUI()
        }.onFailure() { error in
            self.presentAlert("Error while creating the Domain-Alias", message: error.localizedDescription)
        }
    }

}