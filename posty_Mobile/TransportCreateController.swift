//
//  TransportCreateController.swift
//  posty_Mobile
//
//  Created by admin on 08.06.15.
//  Copyright (c) 2015 ben-hx. All rights reserved.
//

import UIKit

class TransportCreateController: SaveableViewController {
    
    var transport: Transport? {
        didSet {
            updateUI()
        }
    }
    
    let repo = ModelFactory.getTransportRepository()
    
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfDestination: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repo.processDelegate = self
        updateUI()
    }
    
    private func updateUI() {
        tfName?.text = transport?.name
        tfDestination?.text = transport?.destination
    }
    
    override func saveClicked(sender: UIBarButtonItem) {
        repo.create(Transport(name: tfName.text, destination: tfDestination.text)!).onSuccess{ result in
            navigationController?.popViewControllerAnimated(true)
            }.onFailure() { error in
                self.presentAlert("Error while creating the Transport", message: error.localizedDescription)
        }
    }
    
}
