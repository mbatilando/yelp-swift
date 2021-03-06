//
//  SearchManager.swift
//  Yelp
//
//  Created by Mari Batilando on 2/12/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import Foundation
class SearchManager {
    
    var client: YelpClient
    var filterManager: FilterManager
    var offset: Int = 0
    let yelpConsumerKey = "DlBsYPjUKUE605DH45PWQQ"
    let yelpConsumerSecret = "cQlvZRMlfmJhTABcjCMTeRT6Ceg"
    let yelpToken = "MlVd2OpJvnVlszL8Wlk6q6lldu94lT-A"
    let yelpTokenSecret = "_8Zfs3B64WqA5nKqtxp_ta_n6cM"
    
    
    
    init() {
        self.client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        var foodFilters = [
            Filter(label: "Thai", value: "thai", active: false),
            Filter(label: "Greek", value: "greek", active: false),
            Filter(label: "Japanese", value: "japanese", active: false),
            Filter(label: "American", value: "newamerican", active: false),
            Filter(label: "Belgian", value: "belgian", active: false),
            Filter(label: "Burmese", value: "burmese", active: false),
            Filter(label: "Brazillian", value: "brazillian", active: false),
            Filter(label: "Bulgarian", value: "bulgarian", active: false),
            Filter(label: "Cafes", value: "cafes", active: false),
            Filter(label: "Hawaiian", value: "hawaiian", active: false),
            Filter(label: "Latin American", value: "latin", active: false)
        ]
        var foodCategory = FilterCategory(filterName: "category",label: "Food Category", filters: foodFilters, expanded: false)
        
        var bestDealFilter = Filter(label: "Best Deals", value: "true", active: false, bestDeal: true)
        var bestDealCategory = FilterCategory(filterName: "deals_filter", label: "Deals", filters: [bestDealFilter], expanded: false)
        
        var sortFilters = [
            Filter(label: "Best Match", value: "0", active: false, isFilterLabel: true),
            Filter(label: "Distance", value: "1", active: false, isFilterLabel: true),
            Filter(label: "Highest Rated", value: "2", active: false, isFilterLabel: true)
        ]
        var sortCategory = FilterCategory(filterName: "sort", label: "Sort", filters: sortFilters, expanded: false)
        
        var radiusFilters = [
            Filter(label: "5 mi", value: "8046.72", active: false, isRadiusFilter: true),
            Filter(label: "10 mi", value: "16093.4", active: false, isRadiusFilter: true),
            Filter(label: "15 mi", value: "24140.2", active: false, isRadiusFilter: true),
            Filter(label: "25 mi", value: "40233.6", active: true, isRadiusFilter: true),
            Filter(label: "50 mi", value: "80467.2", active: false, isRadiusFilter: true)
            
        ]
        var radiusCategory = FilterCategory(filterName: "radius_filter", label: "Radius", filters: radiusFilters, expanded: false)
        radiusCategory.selectedIndex = 3
        
        var categories = [bestDealCategory, foodCategory, sortCategory, radiusCategory]
        
        self.filterManager = FilterManager(filterCategories: categories)
    }
    
    func search(#term: String, onSuccess: (restaurants:[Restaurant]) -> Void, onFailure: () -> Void) {
        
        var catFilterValue = ""
        var sortFilterValue = ""
        var filterOptions = [String:String]()
        
        for filterCategory in self.filterManager.filterCategories {
            if !filterCategory.getSelectedOptions().isEmpty {
                filterOptions[filterCategory.filterName] = filterCategory.getSelectedOptions()
            }
        }
        
        if self.offset > 0 {
            filterOptions["offset"] = String(self.offset)
        }
        
        self.client.searchWithTerm(term: term, filterOptions: filterOptions,
            success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                var restaurants = (response["businesses"] as Array).map({
                    (data: NSDictionary) -> Restaurant in
                    return Restaurant(data: data)
                })
                onSuccess(restaurants: restaurants)
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                onFailure()
            }
    }
    
}