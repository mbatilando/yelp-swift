//
//  Restaurant.swift
//  Yelp
//
//  Created by Mari Batilando on 2/11/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit
class Restaurant {
    let name: String
    let profileImageUrl: NSURL
    let ratingImageUrl: NSURL
    let reviewCount: Int
    let location: NSDictionary?
    let category: String
    let region: NSDictionary?
    
    init(data: NSDictionary) {
        self.name = data["name"] as String
        
        let restaurantImgStr = data["image_url"] as NSString
        self.profileImageUrl = NSURL(string: restaurantImgStr)!
        
        let ratingImgStr = data["rating_img_url"] as NSString
        self.ratingImageUrl = NSURL(string: ratingImgStr)!
        
        let numRatings = data["review_count"] as Int
        self.reviewCount = numRatings
        
//        let location = data["location"] as NSDictionary
//        let streetObj = location["address"] as NSArray
//        self.location = streetObj[0] as String
        
        self.location = data["location"] as NSDictionary
        
        let categoriesObj = data["categories"] as NSArray
        let categoriesObj2 = categoriesObj[0] as NSArray
        self.category = categoriesObj2[0] as String
    }
    
    var address: String {
        get {
            if let location = self.location {
                if let address = location["address"] {
                    if let neighborhood = location["neighborhoods"] {
                        return (address[0] as String) + " " + (neighborhood[0] as String)
                    }
                }
            }
            return ""
        }
    }
}
