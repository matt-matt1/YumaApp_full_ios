//
//  Debug2ViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-15.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


struct Property
{
	let key: String?
	let value: Any
}


class Debug2ViewController: UITableViewController
{
//	var resource: String?
//	{
//		didSet
//		{
//			navigationItem.title = resource
//		}
//	}
	let store = DataStore.sharedInstance
	let cellId = "cell"
	var resourceList: [Property] = []

	
	override func viewDidLoad()
	{
        super.viewDidLoad()

		if DebugViewController.resource != nil
		{
        	navigationItem.title = DebugViewController.resource
			if DebugViewController.resource == "addresses"
			{
				let addrMirror = Mirror(reflecting: store.addresses[0])
				for (key, value) in addrMirror.children
				{
					guard let key = key else { 	continue 	}
					resourceList.append(Property(key: key, value: value))
					//print("\(key): \(type (of: value)) = '\(value)'")
				}
			}
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		if DebugViewController.resource != nil
		{
			return resourceList.count
		}
		return 1
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! Debug2TableViewCell
		if resourceList[indexPath.row].value != nil
		{
			cell.setup(str: resourceList[indexPath.row].key!, "\(resourceList[indexPath.row].value)")
		}
		else
		{
			cell.setup(str: resourceList[indexPath.row].key!)
		}
		return cell
	}
}
