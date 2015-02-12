//
//  ViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 9/19/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    var client: YelpClient!
    var searchBar: UISearchBar!
    var restaurants: [Restaurant]?
    var searchManager: SearchManager
    
    @IBOutlet weak var resultsTableView: UITableView!

    
    required init(coder aDecoder: NSCoder) {
        self.searchManager = SearchManager()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.resultsTableView.dataSource = self
        self.resultsTableView.delegate = self
        self.resultsTableView.rowHeight = UITableViewAutomaticDimension;
        self.resultsTableView.estimatedRowHeight = 85;
        
        self.searchBar = UISearchBar()
        self.navigationItem.titleView = searchBar
        searchBar.delegate = self

        searchManager.search("Food", onSuccess: { (restaurants) -> Void in
            self.restaurants = restaurants
            self.resultsTableView.reloadData()
        }) { () -> Void in}
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RestaurantCell") as RestaurantCell
        let restaurant = self.restaurants![indexPath.row]
        
        cell.restaurantNameLabel.text = restaurant.name
        cell.restaurantNumRatingsLabel.text = String(restaurant.reviewCount) +  " reviews"
        cell.restaurantAddressLabel.text = restaurant.address
        cell.restaurantCategoryLabel.text = restaurant.category
        cell.restaurantImage.layer.cornerRadius = 10.0
        cell.restaurantImage.clipsToBounds = true
        cell.restaurantImage.setImageWithURL(restaurant.profileImageUrl)
        cell.ratingImage.setImageWithURL(restaurant.ratingImageUrl)
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.restaurants != nil {
            return self.restaurants!.count
        }
        return 0
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchManager.search(searchBar.text, onSuccess: { (restaurants) -> Void in
            self.restaurants = restaurants
            self.resultsTableView.reloadData()
            self.searchBar.resignFirstResponder()
        }) { () -> Void in}
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
    
}

