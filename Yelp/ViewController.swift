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
    
    @IBOutlet weak var resultsTableView: UITableView!
    // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
    let yelpConsumerKey = "DlBsYPjUKUE605DH45PWQQ"
    let yelpConsumerSecret = "cQlvZRMlfmJhTABcjCMTeRT6Ceg"
    let yelpToken = "MlVd2OpJvnVlszL8Wlk6q6lldu94lT-A"
    let yelpTokenSecret = "_8Zfs3B64WqA5nKqtxp_ta_n6cM"
    var restaurants: [Restaurant]?
    
    required init(coder aDecoder: NSCoder) {
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
        
        // Do any additional setup after loading the view, typically from a nib.
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        search("Thai")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        search(searchBar.text)
        self.searchBar.resignFirstResponder()
    }
    
    func search(query: String) {
        client.searchWithTerm(query, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            println(response);
            self.restaurants = (response["businesses"] as Array).map({
                (data: NSDictionary) -> Restaurant in
                return Restaurant(data: data)
            })
            self.resultsTableView.reloadData()
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if sender?.destinationViewController is 
    }
    
//    func onFilterButton() {
//        let filtersVc = FiltersViewController()
//        let navigationController = UINavigationController(rootViewController: filtersVc)
//        presentViewController(filtersVc, animated: true, completion: nil)
//        
//    }
    
    
}

