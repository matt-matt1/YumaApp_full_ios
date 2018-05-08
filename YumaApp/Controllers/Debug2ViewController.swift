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


class Debug2ViewController: UIViewController, UIScrollViewDelegate
{
	@IBOutlet weak var pageControl: UIPageControl!
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var tableView: UITableView!
	let store = DataStore.sharedInstance
	let cellId = "cell"
	let collCell = "collCell"
	let altRowColor = "#E0E0E0"
	var resourceList: [Property] = []
	
	
	override func viewDidLoad()
	{
        super.viewDidLoad()

		pageControl.pageIndicatorTintColor = R.color.YumaYel
		pageControl.currentPageIndicatorTintColor = R.color.YumaRed
//		if pageControl.currentPage == nil
//		{
//			pageControl.currentPage = 0
//		}
		if DebugViewController.resource != nil
		{
        	navigationItem.title = DebugViewController.resource
			var mirror: Mirror? = nil
			switch(DebugViewController.resource)
			{
			case "addresses":
				if store.addresses.count > 0
				{
					mirror = Mirror(reflecting: store.addresses[pageControl.currentPage])
					pageControl.numberOfPages = store.addresses.count
				}
				break
			case "carriers":
				if store.carriers.count > 0
				{
					mirror = Mirror(reflecting: store.carriers[pageControl.currentPage])
					pageControl.numberOfPages = store.carriers.count
				}
				break
			case "cart_rules":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.cart_rules.count > 0
//				{
//					mirror = Mirror(reflecting: store.cart_rules[pageControl.currentPage])
//				pageControl.numberOfPages = store.addresses.count
//				}
				break
			case "carts":
				if store.carts.count > 0
				{
					mirror = Mirror(reflecting: store.carts[pageControl.currentPage])
					pageControl.numberOfPages = store.carts.count
				}
				break
			case "categories":
				if store.categories.count > 0
				{
					mirror = Mirror(reflecting: store.categories[pageControl.currentPage])
					pageControl.numberOfPages = store.categories.count
				}
				break
			case "combinations":
				if store.combinations.count > 0
				{
					mirror = Mirror(reflecting: store.combinations[pageControl.currentPage])
					pageControl.numberOfPages = store.combinations.count
				}
				break
			case "configurations":
				if store.configurations.count > 0
				{
					mirror = Mirror(reflecting: store.configurations[pageControl.currentPage])
					pageControl.numberOfPages = store.configurations.count
				}
				break
			case "contacts":
				if store.storeContacts.count > 0
				{
					mirror = Mirror(reflecting: store.storeContacts[pageControl.currentPage])
					pageControl.numberOfPages = store.storeContacts.count
				}
				break
			case "content_management_system":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.content_management_system.count > 0
//				{
//					mirror = Mirror(reflecting: store.content_management_system[pageControl.currentPage])
//				}
				break
			case "countries":
				if store.countries.count > 0
				{
					mirror = Mirror(reflecting: store.countries[pageControl.currentPage])
					pageControl.numberOfPages = store.countries.count
				}
				break
			case "currencies":
				if store.currencies.count > 0
				{
					mirror = Mirror(reflecting: store.currencies[pageControl.currentPage])
					pageControl.numberOfPages = store.currencies.count
				}
				break
			case "customer_messages":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.customer_messages.count > 0
//				{
//					mirror = Mirror(reflecting: store.customer_messages[pageControl.currentPage])
//				}
				break
			case "customer_threads":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.customer_threads.count > 0
//				{
//					mirror = Mirror(reflecting: store.customer_threads[pageControl.currentPage])
//				}
				break
			case "customers":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.customers.count > 0
//				{
//					mirror = Mirror(reflecting: store.customers[pageControl.currentPage])
//				}
				break
			case "customizations":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.customizations.count > 0
//				{
//					mirror = Mirror(reflecting: store.customizations[pageControl.currentPage])
//				}
				break
			case "deliveries":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.deliveries.count > 0
//				{
//					mirror = Mirror(reflecting: store.deliveries[pageControl.currentPage])
//				}
				break
			case "employees":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.employees.count > 0
//				{
//					mirror = Mirror(reflecting: store.employees[pageControl.currentPage])
//				}
				break
			case "groups":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.groups.count > 0
//				{
//					mirror = Mirror(reflecting: store.groups[pageControl.currentPage])
//				}
				break
			case "guests":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.guests.count > 0
//				{
//					mirror = Mirror(reflecting: store.guests[pageControl.currentPage])
//				}
				break
			case "image_types":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.image_types.count > 0
//				{
//					mirror = Mirror(reflecting: store.image_types[pageControl.currentPage])
//				}
				break
			case "images":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.images.count > 0
//				{
//					mirror = Mirror(reflecting: store.images[pageControl.currentPage])
//				}
				break
			case "languages":
				if store.langs.count > 0
				{
					mirror = Mirror(reflecting: store.langs[pageControl.currentPage])
					pageControl.numberOfPages = store.langs.count
				}
				break
			case "manufacturers":
				if store.manufacturers.count > 0
				{
					mirror = Mirror(reflecting: store.manufacturers[pageControl.currentPage])
					pageControl.numberOfPages = store.manufacturers.count
				}
				break
			case "messages":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.messages.count > 0
//				{
//					mirror = Mirror(reflecting: store.messages[pageControl.currentPage])
//				}
				break
			case "order_carriers":
				if store.orderCarriers.count > 0
				{
					mirror = Mirror(reflecting: store.orderCarriers[pageControl.currentPage])
					pageControl.numberOfPages = store.orderCarriers.count
				}
				break
			case "order_details":
				if store.orderDetails.count > 0
				{
					mirror = Mirror(reflecting: store.orderDetails[pageControl.currentPage])
					pageControl.numberOfPages = store.orderDetails.count
				}
				break
			case "order_histories":
				if store.orderHistories.count > 0
				{
					mirror = Mirror(reflecting: store.orderHistories[pageControl.currentPage])
					pageControl.numberOfPages = store.orderHistories.count
				}
				break
			case "order_invoices":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.order_invoices.count > 0
//				{
//					mirror = Mirror(reflecting: store.order_invoices[pageControl.currentPage])
//				}
				break
			case "order_payments":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.order_payments.count > 0
//				{
//					mirror = Mirror(reflecting: store.order_payments[pageControl.currentPage])
//				}
				break
			case "order_slip":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.order_slip.count > 0
//				{
//					mirror = Mirror(reflecting: store.order_slip[pageControl.currentPage])
//				}
				break
			case "order_states":
				if store.orderStates.count > 0
				{
					mirror = Mirror(reflecting: store.orderStates[pageControl.currentPage])
					pageControl.numberOfPages = store.orderStates.count
				}
				break
			case "orders":
				if store.orders.count > 0
				{
					mirror = Mirror(reflecting: store.orders[pageControl.currentPage])
					pageControl.numberOfPages = store.orders.count
				}
				break
			case "price_ranges":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.price_ranges.count > 0
//				{
//					mirror = Mirror(reflecting: store.price_ranges[pageControl.currentPage])
//				}
				break
			case "product_customization_fields":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.product_customization_fields.count > 0
//				{
//					mirror = Mirror(reflecting: store.product_customization_fields[pageControl.currentPage])
//				}
				break
			case "product_feature_values":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.product_feature_values.count > 0
//				{
//					mirror = Mirror(reflecting: store.product_feature_values[pageControl.currentPage])
//				}
				break
			case "product_features":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.product_features.count > 0
//				{
//					mirror = Mirror(reflecting: store.product_features[pageControl.currentPage])
//				}
				break
			case "product_option_values":
				if store.productOptionValues.count > 0
				{
					mirror = Mirror(reflecting: store.productOptionValues[pageControl.currentPage])
					pageControl.numberOfPages = store.productOptionValues.count
				}
				break
			case "product_options":
				if store.productOptions.count > 0
				{
					mirror = Mirror(reflecting: store.productOptions[pageControl.currentPage])
					pageControl.numberOfPages = store.productOptions.count
				}
				break
			case "product_suppliers":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.product_suppliers.count > 0
//				{
//					mirror = Mirror(reflecting: store.product_suppliers[pageControl.currentPage])
//				}
				break
			case "products":
				if store.products.count > 0
				{
					mirror = Mirror(reflecting: store.products[pageControl.currentPage])
					pageControl.numberOfPages = store.products.count
				}
				break
			case "search":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.search.count > 0
//				{
//					mirror = Mirror(reflecting: store.search[pageControl.currentPage])
//				}
				break
			case "shop_groups":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.shop_groups.count > 0
//				{
//					mirror = Mirror(reflecting: store.shop_groups[pageControl.currentPage])
//				}
				break
			case "shop_urls":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.shop_urls.count > 0
//				{
//					mirror = Mirror(reflecting: store.shop_urls[pageControl.currentPage])
//				}
				break
			case "shops":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.shops.count > 0
//				{
//					mirror = Mirror(reflecting: store.shops[pageControl.currentPage])
//				}
				break
			case "specific_price_rules":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.specific_price_rules.count > 0
//				{
//					mirror = Mirror(reflecting: store.specific_price_rules[pageControl.currentPage])
//				}
				break
			case "specific_prices":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.specific_prices.count > 0
//				{
//					mirror = Mirror(reflecting: store.specific_prices[pageControl.currentPage])
//				}
				break
			case "states":
				if store.states.count > 0
				{
					mirror = Mirror(reflecting: store.states[pageControl.currentPage])
					pageControl.numberOfPages = store.states.count
				}
				break
			case "stock_availables":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.stock_availables.count > 0
//				{
//					mirror = Mirror(reflecting: store.stock_availables[pageControl.currentPage])
//				}
				break
			case "stock_movement_reasons":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.stock_movement_reasons.count > 0
//				{
//					mirror = Mirror(reflecting: store.stock_movement_reasons[pageControl.currentPage])
//				}
				break
			case "stock_movement":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.stock_movement.count > 0
//				{
//					mirror = Mirror(reflecting: store.stock_movement[pageControl.currentPage])
//				}
				break
			case "stocks":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.stocks.count > 0
//				{
//					mirror = Mirror(reflecting: store.stocks[pageControl.currentPage])
//				}
				break
			case "stores":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.stores.count > 0
//				{
//					mirror = Mirror(reflecting: store.stores[pageControl.currentPage])
//				}
				break
			case "suppliers":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.suppliers.count > 0
//				{
//					mirror = Mirror(reflecting: store.suppliers[pageControl.currentPage])
//				}
				break
			case "supply_order_details":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.supply_order_details.count > 0
//				{
//					mirror = Mirror(reflecting: store.supply_order_details[pageControl.currentPage])
//				}
				break
			case "supply_order_histories":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.supply_order_histories.count > 0
//				{
//					mirror = Mirror(reflecting: store.supply_order_histories[pageControl.currentPage])
//				}
				break
			case "supply_order_receipt_histories":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.supply_order_receipt_histories.count > 0
//				{
//					mirror = Mirror(reflecting: store.supply_order_receipt_histories[pageControl.currentPage])
//				}
				break
			case "supply_order_states":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.supply_order_states.count > 0
//				{
//					mirror = Mirror(reflecting: store.supply_order_states[pageControl.currentPage])
//				}
				break
			case "supply_orders":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.supply_orders.count > 0
//				{
//					mirror = Mirror(reflecting: store.supply_orders[pageControl.currentPage])
//				}
				break
			case "tags":
				if store.tags.count > 0
				{
					mirror = Mirror(reflecting: store.tags[pageControl.currentPage])
					pageControl.numberOfPages = store.tags.count
				}
				break
			case "tax_rule_groups":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.tax_rule_groups.count > 0
//				{
//					mirror = Mirror(reflecting: store.tax_rule_groups[pageControl.currentPage])
//				}
				break
			case "tax_rules":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.tax_rules.count > 0
//				{
//					mirror = Mirror(reflecting: store.tax_rules[pageControl.currentPage])
//				}
				break
			case "taxes":
				if store.taxes.count > 0
				{
					mirror = Mirror(reflecting: store.taxes[pageControl.currentPage])
					pageControl.numberOfPages = store.taxes.count
				}
				break
			case "translated_configurations":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.translated_configurations.count > 0
//				{
//					mirror = Mirror(reflecting: store.translated_configurations[pageControl.currentPage])
//				}
				break
			case "warehouse_product_locations":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.warehouse_product_locations.count > 0
//				{
//					mirror = Mirror(reflecting: store.warehouse_product_locations[pageControl.currentPage])
//				}
				break
			case "warehouses":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.warehouses.count > 0
//				{
//					mirror = Mirror(reflecting: store.warehouses[pageControl.currentPage])
//				}
				break
			case "weight_ranges":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.weight_ranges.count > 0
//				{
//					mirror = Mirror(reflecting: store.weight_ranges[pageControl.currentPage])
//				}
				break
			case "zones":
				print("\(DebugViewController.resource ?? "") not implemented yet")
//				if store.zones.count > 0
//				{
//					mirror = Mirror(reflecting: store.zones[pageControl.currentPage])
//				}
				break
			default:
				print("unknown resource")
			}
			if mirror != nil
			{
				for (key, value) in (mirror?.children)!
				{
					guard let key = key else { 	continue 	}
					resourceList.append(Property(key: key, value: value))
				}
			}
		}
    }

    override func didReceiveMemoryWarning()
	{
        super.didReceiveMemoryWarning()
        resourceList.removeAll()
    }
	
	func scrollViewDidScroll(_ scrollView: UIScrollView)
	{
		if scrollView == self.scrollView
		{
			pageControl.currentPage = Int(round(scrollView.contentOffset.x / self.scrollView.frame.width))
			self.tableView.reloadData()
		}
	}

}



extension Debug2ViewController: UITableViewDelegate, UITableViewDataSource
{
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		if DebugViewController.resource != nil
		{
			return resourceList.count
		}
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! Debug2TableViewCell
//		if resourceList[indexPath.row].value != nil
//		{
			cell.setup(str: resourceList[indexPath.row].key!, resourceList[indexPath.row].value as? String)
//		}
//		else
//		{
//			cell.setup(str: resourceList[indexPath.row].key!, "")
//		}
		cell.backgroundColor = (indexPath.row % 2 == 0) ? UIColor.init(hex: altRowColor) : UIColor.white
		return cell
	}

}



extension Debug2ViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		return pageControl.numberOfPages
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collCell, for: indexPath) as! Debug2CollectionViewCell
		cell.setup(str: resourceList[indexPath.row].key!, resourceList[indexPath.row].value as? String)
		return cell
	}
	
//	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator)
//	{
//		coordinator.animate(alongsideTransition:
//			{
//				(_) in
//
//				self.collectionView?.collectionViewLayout.invalidateLayout()
//
//				if self.pageControl.currentPage == 0
//				{
//					self.collectionView?.contentOffset = .zero
//				}
//				else
//				{
//					let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
//					self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//				}
//		}
//			)
//		{
//			(_) in
//		}
//	}

}
