//
//  DebugViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-13.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


struct ResourceStringAndCount
{
	let name: String
	let count: Int?
}

class DebugViewController: UIViewController
{
	@IBOutlet weak var navClose: UIBarButtonItem!
	@IBOutlet weak var tableView: UITableView!
	//	@IBOutlet weak var collView: UICollectionView!
	let cellId = "debugCell"
	let altRowColor = "#E0E0E0"
	let store = DataStore.sharedInstance
	var debugList: [ResourceStringAndCount]? = []
	static var resource: String?
	var mirror: Mirror? = nil

	
    override func viewDidLoad()
	{
        super.viewDidLoad()
		navClose.setTitleTextAttributes([NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)], for: .normal)
		navClose.setTitleTextAttributes([
			NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)
			], for: UIControlState.selected)
		navClose.title = FontAwesome.times.rawValue
		navigationItem.title = "Resources"

		debugList = [
			ResourceStringAndCount(name: "addresses", count: store.addresses.count),
			ResourceStringAndCount(name: "carriers", count: store.carriers.count),
			ResourceStringAndCount(name: "cart_rules", count: nil/*store.cartRules.count*/),
			ResourceStringAndCount(name: "carts", count: store.carts.count),
			ResourceStringAndCount(name: "categories", count: store.categories.count),
			ResourceStringAndCount(name: "combinations", count: store.combinations.count),
			ResourceStringAndCount(name: "configurations", count: store.configurations.count),
			ResourceStringAndCount(name: "contacts", count: store.storeContacts.count),
			ResourceStringAndCount(name: "content_management_system", count: nil/*store.contentManagementSystem.count*/),
			ResourceStringAndCount(name: "countries", count: store.countries.count),
			ResourceStringAndCount(name: "currencies", count: store.currencies.count),
			ResourceStringAndCount(name: "customer_messages", count: nil/*store.customerMessages.count*/),
			ResourceStringAndCount(name: "customer_threads", count: nil/*store.customerThreads.count*/),
			ResourceStringAndCount(name: "customers", count: nil/*store.customers.count*/),
			ResourceStringAndCount(name: "customizations", count: nil/*store.customizations.count*/),
			ResourceStringAndCount(name: "deliveries", count: nil/*store.deliveries.count*/),
			ResourceStringAndCount(name: "employees", count: nil/*store.employees.count*/),
			ResourceStringAndCount(name: "groups", count: nil/*store.groups.count*/),
			ResourceStringAndCount(name: "guests", count: nil/*store.guests.count*/),
			ResourceStringAndCount(name: "image_types", count: nil/*store.imageTypes.count*/),
			ResourceStringAndCount(name: "images", count: nil/*store.images.count*/),
			ResourceStringAndCount(name: "languages", count: store.langs.count),
			ResourceStringAndCount(name: "manufacturers", count: store.manufacturers.count),
			ResourceStringAndCount(name: "messages", count: nil/*store.messages.count*/),
			ResourceStringAndCount(name: "order_carriers", count: store.orderCarriers.count),
			ResourceStringAndCount(name: "order_details", count: store.orderDetails.count),
			ResourceStringAndCount(name: "order_histories", count: store.orderHistories.count),
			ResourceStringAndCount(name: "order_invoices", count: nil/*store.orderInvoices.count*/),
			ResourceStringAndCount(name: "order_payments", count: nil/*store.orderPayments.count*/),
			ResourceStringAndCount(name: "order_slip", count: nil/*store.orderSlip.count*/),
			ResourceStringAndCount(name: "order_states", count: store.orderStates.count),
			ResourceStringAndCount(name: "orders", count: store.orders.count),
			ResourceStringAndCount(name: "price_ranges", count: nil/*store.priceRanges.count*/),
			ResourceStringAndCount(name: "product_customization_fields", count: nil/*store.productCustomizationFields.count*/),
			ResourceStringAndCount(name: "product_feature_values", count: nil/*store.productFeatureValues.count*/),
			ResourceStringAndCount(name: "product_features", count: nil/*store.productFeatures.count*/),
			ResourceStringAndCount(name: "product_option_values", count: store.productOptionValues.count),
			ResourceStringAndCount(name: "product_options", count: store.productOptions.count),
			ResourceStringAndCount(name: "product_suppliers", count: nil/*store.productSuppliers.count*/),
			ResourceStringAndCount(name: "products", count: store.products.count),
			ResourceStringAndCount(name: "search", count: nil/*store.search.count*/),
			ResourceStringAndCount(name: "shop_groups", count: nil/*store.shopGroups.count*/),
			ResourceStringAndCount(name: "shop_urls", count: nil/*store.shopUrls.count*/),
			ResourceStringAndCount(name: "shops", count: nil/*store.shops.count*/),
			ResourceStringAndCount(name: "specific_price_rules", count: nil/*store.specificPriceRules.count*/),
			ResourceStringAndCount(name: "specific_prices", count: nil/*store.specificPrices.count*/),
			ResourceStringAndCount(name: "states", count: store.states.count),
			ResourceStringAndCount(name: "stock_availables", count: nil/*store.stockAvailables.count*/),
			ResourceStringAndCount(name: "stock_movement_reasons", count: nil/*store.stockMovementReasons.count*/),
			ResourceStringAndCount(name: "stock_movement", count: nil/*store.stockMovement.count*/),
			ResourceStringAndCount(name: "stocks", count: nil/*store.stocks.count*/),
			ResourceStringAndCount(name: "stores", count: nil/*store.stores.count*/),
			ResourceStringAndCount(name: "suppliers", count: nil/*store.suppliers.count*/),
			ResourceStringAndCount(name: "supply_order_details", count: nil/*store.supplyOrderDetails.count*/),
			ResourceStringAndCount(name: "supply_order_histories", count: nil/*store.supplyOrderHistories.count*/),
			ResourceStringAndCount(name: "supply_order_receipt_histories", count: nil/*store.supplyOrderReceiptHistories.count*/),
			ResourceStringAndCount(name: "supply_order_states", count: nil/*store.supplyOrderStates.count*/),
			ResourceStringAndCount(name: "supply_orders", count: nil/*store.supplyOrders.count*/),
			ResourceStringAndCount(name: "tags", count: store.tags.count),
			ResourceStringAndCount(name: "tax_rule_groups", count: nil/*store.taxRuleGroups.count*/),
			ResourceStringAndCount(name: "tax_rules", count: nil/*store.taxRules.count*/),
			ResourceStringAndCount(name: "taxes", count: store.taxes.count),
			ResourceStringAndCount(name: "translated_configurations", count: nil/*store.translatedConfigurations.count*/),
			ResourceStringAndCount(name: "warehouse_product_locations", count: nil/*store.warehouseProductLocations.count*/),
			ResourceStringAndCount(name: "warehouses", count: nil/*store.warehouses.count*/),
			ResourceStringAndCount(name: "weight_ranges", count: nil/*store.weight.count*/),
			ResourceStringAndCount(name: "zones", count: nil/*store.zones.count*/)
		]
		let mirror = Mirror(reflecting: store)
		for (key, val) in mirror.children
		{
			guard let key = key else { 	continue 	}
			if type(of: val) != Int.self && type(of: val) != String.self && type(of: val) != Bool.self
			{
				store.properties.append(key)
			}
		}
		print(store.properties)
    }

    override func didReceiveMemoryWarning()
	{
        super.didReceiveMemoryWarning()
        debugList?.removeAll()
    }
    
	@IBAction func navCloseAct(_ sender: Any)
	{
		self.dismiss(animated: false, completion: nil)
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
			if debugList[indexPath.row].count != nil
			{
				cell.setup(str: debugList[indexPath.row].name, String(debugList[indexPath.row].count!))
			}
			else
			{
				cell.setup(str: debugList[indexPath.row].name)
			}
			cell.backgroundColor = (indexPath.row % 2 == 0) ? UIColor.init(hex: altRowColor) : UIColor.white
		}
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
	{
		DebugViewController.resource = debugList?[indexPath.row].name
	}

}
