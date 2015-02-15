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
    
    func foodCategoryCellForRow(#tableView: UITableView, indexPath: NSIndexPath) -> UITableViewCell {
        let filterCategory = self.filterManager?.filterCategories[indexPath.section]

        if filterCategory!.expanded && indexPath.row == filterCategory!.filters.count {
            let cell = self.filtersTable.dequeueReusableCellWithIdentifier("SeeLessCell") as UITableViewCell
            return cell
        } else if !filterCategory!.expanded && indexPath.row == 3 {
            let cell = self.filtersTable.dequeueReusableCellWithIdentifier("SeeMoreCell") as UITableViewCell
            return cell
        }
        let filter = filterCategory?.filters[indexPath.row]
        let cell = self.filtersTable.dequeueReusableCellWithIdentifier("FilterSwitchCell") as FilterSwitchCell
        cell.filterNameLabel.text = filter?.label
        cell.filterSwitch.on = filter!.active
        cell.delegate = self
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell

    }
    
    func radiusCategoryCellForRow(#tableView: UITableView, indexPath: NSIndexPath) -> UITableViewCell {
        let filterCategory = self.filterManager?.filterCategories[indexPath.section]
        if !filterCategory!.expanded {
            let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "NormalCell")
            let selectedFilter = filterCategory!.filters[filterCategory!.selectedIndex!]
            cell.textLabel?.text = selectedFilter.label
            cell.accessoryView = UIImageView(image: UIImage(named: "expand"))
            return cell
        } else {
            let filter = filterCategory?.filters[indexPath.row]
            let cell = self.filtersTable.dequeueReusableCellWithIdentifier("FilterLabelCell") as FilterLabelCell
            cell.filterLabel.text = filter?.label
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            if filter!.active {
                cell.accessoryView = UIImageView(image: UIImage(named: "check"))
            } else {
                cell.accessoryView = nil
            }
            return cell
        }
    }
    
    func sortCategoryCellForRow(#tableView: UITableView, indexPath: NSIndexPath) -> UITableViewCell {
        let filterCategory = self.filterManager?.filterCategories[indexPath.section]
        let filter = filterCategory?.filters[indexPath.row]
        let cell = self.filtersTable.dequeueReusableCellWithIdentifier("FilterLabelCell") as FilterLabelCell
        cell.filterLabel.text = filter?.label
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        if filter!.active {
            cell.accessoryView = UIImageView(image: UIImage(named: "check"))
        } else {
            cell.accessoryView = nil
        }
        return cell
    }
    
    func bestDealCategoryCellForRow(#tableView: UITableView, indexPath: NSIndexPath) -> UITableViewCell {
        let filterCategory = self.filterManager?.filterCategories[indexPath.section]
        let filter = filterCategory?.filters[indexPath.row]
        let cell = self.filtersTable.dequeueReusableCellWithIdentifier("FilterSwitchCell") as FilterSwitchCell
        cell.filterNameLabel.text = filter?.label
        cell.filterSwitch.on = filter!.active
        cell.delegate = self
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let filterCategory = self.filterManager?.filterCategories[indexPath.section]
        switch filterCategory!.label {
            case "Food Category":
                let cell = foodCategoryCellForRow(tableView: tableView, indexPath: indexPath)
                return cell
            case "Radius":
                let cell = radiusCategoryCellForRow(tableView: tableView, indexPath: indexPath)
                return cell
            case "Sort":
                let cell = sortCategoryCellForRow(tableView: tableView, indexPath: indexPath)
                return cell
            default:
                let cell = bestDealCategoryCellForRow(tableView: tableView, indexPath: indexPath)
                return cell
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let filterCategory = self.filterManager?.filterCategories[section]
        if filterCategory?.label == "Food Category" {
            if !filterCategory!.expanded {
                return 4
            }
            return filterCategory!.filters.count + 1
        }

        if filterCategory?.label == "Radius" {
            if !filterCategory!.expanded {
                return 1
            }
        }
        
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
        
        if filterCategory?.label == "Food Category" {
            if !filterCategory!.expanded && indexPath.row == 3 {
                filterCategory!.expanded = true
                self.filtersTable.reloadSections(NSMutableIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.Fade)
                return
            } else if filterCategory!.expanded && indexPath.row == filterCategory!.filters.count {
                filterCategory!.expanded = false
                self.filtersTable.reloadSections(NSMutableIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.Fade)
                return
            }
        }
        
        if filterCategory?.label == "Radius" {
            if !filterCategory!.expanded {
                filterCategory!.expanded = true
            } else if filterCategory!.expanded {
                filterCategory!.expanded = false
                filterCategory!.selectSingleOption(atIndex: indexPath.row)
            }
            self.filtersTable.reloadSections(NSMutableIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.Fade)
            return
        }
        
        if filterCategory?.label == "Sort" {
            let filter = filterCategory!.filters[indexPath.row]
            
            if filter.isFilterLabel {
                filterCategory?.selectSingleOption(atIndex: indexPath.row)
                self.filtersTable.reloadSections(NSMutableIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.None)
            }
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
