//
//  ResourceStage2ViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-05-15.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit
import AwesomeEnum


struct Property
{
	let key: String?
	let value: Any
}


class ResourceStage2ViewController: UIViewController
{
	var name: String?
	var count: Int?
	let cellId = "resourceColl"
	var statusBarFrame: CGRect!
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
	var navBarHeight: CGFloat = 44
	let navTitle: UINavigationItem =
	{
		let view = UINavigationItem()
		return view
	}()
	var navClose: UIBarButtonItem =
	{
		let view = UIBarButtonItem()
		view.image = Awesome.solid.angleLeft.asImage(size: 34)
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
	var collView: UICollectionView =
	{
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.minimumLineSpacing = 0
		let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
		view.translatesAutoresizingMaskIntoConstraints = false
		//view.backgroundColor = UIColor.red
		view.isPagingEnabled = true
		return view
	}()
	var pageControl: UIPageControl =
	{
		let view = UIPageControl()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.isUserInteractionEnabled = false
		view.pageIndicatorTintColor = R.color.YumaYel
		view.currentPageIndicatorTintColor = R.color.YumaRed
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


    override func viewDidLoad()
	{
        super.viewDidLoad()

		view.backgroundColor = UIColor.lightGray
//		statusBarFrame = UIApplication.shared.statusBarFrame
		setViews()
		setNavigation()
		collView.delegate = self
		collView.dataSource = self
		collView.register(ResourceStage2ViewCell.self, forCellWithReuseIdentifier: cellId)
		if count != nil
		{
			pageControl.numberOfPages = count!
		}
		panel.addSubview(pageControl)
		panel.addSubview(collView)
		stackAll.addSubview(panel)
//		self.view.addSubview(panel)
//		let line = UIView()
//		line.translatesAutoresizingMaskIntoConstraints = false
//		line.backgroundColor = R.color.YumaDRed
//		self.view.addSubview(line)
		NSLayoutConstraint.activate([
			pageControl.leadingAnchor.constraint(equalTo: panel.leadingAnchor, constant: 5),
			pageControl.trailingAnchor.constraint(equalTo: panel.trailingAnchor, constant: -5),
			pageControl.topAnchor.constraint(equalTo: panel.topAnchor, constant: 2),
			
			collView.leadingAnchor.constraint(equalTo: panel.leadingAnchor/*, constant: 2*/),
			collView.trailingAnchor.constraint(equalTo: panel.trailingAnchor/*, constant: -2*/),
			collView.topAnchor.constraint(equalTo: pageControl.bottomAnchor/*, constant: 2*/),
			collView.bottomAnchor.constraint(equalTo: panel.bottomAnchor/*, constant: -2*/),
			
//			panel.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: 5),
//			panel.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor, constant: -5),
//			panel.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: -5),
//			panel.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 20),

			panel.leadingAnchor.constraint(equalTo: stackAll.leadingAnchor, constant: 5),
			panel.trailingAnchor.constraint(equalTo: stackAll.trailingAnchor, constant: -5),
//			panel.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 0),
			panel.topAnchor.constraint(equalTo: stackAll.topAnchor, constant: navBarHeight),
			panel.bottomAnchor.constraint(equalTo: stackAll.bottomAnchor, constant: -5),
			
//			line.topAnchor.constraint(equalTo: view.safeTopAnchor),
//			line.heightAnchor.constraint(equalToConstant: 20),
//			line.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor),
//			line.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor),
			])
    }


	override func viewWillDisappear(_ animated: Bool)
	{
		if let statusbar = UIApplication.shared.value(forKey: "statusBar") as? UIView
		{
			statusbar.backgroundColor = UIColor.clear
		}
	}


	func scrollViewDidScroll(_ scrollView: UIScrollView)
	{
//		if scrollView == self.collView
//		{
		pageControl.currentPage = Int(round(scrollView.contentOffset.x / self.collView.frame.width))
//		}
	}


	fileprivate func setViews()
	{
		view.addSubview(stackAll)
		if #available(iOS 11.0, *) {
			stackAll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		} else {
			//			navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
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
		navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: navBarHeight))
		navTitle.title = R.string.OrdHist
		navBar.setItems([navTitle], animated: false)
		navBar.tintColor = UIColor.white
		stackAll.addArrangedSubview(navBar)
		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
		navBar.topItem?.title = self.name?.replacingOccurrences(of: "_", with: "").capitalized
//		navClose = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(navCloseAct(_:)))
		navTitle.leftBarButtonItems = [navClose]
//		navTitle.rightBarButtonItems = [navHelp]
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


	override func didReceiveMemoryWarning()
	{
        super.didReceiveMemoryWarning()
    }

	@objc func navCloseAct(_ sender: UITapGestureRecognizer)
	{
		self.dismiss(animated: false, completion: nil)
	}
}



extension ResourceStage2ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
	{
		return CGSize(width: collView.frame.width, height: collView.frame.height)
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		if count != nil
		{
			return count!
		}
		return 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
//		let colours = [UIColor.blue, UIColor.brown, UIColor.cyan, UIColor.red, UIColor.green, UIColor.blueApple, UIColor.gray]
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ResourceStage2ViewCell
//		cell.backgroundColor = indexPath.item < colours.count ? colours[indexPath.item] : UIColor.blue
		cell.resource = name!
		cell.itemNo = indexPath.item
		cell.setup()
		return cell
	}

}


class ResourceStage2ViewCell: UICollectionViewCell
{
	let store = DataStore.sharedInstance
	var tableView: UITableView =
	{
		let view = UITableView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.separatorStyle = .none
		//view.clipsToBounds = true
		return view
	}()
	var resourceList: [Property] = []
	let cellId = "tableInColl"
	let altRowColor = "#E0E0E0"
	var resource: String?
	var itemNo: Int?
	var mirror: Mirror? = nil


	override init(frame: CGRect)
	{
		super.init(frame: frame)
		addSubview(tableView)
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(ResourceStage2TableCell.self, forCellReuseIdentifier: "stage2Table")
		addConstraintsWithFormat(format: "H:|[v0]|", views: tableView)
		addConstraintsWithFormat(format: "V:|[v0]|", views: tableView)
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
	
	func setup()
	{
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
		if resource != nil
		{
			switch(resource)
			{
			case "addresses":
				if store.addresses.count > 0 && itemNo != nil
				{
					mirror = Mirror(reflecting: store.addresses[itemNo!])
				}
				break
			case "carriers":
				if store.carriers.count > 0 && itemNo != nil
				{
					mirror = Mirror(reflecting: store.carriers[itemNo!])
				}
				break
			case "cart_rules":
				print("\(resource ?? "") not implemented yet")
				//				if store.cart_rules.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.cart_rules[itemNo])
				//				pageControl.numberOfPages = store.addresses.count
				//				}
				break
			case "carts":
				if store.carts.count > 0 && itemNo != nil
				{
					mirror = Mirror(reflecting: store.carts[itemNo!])
				}
				break
			case "categories":
				if store.categories.count > 0 && itemNo != nil
				{
					mirror = Mirror(reflecting: store.categories[itemNo!])
				}
				break
			case "combinations":
				if store.combinations.count > 0 && itemNo != nil
				{
					mirror = Mirror(reflecting: store.combinations[itemNo!])
				}
				break
			case "configurations":
				if store.configurations.count > 0 && itemNo != nil
				{
					mirror = Mirror(reflecting: store.configurations[itemNo!])
				}
				break
			case "contacts":
				if store.storeContacts.count > 0 && itemNo != nil
				{
					mirror = Mirror(reflecting: store.storeContacts[itemNo!])
				}
				break
			case "content_management_system":
				print("\(resource ?? "") not implemented yet")
				//				if store.content_management_system.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.content_management_system[itemNo])
				//				}
				break
			case "countries":
				if store.countries.count > 0 && itemNo != nil
				{
					mirror = Mirror(reflecting: store.countries[itemNo!])
				}
				break
			case "currencies":
				if store.currencies.count > 0 && itemNo != nil
				{
					mirror = Mirror(reflecting: store.currencies[itemNo!])
				}
				break
			case "customer_messages":
				print("\(resource ?? "") not implemented yet")
				//				if store.customer_messages.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.customer_messages[itemNo])
				//				}
				break
			case "customer_threads":
				print("\(resource ?? "") not implemented yet")
				//				if store.customer_threads.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.customer_threads[itemNo])
				//				}
				break
			case "customers":
				print("\(resource ?? "") not implemented yet")
				//				if store.customers.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.customers[itemNo])
				//				}
				break
			case "customizations":
				print("\(resource ?? "") not implemented yet")
				//				if store.customizations.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.customizations[itemNo])
				//				}
				break
			case "deliveries":
				print("\(resource ?? "") not implemented yet")
				//				if store.deliveries.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.deliveries[itemNo])
				//				}
				break
			case "employees":
				print("\(resource ?? "") not implemented yet")
				//				if store.employees.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.employees[itemNo])
				//				}
				break
			case "groups":
				print("\(resource ?? "") not implemented yet")
				//				if store.groups.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.groups[itemNo])
				//				}
				break
			case "guests":
				print("\(resource ?? "") not implemented yet")
				//				if store.guests.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.guests[itemNo])
				//				}
				break
			case "image_types":
				print("\(resource ?? "") not implemented yet")
				//				if store.image_types.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.image_types[itemNo])
				//				}
				break
			case "images":
				print("\(resource ?? "") not implemented yet")
				//				if store.images.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.images[itemNo])
				//				}
				break
			case "languages":
				if store.langs.count > 0 && itemNo != nil
				{
					mirror = Mirror(reflecting: store.langs[itemNo!])
				}
				break
			case "manufacturers":
				if store.manufacturers.count > 0 && itemNo != nil
				{
					mirror = Mirror(reflecting: store.manufacturers[itemNo!])
				}
				break
			case "messages":
				print("\(resource ?? "") not implemented yet")
				//				if store.messages.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.messages[itemNo])
				//				}
				break
			case "order_carriers":
				if store.orderCarriers.count > 0 && itemNo != nil
				{
					mirror = Mirror(reflecting: store.orderCarriers[itemNo!])
				}
				break
			case "order_details":
				if store.orderDetails.count > 0 && itemNo != nil
				{
					mirror = Mirror(reflecting: store.orderDetails[itemNo!])
				}
				break
			case "order_histories":
				if store.orderHistories.count > 0 && itemNo != nil
				{
					mirror = Mirror(reflecting: store.orderHistories[itemNo!])
				}
				break
			case "order_invoices":
				print("\(resource ?? "") not implemented yet")
				//				if store.order_invoices.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.order_invoices[itemNo])
				//				}
				break
			case "order_payments":
				print("\(resource ?? "") not implemented yet")
				//				if store.order_payments.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.order_payments[itemNo])
				//				}
				break
			case "order_slip":
				print("\(resource ?? "") not implemented yet")
				//				if store.order_slip.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.order_slip[itemNo])
				//				}
				break
			case "order_states":
				if store.orderStates.count > 0 && itemNo != nil
				{
					mirror = Mirror(reflecting: store.orderStates[itemNo!])
				}
				break
			case "orders":
				if store.orders.count > 0 && itemNo != nil
				{
					mirror = Mirror(reflecting: store.orders[itemNo!])
				}
				break
			case "price_ranges":
				print("\(resource ?? "") not implemented yet")
				//				if store.price_ranges.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.price_ranges[itemNo])
				//				}
				break
			case "product_customization_fields":
				print("\(resource ?? "") not implemented yet")
				//				if store.product_customization_fields.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.product_customization_fields[itemNo])
				//				}
				break
			case "product_feature_values":
				print("\(resource ?? "") not implemented yet")
				//				if store.product_feature_values.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.product_feature_values[itemNo])
				//				}
				break
			case "product_features":
				print("\(resource ?? "") not implemented yet")
				//				if store.product_features.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.product_features[itemNo])
				//				}
				break
			case "product_option_values":
				if store.productOptionValues.count > 0 && itemNo != nil
				{
					mirror = Mirror(reflecting: store.productOptionValues[itemNo!])
				}
				break
			case "product_options":
				if store.productOptions.count > 0 && itemNo != nil
				{
					mirror = Mirror(reflecting: store.productOptions[itemNo!])
				}
				break
			case "product_suppliers":
				print("\(resource ?? "") not implemented yet")
				//				if store.product_suppliers.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.product_suppliers[itemNo])
				//				}
				break
			case "products":
				if store.products.count > 0 && itemNo != nil
				{
					mirror = Mirror(reflecting: store.products[itemNo!])
				}
				break
			case "search":
				print("\(resource ?? "") not implemented yet")
				//				if store.search.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.search[itemNo])
				//				}
				break
			case "shop_groups":
				print("\(resource ?? "") not implemented yet")
				//				if store.shop_groups.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.shop_groups[itemNo])
				//				}
				break
			case "shop_urls":
				print("\(resource ?? "") not implemented yet")
				//				if store.shop_urls.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.shop_urls[itemNo])
				//				}
				break
			case "shops":
				print("\(resource ?? "") not implemented yet")
				//				if store.shops.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.shops[itemNo])
				//				}
				break
			case "specific_price_rules":
				print("\(resource ?? "") not implemented yet")
				//				if store.specific_price_rules.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.specific_price_rules[itemNo])
				//				}
				break
			case "specific_prices":
				print("\(resource ?? "") not implemented yet")
				//				if store.specific_prices.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.specific_prices[itemNo])
				//				}
				break
			case "states":
				if store.states.count > 0 && itemNo != nil
				{
					mirror = Mirror(reflecting: store.states[itemNo!])
				}
				break
			case "stock_availables":
				print("\(resource ?? "") not implemented yet")
				//				if store.stock_availables.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.stock_availables[itemNo])
				//				}
				break
			case "stock_movement_reasons":
				print("\(resource ?? "") not implemented yet")
				//				if store.stock_movement_reasons.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.stock_movement_reasons[itemNo])
				//				}
				break
			case "stock_movement":
				print("\(resource ?? "") not implemented yet")
				//				if store.stock_movement.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.stock_movement[itemNo])
				//				}
				break
			case "stocks":
				print("\(resource ?? "") not implemented yet")
				//				if store.stocks.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.stocks[itemNo])
				//				}
				break
			case "stores":
				print("\(resource ?? "") not implemented yet")
				//				if store.stores.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.stores[itemNo])
				//				}
				break
			case "suppliers":
				print("\(resource ?? "") not implemented yet")
				//				if store.suppliers.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.suppliers[itemNo])
				//				}
				break
			case "supply_order_details":
				print("\(resource ?? "") not implemented yet")
				//				if store.supply_order_details.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.supply_order_details[itemNo])
				//				}
				break
			case "supply_order_histories":
				print("\(resource ?? "") not implemented yet")
				//				if store.supply_order_histories.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.supply_order_histories[itemNo])
				//				}
				break
			case "supply_order_receipt_histories":
				print("\(resource ?? "") not implemented yet")
				//				if store.supply_order_receipt_histories.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.supply_order_receipt_histories[itemNo])
				//				}
				break
			case "supply_order_states":
				print("\(resource ?? "") not implemented yet")
				//				if store.supply_order_states.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.supply_order_states[itemNo])
				//				}
				break
			case "supply_orders":
				print("\(resource ?? "") not implemented yet")
				//				if store.supply_orders.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.supply_orders[itemNo])
				//				}
				break
			case "tags":
				if store.tags.count > 0 && itemNo != nil
				{
					mirror = Mirror(reflecting: store.tags[itemNo!])
				}
				break
			case "tax_rule_groups":
				print("\(resource ?? "") not implemented yet")
				//				if store.tax_rule_groups.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.tax_rule_groups[itemNo])
				//				}
				break
			case "tax_rules":
				print("\(resource ?? "") not implemented yet")
				//				if store.tax_rules.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.tax_rules[itemNo])
				//				}
				break
			case "taxes":
				if store.taxes.count > 0 && itemNo != nil
				{
					mirror = Mirror(reflecting: store.taxes[itemNo!])
				}
				break
			case "translated_configurations":
				print("\(resource ?? "") not implemented yet")
				//				if store.translated_configurations.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.translated_configurations[itemNo])
				//				}
				break
			case "warehouse_product_locations":
				print("\(resource ?? "") not implemented yet")
				//				if store.warehouse_product_locations.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.warehouse_product_locations[itemNo])
				//				}
				break
			case "warehouses":
				print("\(resource ?? "") not implemented yet")
				//				if store.warehouses.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.warehouses[itemNo])
				//				}
				break
			case "weight_ranges":
				print("\(resource ?? "") not implemented yet")
				//				if store.weight_ranges.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.weight_ranges[itemNo])
				//				}
				break
			case "zones":
				print("\(resource ?? "") not implemented yet")
				//				if store.zones.count > 0
				//				{
				//					mirror = Mirror(reflecting: store.zones[itemNo])
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
	
}



extension ResourceStage2ViewCell: UITableViewDelegate, UITableViewDataSource
{
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return resourceList.count
	}


	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
//		let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: cellId)
//		cell.textLabel?.text = resourceList[indexPath.row].key
//		if let val = resourceList[indexPath.row].value as? String
//		{
//			cell.detailTextLabel?.text = val
//		}
//		else
//		{
//			cell.detailTextLabel?.text = "-"
//		}
		let cell = tableView.dequeueReusableCell(withIdentifier: "stage2Table") as! ResourceStage2TableCell
		if resourceList[indexPath.row].value is String
		{
			cell.setup(resourceList[indexPath.row].key!, resourceList[indexPath.row].value as? String)
		}
		else if resourceList[indexPath.row].value is Bool
		{
			cell.setup(resourceList[indexPath.row].key!, resourceList[indexPath.row].value as! Bool ? "true" : "false")
		}
		else if resourceList[indexPath.row].value is Int
		{
			cell.setup(resourceList[indexPath.row].key!, "\(resourceList[indexPath.row].value as! Int)")
		}
		else
		{
			cell.setup(resourceList[indexPath.row].key!)
		}
		cell.backgroundColor = (indexPath.row % 2 == 0) ? UIColor.init(hex: altRowColor) : UIColor.white
		return cell
	}


	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
	{
		return 40
	}
}



class ResourceStage2TableCell: UITableViewCell
{
	var labelKey: UILabel =
	{
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.text = "key"
		view.textColor = UIColor.darkGray
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


//	override init(style: UITableViewCellStyle, reuseIdentifier: String?)
//	{
//		super.init(style: style, reuseIdentifier: reuseIdentifier)
//		//setup(<#T##key: String##String#>, <#T##value: String?##String?#>)
//	}
//
//	required init?(coder aDecoder: NSCoder)
//	{
//		fatalError("init(coder:) has not been implemented")
//	}


	func setup(_ key: String, _ value: String? = nil)
	{
		addSubview(labelKey)
		addSubview(labelValue)
		addConstraintsWithFormat(format: "V:|-8-[v0]-8-|", views: labelKey)
		addConstraintsWithFormat(format: "V:|-8-[v0]-8-|", views: labelValue)
		addConstraintsWithFormat(format: "H:|-4-[v0]-2-[v1]-4-|", views: labelKey, labelValue)
		labelKey.text = key//.snake_caseToCamelCase()//key.replacingOccurrences(of: "_", with: " ").capitalized
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
