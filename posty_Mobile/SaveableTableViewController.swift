//
//  SaveableTableViewController.swift
//  posty_Mobile
//
//  Created by admin on 03.07.15.
//  Copyright (c) 2015 ben-hx. All rights reserved.
//

import UIKit

class SaveableTableViewController: UITableViewController, ActivityIndicatorViewWithEventsDelegate, Processable {
    
    var loadingIndicator:  ActivityIndicatorViewWithEvents?
    var saveBarButtonItem: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.saveBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self, action: "saveClicked:")
        self.navigationItem.setRightBarButtonItem(saveBarButtonItem, animated: true)
        self.loadingIndicator = getActivityIndicatorView()
        self.loadingIndicator?.delegate = self
    }
    
    func didStartAnimating() {
        saveBarButtonItem?.enabled = false
    }
    
    func didStopAnimating() {
        saveBarButtonItem?.enabled = true
    }
    
    func beginProcess() {
        self.loadingIndicator?.startAnimating()
    }
    
    func endProcess() {
        self.loadingIndicator?.stopAnimating()
    }
    
    func saveClicked(sender: UIBarButtonItem) {
    }
}