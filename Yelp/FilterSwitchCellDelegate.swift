//
//  FilterCellDelegate.swift
//  Yelp
//
//  Created by Mari Batilando on 2/12/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import Foundation
protocol FilterSwitchCellDelegate {
    func filterCellDidUpdateValue(filterCell: FilterSwitchCell, value: Bool)
}