//
//  APIAuthenticateController.swift
//  posty_Mobile
//
//  Created by admin on 08.06.15.
//  Copyright (c) 2015 ben-hx. All rights reserved.
//

import UIKit

class APIAuthenticateController: SaveableViewController {
    
    private struct Consts
    {
        struct Sagues {
            static let AuthenticationOk = "AuthenticationOk"
        }
    }

    let repo = ModelFactory.getAPIRepository()
    
    @IBOutlet weak var tfCaption: UITextField!
    @IBOutlet weak var tfURL: UITextField!
    @IBOutlet weak var tfKey: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repo.processDelegate = self
    }
    
    @IBAction func authenticateClicked(sender: UIButton) {
        let apiConnection = API(caption: tfCaption.text, url: tfURL.text, authKey: tfKey.text)
        repo.setCurrentAPI(apiConnection)
        repo.checkConnection(apiConnection).onSuccess{ result in
            if (result) {
                self.performSegueWithIdentifier(Consts.Sagues.AuthenticationOk, sender: sender)
            } else {
               self.hostUnreachable("")
            }
            }.onFailure() { error in
                self.hostUnreachable(error.localizedDescription)
        }
    }
    
    func hostUnreachable(message: String) {
        presentAlert("Host is unreachable, please check your authentication!", message: message)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case Consts.Sagues.AuthenticationOk:
                if let destination = segue.destinationViewController as? UITabBarController {
                }
            default: break
            }
        }
    }

}