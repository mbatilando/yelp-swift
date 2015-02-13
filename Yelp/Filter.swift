//
//  Filter.swift
//  Yelp
//
//  Created by Mari Batilando on 2/12/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import Foundation
class Filter {
    var label: String
    var value: String
    var active: Bool
    var bestDeal: Bool
    var isFilterLabel: Bool

    init(label: String, value: String, active: Bool) {
        self.label = label
        self.value = value
        self.active = active
        self.bestDeal = false
        self.isFilterLabel = false
    }
    
    init(label: String, value: String, active: Bool, bestDeal: Bool) {
        self.label = label
        self.value = value
        self.active = active
        self.bestDeal = bestDeal
        self.isFilterLabel = false
    }
    
    init(label: String, value: String, active: Bool, isFilterLabel: Bool) {
        self.label = label
        self.value = value
        self.active = active
        self.bestDeal = false
        self.isFilterLabel = isFilterLabel
    }
}
