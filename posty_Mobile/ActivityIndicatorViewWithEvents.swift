//
//  ActivityIndicatorViewWithEvents.swift
//  posty_Mobile
//
//  Created by admin on 03.07.15.
//  Copyright (c) 2015 ben-hx. All rights reserved.
//

import UIKit

protocol ActivityIndicatorViewWithEventsDelegate {
    func didStartAnimating()
    func didStopAnimating()
}

class ActivityIndicatorViewWithEvents: UIActivityIndicatorView {
    
    var delegate: ActivityIndicatorViewWithEventsDelegate?
    
    override func startAnimating() {
        super.startAnimating()
        delegate?.didStartAnimating()
    }
    
    override func stopAnimating() {
        super.stopAnimating()
        delegate?.didStopAnimating()
    }
    
}