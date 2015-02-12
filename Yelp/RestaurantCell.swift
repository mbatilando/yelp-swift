//
//  RestaurantCell.swift
//  Yelp
//
//  Created by Mari Batilando on 2/11/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class RestaurantCell: UITableViewCell {
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var restaurantAddressLabel: UILabel!
    @IBOutlet weak var restaurantDistanceLabel: UILabel!
    @IBOutlet weak var restaurantNumRatingsLabel: UILabel!
    @IBOutlet weak var restaurantCategoryLabel: UILabel!
    
    func setContents(#name: String, profileImageUrl: NSURL, ratingImageUrl: NSURL, address: String, numRatings: Int, categories: String) {
        self.restaurantNameLabel.text = name
        self.restaurantNumRatingsLabel.text = String(numRatings) +  " reviews"
        self.restaurantAddressLabel.text = address
        self.restaurantCategoryLabel.text = categories
        self.restaurantImage.layer.cornerRadius = 10.0
        self.restaurantImage.clipsToBounds = true
        self.restaurantImage.setImageWithURL(profileImageUrl)
        self.ratingImage.setImageWithURL(ratingImageUrl)
    }
}
