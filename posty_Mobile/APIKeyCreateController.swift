//
//  APIKeyCreateController.swift
//  posty_Mobile
//
//  Created by admin on 08.06.15.
//  Copyright (c) 2015 ben-hx. All rights reserved.
//

import UIKit

class APIKeyCreateController: SaveableViewController {
    
    var apiKey: APIKey? {
        didSet {
            updateUI()
        }
    }
    
    let repo = ModelFactory.getAPIKeyRepository()
    
    @IBOutlet weak var tfToken: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repo.processDelegate = self
        updateUI()
    }
    
    private func updateUI() {
        tfToken?.text = apiKey?.token
    }
    
    override func saveClicked(sender: UIBarButtonItem) {
        repo.create(APIKey(token: tfToken.text)!).onSuccess{ result in
            navigationController?.popViewControllerAnimated(true)
            }.onFailure() { error in
                self.presentAlert("Error while creating the API-Key", message: error.localizedDescription)
        }
    }
    
}