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
    
    var restaurant: Restaurant {
        get {
            return self.restaurant
        }
        set (data) {
            self.restaurantNameLabel.text = data.name
            self.restaurantNumRatingsLabel.text = String(data.reviewCount) +  " reviews"
            self.restaurantAddressLabel.text = data.address
            self.restaurantCategoryLabel.text = data.category
            self.restaurantImage.layer.cornerRadius = 10.0
            self.restaurantImage.clipsToBounds = true
            self.restaurantImage.setImageWithURL(data.profileImageUrl)
            self.ratingImage.setImageWithURL(data.ratingImageUrl)
        }
    }
    
    override init() {
        super.init()
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
