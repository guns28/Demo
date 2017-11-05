//
//  ToDoTableViewCell.swift
//  Demo
//
//  Created by Ahmed Karmous on 04/11/2017.
//  Copyright © 2017 Ahmed Karmous. All rights reserved.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {

    @IBOutlet weak var toDoName: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
