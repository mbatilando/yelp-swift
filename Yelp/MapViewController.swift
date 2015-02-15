//
//  MapViewController.swift
//  Yelp
//
//  Created by Mari Batilando on 2/14/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import Foundation
import MapKit
class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var restaurants: [Restaurant] = []
    var searchTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = self.searchTitle

        let location = CLLocationCoordinate2D(
            latitude: 37.764384,
            longitude: -122.440902
        )
        let span = MKCoordinateSpanMake(0.15, 0.15)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        for restaurant in self.restaurants {
            let annotation = MKPointAnnotation()
            let restaurantLocObj = restaurant.location!["coordinate"] as NSDictionary
            let restaurantLat = restaurantLocObj["latitude"] as Double
            let restaurantLong = restaurantLocObj["longitude"] as Double
            let restaurantLoc = CLLocationCoordinate2D(latitude: restaurantLat, longitude: restaurantLong)
            annotation.setCoordinate(restaurantLoc)
            annotation.title = restaurant.name
            mapView.addAnnotation(annotation)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onList(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}