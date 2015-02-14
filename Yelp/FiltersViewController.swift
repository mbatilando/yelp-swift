//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Mari Batilando on 2/11/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FilterSwitchCellDelegate {
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
        
        if (filter!.isFilterLabel) {
            let cell = self.filtersTable.dequeueReusableCellWithIdentifier("FilterLabelCell") as FilterLabelCell
            cell.filterLabel.text = filter?.label
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            if filter!.active {
                cell.accessoryView = UIImageView(image: UIImage(named: "check"))
            } else {
                cell.accessoryView = nil
            }
            return cell
        } else {
            let cell = self.filtersTable.dequeueReusableCellWithIdentifier("FilterSwitchCell") as FilterSwitchCell
            cell.filterNameLabel.text = filter?.label
            cell.filterSwitch.on = filter!.active
            cell.delegate = self
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell

        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let filterCategory = self.filterManager?.filterCategories[section]
        return filterCategory!.filters.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.filterManager?.filterCategories[section].label
    }
    
    func filterCellDidUpdateValue(filterCell: FilterSwitchCell, value: Bool) {
        if let indexPath = self.filtersTable.indexPathForCell(filterCell) {
            let filterCategory = self.filterManager?.filterCategories[indexPath.section]
            let filter = filterCategory?.filters[indexPath.row]
            filter?.active = value
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let filterCategory = self.filterManager?.filterCategories[indexPath.section]
        let filter = filterCategory!.filters[indexPath.row]
        if filter.isFilterLabel {
            // Unselect previously selected filter
            for filter in filterCategory!.filters {
                if filter.active {
                    filter.active = false
                    break
                }
            }
            filter.active = !filter.active
            self.filtersTable.reloadSections(NSMutableIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.None)
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
