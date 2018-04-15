//
//  DebugTableViewCell.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-14.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class DebugTableViewCell: UITableViewCell
{
	@IBOutlet weak var label1: UILabel!
	@IBOutlet weak var label2: UILabel!
	let store = DataStore.sharedInstance
	var properties: [String : String]?

	
	func setup(str: String, _ str2: String? = nil)
	{
		label1.text = str
		if str2 != nil
		{
			label2.text = str2
		}
		//let array = store.addresses as NSArray
		//properties = {array.$0 : array.$1}
//		for addr in store.addresses
//		{
//			//let _ /*addrDict*/ = CustomerOrdersVC.getKeysAndTypes(forObject: Address.self)
//			let addrMirror = Mirror(reflecting: addr)
//			for (key, value) in addrMirror.children
//			{
//				guard let key = key else { 	continue 	}
//				print("\(key): \(type (of: value)) = '\(value)'")
//			}
//		}
//		if let count = store.properties[str].count
//		{
//			label2.text = String(count)
//		}
//		else
//		{
			label2.text = str2
//		}
	}
}
