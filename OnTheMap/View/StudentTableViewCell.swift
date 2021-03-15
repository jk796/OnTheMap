//
//  StudentTableViewCell.swift
//  OnTheMap
//
//  Created by Jimin Kim on 3/9/21.
//  Copyright © 2021 Jimin Kim. All rights reserved.
//

import UIKit

class StudentTableViewCell: UITableViewCell {

    @IBOutlet weak var pinImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mediaURLLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
