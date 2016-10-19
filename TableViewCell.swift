//
//  TableViewCell.swift
//  PetraDirectory
//
//  Created by Justinus Andjarwirawan on 10/1/15.
//  Copyright © 2015 Petra Christian University. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var realName: UILabel!
    @IBOutlet weak var otherInfo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
