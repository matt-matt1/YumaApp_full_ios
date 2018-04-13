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
	@IBOutlet weak var collView: UICollectionView!
	let cellId = "debugCell"
	var debugList: [String] = [
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
	//var debugCount: [Int] = []
	//let store = DataStore.sharedInstance

	
    override func viewDidLoad()
	{
        super.viewDidLoad()

		//collView.delegate = self
		//collView.dataSource = self
//		for i in 0 ..< debugList.count
//		{
//			let debugCount[i] = store.str.count
//		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}



extension DebugViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		return debugList.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
		//let str = debugList[indexPath.item]
		//let cnt = debugCount[indexPath.item]
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DebugCollectionViewCell
		//cell.label1.text = str
		//cell.label2.text = String(store.configurations.count)
		cell.setup(str: debugList[indexPath.item])
		return cell
	}
	
	
}
