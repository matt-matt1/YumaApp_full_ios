//
//  DebugViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-13.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


class DebugViewController: UIViewController
{
	@IBOutlet weak var tableView: UITableView!
	//	@IBOutlet weak var collView: UICollectionView!
	let cellId = "debugCell"
	let altRowColor = "#E0E0E0"
	var debugList: [String]? = [
		"addresses",
		"carriers",
//		"cart_rules",
		"carts",
		"categories",
		"combinations",
		"configurations",
//		"contacts",
//		"content_management_system",
		"countries",
		"currencies",
//		"customer_messages",
//		"customer_threads",
		"customers",
//		"customizations",
//		"deliveries",
//		"employees",
//		"groups",
//		"guests",
//		"image_types",
//		"images",
		"languages",
		"manufacturers",
//		"messages",
		"order_carriers",
		"order_details",
//		"order_histories",
//		"order_invoices",
//		"order_payments",
//		"order_slip",
		"order_states",
		"orders",
//		"price_ranges",
//		"product_customization_fields",
//		"product_feature_values",
//		"product_features",
		"product_option_values",
		"product_options",
//		"product_suppliers",
		"products",
//		"search",
//		"shop_groups",
//		"shop_urls",
//		"shops",
//		"specific_price_rules",
//		"specific_prices",
		"states",
//		"stock_availables",
//		"stock_movement_reasons",
//		"stock_movement",
//		"stocks",
//		"stores",
//		"suppliers",
//		"supply_order_details",
//		"supply_order_histories",
//		"supply_order_receipt_histories",
//		"supply_order_states",
//		"supply_orders",
		"tags",
//		"tax_rule_groups",
//		"tax_rules",
		"taxes",
//		"translated_configurations",
//		"warehouse_product_locations",
//		"warehouses",
//		"weight_ranges",
//		"zones",
	]
	static var resource: String?
	//let store = DataStore.sharedInstance

	
    override func viewDidLoad()
	{
        super.viewDidLoad()
		navigationItem.title = "Resources"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}



extension DebugViewController: UITableViewDelegate, UITableViewDataSource
{
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		if self.debugList == nil
		{
			return 0
		}
		return debugList!.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! DebugTableViewCell
		if let debugList = debugList, debugList.count >= indexPath.row
		{
			cell.setup(str: debugList[indexPath.row])
			cell.backgroundColor = (indexPath.row % 2 == 0) ? UIColor.init(hex: altRowColor) : UIColor.white
		}
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
	{
		DebugViewController.resource = debugList?[indexPath.row]
	}

}
