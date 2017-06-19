//
//  customTableViewCell.swift
//  
//
//  Created by 福島達也 on 2017/05/27.
//
//

import UIKit
import MCSwipeTableViewCell

class customTableViewCell: MCSwipeTableViewCell{
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var importance: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


    
}
