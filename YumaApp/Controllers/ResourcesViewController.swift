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
	let stackAll: UIStackView =
	{
		let view = UIStackView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.axis = .vertical
		return view
	}()
	var navBar: UINavigationBar =
	{
		let view = UINavigationBar()
		view.backgroundColor = R.color.YumaDRed
		return view
	}()
	let navTitle: UINavigationItem =
	{
		let view = UINavigationItem()
		return view
	}()
	var navClose: UIBarButtonItem =
	{
		let view = UIBarButtonItem()
		view.image = Awesome.solid.times.asImage(size: 24)
		view.action = #selector(navCloseAct(_:))
		view.style = UIBarButtonItemStyle.plain
		return view
	}()
//	var navHelp: UIBarButtonItem =
//	{
//		let view = UIBarButtonItem()
//		view.image = Awesome.solid.questionCircle.asImage(size: 24)
////		view.action = #selector(navHelpAct(_:))
//		view.style = UIBarButtonItemStyle.plain
//		return view
//	}()
	var tableView: UITableView =
	{
		let view = UITableView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.separatorStyle = .none
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
//		statusBarFrame = UIApplication.shared.statusBarFrame
		setNavigation()
		setViews()
		//panel = UIView(frame: CGRect(x: 5, y: statusBarFrame.height, width: view.frame.width-10, height: view.frame.height-statusBarFrame.height-5))
//		tableView = UITableView()//frame: CGRect(x: 2, y: 0, width: /*view.frame.width-14*/panel.frame.width, height: /*view.frame.height-statusBarFrame.height-85*/panel.frame.height))
//		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.register(ResourceCell.self, forCellReuseIdentifier: cellId)
		tableView.delegate = self
		tableView.dataSource = self
		panel.addSubview(tableView)
		stackAll.addArrangedSubview(panel)
//		self.view.addSubview(panel)
//		let line = UIView()
//		line.translatesAutoresizingMaskIntoConstraints = false
//		line.backgroundColor = R.color.YumaDRed
//		self.view.addSubview(line)
		NSLayoutConstraint.activate([
			tableView.leadingAnchor.constraint(equalTo: panel.leadingAnchor, constant: 5),
			tableView.trailingAnchor.constraint(equalTo: panel.trailingAnchor, constant: -5),
			tableView.topAnchor.constraint(equalTo: panel.topAnchor, constant: 0),
			tableView.bottomAnchor.constraint(equalTo: panel.bottomAnchor, constant: -5),

//			panel.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: 5),
//			panel.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor, constant: -5),
//			panel.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 0),
//			panel.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: -5),
			
			panel.leadingAnchor.constraint(equalTo: stackAll.leadingAnchor, constant: 0),
			panel.trailingAnchor.constraint(equalTo: stackAll.trailingAnchor, constant: -5),
			panel.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 0),
//			panel.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 2),
			panel.bottomAnchor.constraint(equalTo: stackAll.bottomAnchor, constant: -5),
			
//			line.topAnchor.constraint(equalTo: view.safeTopAnchor),
//			line.heightAnchor.constraint(equalToConstant: 2),
//			line.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor),
//			line.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor),
			])
		fillContent()
    }


//	override func viewWillDisappear(_ animated: Bool)
//	{
//		if let statusbar = UIApplication.shared.value(forKey: "statusBar") as? UIView
//		{
//			statusbar.backgroundColor = UIColor.clear
//		}
//	}

	
	override func didReceiveMemoryWarning()
	{
        super.didReceiveMemoryWarning()
		debugList?.removeAll()
    }


//	override var prefersStatusBarHidden: Bool
//	{
//		return true
//	}


	fileprivate func setViews()
	{
		view.addSubview(stackAll)
		if #available(iOS 11.0, *) {
			stackAll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		} else {
			let topMargin = stackAll.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0)
			topMargin.priority = UILayoutPriority(rawValue: 250)
			topMargin.isActive = true
			let top20 = stackAll.topAnchor.constraint(equalTo: view.topAnchor, constant: 20)
			top20.priority = UILayoutPriority(rawValue: 750)
			top20.isActive = true
		}
		stackAll.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: 0).isActive = true
		stackAll.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: 0).isActive = true
		stackAll.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor, constant: 0).isActive = true
	}


	func setNavigation()
	{
		navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
//		navTitle.title = "Resources"
		navBar.setItems([navTitle], animated: false)
		navBar.tintColor = UIColor.white
		stackAll.addArrangedSubview(navBar)
		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
		navBar.topItem?.title = "Resources"
		navClose = UIBarButtonItem(barButtonSystemItem: .stop, target: nil, action: #selector(navCloseAct(_:)))
		navTitle.leftBarButtonItems = [navClose]
//		navTitle.rightBarButtonItems = [navHelp]
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
//	func numberOfSections(in tableView: UITableView) -> Int
//	{
//		return 26
//	}


	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
	{
		return ""
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
//			navigationController?.pushViewController(vc, animated: false)
			self.present(vc, animated: false)
			tableView.deselectRow(at: indexPath, animated: true)
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
