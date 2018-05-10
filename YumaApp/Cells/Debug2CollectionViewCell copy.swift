//
//  Debug2CollectionViewCell.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-17.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class Debug2CollectionViewCell: UICollectionViewCell
{
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var tableCell: Debug2TableViewCell!
	@IBOutlet weak var tableLabel1: UILabel!
	@IBOutlet weak var tableLabel2: UILabel!
	
	
	func setup(str: String, _ str2: String? = nil)
	{
		tableLabel1.text = str
		if str2 != nil
		{
			tableLabel2.text = str2
		}
		else
		{
			tableLabel2.text = "-"
		}
	}
}
