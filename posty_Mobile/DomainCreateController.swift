//
//  DomainCreateEditViewController.swift
//  posty_Mobile
//
//  Created by admin on 08.06.15.
//  Copyright (c) 2015 ben-hx. All rights reserved.
//

import UIKit

class DomainCreateController: UIViewController {
    
    var domain: Domain? {
        didSet {
            updateUI()
        }
    }
    
    let manager = ModelFactory.getDomainRepository()
    
    private func updateUI() {
        tfName?.text = domain?.name
    }
    
    override func viewDidLoad() {
        updateUI()
    }
    
    @IBOutlet weak var tfName: UITextField!
    
    @IBAction func save(sender: AnyObject) {
        manager.create(Domain(name: tfName.text)!).onSuccess{ result in
            navigationController?.popViewControllerAnimated(true)
        }.onFailure() { error in
            self.presentAlert("Error while creating the Domain", message: error.localizedDescription)
        }
    }
    
}
