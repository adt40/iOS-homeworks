//
//  PedigreeTableViewCell.swift
//  HW8
//
//  Created by Austin Toot on 4/3/18.
//  Copyright © 2018 Austin Toot. All rights reserved.
//

import UIKit

class PedigreeTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var parentsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
