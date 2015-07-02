//
//  TableViewListDataSource.swift
//  posty_Mobile
//
//  Created by admin on 28.06.15.
//  Copyright (c) 2015 ben-hx. All rights reserved.
//
protocol SearchtextFiltable {
    func filter(searchText: String) -> Bool
}

class FilterableList<T : protocol<Equatable, SearchtextFiltable>> {

    private var list: [T] = []
    private var listFiltered: [T] = []
    private var searchText = ""
    
    func reload(newList: [T]) {
        self.list = newList
        if searchText != "" {
            self.listFiltered = list.filter({ (value) -> Bool in
                return value.filter(self.searchText)
            })
        } else {
            self.listFiltered.removeAll(keepCapacity: true)
            for value in self.list {
                self.listFiltered.append(value)
            }
        }
    }
    
    func getAtIndex(index: Int) -> T? {
        return self.listFiltered[index]
    }
    
    private func removeAtIndex(var values: [T], value: T) {
        for var index = 0; index < values.count; ++index {
            if value == values[index] {
                values.removeAtIndex(index)
            }
        }
    }
    
    func remove(value: T) {
        for var index = 0; index < list.count; ++index {
            if value == list[index] {
                list.removeAtIndex(index)
            }
        }
        reload(list)
    }
    
    func search(searchText: String) {
        self.searchText = searchText
        self.reload(list)
    }
    
    func count() -> Int {
        return listFiltered.count
    }

}
