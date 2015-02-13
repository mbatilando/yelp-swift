//
//  FilterCell.swift
//  Yelp
//
//  Created by Mari Batilando on 2/12/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class FilterCell: UITableViewCell {

    @IBOutlet weak var filterNameLabel: UILabel!
    @IBOutlet weak var filterSwitch: UISwitch!
    
    var delegate: FilterCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func didChangeValue(sender: AnyObject) {
        self.delegate?.filterCellDidUpdateValue(self, value: self.filterSwitch.on)
    }

}
