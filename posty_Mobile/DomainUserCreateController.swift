//
//  DomainUserCreateController.swift
//  posty_Mobile
//
//  Created by admin on 03.07.15.
//  Copyright (c) 2015 ben-hx. All rights reserved.
//

import UIKit

class DomainUserCreateController: SaveableViewController {
    
    var domain: Domain? {
        didSet {
            repo = ModelFactory.getDomainUserRepository(domain!)
            updateUI()
        }
    }
    var repo: DomainUserRepository?
    
    @IBOutlet weak var lDomain: UILabel!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfConfirmPassword: UITextField!
    @IBOutlet weak var tfQuota: UITextField!
    @IBOutlet weak var sQuota: UIStepper! {
        didSet {
            sQuota.autorepeat = true
            sQuota.minimumValue = 0.0
            sQuota.value = 0.0
        }
    }
    
    @IBAction func sQuotaValueChanged(sender: UIStepper) {
        self.tfQuota.text = sender.value.description
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        repo?.processDelegate = self
        updateUI()
    }
    
    private func updateUI() {
        lDomain?.text = "@"+domain!.name
    }
    
    private func passwordIsOk() -> Bool {
        let notEmpty = tfPassword.text != "" && tfConfirmPassword.text != ""
        let equal = tfPassword.text == tfConfirmPassword.text
        return notEmpty && equal
    }
    
    override func saveClicked(sender: UIBarButtonItem) {
        if !passwordIsOk() {
            self.presentAlert("Password", message: "Please confirm the right password!")
            tfConfirmPassword.becomeFirstResponder()
            return
        }
        let user = DomainUser(name: tfName.text, password: tfPassword.text, quota: NSString(string: tfQuota.text).doubleValue)
        repo!.create(user!).onSuccess{ result in
            navigationController?.popViewControllerAnimated(true)
        }.onFailure() { error in
                self.presentAlert("Error while creating the User", message: error.localizedDescription)
        }
    }
    
}
