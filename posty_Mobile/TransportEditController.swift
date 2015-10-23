//
//  TransportEditController.swift
//  posty_Mobile
//
//  Created by admin on 22.06.15.
//  Copyright (c) 2015 ben-hx. All rights reserved.
//

import UIKit
import BrightFutures

class TransportEditController: SaveableViewController {
    
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
        if (transport != nil && tfName != nil) {
            var oldName = transport!.name
            var oldDestination = transport!.destination
            transport!.name = tfName!.text
            transport?.destination = tfDestination!.text
            repo.update(oldName, tansport: transport!).onSuccess{ result in
                navigationController?.popViewControllerAnimated(true)
                }.onFailure() { error in
                    self.presentAlert("Error while updating the Transport", message: error.localizedDescription)
                    self.transport!.name = oldName
                    self.transport!.name = oldDestination
            }
        }
    }
    
}