//
//  APIKeyEditController.swift
//  posty_Mobile
//
//  Created by admin on 08.06.15.
//  Copyright (c) 2015 ben-hx. All rights reserved.
//

import UIKit

class APIKeyEditController: SaveableViewController {
    
    var apiKey: APIKey? {
        didSet {
            updateUI()
        }
    }
    
    let repo = ModelFactory.getAPIKeyRepository()
    
    @IBOutlet weak var tfToken: UITextField!
    @IBOutlet weak var swActive: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repo.processDelegate = self
        updateUI()
    }
    
    private func updateUI() {
        tfToken?.text = apiKey?.token
        let isActive = apiKey?.active
        if (isActive != nil) {
            swActive?.setOn(isActive!, animated: true)
        }
    }
    
    override func saveClicked(sender: UIBarButtonItem) {
        if (apiKey != nil && tfToken != nil) {
            var oldToken = apiKey!.token
            var oldActice = apiKey!.active
            apiKey!.token = tfToken!.text
            apiKey!.active = swActive.on
            println(swActive.on)
            repo.update(oldToken, apiKey: apiKey!).onSuccess{ result in
                navigationController?.popViewControllerAnimated(true)
                }.onFailure() { error in
                    self.presentAlert("Error while updating the API-Key", message: error.localizedDescription)
                    self.apiKey!.token = oldToken
                    self.apiKey!.active = oldActice
            }
        }
    }
    
}