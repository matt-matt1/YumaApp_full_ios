//
//  CartTableViewCell.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-23.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {

	@IBOutlet weak var cellView: UIView!
	@IBOutlet weak var quantity: UIButton!
	@IBOutlet weak var prodName: UILabel!
	@IBOutlet weak var prodImage: UIImageView!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	@IBAction func quantityAct(_ sender: Any) {
	}
	
}
