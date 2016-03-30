//
//  AlarmTableViewCell.swift
//  LastChance
//
//  Created by Ben Chaimberg on 3/30/16.
//  Copyright © 2016 Ben Chaimberg. All rights reserved.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {

    
    @IBOutlet weak var `switch`: UISwitch!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
