//
//  TableCellSearchHeader.swift
//  posty_Mobile
//
//  Created by admin on 26.06.15.
//  Copyright (c) 2015 ben-hx. All rights reserved.
//

import UIKit

protocol TableCellSearchHeaderDelegate {
    func tableCellSearchHeaderSearchTextDidChange(searchHeader: TableCellSearchHeader, searchText: String)
}

class TableCellSearchHeader: UITableViewHeaderFooterView, UISearchBarDelegate {
    private struct Consts {
        static let SearchTimeDelayInSecs = 0.2
    }
    
    var delegate: TableCellSearchHeaderDelegate?
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    private var timesUntilSearch = 0
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        timesUntilSearch++
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(Consts.SearchTimeDelayInSecs * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.timesUntilSearch--
            if (self.timesUntilSearch == 0) {
                self.delegate?.tableCellSearchHeaderSearchTextDidChange(self, searchText: searchText)
            }
        }
    }
    

}
