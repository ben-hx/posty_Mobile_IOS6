//
//  UIViewControllerExtensions.swift
//  posty_Mobile
//
//  Created by admin on 22.06.15.
//  Copyright (c) 2015 ben-hx. All rights reserved.
//

import UIKit

extension UIViewController {

    func presentAlert(title: String, message: String, completion: (() -> Void)? = nil) -> Void {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertControllerStyle.Alert
        )
        var action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (_) -> Void in
            completion?()
        })
        alertController.addAction(action)
        self.presentViewController(alertController, animated: true, completion: nil)
    }

}