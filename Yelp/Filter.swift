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

    init(label: String, value: String, active:Bool = false) {
        self.label = label
        self.value = value
        self.active = active
    }
}
