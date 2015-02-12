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
    var restaurants: NSArray?
    
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
        let business = self.restaurants![indexPath.row] as NSDictionary
        let name = business["name"] as NSString
        cell.restaurantNameLabel.text = "\(indexPath.row+1). \(name)"
        
        let location = business["location"] as NSDictionary
        let streetObj = location["address"] as NSArray
        cell.restaurantAddressLabel.text = streetObj[0] as NSString
        let numRatings = business["review_count"] as Int
        cell.restaurantNumRatingsLabel.text = String(numRatings) + " reviews"
        
        let categoriesObj = business["categories"] as NSArray
        let categoriesObj2 = categoriesObj[0] as NSArray
        let category = categoriesObj2[0] as NSString
        cell.restaurantCategoryLabel.text = category
        
        let restaurantImgStr = business["image_url"] as NSString
        let restaurantImgUrl = NSURL(string: restaurantImgStr)
        cell.restaurantImage.setImageWithURL(restaurantImgUrl)
        cell.restaurantImage.layer.cornerRadius = 10.0
        cell.restaurantImage.clipsToBounds = true
        
        let ratingImgStr = business["rating_img_url"] as NSString
        let ratingImgUrl = NSURL(string: ratingImgStr)
        cell.ratingImage.setImageWithURL(ratingImgUrl)
        
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
            self.restaurants = response["businesses"] as NSArray
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

