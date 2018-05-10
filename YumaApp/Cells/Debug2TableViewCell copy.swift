//
//  Debug2TableViewCell.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-15.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class Debug2TableViewCell: UITableViewCell
{
	@IBOutlet weak var label1: UILabel!
	@IBOutlet weak var label2: UILabel!
	let store = DataStore.sharedInstance
	
	
	func setup(str: String, _ str2: String? = nil)
	{
		label1.text = str
		if str2 != nil
		{
			label2.text = str2
		}
		else
		{
			label2.text = "-"
		}
	}
}
