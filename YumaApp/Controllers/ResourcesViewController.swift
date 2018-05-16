//
//  ResourcesViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-05-15.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


struct ResourceStringAndCount
{
	let name: String
	let count: Int?
}


class ResourcesViewController: UIViewController
{
	let cellId = "debugCell"
	let altRowColor = "#E0E0E0"
	let store = DataStore.sharedInstance
	var debugList: [ResourceStringAndCount]? = []
	static var resource: String?
	var mirror: Mirror? = nil
	var tableView: UITableView =
	{
		let view = UITableView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.green
		return view
	}()
	var panel: UIView =
	{
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.white
		view.shadowColor = UIColor.darkGray
		view.shadowOffset = .zero
		view.shadowRadius = 5
		view.shadowOpacity = 1
		return view
	}()
	var statusBarFrame: CGRect!
	
	
    override func viewDidLoad()
	{
        super.viewDidLoad()

		view.backgroundColor = UIColor.lightGray
//		print("frame-x: \(view.frame.origin.x), y: \(view.frame.origin.y), w: \(view.frame.size.width), h: \(view.frame.size.height)")
		statusBarFrame = UIApplication.shared.statusBarFrame
		setNavigation()
		//panel = UIView(frame: CGRect(x: 5, y: statusBarFrame.height, width: view.frame.width-10, height: view.frame.height-statusBarFrame.height-5))
		tableView = UITableView(frame: CGRect(x: 2, y: 0, width: view.frame.width-14, height: view.frame.height-statusBarFrame.height-85))
		tableView.register(ResourceCell.self, forCellReuseIdentifier: cellId)
		tableView.delegate = self
		tableView.dataSource = self
		panel.addSubview(tableView)
		self.view.addSubview(panel)
		NSLayoutConstraint.activate([
			tableView.leadingAnchor.constraint(equalTo: panel.leadingAnchor, constant: 5),
			tableView.trailingAnchor.constraint(equalTo: panel.trailingAnchor, constant: -5),
			tableView.topAnchor.constraint(equalTo: panel.topAnchor, constant: 5),
			tableView.bottomAnchor.constraint(equalTo: panel.bottomAnchor, constant: -5),

			panel.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: 5),
			panel.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor, constant: -5),
			panel.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 0),
			panel.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: /*-statusBarFrame.height*/-5)
			])
		fillContent()
    }


    override func didReceiveMemoryWarning()
	{
        super.didReceiveMemoryWarning()
		debugList?.removeAll()
    }
	
	
	func setNavigation()
	{
		navigationController?.navigationBar.backgroundColor = R.color.YumaRed
		//		print("frame-x: \(navigationController?.navigationBar.frame.origin.x), y: \(navigationController?.navigationBar.frame.origin.y), w: \(navigationController?.navigationBar.frame.width), h: \(navigationController?.navigationBar.frame.height)")
//		navigationController?.navigationBar.setBackgroundImage(myGradientV(frame: (navigationController?.navigationBar.frame)!, colors: [R.color.YumaDRed, R.color.YumaRed]), for: .default)
		//navigationController?.navigationBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
		navigationItem.title = "Resources"
		let navClose = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(navCloseAct(_:)))
		navClose.style = UIBarButtonItemStyle.done
		self.navigationItem.leftBarButtonItems = [navClose]
//		let statusBar = UIView(frame: statusBarFrame)
//		statusBar.backgroundColor = UIColor.lightGray
	}
	
	
	func myGradientV(frame: CGRect, colors: [UIColor]) -> UIImage?
	{
		//		print("frame-x: \(view.frame.origin.x), y: \(view.frame.origin.y), w: \(view.frame.size.width), h: \(view.frame.size.height)")
		let cgcolors = colors.map { 	$0.cgColor 	}
		UIGraphicsBeginImageContextWithOptions(frame.size, true, 0.0/*frame.origin.x*/)
		guard let context = UIGraphicsGetCurrentContext() else { 	return nil 	}
		defer { 	UIGraphicsEndImageContext() 	}
		var locations: [CGFloat] = [0.0, 1.0]
		guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: cgcolors as NSArray as CFArray, locations: &locations) else { 	return nil 	}
		context.drawLinearGradient(gradient, start: CGPoint(x: 0.0, y: /*statusBarFrame.height*/frame.origin.y), end: CGPoint(x: 0.0, y: frame.height), options: [])
		//context.clear(statusBarFrame)
		return UIGraphicsGetImageFromCurrentImageContext()
	}


	func fillContent()
	{
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
	}


	@objc func navCloseAct(_ sender: AnyObject)
	{
		self.dismiss(animated: false, completion: nil)
	}

}



extension ResourcesViewController: UITableViewDelegate, UITableViewDataSource
{
	func numberOfSections(in tableView: UITableView) -> Int
	{
		return 26
	}


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
		let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! ResourceCell
		if let debugList = debugList, debugList.count >= indexPath.row
		{
			if debugList[indexPath.row].count != nil
			{
				cell.setup(debugList[indexPath.row].name, String(debugList[indexPath.row].count!))
			}
			else
			{
				cell.setup(debugList[indexPath.row].name)
			}
			cell.backgroundColor = (indexPath.row % 2 == 0) ? UIColor.init(hex: altRowColor) : UIColor.white
		}
		return cell
	}


	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
	{
		if debugList != nil && debugList?[indexPath.item] != nil && debugList?[indexPath.item].count != nil && debugList![indexPath.item].count! > 0
		{
			let vc = ResourceStage2ViewController()
			vc.name = (debugList?[indexPath.row].name)!
			vc.count = (debugList?[indexPath.row].count)!
			navigationController?.pushViewController(vc, animated: false)
		}
	}

}



class ResourceCell: UITableViewCell
{
	var labelKey: UILabel =
	{
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.text = "key"
		view.textColor = UIColor.blueApple
		view.font = UIFont.boldSystemFont(ofSize: 17)
//		view.attributedText = NSMutableAttributedString(string: view.text!, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 17),														NSAttributedStringKey.foregroundColor: UIColor.blueApple])
		return view
	}()
	var labelValue: UILabel =
	{
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.text = "value"
		view.textColor = UIColor.gray
		view.font = UIFont.systemFont(ofSize: 17)
//		view.attributedText = NSMutableAttributedString(string: view.text!, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17)])
		return view
	}()
	let store = DataStore.sharedInstance
	var properties: [String : String]?


	func setup(_ key: String, _ value: String? = nil)
	{
		addSubview(labelKey)
		addSubview(labelValue)
		addConstraintsWithFormat(format: "V:|-8-[v0]-8-|", views: labelKey)
		addConstraintsWithFormat(format: "V:|-8-[v0]-8-|", views: labelValue)
		addConstraintsWithFormat(format: "H:|-4-[v0]-2-[v1]-4-|", views: labelKey, labelValue)
		labelKey.text = key.replacingOccurrences(of: "_", with: " ").capitalized
		if value != nil
		{
			labelValue.text = value
		}
		else
		{
			labelValue.text = "-"
		}
	}

}



//struct Sections
//{
//	var opened = Bool()
//	var title = String()
//	var contents: ResourceStringAndCount
//}
