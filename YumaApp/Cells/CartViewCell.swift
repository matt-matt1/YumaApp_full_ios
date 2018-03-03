//
//  CartViewCell.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-02.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class CartViewCell: UITableViewCell
{
	@IBOutlet weak var prodQtyBorder: UIView!
	@IBOutlet weak var prodQty: UILabel!
	@IBOutlet weak var prodTitle: UILabel!
	@IBOutlet weak var prodImage: UIImageView!
	
	func setup(string: String)
	{
		prodTitle.text = string
	}
}
