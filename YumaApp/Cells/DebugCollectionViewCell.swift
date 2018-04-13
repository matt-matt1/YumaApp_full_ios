//
//  DebugCollectionViewCell.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-13.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class DebugCollectionViewCell: UICollectionViewCell
{
	@IBOutlet weak var label1: UILabel!
	@IBOutlet weak var label2: UILabel!
	let store = DataStore.sharedInstance
	
	
	func setup(str: String)
	{
		label1.text = str
		label2.text = String(store.carts.count)
	}
}
