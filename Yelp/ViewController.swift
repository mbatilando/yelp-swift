//
//  ViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 9/19/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, FiltersViewDelegate {
    var client: YelpClient!
    var searchBar: UISearchBar!
    var restaurants: [Restaurant]
    var searchManager: SearchManager
    
    @IBOutlet weak var resultsTableView: UITableView!

    
    required init(coder aDecoder: NSCoder) {
        self.searchManager = SearchManager()
        self.restaurants = []
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.resultsTableView.dataSource = self
        self.resultsTableView.delegate = self
        self.resultsTableView.rowHeight = UITableViewAutomaticDimension;
        self.resultsTableView.estimatedRowHeight = 80;
        
        self.searchBar = UISearchBar()
        self.searchBar.searchBarStyle = UISearchBarStyle.Default
        self.navigationItem.titleView = searchBar
        searchBar.delegate = self

        self.searchBar.text = "Thai"
        self.searchManager.search(term: "Thai", onSuccess: { (restaurants) -> Void in
            self.restaurants = restaurants
            self.resultsTableView.reloadData()
        }) { () -> Void in}
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RestaurantCell") as RestaurantCell
        let restaurant = self.restaurants[indexPath.row]
        cell.restaurant = restaurant
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.restaurants.count
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchManager.search(term: searchBar.text, onSuccess: { (restaurants) -> Void in
            self.restaurants = restaurants
            self.resultsTableView.reloadData()
            self.searchBar.resignFirstResponder()
        }) { () -> Void in}
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController is UINavigationController {
            let nav = segue.destinationViewController as UINavigationController
            if nav.viewControllers[0] is FiltersViewController {
                let filtersViewController = nav.viewControllers[0] as FiltersViewController
                filtersViewController.delegate = self
                filtersViewController.filterManager = self.searchManager.filterManager
            }
            
        }
    }
    
    func filtersDidChange() {
        searchManager.search(term: self.searchBar.text, onSuccess: { (restaurants) -> Void in
            self.restaurants = restaurants
            self.resultsTableView.reloadData()
            }) { () -> Void in}
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offset = scrollView.contentOffset
        let bounds = scrollView.bounds
        let size = scrollView.contentSize
        let inset = scrollView.contentInset
        let y = offset.y + bounds.size.height - inset.bottom
        let h = size.height
        if y > h {
            loadMoreRows()
        }
    }
    
    private func loadMoreRows() {
        self.searchManager.offset = self.restaurants.count
        self.searchManager.search(term: self.searchBar.text, onSuccess: { (restaurants) -> Void in
            self.restaurants += restaurants
            self.resultsTableView.reloadData()
            }) { () -> Void in}
    }
    
}

