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
    var bestDeal: Bool?
    var isFilterLabel: Bool = false

    init(label: String, value: String, active:Bool = false) {
        self.label = label
        self.value = value
        self.active = active
        self.bestDeal = false
        self.isFilterLabel = false
    }
    
    init(label: String, value: String, active:Bool = false, bestDeal: Bool) {
        self.label = label
        self.value = value
        self.active = active
        self.bestDeal = bestDeal
        self.isFilterLabel = false
    }
    
    init(label: String, value: String, active:Bool = false, isFilterLabel: Bool) {
        self.label = label
        self.value = value
        self.active = active
        self.bestDeal = false
        self.isFilterLabel = isFilterLabel
    }
}
