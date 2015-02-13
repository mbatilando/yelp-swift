//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Mari Batilando on 2/11/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FilterCellDelegate {
    var delegate: FiltersViewDelegate?
    var filterManager: FilterManager?
    
    @IBOutlet weak var filtersTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.filtersTable.delegate = self
        self.filtersTable.dataSource = self
        self.filtersTable.rowHeight = UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let filterCategory = self.filterManager?.filterCategories[indexPath.section]
        let filter = filterCategory?.filters[indexPath.row]
        let cell = self.filtersTable.dequeueReusableCellWithIdentifier("FilterCell") as FilterCell
        cell.filterNameLabel.text = filter?.label
        cell.filterSwitch.on = filter!.active
        
        cell.delegate = self
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let filterCategory = self.filterManager?.filterCategories[section]
        return filterCategory!.filters.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.filterManager?.filterCategories[section].label
    }
    
    func filterCellDidUpdateValue(filterCell: FilterCell, value: Bool) {
        if let indexPath = self.filtersTable.indexPathForCell(filterCell) {
            let filterCategory = self.filterManager?.filterCategories[indexPath.section]
            let filter = filterCategory?.filters[indexPath.row]
            filter?.active = value
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.filterManager!.filterCategories.count
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onSearch(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        delegate?.filtersDidChange()
    }
}
