//
//  Restaurant.swift
//  Yelp
//
//  Created by Mari Batilando on 2/11/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit
class Restaurant {
    var name: String
    var profileImageUrl: NSURL
    var ratingImageUrl: NSURL
    var reviewCount: Int
    var location: String
    var category: String
    var region: NSDictionary?
    
    init(data: NSDictionary) {
        self.name = data["name"] as String
        
        let restaurantImgStr = data["image_url"] as NSString
        self.profileImageUrl = NSURL(string: restaurantImgStr)!
        
        let ratingImgStr = data["rating_img_url"] as NSString
        self.ratingImageUrl = NSURL(string: ratingImgStr)!
        
        let numRatings = data["review_count"] as Int
        self.reviewCount = numRatings
        
        let location = data["location"] as NSDictionary
        let streetObj = location["address"] as NSArray
        self.location = streetObj[0] as String
        
        let categoriesObj = data["categories"] as NSArray
        let categoriesObj2 = categoriesObj[0] as NSArray
        self.category = categoriesObj2[0] as String
    }
}
