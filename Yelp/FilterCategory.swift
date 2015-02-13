//
//  FilterCategory.swift
//  Yelp
//
//  Created by Mari Batilando on 2/12/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import Foundation
class FilterCategory {
    var filters: [Filter]
    var label: String
    var expanded: Bool
    var filterName: String
    
    init (filterName: String, label: String, filters: [Filter], expanded: Bool = false) {
        self.label = label
        self.filters = filters
        self.expanded = expanded
        self.filterName = filterName
    }
    
    func getSelectedOptions() -> String {
        var options = [String]()
        for filter in self.filters {
            if filter.active {
                options.append(filter.value)
            }
        }
        return ",".join(options)
    }
}