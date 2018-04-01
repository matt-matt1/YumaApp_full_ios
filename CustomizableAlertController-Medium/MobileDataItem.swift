//
//  MobileDataItem.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-27.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class MobileDataItem: UITableViewController
{
	override func viewDidLoad()
	{
		self.tableView.rowHeight = 35
		self.tableView.isScrollEnabled = false
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return 1
	}
	
	override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool
	{
		return false
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
		
		cell.imageView?.image = #imageLiteral(resourceName: "safariIcon")
		cell.textLabel?.text = "Safari"
		cell.detailTextLabel?.text = "474MB"
		cell.accessoryView = UISwitch()
		
		return cell
	}

}
