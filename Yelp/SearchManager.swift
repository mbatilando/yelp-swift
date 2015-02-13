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
    let yelpConsumerKey = "DlBsYPjUKUE605DH45PWQQ"
    let yelpConsumerSecret = "cQlvZRMlfmJhTABcjCMTeRT6Ceg"
    let yelpToken = "MlVd2OpJvnVlszL8Wlk6q6lldu94lT-A"
    let yelpTokenSecret = "_8Zfs3B64WqA5nKqtxp_ta_n6cM"
    
    
    
    init() {
        self.client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        var foodFilters = [
            Filter(label: "Thai", value: "thai", active: false),
            Filter(label: "Greek", value: "greek", active: false),
            Filter(label: "Japanese", value: "japanese", active: false)
        ]
        var foodCategory = FilterCategory(label: "Food Category", filters: foodFilters, expanded: false)
        
        var bestDealFilter = Filter(label: "Best Deals", value: "best_deal", active: false, bestDeal: true)
        var bestDealCategory = FilterCategory(label: "Deals", filters: [bestDealFilter], expanded: false)
        
        var sortFilters = [
            Filter(label: "Best Match", value: "0", active: false, isFilterLabel: true),
            Filter(label: "Distance", value: "1", active: false, isFilterLabel: true),
            Filter(label: "Highest Rated", value: "2", active: false, isFilterLabel: true)
        ]
        var sortCategory = FilterCategory(label: "Sort", filters: sortFilters, expanded: false)
        
        var radiusFilters = [
            Filter(label: "5 mi", value: "5", active: false, isRadiusFilter: true),
            Filter(label: "10 mi", value: "10", active: false, isRadiusFilter: true),
            Filter(label: "15 mi", value: "15", active: false, isRadiusFilter: true)
        ]
        var radiusCategory = FilterCategory(label: "Radius", filters: radiusFilters, expanded: false)
        
        var categories = [foodCategory, bestDealCategory, sortCategory, radiusCategory]
        
        self.filterManager = FilterManager(filterCategories: categories)
    }
    
    func search(term: String, onSuccess: (restaurants:[Restaurant]) -> Void, onFailure: () -> Void) {
        self.client.searchWithTerm(term,
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