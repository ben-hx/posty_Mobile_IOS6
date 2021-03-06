//
//  DomainCreateEditViewController.swift
//  posty_Mobile
//
//  Created by admin on 08.06.15.
//  Copyright (c) 2015 ben-hx. All rights reserved.
//

import UIKit

class DomainCreateController: SaveableViewController {
    
    var domain: Domain? {
        didSet {
            updateUI()
        }
    }
    
    let repo = ModelFactory.getDomainRepository()
    
    @IBOutlet weak var tfName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repo.processDelegate = self
        updateUI()
    }
    
    private func updateUI() {
        tfName?.text = domain?.name
    }
    
    override func saveClicked(sender: UIBarButtonItem) {
        repo.create(Domain(name: tfName.text)!).onSuccess{ result in
            navigationController?.popViewControllerAnimated(true)
        }.onFailure() { error in
           self.presentAlert("Error while creating the Domain", message: error.localizedDescription)
        }
    }
    
}
