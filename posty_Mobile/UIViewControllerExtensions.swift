//
//  UIViewControllerExtensions.swift
//  posty_Mobile
//
//  Created by admin on 22.06.15.
//  Copyright (c) 2015 ben-hx. All rights reserved.
//

import UIKit

extension UIViewController {
    
    private struct Consts
    {
        static let PostyLogoImage = "postyMobileLogo.png"
    }

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
    
    func getPostyBarButtonItem(navBar: UINavigationBar) -> UIBarButtonItem {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 70, height: navBar.frame.height))
        imageView.contentMode = .ScaleAspectFit
        imageView.image = UIImage(named: Consts.PostyLogoImage)
        return  UIBarButtonItem(customView: imageView)
    }
    
    func getActivityIndicatorView() ->  ActivityIndicatorViewWithEvents {
        let indicator = ActivityIndicatorViewWithEvents(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        indicator.color = UIColor.postyColor()
        indicator.frame = CGRectMake(0.0, 0.0, 10.0, 10.0)
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        indicator.bringSubviewToFront(self.view)
        return indicator
    }

}