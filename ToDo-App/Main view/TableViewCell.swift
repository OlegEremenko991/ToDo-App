//
//  TableViewCell.swift
//  ToDo_App_MVVM
//
//  Created by Олег Еременко on 21.06.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var itemNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
