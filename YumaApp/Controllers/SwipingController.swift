//
//  SwipingController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-24.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit
import AwesomeEnum
//import AwesomeSwift
//import PCLBlurEffectAlert


class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout, XMLParserDelegate
{
	//MARK: EXTENSION FILES:
		//SwipingControllerCollection
		//SwipingControllerTaps
	
	//MARK: Properties
	var cellId = 			"cellID"
	let pageContent: 		[Slide] = [
		Slide(id: 1, image: "home-slider-printers", caption1: "Laser Printers", caption2: "", target: #selector(printTapped)),
		Slide(id: 1, image: "home-slider-cartridges", caption1: "Toner Cartridges", caption2: "that last", target: #selector(tonersTapped)),
		Slide(id: 1, image: "home-slider-laptops", caption1: "Laptop Computers", caption2: "", target: #selector(laptopTapped))
	]
	let store = DataStore.sharedInstance
//	let prevBtn: 			UIButton =
//	{
//		let button = 		UIButton(type: .system)
//		button.setTitle("PREV", for: .normal)
//		button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
//		return button
//	}()
//	let nextBtn: 			UIButton =
//	{
//		let button = 		UIButton(type: .system)
//		button.setTitle("NEXT", for: .normal)
//		button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
//		return button
//	}()
	lazy var pageControl: 	UIPageControl =
	{
		let pc = 			UIPageControl()
		pc.numberOfPages = 	pageContent.count
		pc.currentPage = 	0
		pc.currentPageIndicatorTintColor = R.color.YumaRed
		pc.pageIndicatorTintColor = R.color.YumaYel
		pc.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(gotoDebug(_:))))
		return pc
	}()
	
	
	//MARK: Methods
	override func viewDidLoad()
	{
		super.viewDidLoad()
		self.view.backgroundColor = UIColor.white
		if let statusbar = UIApplication.shared.value(forKey: "statusBar") as? UIView
		{
			statusbar.backgroundColor = UIColor.clear
		}
		drawLayout()
		
		collectionView?.backgroundColor = UIColor.white
		collectionView?.register(PageCell.self, forCellWithReuseIdentifier: cellId)
		collectionView?.isPagingEnabled = true
		collectionView?.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
		
		UserDefaults.standard.set(nil, forKey: "Orders3")
		//UserDefaults.standard.set(nil, forKey: "Orders9Details")
		//UserDefaults.standard.set(nil, forKey: "Orders10Details")
		UserDefaults.standard.set(nil, forKey: "customer")
		//UserDefaults.standard.set(nil, forKey: "Orders8Details")
		//UserDefaults.standard.set(nil, forKey: "Orders7Details")
		UserDefaults.standard.set(nil, forKey: "CustomerAddresses")
		getValues()
		setDefaults()// instead use -eg. store.configValue(forKey: "PS_PASSWD_RESET_VALIDITY")
//		var ws = WebService()
//		ws.startURL = R.string.WSbase
//		ws.resource = APIResource.addresses
//		ws.keyAPI = R.string.APIkey
//		ws.filter = ["id" : [4]]
//		//ws.filter = [(Addresses_filter.alias as! String):["Q"]]
//		//ws.filter = ["firstname":["john"], "lastname":["DOE%"]]
//		//ws.display = ["birthday"]
//		ws.display = ["full"]
//		//ws.sort = ["firstname" : Direction.DESC]
//		//ws.outputAs = OutputFormat.JSON
//		//ws.limit = [6]
//		ws.printURL()
//		print("----")
//		ws.get 	{ 	(result) in
//			if result.data != nil
//			{
//				let data = String(data: result.data! as Data, encoding: .utf8)
//				print(data!)
//				print("----get^")
//				ws.xml = data
//					// parse XML
//				let xmlParser = XMLParser(data: (data?.data(using: .utf8))!)
//				xmlParser.delegate = self
//				let success: Bool = xmlParser.parse()
//				//print("xml \(success ? "parsed" : "failed")")
//				if success
//				{
//					print("XML parsed")
//				}
//				else
//				{
//					print(xmlParser.parserError.debugDescription)
//				}
//				print("----")
//				//print(xmlParser.value(forKey: "address")!)
//				let newRow: Any?
//					// Edit the given row
//				ws.id = 4
//				newRow = self.store.carriers[0]
//				ws.xml = PSWebServices.object2psxml(object: newRow!, resource: "\(ws.resource!)", resource2: ws.resource2(resource: "\(ws.resource!)"), excludeId: false)
//				//print(ws.xml)
//				ws.printURL()
//				ws.edit() 	{ 	(result) in
//					if result.data != nil
//					{
//						let data = String(data: result.data! as Data, encoding: .utf8)
//						print(data!)
//						print("----edit^")
//					}
//				}
//				// Add a row
////				ws.schema = Schema.blank
////				ws.xml = PSWebServices.object2psxml(object: newRow!, resource: "\(ws.resource!)", resource2: ws.resource2(resource: "\(ws.resource!)"), excludeId: true)
////				ws.printURL()
////				ws.add() 	{ 	(result) in
////					if result.data != nil
////					{
////						let data = String(data: result.data! as Data, encoding: .utf8)
////						print(data!)
////						print("----add^")
////					}
////				}
//					// Delete a row
////				ws.delete(completionHandler: 	{ 	(result) in
////					if result.data != nil
////					{
////						let data = String(data: result.data! as Data, encoding: .utf8)
////						print(data!)
////						print("----delete^")
////					}
////				})
//			}
//		}
//		if ws.resource != nil
//		{
//			let res = "\(ws.resource!)".capitalized
//			print("\(res):\(ws.listProperties(resource: ws.resource!))")//ws.resource!.rawValue
//		}

		Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(handleCycle), userInfo: nil, repeats: true)
	}


	fileprivate func getValues()
	{
		if store.countries.count < 1	//check if not already in data store
		{
			let items = UserDefaults.standard.string(forKey: "Countries")
			if (items == nil || items == "[]") && Reachability.isConnectedToNetwork()
			{
				store.callGetCountries() { 	(items, err) in
					if self.store.debug > 5
					{
						if err == nil
						{
							print("got \((items as! [Country]?)?.count ?? 0) countries")
						}
						else
						{
							print("\(R.string.err) \(err?.localizedDescription ?? err.debugDescription)")
						}
					}
				}
			}
			else
			{
				do	//decode user data then insert each into the data store
				{
					let all = try JSONDecoder().decode(Countries.self, from: (items?.data(using: .utf8))!)
					for t in all.countries
					{
						store.countries.append(t)
					}
					print("decoded \(store.countries.count) countries")
				}
				catch let JSONerr
				{
					print("\(R.string.err) \(JSONerr)")
				}
			}
		}
		else
		{
			print("data store has \(store.countries.count) countries")
		}
		if store.states.count < 1	//check if not already in data store
		{
			let items = UserDefaults.standard.string(forKey: "States")
			if (items == nil || items == "[]") && Reachability.isConnectedToNetwork()
			{
				store.callGetStates(id_country: 0) { 	(items, err) in
					if self.store.debug > 5
					{
						if err == nil
						{
							print("got \((items as! [CountryState]?)?.count ?? 0) states")
						}
						else
						{
							print("\(R.string.err) \(err?.localizedDescription ?? err.debugDescription)")
						}
					}
				}
			}
			else
			{
				do	//decode user data then insert each into the data store
				{
					let all = try JSONDecoder().decode(CountryStates.self, from: (items?.data(using: .utf8))!)
					for t in all.states!
					{
						store.states.append(t)
					}
					print("decoded \(store.states.count) states")
				}
				catch let JSONerr
				{
					print("\(R.string.err) \(JSONerr)")
				}
			}
		}
		else
		{
			print("data store has \(store.states.count) states")
		}
		if store.carriers.count < 1	//check if not already in data store
		{
			let items = UserDefaults.standard.string(forKey: "Carriers")
			if (items == nil || items == "[]") && Reachability.isConnectedToNetwork()
			{
				store.callGetCarriers { 	(items, err) in
					if self.store.debug > 5
					{
						if err == nil
						{
							print("got \((items as [Carrier]?)?.count ?? 0) carriers")
						}
						else
						{
							print("\(R.string.err) \(err?.localizedDescription ?? err.debugDescription)")
						}
					}
				}
			}
			else
			{
				do	//decode user data then insert each into the data store
				{
					let all = try JSONDecoder().decode(CarrierList.self, from: (items?.data(using: .utf8))!)
					for t in all.carriers!
					{
						store.carriers.append(t)
					}
					print("decoded \(store.carriers.count) carriers")
				}
				catch let JSONerr
				{
					print("\(R.string.err) \(JSONerr)")
				}
			}
		}
		else
		{
			print("data store has \(store.carriers.count) carriers")
		}
		if store.orderStates.count < 1	//check if not already in data store
		{
			let items = UserDefaults.standard.string(forKey: "OrderStates")
			if (items == nil || items == "[]") && Reachability.isConnectedToNetwork()
			{
				store.getOrderStates() { 	(items, err) in
					if self.store.debug > 5
					{
						if err == nil
						{
							print("got \((items as! OrderStates).order_states?.count ?? 0) order states")
						}
						else
						{
							print("\(R.string.err) \(err?.localizedDescription ?? err.debugDescription)")
						}
					}
				}
			}
			else
			{
				do	//decode user data then insert each into the data store
				{
					let all = try JSONDecoder().decode(OrderStates.self, from: (items?.data(using: .utf8))!)
					for t in all.order_states!
					{
						store.orderStates.append(t)
					}
					print("decoded \(store.orderStates.count) order states")
				}
				catch let JSONerr
				{
					print("\(R.string.err) \(JSONerr)")
				}
			}
		}
		else
		{
			print("data store has \(store.orderStates.count) order states")
		}
		
		if store.langs.count < 1	//check if not already in data store
		{
			let items = UserDefaults.standard.string(forKey: "Languages")
			if (items == nil || items == "[]") && Reachability.isConnectedToNetwork()
			{
				store.callGetLanguages() { 	(items, err) in
					if self.store.debug > 5
					{
						if err == nil
						{
							print("got \((items as! [Language]?)?.count ?? 0) langs")
						}
						else
						{
							print("\(R.string.err) \(err?.localizedDescription ?? err.debugDescription)")
						}
					}
				}
			}
			else
			{
				do	//decode user data then insert each into the data store
				{
					let all = try JSONDecoder().decode(Languages.self, from: (items?.data(using: .utf8))!)
					for t in all.languages!
					{
						store.langs.append(t)
					}
					print("decoded \(store.langs.count) langs")
				}
				catch let JSONerr
				{
					print("\(R.string.err) \(JSONerr)")
				}
			}
		}
		else
		{
			print("data store has \(store.langs.count) langs")
		}
		if store.orderHistories.count < 1	//check if not already in data store
		{
			let items = UserDefaults.standard.string(forKey: "OrderHistories")
			if (items == nil || items == "[]") && Reachability.isConnectedToNetwork()
			{
				store.getOrderHistories() { 	(items, err) in
					if self.store.debug > 5
					{
						if err == nil
						{
							print("got \((items as! [OrderHistory]?)?.count ?? 0) order histories")
						}
						else
						{
							print("\(R.string.err) \(err?.localizedDescription ?? err.debugDescription)")
						}
					}
				}
			}
			else
			{
				do	//decode user data then insert each into the data store
				{
					let all = try JSONDecoder().decode(OrderHistories.self, from: (items?.data(using: .utf8))!)
					for t in all.order_histories!
					{
						store.orderHistories.append(t)
					}
					print("decoded \(store.orderHistories.count) order histories")
				}
				catch let JSONerr
				{
					print("\(R.string.err) \(JSONerr)")
				}
			}
		}
		else
		{
			print("data store has \(store.orderHistories.count) order histories")
		}
		if store.categories.count < 1	//check if not already in data store
		{
			let items = UserDefaults.standard.string(forKey: "Categories")
			if (items == nil || items == "[]") && Reachability.isConnectedToNetwork()
			{
				store.callGetCategories() { 	(items, err) in
					if self.store.debug > 5
					{
						if err == nil
						{
							print("got \((items as! [aCategory]?)?.count ?? 0) categories")
						}
						else
						{
							print("\(R.string.err) \(err?.localizedDescription ?? err.debugDescription)")
						}
					}
				}
			}
			else
			{
				do	//decode user data then insert each into the data store
				{
					let all = try JSONDecoder().decode(Categories.self, from: (items?.data(using: .utf8))!)
					for t in all.categories!
					{
						store.categories.append(t)
					}
					print("decoded \(store.categories.count) categories")
				}
				catch let JSONerr
				{
					print("\(R.string.err) \(JSONerr)")
				}
			}
		}
		else
		{
			print("data store has \(store.categories.count) categories")
		}
		if store.combinations.count < 1	//check if not already in data store
		{
			let items = UserDefaults.standard.string(forKey: "Combinations")
			if (items == nil || items == "[]") && Reachability.isConnectedToNetwork()
			{
				store.callGetCombinations() { 	(items, err) in
					if self.store.debug > 5
					{
						if err == nil
						{
							print("got \((items as! [Combination]?)?.count ?? 0) combinations")
						}
						else
						{
							print("\(R.string.err) \(err?.localizedDescription ?? err.debugDescription)")
						}
					}
				}
			}
			else
			{
				do	//decode user data then insert each into the data store
				{
					let all = try JSONDecoder().decode(Combinations.self, from: (items?.data(using: .utf8))!)
					for t in all.combinations!
					{
						store.combinations.append(t)
					}
					print("decoded \(store.combinations.count) combinations")
				}
				catch let JSONerr
				{
					print("\(R.string.err) \(JSONerr)")
				}
			}
		}
		else
		{
			print("data store has \(store.combinations.count) combinations")
		}
		if store.orderCarriers.count < 1	//check if not already in data store
		{
			let items = UserDefaults.standard.string(forKey: "OrderCarriers")
			if (items == nil || items == "[]") && Reachability.isConnectedToNetwork()
			{
				store.getOrderCarriers() { 	(items, err) in
					if self.store.debug > 5
					{
						if err == nil
						{
							print("got \((items as! [OrderCarrier]?)?.count ?? 0) order carriers")
						}
						else
						{
							print("\(R.string.err) \(err?.localizedDescription ?? err.debugDescription)")
						}
					}
				}
			}
			else
			{
				do	//decode user data then insert each into the data store
				{
					let all = try JSONDecoder().decode(OrderCarriers.self, from: (items?.data(using: .utf8))!)
					for t in all.order_carriers!
					{
						store.orderCarriers.append(t)
					}
					print("decoded \(store.orderCarriers.count) order carriers")
				}
				catch let JSONerr
				{
					print("\(R.string.err) \(JSONerr)")
				}
			}
		}
		else
		{
			print("data store has \(store.orderCarriers.count) order carriers")
		}
		if store.productOptions.count < 1	//check if not already in data store
		{
			let items = UserDefaults.standard.string(forKey: "ProductOptions")
			if (items == nil || items == "[]") && Reachability.isConnectedToNetwork()
			{
				store.callGetProductOptions() { 	(items, err) in
					if self.store.debug > 5
					{
						if err == nil
						{
							print("got \((items as! [ProductOption]?)?.count ?? 0) product options")
						}
						else
						{
							print("\(R.string.err) \(err?.localizedDescription ?? err.debugDescription)")
						}
					}
				}
			}
			else
			{
				do	//decode user data then insert each into the data store
				{
					let all = try JSONDecoder().decode(ProductOptions.self, from: (items?.data(using: .utf8))!)
					for t in all.product_options!
					{
						store.productOptions.append(t)
					}
					print("decoded \(store.productOptions.count) product options")
				}
				catch let JSONerr
				{
					print("\(R.string.err) \(JSONerr)")
				}
			}
		}
		else
		{
			print("data store has \(store.productOptions.count) product options")
		}
		if store.currencies.count < 1	//check if not already in data store
		{
			let items = UserDefaults.standard.string(forKey: "Currencies")
			if (items == nil || items == "[]") && Reachability.isConnectedToNetwork()
			{
				store.callGetCurrencies() { 	(items, err) in
					if self.store.debug > 5
					{
						if err == nil
						{
							print("got \((items as! [Currency]?)?.count ?? 0) currencies")
						}
						else
						{
							print("\(R.string.err) \(err?.localizedDescription ?? err.debugDescription)")
						}
					}
				}
			}
			else
			{
				do	//decode user data then insert each into the data store
				{
					let all = try JSONDecoder().decode(Currencies.self, from: (items?.data(using: .utf8))!)
					for t in all.currencies!
					{
						store.currencies.append(t)
					}
					print("decoded \(store.currencies.count) currencies")
				}
				catch let JSONerr
				{
					print("\(R.string.err) \(JSONerr)")
				}
			}
		}
		else
		{
			print("data store has \(store.currencies.count) currencies")
		}
//		let myClient = MyClient()
//		myClient.getREST(from: .addresses(filters: [
//			Addresses_filter.idCustomer : "3",
//			Addresses_filter.idCountry : "4",
//			//Addresses_filter.idManufacturer : "0",
//			]), completion:
//			{ 	(addr) in
//				print("got addr for cust3,country4")
//			}
//		)
		//			myClient.getREST(from: .addresses(nil, nil), completion: { (addr) in
		//				//
		//			})
		//let str = collect.addresses(addresses_filter.idCustomer, "3")
		//print("\(str)")
		if store.taxes.count < 1	//check if not already in data store
		{
			let items = UserDefaults.standard.string(forKey: "Taxes")
			if (items == nil || items == "[]") && Reachability.isConnectedToNetwork()
			{
				store.callGetTaxes { (taxes, err) in
					if self.store.debug > 5
					{
						if err == nil
						{
							print("got \((taxes as [Tax]?)?.count ?? 0) taxes")
						}
						else
						{
							print("\(R.string.err) \(err?.localizedDescription ?? err.debugDescription)")
						}
					}
				}
			}
			else
			{
				do	//decode user data then insert each into the data store
				{
					let allTaxes = try JSONDecoder().decode(Taxes.self, from: (items?.data(using: .utf8))!)
					for t in allTaxes.taxes!
					{
						store.taxes.append(t)
					}
					print("decoded \(store.taxes.count) taxes")
				}
				catch let JSONerr
				{
					print("\(R.string.err) \(JSONerr)")
				}
			}
		}
		else
		{
			print("data store has \(store.taxes.count) taxes")
		}
		if store.configurations.count < 1	//check if not already in data store
		{
			let items = UserDefaults.standard.string(forKey: "Configurations")
			if (items == nil || items == "[]") && Reachability.isConnectedToNetwork()
			{
				store.callGetConfigurations { (configurations, err) in
					if self.store.debug > 5
					{
						if err == nil
						{
							print("got \((configurations as [Configuration]?)?.count ?? 0) configurations")
						}
						else
						{
							print("\(R.string.err) \(err?.localizedDescription ?? err.debugDescription)")
						}
					}
				}
			}
			else
			{
				do	//decode user data then insert each into the data store
				{
					let all = try JSONDecoder().decode(Configurations.self, from: (items?.data(using: .utf8))!)
					for t in all.configurations!
					{
						store.configurations.append(t)
					}
					print("decoded \(store.configurations.count) configurations")
				}
				catch let JSONerr
				{
					print("\(R.string.err) \(JSONerr)")
				}
			}
		}
		else
		{
			print("data store has \(store.configurations.count) configurations")
//			let configDict = store.config2Dict()
		}
		if store.tags.count < 1	//check if not already in data store
		{
			let items = UserDefaults.standard.string(forKey: "Tags")
			if (items == nil || items == "[]") && Reachability.isConnectedToNetwork()
			{
				store.callGetTags { (tags, err) in	//api get
					if self.store.debug > 5
					{
						if err == nil
						{
							print("got \((tags as [myTag]?)?.count ?? 0) tags")
						}
						else
						{
							print("\(R.string.err) \(err?.localizedDescription ?? err.debugDescription)")
						}
					}
				}
			}
			else
			{
				do	//decode user data then insert each into the data store
				{
					let allTags = try JSONDecoder().decode(Tags.self, from: (items?.data(using: .utf8))!)
					for t in allTags.tags!
					{
						store.tags.append(t)
					}
					print("decoded \(store.tags.count) tags")
				}
				catch let JSONerr
				{
					print("\(R.string.err) \(JSONerr)")
				}
			}
		}
		else
		{
			print("data store has \(store.tags.count) tags")
		}
		if store.storeContacts.count < 1	//check if not already in data store
		{
			//UserDefaults.standard.removeObject(forKey: "Contacts")
			let items = UserDefaults.standard.string(forKey: "Contacts")
			if (items == nil || items == "[]") && Reachability.isConnectedToNetwork()
			{
				store.callGetContacts(completion:
				{ 	(contacts, err) in	//api get
					if self.store.debug > 5
					{
						if err == nil
						{
							print("got \((contacts as! [Contact]?)?.count ?? 0) contacts")
						}
						else
						{
							print("\(R.string.err) \(err?.localizedDescription ?? err.debugDescription)")
						}
					}
				})
			}
			else
			{
				do	//decode user data then insert each into the data store
				{
					store.storeContacts.removeAll()
					let all = try JSONDecoder().decode(Contacts.self, from: (items?.data(using: .utf8))!)
					//let array = all.contacts as! [Contact]
					//for t in array
					for t in all.contacts!
					{
						store.storeContacts.append(t)
					}
					print("decoded \(store.storeContacts.count) contacts")
				}
				catch let JSONerr
				{
					print("\(R.string.err) \(JSONerr)")
				}
			}
		}
		else
		{
			print("data store has \(store.storeContacts.count) contacts")
		}
		if store.productOptionValues.count < 1	//check if not already in data store
		{
			let items = UserDefaults.standard.string(forKey: "ProductOptionValues")
			if (items == nil || items == "[]") && Reachability.isConnectedToNetwork()
			{
				store.callGetProductOptionValues(completion:
				{ 	(items, err) in	//api get
					if self.store.debug > 5
					{
						if err == nil
						{
							print("got \((items)?.count ?? 0) product option values")
						}
						else
						{
							print("\(R.string.err) \(err?.localizedDescription ?? err.debugDescription)")
						}
					}
				})
			}
			else
			{
				do	//decode user data then insert each into the data store
				{
					let all = try JSONDecoder().decode(ProductOptionValues.self, from: (items?.data(using: .utf8))!)
					for t in all.product_option_values
					{
						store.productOptionValues.append(t)
					}
					print("decoded \(store.productOptionValues.count) product option values")
				}
				catch let JSONerr
				{
					print("\(R.string.err) \(JSONerr)")
				}
			}
		}
		else
		{
			print("data store has \(store.tags.count) groups")
		}
		if store.groups.count < 1	//check if not already in data store
		{
			let items = UserDefaults.standard.string(forKey: "Groups")
			if (items == nil || items == "[]") && Reachability.isConnectedToNetwork()
			{
				store.callGetGroups(completion:
					{ 	(items, err) in	//api get
						if self.store.debug > 5
						{
							if err == nil
							{
								print("got \(((items) as AnyObject).count ?? 0) groups")
							}
							else
							{
								print("\(R.string.err) \(err?.localizedDescription ?? err.debugDescription)")
							}
						}
				})
			}
			else
			{
				do	//decode user data then insert each into the data store
				{
					let all = try JSONDecoder().decode(Groups.self, from: (items?.data(using: .utf8))!)
					for t in all.groups!
					{
						store.groups.append(t)
					}
					print("decoded \(store.groups.count) groups")
				}
				catch let JSONerr
				{
					print("\(R.string.err) \(JSONerr)")
				}
			}
		}
		else
		{
			print("data store has \(store.tags.count) groups")
		}
	}


	func setDefaults()	// instead use -eg. store.configValue(forKey: "PS_PASSWD_RESET_VALIDITY")
	{
/**/
//		//572 elements
//		0 : "1" : "PS_LANG_DEFAULT" date_add : "2016-12-18 22:19:37"date_upd : "2016-12-18 22:19:37"
		//		store.myLang = Int(store.configValue(forKey: "PS_LANG_DEFAULT"))!
		let myLang = store.configValue(forKey: "PS_LANG_DEFAULT")
//		if !myLang.isEmpty
//		{
//			store.myLang = Int(myLang)!
//		}
//		else
//		{
//			store.myLang = 0
//		}
		//store.disallowReorder = (!tempDisallowReorder.isEmpty) ? (tempDisallowReorder == "1") : false
		//		store.weightUnit = (!tempWeightUnit.isEmpty) ? tempWeightUnit : "kg"
		store.myLang = (!myLang.isEmpty) ? Int(myLang)! : 0
//		1 : value : "1.7.2.4" name : "PS_VERSION_DB" date_add : "2016-12-18 22:19:37" date_upd : "2016-12-18 22:19:37"
//		2 : value : "1.7.0.2" name : "PS_INSTALL_VERSION" date_add : "2016-12-18 22:19:37" date_upd : "2016-12-18 22:19:37"
//		3 : value : "1" : "PS_CARRIER_DEFAULT" date_add : "2016-12-18 22:19:42" date_upd : "2018-04-25 16:28:31"
		let tempDefaultCarrier = store.configValue(forKey: "PS_CARRIER_DEFAULT")
//		if !tempDefaultCarrier.isEmpty
//		{
//			store.defaultCarrier = Int(tempDefaultCarrier)!
//		}
//		else
//		{
//			store.defaultCarrier = 1
//		}
		store.defaultCarrier = (!tempDefaultCarrier.isEmpty) ? Int(tempDefaultCarrier)! : 1
//		4 value : "1" : "PS_GROUP_FEATURE_ACTIVE" date_add : "2016-12-18 22:19:43" date_upd : "2016-12-18 22:19:43"
//		5 value : "1" : "PS_SEARCH_INDEXATION" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		6 value : "1" : "PS_CURRENCY_DEFAULT" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
		let defaultCurr = store.configValue(forKey: "PS_CURRENCY_DEFAULT")
//		if !defaultCurr.isEmpty
//		{
//			store.defaultCurr = Int(defaultCurr)!
//		}
//		else
//		{
//			store.defaultCurr = 0
//		}
		store.defaultCurr = (!defaultCurr.isEmpty) ? Int(defaultCurr)! : 0
//		7 value : "4" : "PS_COUNTRY_DEFAULT" date_add : "0000-00-00 00:00:00" date_upd : "2016-12-18 22:19:46"
		//		store.defaultCountry = Int(store.configValue(forKey: "PS_COUNTRY_DEFAULT"))!
		let defaultCountry = store.configValue(forKey: "PS_COUNTRY_DEFAULT")
//		if !defaultCountry.isEmpty
//		{
//			store.defaultCountry = Int(defaultCountry)!
//		}
//		else
//		{
//			store.defaultCountry = 0
//		}
		//store.disallowReorder = (!tempDisallowReorder.isEmpty) ? (tempDisallowReorder == "1") : false
//		store.weightUnit = (!tempWeightUnit.isEmpty) ? tempWeightUnit : "kg"
		store.defaultCountry = (!defaultCountry.isEmpty) ? Int(defaultCountry)! : 0
//		8 value : "1" : "PS_REWRITING_SETTINGS" date_add : "0000-00-00 00:00:00" date_upd : "2016-12-18 22:19:46"
//		9 value : "1" : "PS_ORDER_OUT_OF_STOCK" date_add : "0000-00-00 00:00:00" date_upd : "2016-12-19 21:27:48"
//		10 value : "3" : "PS_LAST_QTIES" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		11 value : "0" : "PS_CONDITIONS" date_add : "0000-00-00 00:00:00" date_upd : "2016-12-19 21:29:02"
//		12 value : "0" : "PS_RECYCLABLE_PACK" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		13 value : "0" : "PS_GIFT_WRAPPING" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		14 value : "0" : "PS_GIFT_WRAPPING_PRICE" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		15 value : "1" : "PS_STOCK_MANAGEMENT" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		16 value : ">" : "PS_NAVIGATION_PIPE" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		17 value : "12" : "PS_PRODUCTS_PER_PAGE" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		18 value : "0" : "PS_PURCHASE_MINIMUM" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		19 value : "0" : "PS_PRODUCTS_ORDER_WAY" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		20 value : "4" : "PS_PRODUCTS_ORDER_BY" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		21 value : "0" : "PS_DISPLAY_QTIES" date_add : "0000-00-00 00:00:00" date_upd : "2016-12-19 21:27:48" 22 value : "2" : "PS_SHIPPING_HANDLING" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		23 value : "0" : "PS_SHIPPING_FREE_PRICE" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		24 value : "0" : "PS_SHIPPING_FREE_WEIGHT" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		25 value : "1" : "PS_SHIPPING_METHOD" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		26 value : "1" : "PS_TAX" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		27 value : "1" : "PS_SHOP_ENABLE" date_add : "0000-00-00 00:00:00" date_upd : "2018-04-16 19:15:38"
//		28 value : "20" : "PS_NB_DAYS_NEW_PRODUCT" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		29 value : "0" : "PS_SSL_ENABLED" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		30 value : "kg" : "PS_WEIGHT_UNIT" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
		let tempWeightUnit = store.configValue(forKey: "PS_WEIGHT_UNIT")
//		if !tempWeightUnit.isEmpty
//		{
//			store.weightUnit = tempWeightUnit
//		}
//		else
//		{
//			store.weightUnit = "kg"
//		}
		//store.disallowReorder = (!tempDisallowReorder.isEmpty) ? (tempDisallowReorder == "1") : false
		store.weightUnit = (!tempWeightUnit.isEmpty) ? tempWeightUnit : "kg"
//		31 value : "1" : "PS_BLOCK_CART_AJAX" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		32 value : "0" : "PS_ORDER_RETURN" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		33 value : "14" : "PS_ORDER_RETURN_NB_DAYS" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		34 value : "3" : "PS_MAIL_TYPE" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		35 value : "8388608" : "PS_PRODUCT_PICTURE_MAX_SIZE" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		36 value : "64" : "PS_PRODUCT_PICTURE_WIDTH" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		37 value : "64" : "PS_PRODUCT_PICTURE_HEIGHT" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		38 value : "{\"avoid\":[]}" : "PS_INVCE_INVOICE_ADDR_RULES" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		39 value : "{\"avoid\":[]}" : "PS_INVCE_DELIVERY_ADDR_RULES" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		40 value : "1" : "PS_DELIVERY_NUMBER" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		41 value : "1" : "PS_INVOICE" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		42 value : "360" : "PS_PASSWD_TIME_BACK" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		43 value : "360" : "PS_PASSWD_TIME_FRONT" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
		let tempPasswdTimeFront = store.configValue(forKey: "PS_PASSWD_TIME_FRONT")
//		if !tempPasswdTimeFront.isEmpty
//		{
//			store.passwdTimeFront = TimeInterval(tempPasswdTimeFront)!
//		}
//		else
//		{
//			store.passwdTimeFront = TimeInterval(0)
//		}
		//store.disallowReorder = (!tempDisallowReorder.isEmpty) ? (tempDisallowReorder == "1") : false
		store.passwdTimeFront = (!tempPasswdTimeFront.isEmpty) ? TimeInterval(tempPasswdTimeFront)! : TimeInterval(0)
//		44 value : "1440" : "PS_PASSWD_RESET_VALIDITY" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
		let passwdTimeResetValidity = store.configValue(forKey: "PS_PASSWD_RESET_VALIDITY")
//		if !passwdTimeResetValidity.isEmpty
//		{
//			store.passwdTimeResetValidity = TimeInterval(passwdTimeResetValidity)!
//		}
//		else
//		{
//			store.passwdTimeResetValidity = TimeInterval(0)
//		}
		//store.disallowReorder = (!tempDisallowReorder.isEmpty) ? (tempDisallowReorder == "1") : false
		store.passwdTimeResetValidity = (!passwdTimeResetValidity.isEmpty) ? TimeInterval(passwdTimeResetValidity)! : TimeInterval(0)
//		45 value : "1" : "PS_DISP_UNAVAILABLE_ATTR" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		46 value : "3" : "PS_SEARCH_MINWORDLEN" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		47 value : "6" : "PS_SEARCH_WEIGHT_PNAME" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		48 value : "10" : "PS_SEARCH_WEIGHT_REF" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		49 value : "1" : "PS_SEARCH_WEIGHT_SHORTDESC" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		50 value : "1" : "PS_SEARCH_WEIGHT_DESC" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		51 value : "3" : "PS_SEARCH_WEIGHT_CNAME" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		52 value : "3" : "PS_SEARCH_WEIGHT_MNAME" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		53 value : "4" : "PS_SEARCH_WEIGHT_TAG" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		54 value : "2" : "PS_SEARCH_WEIGHT_ATTRIBUTE" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		55 value : "2" : "PS_SEARCH_WEIGHT_FEATURE" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		56 value : "1" : "PS_SEARCH_AJAX" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		57 value : "America/Toronto" : "PS_TIMEZONE" date_add : "0000-00-00 00:00:00" date_upd : "2016-12-18 22:19:46"
//		58 value : "0" : "PS_THEME_V11" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		59 value : "1" : "PRESTASTORE_LIVE" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		60 value : "0" : "PS_TIN_ACTIVE" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		61 value : "0" : "PS_SHOW_ALL_MODULES" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		62 value : "0" : "PS_BACKUP_ALL" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		63 value : "2011-12-27 10:20:42" : "PS_1_3_UPDATE_DATE" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		64 value : "2" : "PS_PRICE_ROUND_MODE" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		65 value : "2011-12-27 10:20:42" : "PS_1_3_2_UPDATE_DATE" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		66 value : "0" : "PS_CONDITIONS_CMS_ID" date_add : "0000-00-00 00:00:00" date_upd : "2016-12-19 21:29:02"
//		67 value : "1" : "TRACKING_DIRECT_TRAFFIC" date_add : "0000-00-00 00:00:00" date_upd : "2017-08-08 11:02:09"
//		68 value : "cl" : "PS_VOLUME_UNIT" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		69 value : "1" : "PS_CIPHER_ALGORITHM" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		70 value : "1" : "PS_ATTRIBUTE_CATEGORY_DISPLAY" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		71 value : "1" : "PS_CUSTOMER_SERVICE_FILE_UPLOAD" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		72 value : "0" : "PS_BLOCK_BESTSELLERS_DISPLAY" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		73 value : "0" : "PS_BLOCK_NEWPRODUCTS_DISPLAY" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		74 value : "0" : "PS_BLOCK_SPECIALS_DISPLAY" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		75 value : "3" : "PS_STOCK_MVT_REASON_DEFAULT" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		76 value : "id_shop;id_currency;id_country;id_group" : "PS_SPECIFIC_PRICE_PRIORITIES" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		77 value : "1" : "PS_TAX_DISPLAY" date_add : "0000-00-00 00:00:00" date_upd : "2016-12-18 22:19:47"
//		78 value : "1" : "PS_SMARTY_FORCE_COMPILE" date_add : "0000-00-00 00:00:00" date_upd : "2017-08-08 10:27:57"
//		79 value : "km" : "PS_DISTANCE_UNIT" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		80 value : "1" : "PS_STORES_DISPLAY_CMS" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		81 value : "127" : "SHOP_LOGO_WIDTH" date_add : "0000-00-00 00:00:00" date_upd : "2017-07-26 10:04:40"
//		82 value : "77" : "SHOP_LOGO_HEIGHT" date_add : "0000-00-00 00:00:00" date_upd : "2017-07-26 10:04:40"
//		83 value : "530" : "EDITORIAL_IMAGE_WIDTH" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		84 value : "228" : "EDITORIAL_IMAGE_HEIGHT" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		85 value : "0" : "PS_STATSDATA_CUSTOMER_PAGESVIEWS" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		86 value : "0" : "PS_STATSDATA_PAGESVIEWS" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		87 value : "0" : "PS_STATSDATA_PLUGINS" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		88 value : "0" : "PS_GEOLOCATION_ENABLED" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		89 value : "AF;ZA;AX;AL;DZ;DE;AD;AO;AI;AQ;AG;AN;SA;AR;AM;AW;AU;AT;AZ;BS;BH;BD;BB;BY;BE;BZ;BJ;BM;BT;BO;BA;BW;BV;BR;BN;BG;BF;MM;BI;KY;KH;CM;CA;CV;CF;CL;CN;CX;CY;CC;CO;KM;CG;CD;CK;KR;KP;CR;CI;HR;CU;DK;DJ;DM;EG;IE;SV;AE;EC;ER;ES;EE;ET;FK;FO;FJ;FI;FR;GA;GM;GE;GS;GH;GI;GR;GD;GL;GP;GU;GT;GG;GN;GQ;GW;GY;GF;HT;HM;HN;HK;HU;IM;MU;VG;VI;IN;ID;IR;IQ;IS;IL;IT;JM;JP;JE;JO;KZ;KE;KG;KI;KW;LA;LS;LV;LB;LR;LY;LI;LT;LU;MO;MK;MG;MY;MW;MV;ML;MT;MP;MA;MH;MQ;MR;YT;MX;FM;MD;MC;MN;ME;MS;MZ;NA;NR;NP;NI;NE;NG;NU;NF;NO;NC;NZ;IO;OM;UG;UZ;PK;PW;PS;PA;PG;PY;NL;PE;PH;PN;PL;PF;PR;PT;QA;DO;CZ;RE;RO;GB;RU;RW;EH;BL;KN;SM;MF;PM;VA;VC;LC;SB;WS;AS;ST;SN;RS;SC;SL;SG;SK;SI;SO;SD;LK;SE;CH;SR;SJ;SZ;SY;TJ;TW;TZ;TD;TF;TH;TL;TG;TK;TO;TT;TN;TM;TC;TR;TV;UA;UY;US;VU;VE;VN;WF;YE;ZM;ZW" : "PS_ALLOWED_COUNTRIES" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		90 value : "0" : "PS_GEOLOCATION_BEHAVIOR" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		91 value : "en" : "PS_LOCALE_LANGUAGE" date_add : "0000-00-00 00:00:00" date_upd : "2016-12-18 22:19:46"
		//		store.defaultLangISO = store.configValue(forKey: "PS_LOCALE_LANGUAGE")
		let defaultLangISO = store.configValue(forKey: "PS_LOCALE_LANGUAGE")
//		if !defaultLangISO.isEmpty
//		{
//			store.defaultLangISO = defaultLangISO
//		}
//		else
//		{
//			store.defaultLangISO = ""
//		}
		//store.disallowReorder = (!tempDisallowReorder.isEmpty) ? (tempDisallowReorder == "1") : false
		store.defaultLangISO = (!defaultLangISO.isEmpty) ? defaultLangISO : ""
//		92 value : "ca" : "PS_LOCALE_COUNTRY" date_add : "0000-00-00 00:00:00" date_upd : "2016-12-18 22:19:46"
		//		store.defaultCountryISO = store.configValue(forKey: "PS_LOCALE_COUNTRY")
		let defaultCountryISO = store.configValue(forKey: "PS_LOCALE_COUNTRY")
//		if !defaultCountryISO.isEmpty
//		{
//			store.defaultCountryISO = defaultCountryISO
//		}
//		else
//		{
//			store.defaultCountryISO = ""
//		}
		//store.disallowReorder = (!tempDisallowReorder.isEmpty) ? (tempDisallowReorder == "1") : false
		store.defaultCountryISO = (!defaultCountryISO.isEmpty) ? defaultCountryISO : ""
//		93 value : "8" : "PS_ATTACHMENT_MAXIMUM_SIZE" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		94 value : "1" : "PS_SMARTY_CACHE" date_add : "0000-00-00 00:00:00" date_upd : "2017-06-01 18:58:18"
//		95 value : "cm" : "PS_DIMENSION_UNIT" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		96 value : "1" : "PS_GUEST_CHECKOUT_ENABLED" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		97 value : "1" : "PS_DISPLAY_SUPPLIERS" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		98 value : "0" : "PS_DISPLAY_BEST_SELLERS" date_add : "0000-00-00 00:00:00" date_upd : "2016-12-18 22:24:11"
//		99 value : "0" : "PS_CATALOG_MODE" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		100 value : "127;209.185.108;209.185.253;209.85.238;209.85.238.11;209.85.238.4;216.239.33.96;216.239.33.97;216.239.33.98;216.239.33.99;216.239.37.98;216.239.37.99;216.239.39.98;216.239.39.99;216.239.41.96;216.239.41.97;216.239.41.98;216.239.41.99;216.239.45.4;216.239.46;216.239.51.96;216.239.51.97;216.239.51.98;216.239.51.99;216.239.53.98;216.239.53.99;216.239.57.96;91.240.109;216.239.57.97;216.239.57.98;216.239.57.99;216.239.59.98;216.239.59.99;216.33.229.163;64.233.173.193;64.233.173.194;64.233.173.195;64.233.173.196;64.233.173.197;64.233.173.198;64.233.173.199;64.233.173.200;64.233.173.201;64.233.173.202;64.233.173.203;64.233.173.204;64.233.173.205;64.233.173.206;64.233.173.207;64.233.173.208;64.233.173.209;64.233.173.210;64.233.173.211;64.233.173.212;64.233.173.213;64.233.173.214;64.233.173.215;64.233.173.216;64.233.173.217;64.233.173.218;64.233.173.219;64.233.173.220;64.233.173.221;64.233.173.222;64.233.173.223;64.233.173.224;64.233.173.225;64.233.173.226;64.233.173.227;64.233.173.228;64.233.173.229;64.233.173.230;64.233.173.231;64.233.173.232;64.233.173.233;64.233.173.234;64.233.173.235;64.233.173.236;64.233.173.237;64.233.173.238;64.233.173.239;64.233.173.240;64.233.173.241;64.233.173.242;64.233.173.243;64.233.173.244;64.233.173.245;64.233.173.246;64.233.173.247;64.233.173.248;64.233.173.249;64.233.173.250;64.233.173.251;64.233.173.252;64.233.173.253;64.233.173.254;64.233.173.255;64.68.80;64.68.81;64.68.82;64.68.83;64.68.84;64.68.85;64.68.86;64.68.87;64.68.88;64.68.89;64.68.90.1;64.68.90.10;64.68.90.11;64.68.90.12;64.68.90.129;64.68.90.13;64.68.90.130;64.68.90.131;64.68.90.132;64.68.90.133;64.68.90.134;64.68.90.135;64.68.90.136;64.68.90.137;64.68.90.138;64.68.90.139;64.68.90.14;64.68.90.140;64.68.90.141;64.68.90.142;64.68.90.143;64.68.90.144;64.68.90.145;64.68.90.146;64.68.90.147;64.68.90.148;64.68.90.149;64.68.90.15;64.68.90.150;64.68.90.151;64.68.90.152;64.68.90.153;64.68.90.154;64.68.90.155;64.68.90.156;64.68.90.157;64.68.90.158;64.68.90.159;64.68.90.16;64.68.90.160;64.68.90.161;64.68.90.162;64.68.90.163;64.68.90.164;64.68.90.165;64.68.90.166;64.68.90.167;64.68.90.168;64.68.90.169;64.68.90.17;64.68.90.170;64.68.90.171;64.68.90.172;64.68.90.173;64.68.90.174;64.68.90.175;64.68.90.176;64.68.90.177;64.68.90.178;64.68.90.179;64.68.90.18;64.68.90.180;64.68.90.181;64.68.90.182;64.68.90.183;64.68.90.184;64.68.90.185;64.68.90.186;64.68.90.187;64.68.90.188;64.68.90.189;64.68.90.19;64.68.90.190;64.68.90.191;64.68.90.192;64.68.90.193;64.68.90.194;64.68.90.195;64.68.90.196;64.68.90.197;64.68.90.198;64.68.90.199;64.68.90.2;64.68.90.20;64.68.90.200;64.68.90.201;64.68.90.202;64.68.90.203;64.68.90.204;64.68.90.205;64.68.90.206;64.68.90.207;64.68.90.208;64.68.90.21;64.68.90.22;64.68.90.23;64.68.90.24;64.68.90.25;64.68.90.26;64.68.90.27;64.68.90.28;64.68.90.29;64.68.90.3;64.68.90.30;64.68.90.31;64.68.90.32;64.68.90.33;64.68.90.34;64.68.90.35;64.68.90.36;64.68.90.37;64.68.90.38;64.68.90.39;64.68.90.4;64.68.90.40;64.68.90.41;64.68.90.42;64.68.90.43;64.68.90.44;64.68.90.45;64.68.90.46;64.68.90.47;64.68.90.48;64.68.90.49;64.68.90.5;64.68.90.50;64.68.90.51;64.68.90.52;64.68.90.53;64.68.90.54;64.68.90.55;64.68.90.56;64.68.90.57;64.68.90.58;64.68.90.59;64.68.90.6;64.68.90.60;64.68.90.61;64.68.90.62;64.68.90.63;64.68.90.64;64.68.90.65;64.68.90.66;64.68.90.67;64.68.90.68;64.68.90.69;64.68.90.7;64.68.90.70;64.68.90.71;64.68.90.72;64.68.90.73;64.68.90.74;64.68.90.75;64.68.90.76;64.68.90.77;64.68.90.78;64.68.90.79;64.68.90.8;64.68.90.80;64.68.90.9;64.68.91;64.68.92;66.249.64;66.249.65;66.249.66;66.249.67;66.249.68;66.249.69;66.249.70;66.249.71;66.249.72;66.249.73;66.249.78;66.249.79;72.14.199;8.6.48" : "PS_GEOLOCATION_WHITELIST" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		101 value : "5" : "PS_LOGS_BY_EMAIL" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		102 value : "1" : "PS_COOKIE_CHECKIP" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		103 value : "0" : "PS_USE_ECOTAX" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		104 value : "2" : "PS_CANONICAL_REDIRECT" date_add : "0000-00-00 00:00:00" date_upd : "2017-07-12 17:53:43"
//		105 value : "1524677261" : "PS_IMG_UPDATE_TIME" date_add : "0000-00-00 00:00:00" date_upd : "2018-04-25 13:27:41"
//		106 value : "1" : "PS_BACKUP_DROP_TABLE" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		107 value : "1" : "PS_OS_CHEQUE" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		108 value : "2" : "PS_OS_PAYMENT" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		109 value : "3" : "PS_OS_PREPARATION" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		110 value : "4" : "PS_OS_SHIPPING" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		111 value : "5" : "PS_OS_DELIVERED" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		112 value : "6" : "PS_OS_CANCELED" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		113 value : "7" : "PS_OS_REFUND" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		114 value : "8" : "PS_OS_ERROR" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		115 value : "9" : "PS_OS_OUTOFSTOCK" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		116 value : "10" : "PS_OS_BANKWIRE" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		117 value : "11" : "PS_OS_PAYPAL" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		118 value : "12" : "PS_OS_WS_PAYMENT" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		119 value : "9" : "PS_OS_OUTOFSTOCK_PAID" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		120 value : "13" : "PS_OS_OUTOFSTOCK_UNPAID" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		121 value : "14" : "PS_OS_COD_VALIDATION" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		122 value : "0" : "PS_LEGACY_IMAGES" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		123 value : "png" : "PS_IMAGE_QUALITY" date_add : "0000-00-00 00:00:00" date_upd : "2016-12-18 22:20:12"
//		124 value : "7" : "PS_PNG_QUALITY" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		125 value : "90" : "PS_JPEG_QUALITY" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		126 value : "480" : "PS_COOKIE_LIFETIME_FO" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		127 value : "480" : "PS_COOKIE_LIFETIME_BO" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		128 value : "0" : "PS_RESTRICT_DELIVERED_COUNTRIES" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		129 value : "1" : "PS_SHOW_NEW_ORDERS" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		130 value : "1" : "PS_SHOW_NEW_CUSTOMERS" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		131 value : "1" : "PS_SHOW_NEW_MESSAGES" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		132 value : "1" : "PS_FEATURE_FEATURE_ACTIVE" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		133 value : "1" : "PS_COMBINATION_FEATURE_ACTIVE" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		134- value : nil : "PS_SPECIFIC_PRICE_FEATURE_ACTIVE" date_add : "0000-00-00 00:00:00" date_upd : "2016-12-29 11:43:24"
//		135 value : "1" : "PS_VIRTUAL_PROD_FEATURE_ACTIVE" date_add : "0000-00-00 00:00:00" date_upd : "2016-12-18 22:42:53"
//		136 value : "1" : "PS_CUSTOMIZATION_FEATURE_ACTIVE" date_add : "0000-00-00 00:00:00" date_upd : "2016-12-18 22:44:34"
//		137 value : "0" : "PS_CART_RULE_FEATURE_ACTIVE" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		138- value : nil : "PS_PACK_FEATURE_ACTIVE" date_add : "0000-00-00 00:00:00" date_upd : "2018-04-25 13:36:52"
//		139- value : nil : "PS_ALIAS_FEATURE_ACTIVE" date_add : "0000-00-00 00:00:00" date_upd : "2017-06-27 12:19:53"
//		140 value : "id_address_delivery" : "PS_TAX_ADDRESS_TYPE" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		141 value : "1" : "PS_SHOP_DEFAULT" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
		//		store.idShop = Int(store.configValue(forKey: "PS_SHOP_DEFAULT"))!
		let idShop = store.configValue(forKey: "PS_SHOP_DEFAULT")
//		if !idShop.isEmpty
//		{
//			store.idShop = Int(idShop)!
//		}
//		else
//		{
//			store.idShop = 0
//		}
		//store.disallowReorder = (!tempDisallowReorder.isEmpty) ? (tempDisallowReorder == "1") : false
		store.idShop = (!idShop.isEmpty) ? Int(idShop)! : 0
//		142 value : "0" : "PS_CARRIER_DEFAULT_SORT" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		143 value : "1" : "PS_STOCK_MVT_INC_REASON_DEFAULT" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		144 value : "2" : "PS_STOCK_MVT_DEC_REASON_DEFAULT" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		145 value : "0" : "PS_ADVANCED_STOCK_MANAGEMENT" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		146 value : "7" : "PS_STOCK_MVT_TRANSFER_TO" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		147 value : "6" : "PS_STOCK_MVT_TRANSFER_FROM" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		148 value : "0" : "PS_CARRIER_DEFAULT_ORDER" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		149 value : "8" : "PS_STOCK_MVT_SUPPLY_ORDER" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		150 value : "3" : "PS_STOCK_CUSTOMER_ORDER_REASON" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		151 value : "1" : "PS_UNIDENTIFIED_GROUP" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		152 value : "2" : "PS_GUEST_GROUP" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		153 value : "3" : "PS_CUSTOMER_GROUP" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
		//		store.idDefaultGroup = Int(store.configValue(forKey: "PS_CUSTOMER_GROUP"))!
		let idDefaultGroup = store.configValue(forKey: "PS_CUSTOMER_GROUP")
//		if !idDefaultGroup.isEmpty
//		{
//			store.idDefaultGroup = Int(idDefaultGroup)!
//		}
//		else
//		{
//			store.idDefaultGroup = 0
//		}
		//store.disallowReorder = (!tempDisallowReorder.isEmpty) ? (tempDisallowReorder == "1") : false
		store.idDefaultGroup = (!idDefaultGroup.isEmpty) ? Int(idDefaultGroup)! : 0
//		154 value : "0" : "PS_SMARTY_CONSOLE" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		155 value : "invoice" : "PS_INVOICE_MODEL" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		156 value : "2" : "PS_LIMIT_UPLOAD_IMAGE_VALUE" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		157 value : "2" : "PS_LIMIT_UPLOAD_FILE_VALUE" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		158- value : nil : "MB_PAY_TO_EMAIL" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		159- value : nil : "MB_SECRET_WORD" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		160 value : "1" : "MB_HIDE_LOGIN" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		161 value : "1" : "MB_ID_LOGO" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		162 value : "1" : "MB_ID_LOGO_WALLET" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		163 value : "0" : "MB_PARAMETERS" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		164 value : "0" : "MB_PARAMETERS_2" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		165 value : "0" : "MB_DISPLAY_MODE" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		166 value : "http://www.yoursite.com" : "MB_CANCEL_URL" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		167 value : "2" : "MB_LOCAL_METHODS" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		168 value : "5" : "MB_INTER_METHODS" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		169 value : "2,1" : "BANK_WIRE_CURRENCIES" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		170 value : "2,1" : "CHEQUE_CURRENCIES" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		171 value : "3" : "PRODUCTS_VIEWED_NBR" date_add : "0000-00-00 00:00:00" date_upd : "2016-12-23 12:02:04"
//		172 value : "1" : "BLOCK_CATEG_DHTML" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		173 value : "4" : "BLOCK_CATEG_MAX_DEPTH" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		174 value : "1" : "MANUFACTURER_DISPLAY_FORM" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		175 value : "1" : "MANUFACTURER_DISPLAY_TEXT" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		176 value : "5" : "MANUFACTURER_DISPLAY_TEXT_NB" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		177 value : "8" : "NEW_PRODUCTS_NBR" date_add : "0000-00-00 00:00:00" date_upd : "2017-06-01 19:48:12"
//		178 value : "0" : "PS_TOKEN_ENABLE" date_add : "0000-00-00 00:00:00" date_upd : "2016-12-18 22:24:11"
//		179 value : "graphnvd3" : "PS_STATS_RENDER" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		180 value : "never" : "PS_STATS_OLD_CONNECT_AUTO_CLEAN" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		181 value : "gridhtml" : "PS_STATS_GRID_RENDER" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		182 value : "10" : "BLOCKTAGS_NBR" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		183 value : "100" : "CHECKUP_DESCRIPTIONS_LT" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		184 value : "400" : "CHECKUP_DESCRIPTIONS_GT" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		185 value : "1" : "CHECKUP_IMAGES_LT" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		186 value : "2" : "CHECKUP_IMAGES_GT" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		187 value : "1" : "CHECKUP_SALES_LT" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		188 value : "2" : "CHECKUP_SALES_GT" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		189 value : "1" : "CHECKUP_STOCK_LT" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		190 value : "3" : "CHECKUP_STOCK_GT" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		191 value : "0_3|0_4" : "FOOTER_CMS" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		192 value : "0_3|0_4" : "FOOTER_BLOCK_ACTIVATION" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		193 value : "1" : "FOOTER_POWEREDBY" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		194 value : "http://www.prestashop.com" : "BLOCKADVERT_LINK" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		195 value : "store.jpg" : "BLOCKSTORE_IMG" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		196 value : "jpg" : "BLOCKADVERT_IMG_EXT" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		197 value : "CAT2,CAT12,CAT13,CAT14,LNK1,CAT15,LNK2" : "MOD_BLOCKTOPMENU_ITEMS" date_add : "0000-00-00 00:00:00" date_upd : "2017-05-20 12:36:09"
//		198- value : nil : "MOD_BLOCKTOPMENU_SEARCH" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		199- value : nil : "BLOCKSOCIAL_FACEBOOK" date_add : "0000-00-00 00:00:00" date_upd : "2016-12-18 22:20:04"
//		200- value : nil : "BLOCKSOCIAL_TWITTER" date_add : "0000-00-00 00:00:00" date_upd : "2016-12-18 22:20:04"
//		201- value : nil : "BLOCKSOCIAL_RSS" date_add : "0000-00-00 00:00:00" date_upd : "2016-12-18 22:20:04"
//		202 value : "Your company" : "BLOCKCONTACTINFOS_COMPANY" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		203 value : "Address line 1\nCity\nCountry" : "BLOCKCONTACTINFOS_ADDRESS" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		204 value : "0123-456-789" : "BLOCKCONTACTINFOS_PHONE" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		205 value : "pub@prestashop.com" : "BLOCKCONTACTINFOS_EMAIL" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		206 value : "0123-456-789" : "BLOCKCONTACT_TELNUMBER" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		207 value : "pub@prestashop.com" : "BLOCKCONTACT_EMAIL" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		208 value : "1" : "SUPPLIER_DISPLAY_TEXT" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		209 value : "5" : "SUPPLIER_DISPLAY_TEXT_NB" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		210 value : "1" : "SUPPLIER_DISPLAY_FORM" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		211 value : "1" : "BLOCK_CATEG_NBR_COLUMN_FOOTER" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		212- value : nil : "UPGRADER_BACKUPDB_FILENAME" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		213- value : nil : "UPGRADER_BACKUPFILES_FILENAME" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		214 value : "5" : "BLOCKREINSURANCE_NBBLOCKS" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		215 value : "535" : "HOMESLIDER_WIDTH" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		216 value : "5000" : "HOMESLIDER_SPEED" date_add : "0000-00-00 00:00:00" date_upd : "2016-12-18 22:20:04"
//		217 value : "7700" : "HOMESLIDER_PAUSE" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		218 value : "1" : "HOMESLIDER_LOOP" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		219 value : "m" : "PS_BASE_DISTANCE_UNIT" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		220 value : "yumatechnical.com" : "PS_SHOP_DOMAIN" date_add : "0000-00-00 00:00:00" date_upd : "2016-12-18 22:19:46"
//		221 value : "yumatechnical.com" : "PS_SHOP_DOMAIN_SSL" date_add : "0000-00-00 00:00:00" date_upd : "2016-12-18 22:19:46"
//		222 value : "Yuma Technical Store" : "PS_SHOP_NAME" date_add : "0000-00-00 00:00:00" date_upd : "2016-12-19 21:32:37"
//		23 value : "sales@yumatechnical.com" : "PS_SHOP_EMAIL" date_add : "0000-00-00 00:00:00" date_upd : "2016-12-18 22:19:48"
//		224 value : "1" : "PS_MAIL_METHOD" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		225 value : "17" : "PS_SHOP_ACTIVITY" date_add : "0000-00-00 00:00:00" date_upd : "2016-12-18 22:19:46"
//		226 value : "yuma-technical-store-logo-1501078136.jpg" : "PS_LOGO" date_add : "0000-00-00 00:00:00" date_upd : "2017-07-26 10:08:56"
//		227 value : "favicon.ico" : "PS_FAVICON" date_add : "0000-00-00 00:00:00" date_upd : "2018-04-25 13:27:41"
//		228 value : "logo_stores.png" : "PS_STORES_ICON" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		229 value : "1" : "PS_ROOT_CATEGORY" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		230 value : "2" : "PS_HOME_CATEGORY" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		231 value : "0" : "PS_CONFIGURATION_AGREMENT" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		232 value : "smtp." : "PS_MAIL_SERVER" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		233- value : nil : "PS_MAIL_USER" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		234- value : nil : "PS_MAIL_PASSWD" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		235 value : "off" : "PS_MAIL_SMTP_ENCRYPTION" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		236 value : "25" : "PS_MAIL_SMTP_PORT" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		237 value : "#db3484" : "PS_MAIL_COLOR" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		238 value : "n0Rx3rmYgQ0BXWnb" : "NW_SALT" date_add : "0000-00-00 00:00:00" date_upd : "2016-12-18 22:20:03"
//		239 value : "0" : "PS_PAYMENT_LOGO_CMS_ID" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		240 value : "8" : "HOME_FEATURED_NBR" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		241 value : "1" : "SEK_MIN_OCCURENCES" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		242- value : nil : "SEK_FILTER_KW" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		243 value : "1" : "PS_ALLOW_MOBILE_DEVICE" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		244 value : "1" : "PS_CUSTOMER_CREATION_EMAIL" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		245 value : "SMARTY_DEBUG" : "PS_SMARTY_CONSOLE_KEY" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		246 value : "0" : "PS_DASHBOARD_USE_PUSH" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		247 value : "-" : "PS_ATTRIBUTE_ANCHOR_SEPARATOR" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		248 value : "40" : "CONF_AVERAGE_PRODUCT_MARGIN" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		249 value : "0" : "PS_DASHBOARD_SIMULATION" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		250 value : "1" : "PS_USE_HTMLPURIFIER" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		251 value : "filesystem" : "PS_SMARTY_CACHING_TYPE" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		252 value : "1" : "PS_SMARTY_LOCAL" date_add : "0000-00-00 00:00:00" date_upd : "2017-01-02 22:31:46"
//		253 value : "everytime" : "PS_SMARTY_CLEAR_CACHE" date_add : "0000-00-00 00:00:00" date_upd : "2017-01-02 22:40:14"
//		254 value : "1" : "PS_DETECT_LANG" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		255 value : "1" : "PS_DETECT_COUNTRY" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		256 value : "2" : "PS_ROUND_TYPE" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		257 value : "2" : "PS_PRICE_DISPLAY_PRECISION" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		258 value : "1" : "PS_LOG_EMAILS" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		259 value : "1" : "PS_CUSTOMER_OPTIN" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
		//		store.custOptin = Int(store.configValue(forKey: "PS_CUSTOMER_OPTIN"))!
		let custOptin = store.configValue(forKey: "PS_CUSTOMER_OPTIN")
//		if !custOptin.isEmpty
//		{
//			store.custOptin = Int(custOptin)!
//		}
//		else
//		{
//			store.custOptin = 0
//		}
//		store.disallowReorder = (!tempDisallowReorder.isEmpty) ? (tempDisallowReorder == "1") : false
		store.custOptin = (!custOptin.isEmpty) ? Int(custOptin)! : 0
//		260 value : "1" : "PS_CUSTOMER_BIRTHDATE" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
		//		store.custBDate = Int(store.configValue(forKey: "PS_CUSTOMER_BIRTHDATE"))!
		let custBDate = store.configValue(forKey: "PS_CUSTOMER_BIRTHDATE")
//		if !custBDate.isEmpty
//		{
//			store.custBDate = Int(custBDate)!
//		}
//		else
//		{
//			store.custBDate = 0
//		}
//		store.disallowReorder = (!tempDisallowReorder.isEmpty) ? (tempDisallowReorder == "1") : false
		store.custBDate = (!custBDate.isEmpty) ? Int(custBDate)! : 0
//		261 value : "0" : "PS_PACK_STOCK_TYPE" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		262 value : "0" : "PS_LOG_MODULE_PERFS_MODULO" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		263 value : "0" : "PS_DISALLOW_HISTORY_REORDERING" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
		//		store.preventReorderFromHist = Int(store.configValue(forKey: "PS_DISALLOW_HISTORY_REORDERING"))!
//		let preventReorderFromHist = store.configValue(forKey: "PS_DISALLOW_HISTORY_REORDERING")
//		if !preventReorderFromHist.isEmpty
//		{
//			store.preventReorderFromHist = Int(preventReorderFromHist)!
//		}
//		else
//		{
//			store.preventReorderFromHist = 0
//		}
		let tempDisallowReorder = store.configValue(forKey: "PS_DISALLOW_HISTORY_REORDERING")
//		if /*tempDisallowReorder is String &&*/ !tempDisallowReorder.isEmpty
//		{
//			store.disallowReorder = (tempDisallowReorder == "1")
//		}
////		else if tempDisallowReorder is Int
////		{
////			store.disallowReorder = (tempDisallowReorder == 1)
////		}
//		else
//		{
//			store.disallowReorder = false
//		}
		store.disallowReorder = (!tempDisallowReorder.isEmpty) ? (tempDisallowReorder == "1") : false
//		store.disallowReorder = (!tempDisallowReorder.isEmpty) ? Int(tempDisallowReorder)! : 0
//		264 value : "0" : "PS_DISPLAY_PRODUCT_WEIGHT" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
		//		store.displayWeight = Int(store.configValue(forKey: "PS_DISPLAY_PRODUCT_WEIGHT"))!
		let displayWeight = store.configValue(forKey: "PS_DISPLAY_PRODUCT_WEIGHT")
//		if !displayWeight.isEmpty
//		{
//			store.displayWeight = (displayWeight == "1")
//		}
//		else
//		{
//			store.displayWeight = false
//		}
		store.displayWeight = (!displayWeight.isEmpty) ? (displayWeight == "1") : false
//		265 value : "2" : "PS_PRODUCT_WEIGHT_PRECISION" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		266 value : "0" : "PS_ACTIVE_CRONJOB_EXCHANGE_RATE" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		267 value : "1" : "PS_ORDER_RECALCULATE_SHIPPING" date_add : "0000-00-00 00:00:00" date_upd : "0000-00-00 00:00:00"
//		268 value : "1" : "PRICE_DISPLAY_METHOD" date_add : "2016-12-18 22:19:47" date_upd : "2016-12-18 22:19:47"
//		269 value : "30" : "DASHACTIVITY_CART_ACTIVE" date_add : "2016-12-18 22:20:02" date_upd : "2016-12-18 22:20:02"
//		270 value : "24" : "DASHACTIVITY_CART_ABANDONED_MIN" date_add : "2016-12-18 22:20:02" date_upd : "2016-12-18 22:20:02"
//		271 value : "48" : "DASHACTIVITY_CART_ABANDONED_MAX" date_add : "2016-12-18 22:20:02" date_upd : "2016-12-18 22:20:02"
//		272 value : "30" : "DASHACTIVITY_VISITOR_ONLINE" date_add : "2016-12-18 22:20:02" date_upd : "2016-12-18 22:20:02"
//		273 value : "2016" : "PS_DASHGOALS_CURRENT_YEAR" date_add : "2016-12-18 22:20:02" date_upd : "2016-12-18 22:20:02"
//		274 value : "10" : "DASHPRODUCT_NBR_SHOW_LAST_ORDER" date_add : "2016-12-18 22:20:02" date_upd : "2016-12-18 22:20:02"
//		275 value : "10" : "DASHPRODUCT_NBR_SHOW_BEST_SELLER" date_add : "2016-12-18 22:20:02" date_upd : "2016-12-18 22:20:02"
//		276 value : "10" : "DASHPRODUCT_NBR_SHOW_MOST_VIEWED" date_add : "2016-12-18 22:20:02" date_upd : "2016-12-18 22:20:02"
//		277 value : "10" : "DASHPRODUCT_NBR_SHOW_TOP_SEARCH" date_add : "2016-12-18 22:20:02" date_upd : "2016-12-18 22:20:02"
//		278 value : "3" : "BLOCK_CATEG_ROOT_CATEGORY" date_add : "2016-12-18 22:20:02" date_upd : "2016-12-23 17:11:34"
//		279 value : "0.2" : "CONF_PS_CHECKPAYMENT_FIXED" date_add : "2016-12-18 22:20:02" date_upd : "2016-12-18 22:20:02"
//		280 value : "2" : "CONF_PS_CHECKPAYMENT_VAR" date_add : "2016-12-18 22:20:02" date_upd : "2016-12-18 22:20:02"
//		281 value : "0.2" : "CONF_PS_CHECKPAYMENT_FIXED_FOREIGN" date_add : "2016-12-18 22:20:02" date_upd : "2016-12-18 22:20:02"
//		282 value : "2" : "CONF_PS_CHECKPAYMENT_VAR_FOREIGN" date_add : "2016-12-18 22:20:02" date_upd : "2016-12-18 22:20:02"
//		283 value : "1342558327993428875" : "PS_NEWSLETTER_RAND" date_add : "2016-12-18 22:20:03" date_upd : "2016-12-18 22:20:03"
//		284 value : "1" : "PS_LAYERED_SHOW_QTIES" date_add : "2016-12-18 22:20:03" date_upd : "2016-12-18 22:20:03"
//		285 value : "1" : "PS_LAYERED_FULL_TREE" date_add : "2016-12-18 22:20:03" date_upd : "2016-12-18 22:20:03"
//		286 value : "1" : "PS_LAYERED_FILTER_PRICE_USETAX" date_add : "2016-12-18 22:20:03" date_upd : "2016-12-18 22:20:03"
//		287 value : "1" : "PS_LAYERED_FILTER_CATEGORY_DEPTH" date_add : "2016-12-18 22:20:03" date_upd : "2016-12-18 22:20:03"
//		288 value : "1" : "PS_LAYERED_FILTER_PRICE_ROUNDING" date_add : "2016-12-18 22:20:03" date_upd : "2016-12-18 22:20:03"
//		289 value : "1" : "PS_LAYERED_INDEXED" date_add : "2016-12-18 22:20:03" date_upd : "2016-12-18 22:20:03"
//		290 value : "47" : "HOME_FEATURED_CAT" date_add : "2016-12-18 22:20:03" date_upd : "2017-01-02 22:51:33"
//		291 value : "1" : "HOMESLIDER_PAUSE_ON_HOVER" date_add : "2016-12-18 22:20:04" date_upd : "2016-12-18 22:20:04"
//		292 value : "1" : "HOMESLIDER_WRAP" date_add : "2016-12-18 22:20:04" date_upd : "2016-12-18 22:20:04"
//		293 value : "1" : "PS_SC_TWITTER" date_add : "2016-12-18 22:20:04" date_upd : "2016-12-18 22:20:04"
//		294 value : "1" : "PS_SC_FACEBOOK" date_add : "2016-12-18 22:20:04" date_upd : "2016-12-18 22:20:04"
//		295 value : "1" : "PS_SC_GOOGLE" date_add : "2016-12-18 22:20:04" date_upd : "2016-12-18 22:20:04"
//		296 value : "1" : "PS_SC_PINTEREST" date_add : "2016-12-18 22:20:04" date_upd : "2016-12-18 22:20:04"
//		297 value : "12" : "PS_BLOCK_CART_XSELL_LIMIT" date_add : "2016-12-18 22:20:04" date_upd : "2016-12-18 22:20:04"
//		298 value : "1" : "PS_BLOCK_CART_SHOW_CROSSSELLING" date_add : "2016-12-18 22:20:04" date_upd : "2016-12-18 22:20:04"
//		299- value : nil : "BLOCKSOCIAL_YOUTUBE" date_add : "2016-12-18 22:20:04" date_upd : "2016-12-18 22:20:04"
//		300	- value : nil : "BLOCKSOCIAL_GOOGLE_PLUS" date_add : "2016-12-18 22:20:04" date_upd : "2016-12-18 22:20:04"
//		301- value : nil : "BLOCKSOCIAL_PINTEREST" date_add : "2016-12-18 22:20:04" date_upd : "2016-12-18 22:20:04"
//		302- value : nil : "BLOCKSOCIAL_VIMEO" date_add : "2016-12-18 22:20:04" date_upd : "2016-12-18 22:20:04"
//		303	- value : nil : "BLOCKSOCIAL_INSTAGRAM" date_add : "2016-12-18 22:20:04" date_upd : "2016-12-18 22:20:04"
//		304 value : "1" : "BANK_WIRE_PAYMENT_INVITE" date_add : "2016-12-18 22:20:04" date_upd : "2016-12-18 22:20:04"
//		305 value : "0.2" : "CONF_PS_WIREPAYMENT_FIXED" date_add : "2016-12-18 22:20:04" date_upd : "2016-12-18 22:20:04"
//		306 value : "2"	: "CONF_PS_WIREPAYMENT_VAR" date_add : "2016-12-18 22:20:04" date_upd : "2016-12-18 22:20:04"
//		307 value : "0.2" : "CONF_PS_WIREPAYMENT_FIXED_FOREIGN" date_add : "2016-12-18 22:20:04" date_upd : "2016-12-18 22:20:04"
//		308 value : "2" : "CONF_PS_WIREPAYMENT_VAR_FOREIGN" date_add : "2016-12-18 22:20:04" date_upd : "2016-12-18 22:20:04"
//		309 value : "5" : "BLOCKREASSURANCE_NBBLOCKS" date_add : "2016-12-18 22:20:12" date_upd : "2016-12-18 22:20:12"
//		310 value : "0" : "ONBOARDINGV2_CURRENT_STEP" date_add : "2016-12-18 22:22:14" date_upd : "2017-11-30 09:15:17"
//		311 value : "1" : "ONBOARDINGV2_SHUT_DOWN" date_add : "2016-12-18 22:22:37" date_upd : "2016-12-18 22:22:37"
//		312 value : "0" : "PS_SSL_ENABLED_EVERYWHERE" date_add : "2016-12-18 22:24:11" date_upd : "2016-12-18 22:24:11"
//		313 value : "1" : "PS_ALLOW_HTML_IFRAME" date_add : "2016-12-18 22:24:11" date_upd : "2016-12-18 22:24:11"
//		314 value : "0" : "PS_MULTISHOP_FEATURE_ACTIVE" date_add : "2016-12-18 22:24:11" date_upd : "2017-06-01 18:57:05"
//		315 value : "64" : "PS_CCCJS_VERSION" date_add : "2016-12-18 22:27:44" date_upd : "2018-05-24 12:39:57"
//		316 value : "64": "PS_CCCCSS_VERSION" date_add : "2016-12-18 22:27:44" date_upd : "2018-05-24 12:39:57"
//		317 value : "0" : "PS_DISABLE_NON_NATIVE_MODULE" date_add : "2016-12-19 11:47:08" date_upd : "2017-06-10 20:04:56"
//		318 value : "1" : "PS_DISABLE_OVERRIDES" date_add : "2016-12-19 11:47:08" date_upd : "2017-06-10 20:04:56"
//		319 value : "0" : "PS_PRODUCT_SHORT_DESC_LIMIT" date_add : "2016-12-19 21:27:48" date_upd : "2016-12-19 21:27:48"
//		320 value : "0" : "PS_QTY_DISCOUNT_ON_COMBINATION" date_add : "2016-12-19 21:27:48" date_upd : "2016-12-19 21:27:48"
//		321 value : "0" : "PS_FORCE_FRIENDLY_PRODUCT" date_add : "2016-12-19 21:27:48" date_upd : "2016-12-19 21:27:48"
//		322 value : "0" : "PS_PRODUCT_ACTIVATION_DEFAULT" date_add : "2016-12-19 21:27:48" date_upd : "2016-12-19 21:27:48"
//		323 value : "1" : "PS_DISPLAY_DISCOUNT_PRICE" date_add : "2016-12-19 21:27:48" date_upd : "2016-12-23 16:09:23"
		//		store.displayDiscPrice = Int(store.configValue(forKey: "PS_DISPLAY_DISCOUNT_PRICE"))!
		let displayDiscPrice = store.configValue(forKey: "PS_DISPLAY_DISCOUNT_PRICE")
//		if !displayDiscPrice.isEmpty
//		{
//			store.displayDiscPrice = Int(displayDiscPrice)!
//		}
//		else
//		{
//			store.displayDiscPrice = 0
//		}
		store.displayDiscPrice = (!displayDiscPrice.isEmpty) ? Int(displayDiscPrice)! : 0
//		324 value : "0" : "PS_FINAL_SUMMARY_ENABLED" date_add : "2016-12-19 21:29:02" date_upd : "2016-12-19 21:29:02"
//		325 value : "0" : "PS_SHIP_WHEN_AVAILABLE" date_add : "2016-12-19 21:29:02" date_upd : "2016-12-19 21:29:02"
//		326 value : "0" : "PS_GIFT_WRAPPING_TAX_RULES_GROUP" date_add : "2016-12-19 21:29:02" date_upd : "2016-12-19 21:29:02"
//		327- value : nil : "PS_SHOP_DETAILS" date_add : "2016-12-19 21:32:37" date_upd : "2016-12-19 21:32:37"
//		328 value : "24 Hancock Cres" : "PS_SHOP_ADDR1" date_add : "2016-12-19 21:32:37" date_upd : "2016-12-19 21:32:37"
//		329	- value : nil : "PS_SHOP_ADDR2" date_add : "2016-12-19 21:32:37" date_upd : "2016-12-19 21:32:37"
//		330 value : "M1R 2A3" : "PS_SHOP_CODE" date_add : "2016-12-19 21:32:37" date_upd : "2016-12-19 21:32:37"
//		331 value : "Scarborough": "PS_SHOP_CITY" date_add : "2016-12-19 21:32:37" date_upd : "2016-12-19 21:32:37"
//		332 value : "4" : "PS_SHOP_COUNTRY_ID" date_add : "2016-12-19 21:32:37" date_upd : "2016-12-19 21:32:37"
//		333 value : "Canada" : "PS_SHOP_COUNTRY" date_add : "2016-12-19 21:32:37" date_upd : "2016-12-19 21:32:37"
//		334 value : "647-956-6145" : "PS_SHOP_PHONE" date_add : "2016-12-19 21:32:37" date_upd : "2016-12-19 21:32:37"
//		335	- value : nil : "PS_SHOP_FAX" date_add : "2016-12-19 21:32:37" date_upd : "2016-12-19 21:32:37"
//		336 value : "1" : "PS_CSS_THEME_CACHE" date_add : "2016-12-20 18:23:18" date_upd : "2017-07-13 10:30:00"
//		337 value : "1" : "PS_JS_THEME_CACHE" date_add : "2016-12-20 18:23:18" date_upd : "2017-07-13 10:30:00"
//		338 value : "1" : "PS_HTACCESS_CACHE_CONTROL" date_add : "2016-12-20 18:23:18" date_upd : "2017-06-01 18:59:13"
//		339	- value : nil : "GOOGLE_SHOPPING_ACCOUNT_EMAIL" date_add : "2016-12-23 12:20:50" date_upd : "2016-12-23 12:20:50"
//		340	- value : nil : "GOOGLE_WEBMASTER_TAG_CONTENT" date_add : "2016-12-23 12:20:50" date_upd : "2016-12-23 12:20:50"
//		341 value : "1" : "GOOGLE_WEBSERVICE_KEY_ID" date_add : "2016-12-23 12:20:50" date_upd : "2016-12-23 12:20:56"
//		342 value : "1" : "PS_WEBSERVICE" date_add : "2016-12-23 12:20:56" date_upd : "2016-12-23 12:20:56"
//		343 value : " \'2018-01-01 00:00:00\' AND \'2018-04-25 23:59:59\' " : "PS_REFERRERS_CACHE_LIKE" date_add : "2016-12-23 16:11:07" date_upd : "2018-05-22 15:42:27"
//		344 value : "2018-05-22 15:42:53" : "PS_REFERRERS_CACHE_DATE" date_add : "2016-12-23 16:11:07" date_upd : "2018-05-22 15:42:53"
//		345 value : "0" : "BLOCK_CATEG_SORT_WAY" date_add : "2016-12-23 17:11:34" date_upd : "2016-12-23 17:11:34"
//		346 value : "0" : "BLOCK_CATEG_SORT" date_add : "2016-12-23 17:11:34" date_upd : "2016-12-23 17:11:34"
//		347 value : "99.235.192.131,99.227.5.140" : "PS_MAINTENANCE_IP" date_add : "2017-01-02 22:27:55" date_upd : "2018-02-23 10:12:54"
//		348 value : "1523920808" : "PS_LAST_VERSION_CHECK" date_add : "2017-01-02 22:29:46" date_upd : "2018-04-16 19:20:08"
//		349 value : "1" : "PS_AUTOUP_UPDATE_DEFAULT_THEME" date_add : "2017-01-02 22:29:47" date_upd : "2017-01-02 22:29:47"
//		350 value : "0" : "PS_AUTOUP_CHANGE_DEFAULT_THEME" date_add : "2017-01-02 22:29:47" date_upd : "2017-01-02 22:29:47"
//		351 value : "0" : "PS_AUTOUP_KEEP_MAILS" date_add : "2017-01-02 22:29:47" date_upd : "2017-01-02 22:29:47"
//		352 value : "1" : "PS_AUTOUP_CUSTOM_MOD_DESACT" date_add : "2017-01-02 22:29:47" date_upd : "2017-01-02 22:29:47"
//		353 value : "0" : "PS_AUTOUP_MANUAL_MODE" date_add : "2017-01-02 22:29:47" date_upd : "2017-01-02 22:29:47"
//		354 value : "1" : "PS_AUTOUP_PERFORMANCE" date_add : "2017-01-02 22:29:47" date_upd : "2017-01-02 22:29:47"
//		355 value : "0" : "PS_DISPLAY_ERRORS" date_add : "2017-01-02 22:29:47" date_upd : "2017-01-02 22:29:47"
//		356 value : "8" : "HOME_FEATUREDSVC_NBR" date_add : "2017-01-02 22:43:53" date_upd : "2017-01-02 22:43:53"
//		357 value : "15" : "HOME_FEATUREDSVC_CAT" date_add : "2017-01-02 22:43:53" date_upd : "2017-01-02 22:43:53"
//		358 value : "1" : "HOME_FEATUREDSVC_RANDOMIZE" date_add : "2017-01-02 22:43:53" date_upd : "2017-01-02 22:43:53"
//		359 value : "50" : "st_y" date_add : "2017-01-02 22:50:44" date_upd : "2017-01-02 22:50:44"
//		360 value : "50" : "st_x" date_add : "2017-01-02 22:50:44" date_upd : "2017-01-02 22:50:44"
//		361 value : "0.6" : "st_o" date_add : "2017-01-02 22:50:44" date_upd : "2017-01-02 22:50:44"
//		362 value : "1" : "st_color" date_add : "2017-01-02 22:50:44" date_upd : "2017-01-02 22:50:44"
//		363 value : "1" : "HOME_FEATURED_RANDOMIZE" date_add : "2017-01-02 22:51:33" date_upd : "2017-01-02 22:51:33"
//		364 value : "0" : "PS_MEDIA_SERVERS" date_add : "2017-01-11 11:01:31" date_upd : "2018-03-07 14:55:55"
//		365	- value : nil : "PS_MEDIA_SERVER_1" date_add : "2017-01-11 11:01:31" date_upd : "2018-03-07 14:55:55"
//		366 value : "0" : "MA_MERCHANT_COVERAGE" date_add : "2017-01-12 11:43:30" date_upd : "2017-01-12 11:43:30"
//		367 value : "0" : "MA_PRODUCT_COVERAGE" date_add : "2017-01-12 11:43:30" date_upd : "2017-01-12 11:43:30"
//		368 value : "1" : "MA_RETURN_SLIP" date_add : "2017-01-12 11:44:18" date_upd : "2017-01-12 11:44:18"
//		369 value : "U2AYAOQQAQMKXJCQ" : "PS_FOLLOWUP_SECURE_KEY" date_add : "2017-01-22 14:49:18" date_upd : "2017-01-22 14:49:18"
//		370 value : "major" : "PS_UPGRADE_CHANNEL" date_add : "2017-04-06 11:47:25" date_upd : "2017-04-06 11:47:25"
//		371 value : "Yuma Technical Inc." : "CHEQUE_NAME" date_add : "2017-05-20 12:24:55" date_upd : "2017-05-20 12:24:55"
//		372 value : "24 Hancock Cres\r\nScarborough\r\nM1R 2A3" : "CHEQUE_ADDRESS" date_add : "2017-05-20 12:24:55" date_upd : "2017-05-20 12:24:55"
//		373 value : "Bank of Montreal" : "BANK_WIRE_DETAILS" date_add : "2017-05-20 12:27:27" date_upd : "2017-05-20 12:27:27"
//		374 value : "Yuma Technical Inc." : "BANK_WIRE_OWNER" date_add : "2017-05-20 12:27:27" date_upd : "2017-05-20 12:27:27"
//		375 value : "Bank of Montreal" : "BANK_WIRE_ADDRESS" date_add : "2017-05-20 12:27:27" date_upd : "2017-05-20 12:27:27"
//		376	- value : nil : "BANK_WIRE_RESERVATION_DAYS" date_add : "2017-05-20 12:27:27" date_upd : "2017-05-20 12:27:27"
//		377	- value : nil : "BANK_WIRE_CUSTOM_TEXT" date_add : "2017-05-20 12:27:27" date_upd : "2017-05-20 12:27:27"
//		378	- value : nil : "MYBANNER_LINK" date_add : "2017-05-20 18:39:41" date_upd : "2017-05-20 18:39:41"
//		379	- value : nil : "MYBANNER_DESC" date_add : "2017-05-20 18:39:41" date_upd : "2017-05-20 18:39:41"
//		380 value : "1" : "GSITEMAP_PRIORITY_HOME" date_add : "2017-06-26 18:49:25" date_upd : "2017-06-26 18:49:25"
//		381 value : "0.9" : "GSITEMAP_PRIORITY_PRODUCT" date_add : "2017-06-26 18:49:25" date_upd : "2017-06-26 18:49:25"
//		382 value : "0.8" : "GSITEMAP_PRIORITY_CATEGORY" date_add : "2017-06-26 18:49:25" date_upd : "2017-06-26 18:49:25"
//		383 value : "0.7" : "GSITEMAP_PRIORITY_MANUFACTURER" date_add : "2017-06-26 18:49:25" date_upd : "2017-06-26 18:49:25"
//		384 value : "0.6" : "GSITEMAP_PRIORITY_SUPPLIER" date_add : "2017-06-26 18:49:25" date_upd : "2017-06-26 18:49:25"
//		385 value : "0.5" : "GSITEMAP_PRIORITY_CMS" date_add : "2017-06-26 18:49:25" date_upd : "2017-06-26 18:49:25"
//		386 value : "monthly" : "GSITEMAP_FREQUENCY" date_add : "2017-06-26 18:49:25" date_upd : "2017-06-26 18:50:52"
//		387	- value : nil : "GSITEMAP_INDEX_CHECK" date_add : "2017-06-26 18:50:52" date_upd : "2017-06-26 18:50:52"
//		388	- value : nil : "GSITEMAP_CHECK_IMAGE_FILE" date_add : "2017-06-26 18:50:52" date_upd : "2017-06-26 18:50:52"
//		389 value : "11, 12, 13, 14, 3, 15, 24, 16, 17, 43, 18, 6, 21, 25, 19, 20, 1, 7, 22, 9, 23, 10" : "GSITEMAP_DISABLE_LINKS" date_add : "2017-06-26 18:50:52" date_upd : "2017-08-11 14:39:57"
//		390 value : "Fri, 11 Aug 2017 14:39:57 -0400" : "GSITEMAP_LAST_EXPORT" date_add : "2017-06-26 18:50:53" date_upd : "2017-08-11 14:39:57"
//		391 value : "1" : "PS_SEARCH_START" date_add : "2017-06-27 12:10:58" date_upd : "2017-06-27 12:10:58"
//		392 value : "0" : "PS_SEARCH_END" date_add : "2017-06-27 12:10:58" date_upd : "2017-06-27 12:10:58"
//		393 value : "0" : "PS_ALLOW_ACCENTED_CHARS_URL" date_add : "2017-07-12 17:53:43" date_upd : "2017-07-12 17:53:43"
//		394 value : "0" : "PS_HTACCESS_DISABLE_MULTIVIEWS" date_add : "2017-07-12 17:53:43" date_upd : "2017-07-12 17:53:43"
//		395 value : "1" : "PS_HTACCESS_DISABLE_MODSEC" date_add : "2017-07-12 17:53:43" date_upd : "2017-07-12 18:12:59"
//		396	- value : nil : "PS_ROUTE_product_rule" date_add : "2017-07-12 17:53:43" date_upd : "2017-07-12 17:53:43"
//		397	- value : nil : "PS_ROUTE_category_rule" date_add : "2017-07-12 17:53:43" date_upd : "2017-07-12 17:53:43"
//		398	- value : nil : "PS_ROUTE_layered_rule" date_add : "2017-07-12 17:53:43" date_upd : "2017-07-12 17:53:43"
//		399	- value : nil : "PS_ROUTE_supplier_rule" date_add : "2017-07-12 17:53:43" date_upd : "2017-07-12 17:53:43"
//		400- value : nil : "PS_ROUTE_manufacturer_rule" date_add : "2017-07-12 17:53:43" date_upd : "2017-07-12 17:53:43"
//		401	- value : nil : "PS_ROUTE_cms_rule" date_add : "2017-07-12 17:53:43" date_upd : "2017-07-12 17:53:43"
//		402	- value : nil : "PS_ROUTE_cms_category_rule" date_add : "2017-07-12 17:53:43" date_upd : "2017-07-12 17:53:43"
//		403 value : "module/{module}{/:controller}" : "PS_ROUTE_module" date_add : "2017-07-12 17:53:43" date_upd : "2017-07-12 17:53:43"
//		404 value : "a:19:{s:6:\"adv_id\";i:0;s:9:\"plugin_id\";s:6:\"PS0003\";s:7:\"version\";s:3:\"0.1\";s:6:\"enable\";i:0;s:7:\"shop_id\";i:1;s:10:\"custom_css\";s:0:\"\";s:17:\"default_text_form\";s:20:\"Find Your Order Here\";s:19:\"default_text_result\";s:13:\"Order Details\";s:22:\"default_text_reference\";s:15:\"Order Reference\";s:18:\"default_text_email\";s:14:\"Order Email Id\";s:10:\"color_find\";s:7:\"#35B327\";s:10:\"color_home\";s:7:\"#FFAE36\";s:12:\"color_result\";s:7:\"#696B6E\";s:10:\"default_to\";s:10:\"07/13/2017\";s:12:\"default_from\";s:10:\"07/07/2017\";s:9:\"text_form\";a:4:{s:4:\"bold\";i:0;s:6:\"italic\";i:0;s:4:\"size\";i:35;s:5:\"color\";s:7:\"#000000\";}s:11:\"text_result\";a:4:{s:4:\"bold\";i:0;s:6:\"italic\";i:0;s:4:\"size\";i:25;s:5:\"color\";s:7:\"#000000\";}s:14:\"text_reference\";a:4:{s:4:\"bold\";i:0;s:6:\"italic\";i:0;s:4:\"size\";i:20;s:5:\"color\";s:7:\"#000000\";}s:10:\"text_email\";a:4:{s:4:\"bold\";i:0;s:6:\"italic\";i:0;s:4:\"size\";i:15;s:5:\"color\";s:7:\"#000000\";}}" : "ORDERLOOKUP_DATA" date_add : "2017-07-13 08:21:42" date_upd : "2017-07-13 08:21:42"
//		405	- value : nil : "ORDERLOOKUP_CUSTOM_CSS" date_add : "2017-07-13 08:21:42" date_upd : "2017-07-13 08:21:42"
//		406 value : "a0910b6c772a73aac8d6b6105b546a5a" : "CRONJOBS_ADMIN_DIR" date_add : "2017-07-27 14:32:41" date_upd : "2017-07-27 14:32:41"
//		407 value : "webservice" : "CRONJOBS_MODE" date_add : "2017-07-27 14:32:41" date_upd : "2017-07-27 14:32:41"
//		408 value : "1.4.0" : "CRONJOBS_MODULE_VERSION" date_add : "2017-07-27 14:32:41" date_upd : "2017-07-27 14:32:41"
//		409 value : "0" : "CRONJOBS_WEBSERVICE_ID" date_add : "2017-07-27 14:32:41" date_upd : "2017-07-27 14:32:41"
//		410 value : "c8e7f83f22f937ddbfb9d427d5d2848c" : "CRONJOBS_EXECUTION_TOKEN" date_add : "2017-07-27 14:32:41" date_upd : "2017-07-27 14:32:41"
//		411 value : "0" : "REFERER_TAX" date_add : "2017-08-08 11:02:09" date_upd : "2017-08-08 11:02:09"
//		412 value : "1" : "REFERER_SHIPPING" date_add : "2017-08-08 11:02:09" date_upd : "2017-08-08 11:02:09"
//		413 value : "1" : "PS_LOGGED_ON_ADDONS" date_add : "2017-08-09 10:34:32" date_upd : "2017-08-09 10:34:32"
//		414 value : "15" : "_PG_ORDER_AUTH_OK" date_add : "2017-08-09 10:42:21" date_upd : "2017-08-09 10:42:21"
//		415 value : "16" : "_PG_ORDER_AUTH_TEST" date_add : "2017-08-09 10:42:21" date_upd : "2017-08-09 10:42:21"
//		416	- value : nil : "oauth_access" date_add : "2017-08-09 10:42:21" date_upd : "2017-08-09 10:42:21"
//		417 value : "0.2": "CONF_PAYGREEN_FIXED" date_add : "2017-08-09 10:42:21" date_upd : "2017-08-09 10:42:21"
//		418 value : "2" : "CONF_PAYGREEN_VAR" date_add : "2017-08-09 10:42:21" date_upd : "2017-08-09 10:42:21"
//		419 value : "0.2" : "CONF_PAYGREEN_FIXED_FOREIGN" date_add : "2017-08-09 10:42:21" date_upd : "2017-08-09 10:42:21"
//		420 value : "2" : "CONF_PAYGREEN_VAR_FOREIGN" date_add : "2017-08-09 10:42:21" date_upd : "2017-08-09 10:42:21"
//		421 value : "http://yumatechnical.com/admin335zpmbel/index.php?controller=AdminModules&configure=paygreen&token=76fdaa8bd8e30106448ae1b8fc90178f" : "URL_BASE" date_add : "2017-08-09 10:42:47" date_upd : "2017-08-09 10:42:47"
//		422 value : "9" : "PS_STOCK_CUSTOMER_ORDER_CANCEL_REASON" date_add : "2017-08-10 14:03:00" date_upd : "2017-08-10 14:03:00"
//		423 value : "10" : "PS_STOCK_CUSTOMER_RETURN_REASON" date_add : "2017-08-10 14:03:00" date_upd : "2017-08-10 14:03:00"
//		424 value : "11" : "PS_STOCK_MVT_INC_EMPLOYEE_EDITION" date_add : "2017-08-10 14:03:00" date_upd : "2017-08-10 14:03:00"
//		425 value : "12" : "PS_STOCK_MVT_DEC_EMPLOYEE_EDITION" date_add : "2017-08-10 14:03:00" date_upd : "2017-08-10 14:03:00"
//		426 value : "0"	 : "MY_CATEGORYPRODUCTS_DISPLAY_PRICE" date_add : "2017-09-18 10:49:41" date_upd : "2017-09-18 10:49:41"
//		427 value : "4" : "MY_CATEGORYPRODUCTS_DISPLAY_PRODUCTS" date_add : "2017-09-18 10:49:41" date_upd : "2017-09-18 10:49:41"
//		428 value : "3" : "MY_VIEWEDPRODUCT_NBR" date_add : "2017-09-18 10:55:59" date_upd : "2017-09-18 10:55:59"
//		429	- value : nil : "PS_MEDIA_SERVER_2" date_add : "2017-09-18 11:37:27" date_upd : "2017-09-18 11:37:27"
//		430	- value : nil : "PS_MEDIA_SERVER_3" date_add : "2017-09-18 11:37:27" date_upd : "2017-09-18 11:37:27"
//		431 value : "1" : "ONBOARDINGV2_SHUT_DOWN" id_shop_group : "1" id_shop : "1" date_add : "2016-12-18 22:42:25" date_upd : "2016-12-19 11:55:55"
//		432 value : "1482120371" : "PS_IMG_UPDATE_TIME" id_shop_group : "1" id_shop : "1" date_add : "2016-12-18 23:05:13" date_upd : "2016-12-18 23:06:11"
//		433 value : "yuma-technical-store-logo-1483415557.jpg" : "PS_LOGO" id_shop_group : "1" id_shop : "1" date_add : "2016-12-18 23:05:13" date_upd : "2017-01-02 22:52:37"
//		434 value : "300" : "SHOP_LOGO_HEIGHT" id_shop_group : "1" id_shop : "1" date_add : "2016-12-18 23:05:47" date_upd : "2016-12-18 23:05:47"
//		435 value : "493" : "SHOP_LOGO_WIDTH" id_shop_group : "1" id_shop : "1" date_add : "2016-12-18 23:05:47" date_upd : "2016-12-18 23:05:47"
//		436 value : "favicon-1.ico" : "PS_FAVICON" id_shop_group : "1" id_shop : "1" date_add : "2016-12-18 23:06:11" date_upd : "2016-12-18 23:06:11"
//		437 value : "Yuma Technical Store" : "PS_SHOP_NAME" id_shop_group : "1" id_shop : "1" date_add : "2016-12-18 23:18:39" date_upd : "2016-12-18 23:18:39"
//		438 value : "24 Hancock Cres" : "PS_SHOP_ADDR1" id_shop_group : "1" id_shop : "1" date_add : "2016-12-18 23:19:08" date_upd : "2016-12-18 23:19:08"
//		439 value : "M1R 2A3" : "PS_SHOP_CODE" id_shop_group : "1" id_shop : "1" date_add : "2016-12-18 23:19:08" date_upd : "2016-12-18 23:19:08"
//		440 value : "Scarborough" : "PS_SHOP_CITY" id_shop_group : "1" id_shop : "1" date_add : "2016-12-18 23:19:47" date_upd : "2016-12-18 23:19:47"
//		441 value : "647-956-6145" : "PS_SHOP_PHONE" id_shop_group : "1" id_shop : "1" date_add : "2016-12-18 23:19:47" date_upd : "2016-12-18 23:19:47"
//		442 value : "CAT2,CAT12,CAT13,CAT14,CAT15,LNK1,LNK2" : "MOD_BLOCKTOPMENU_ITEMS" id_shop_group : "1" id_shop : "1" date_add : "2016-12-19 00:13:52" date_upd : "2016-12-30 17:37:06"
//		443 value : "66" : "PS_CCCJS_VERSION" id_shop_group : "1" id_shop : "1" date_add : "2016-12-19 12:57:56" date_upd : "2017-02-17 10:40:03"
//		444 value : "68": "PS_CCCCSS_VERSION" id_shop_group : "1" id_shop : "1" date_add : "2016-12-19 12:57:56" date_upd : "2017-02-17 10:40:03"
//		445 value : "1" : "PS_SMARTY_FORCE_COMPILE" id_shop_group : "1" id_shop : "1" date_add : "2016-12-19 12:58:28" date_upd : "2017-02-17 10:52:23"
//		446 value : "1" : "PS_CSS_THEME_CACHE" id_shop_group : "1" id_shop : "1" date_add : "2016-12-19 12:58:28" date_upd : "2017-02-17 10:29:32"
//		447 value : "1" : "PS_JS_THEME_CACHE" id_shop_group : "1" id_shop : "1" date_add : "2016-12-19 12:58:28" date_upd : "2017-02-05 10:52:34"
//		448 value : "1" : "PS_HTACCESS_CACHE_CONTROL" id_shop_group : "1" id_shop : "1" date_add : "2016-12-19 12:58:28" date_upd : "2016-12-29 10:35:51"
//		449 value : "0" : "BLOCK_CATEG_ROOT_CATEGORY" id_shop_group : "1" id_shop : "1" date_add : "2016-12-23 18:22:59" date_upd : "2016-12-23 18:22:59"
//		450 value : "1" : "st_color" id_shop_group : "1" id_shop : "1" date_add : "2016-12-24 12:29:15" date_upd : "2016-12-24 12:29:40"
//		451 value : "50px" : "st_x" id_shop_group : "1" id_shop : "1" date_add : "2016-12-24 12:29:15" date_upd : "2016-12-24 12:29:15"
//		452 value : "50px" : "st_y" id_shop_group : "1" id_shop : "1" date_add : "2016-12-24 12:29:15" date_upd : "2016-12-24 12:29:15"
//		453 value : "0.35" : "st_o" id_shop_group : "1" id_shop : "1" date_add : "2016-12-24 12:29:15" date_upd : "2016-12-24 12:29:40"
//		454 value : "1" : "HOME_FEATURED_RANDOMIZE" id_shop_group : "1" id_shop : "1" date_add : "2016-12-24 20:01:36" date_upd : "2017-01-02 18:05:16"
//		455 value : "1" : "PS_SMARTY_LOCAL" id_shop_group : "1" id_shop : "1" date_add : "2016-12-29 20:08:03" date_upd : "2016-12-29 20:08:03"
//		456 value : "0.2" : "CONF_PS_CASHONDELIVERY_FIXED" id_shop_group : "1" id_shop : "1" date_add : "2016-12-29 20:18:59" date_upd : "2016-12-29 20:18:59"
//		457 value : "2" : "CONF_PS_CASHONDELIVERY_VAR" id_shop_group : "1" id_shop : "1" date_add : "2016-12-29 20:18:59" date_upd : "2016-12-29 20:18:59"
//		458 value : "0.2" : "CONF_PS_CASHONDELIVERY_FIXED_FOREIGN" id_shop_group : "1" id_shop : "1" date_add : "2016-12-29 20:18:59" date_upd : "2016-12-29 20:18:59"
//		459 value : "2" : "CONF_PS_CASHONDELIVERY_VAR_FOREIGN" id_shop_group : "1" id_shop : "1" date_add : "2016-12-29 20:18:59" date_upd : "2016-12-29 20:18:59"
//		460 value : "Yuma Technical Inc." : "CHEQUE_NAME" id_shop_group : "1" id_shop : "1" date_add : "2016-12-29 20:44:02" date_upd : "2016-12-29 20:44:02"
//		461 value : "24 Hancock Cres\r\nScarborough  M1R 2A3" : "CHEQUE_ADDRESS" id_shop_group : "1" id_shop : "1" date_add : "2016-12-29 20:44:02" date_upd : "2016-12-29 20:44:02"
//		462 value : "1" : "PS_CATALOG_MODE" id_shop_group : "1" id_shop : "1" date_add : "2016-12-30 22:53:31" date_upd : "2017-01-13 18:56:13"
//		463 value : "8" : "HOME_FEATUREDSVC_NBR" id_shop_group : "1" id_shop : "1" date_add : "2017-01-02 15:42:58" date_upd : "2017-01-02 15:49:19"
//		464 value : "15" : "HOME_FEATUREDSVC_CAT" id_shop_group : "1" id_shop : "1" date_add : "2017-01-02 15:42:58" date_upd : "2017-01-02 15:49:19"
//		465 value : "1" : "HOME_FEATUREDSVC_RANDOMIZE" id_shop_group : "1" id_shop : "1" date_add : "2017-01-02 15:49:19" date_upd : "2017-01-02 15:49:19"
//		466 value : "47" : "HOME_FEATURED_CAT" id_shop_group : "1" id_shop : "1" date_add : "2017-01-02 17:50:53" date_upd : "2017-01-02 17:50:53"
//		467 value : "117": "PS_AUTOUPDATE_MODULE_IDTAB" id_shop_group : "1" id_shop : "1" date_add : "2017-01-02 19:24:56" date_upd : "2017-01-02 19:24:56"
//		468 value : "1495152597" : "PS_LAST_VERSION_CHECK" id_shop_group : "1" id_shop : "1" date_add : "2017-01-02 19:25:09" date_upd : "2017-05-18 20:09:57"
//		469 value : "major" : "PS_UPGRADE_CHANNEL" id_shop_group : "1" id_shop : "1" date_add : "2017-01-02 19:25:10" date_upd : "2017-01-02 19:25:10"
//		470 value : "1" : "PS_AUTOUP_UPDATE_DEFAULT_THEME" id_shop_group : "1" id_shop : "1" date_add : "2017-01-02 19:25:10" date_upd : "2017-01-02 19:25:10"
//		471 value : "0" : "PS_AUTOUP_CHANGE_DEFAULT_THEME" id_shop_group : "1" id_shop : "1" date_add : "2017-01-02 19:25:10" date_upd : "2017-01-02 19:25:10"
//		472 value : "0" : "PS_AUTOUP_KEEP_MAILS" id_shop_group : "1" id_shop : "1" date_add : "2017-01-02 19:25:10" date_upd : "2017-01-02 19:25:10"
//		473 value : "1" : "PS_AUTOUP_CUSTOM_MOD_DESACT" id_shop_group : "1" id_shop : "1" date_add : "2017-01-02 19:25:10" date_upd : "2017-01-02 19:25:10"
//		474 value : "0" : "PS_AUTOUP_MANUAL_MODE" id_shop_group : "1" id_shop : "1" date_add : "2017-01-02 19:25:10" date_upd : "2017-01-02 19:25:10"
//		475 value : "1" : "PS_AUTOUP_PERFORMANCE" id_shop_group : "1" id_shop : "1" date_add : "2017-01-02 19:25:10" date_upd : "2017-01-02 19:25:10"
//		476 value : "0" : "PS_DISPLAY_ERRORS" id_shop_group : "1" id_shop : "1" date_add : "2017-01-02 19:25:10" date_upd : "2017-01-02 19:25:10"
//		477 value : "1" : "PS_SHOP_ENABLE" id_shop_group : "1" id_shop : "1" date_add : "2017-01-02 19:26:39" date_upd : "2017-04-06 11:49:02"
//		478	- value : nil : "PS_MAINTENANCE_IP" id_shop_group : "1" id_shop : "1" date_add : "2017-01-02 22:54:13" date_upd : "2017-01-02 22:54:13"
//		479	- value : nil : "MYBANNER_LINK" id_shop_group : "1" id_shop : "1" date_add : "2017-01-04 19:58:46" date_upd : "2017-01-04 19:58:46"
//		480	- value : nil : "MYBANNER_LINK2" id_shop_group : "1" id_shop : "1" date_add : "2017-01-04 19:58:46" date_upd : "2017-01-04 19:58:46"
//		481	- value : nil : "MYBANNER_DESC2" id_shop_group : "1" id_shop : "1" date_add : "2017-01-04 19:58:46" date_upd : "2017-01-04 19:58:46"
//		482 value : "1" : "MY_CATEGORYPRODUCTS_DISPLAY_PRICE" id_shop_group : "1" id_shop : "1" date_add : "2017-01-07 12:21:00" date_upd : "2017-01-07 12:21:00"
//		483 value : "16": "MY_CATEGORYPRODUCTS_DISPLAY_PRODUCTS" id_shop_group : "1" id_shop : "1" date_add : "2017-01-07 12:21:00" date_upd : "2017-01-07 12:21:00"
//		484 value : "8" : "MY_VIEWEDPRODUCT_NBR" id_shop_group : "1" id_shop : "1" date_add : "2017-01-07 12:52:16" date_upd : "2017-01-07 12:52:16"
//		485 value : "1" : "PS_PRODUCTS_ORDER_WAY" id_shop_group : "1" id_shop : "1" date_add : "2017-01-07 12:56:11" date_upd : "2017-01-07 12:56:11"
//		486 value : "1" : "PAYPAL_USA_EXP_CHK_PRODUCT" id_shop_group : "1" id_shop : "1" date_add : "2017-01-09 11:19:45" date_upd : "2017-01-09 11:23:47"
//		487 value : "1" : "PAYPAL_USA_EXP_CHK_SHOPPING_CART" id_shop_group : "1" id_shop : "1" date_add : "2017-01-09 11:19:45" date_upd : "2017-01-09 11:23:47"
//		488 value : "PayPal" : "PAYPAL_USA_MANAGER_PARTNER" id_shop_group : "1" id_shop : "1" date_add : "2017-01-09 11:19:45" date_upd : "2017-01-09 11:19:45"
//		489 value : "1" : "PAYPAL_USA_PAYMENT_STANDARD" id_shop_group : "1" id_shop : "1" date_add : "2017-01-09 11:19:45" date_upd : "2017-01-09 11:22:39"
//		490 value : "4" : "PS_SHOP_COUNTRY_ID" id_shop_group : "1" id_shop : "1" date_add : "2017-01-09 11:19:45" date_upd : "2017-01-18 18:05:06"
//		491 value : "0.2": "CONF_PAYPALUSA_FIXED" id_shop_group : "1" id_shop : "1" date_add : "2017-01-09 11:19:47" date_upd : "2017-01-09 11:19:47"
//		492 value : "2" : "CONF_PAYPALUSA_VAR" id_shop_group : "1" id_shop : "1" date_add : "2017-01-09 11:19:47" date_upd : "2017-01-09 11:19:47"
//		493 value : "0.2": "CONF_PAYPALUSA_FIXED_FOREIGN" id_shop_group : "1" id_shop : "1" date_add : "2017-01-09 11:19:47" date_upd : "2017-01-09 11:19:47"
//		494 value : "2" : "CONF_PAYPALUSA_VAR_FOREIGN" id_shop_group : "1" id_shop : "1" date_add : "2017-01-09 11:19:47" date_upd : "2017-01-09 11:19:47"
//		495	- value : nil : "PAYPAL_USA_PAYMENT_ADVANCED" id_shop_group : "1" id_shop : "1" date_add : "2017-01-09 11:22:39" date_upd : "2017-01-09 11:22:39"
//		496	- value : nil : "PAYPAL_USA_PAYFLOW_LINK" id_shop_group : "1" id_shop : "1" date_add : "2017-01-09 11:22:39" date_upd : "2017-01-09 11:22:39"
//		497 value : "1" : "PAYPAL_USA_EXPRESS_CHECKOUT" id_shop_group : "1" id_shop : "1" date_add : "2017-01-09 11:22:39" date_upd : "2017-01-09 11:22:39"
//		498 value : "Yuma Technical Inc." : "PAYPAL_USA_ACCOUNT" id_shop_group : "1" id_shop : "1" date_add : "2017-01-09 11:23:47" date_upd : "2017-01-09 11:23:47"
//		499	- value : nil: "PAYPAL_USA_API_USERNAME" id_shop_group : "1" id_shop : "1" date_add : "2017-01-09 11:23:47" date_upd : "2017-01-09 11:23:47"
//		500- value : nil : "PAYPAL_USA_API_PASSWORD" id_shop_group : "1" id_shop : "1" date_add : "2017-01-09 11:23:47" date_upd : "2017-01-09 11:23:47"
//		501	- value : nil : "PAYPAL_USA_API_SIGNATURE" id_shop_group : "1" id_shop : "1" date_add : "2017-01-09 11:23:47" date_upd : "2017-01-09 11:23:47"
//		502 value : "1" : "PAYPAL_USA_SANDBOX" id_shop_group : "1" id_shop : "1" date_add : "2017-01-09 11:23:47" date_upd : "2017-01-09 11:23:47"
//		503	- value : nil : "PAYPAL_USA_EXP_CHK_BORDER_COLOR" id_shop_group : "1" id_shop : "1" date_add : "2017-01-09 11:23:47" date_upd : "2017-01-09 11:23:47"
//		504 value : "0.2" : "CONF_AUTHORIZEAIM_FIXED" id_shop_group : "1" id_shop : "1" date_add : "2017-01-10 17:52:30" date_upd : "2017-01-10 17:52:30"
//		505 value : "2" : "CONF_AUTHORIZEAIM_VAR" id_shop_group : "1" id_shop : "1" date_add : "2017-01-10 17:52:30" date_upd : "2017-01-10 17:52:30"
//		506 value : "0.2" : "CONF_AUTHORIZEAIM_FIXED_FOREIGN" id_shop_group : "1" id_shop : "1" date_add : "2017-01-10 17:52:30" date_upd : "2017-01-10 17:52:30"
//		507 value : "2" : "CONF_AUTHORIZEAIM_VAR_FOREIGN" id_shop_group : "1" id_shop : "1" date_add : "2017-01-10 17:52:30" date_upd : "2017-01-10 17:52:30"
//		508 value : "1" : "AUTHORIZE_AIM_SANDBOX" id_shop_group : "1" id_shop : "1" date_add : "2017-01-10 17:52:30" date_upd : "2017-01-12 12:14:38"
//		509 value : "0" : "AUTHORIZE_AIM_TEST_MODE" id_shop_group : "1" id_shop : "1" date_add : "2017-01-10 17:52:30" date_upd : "2017-01-12 12:14:38"
//		510 value : "3" : "AUTHORIZE_AIM_HOLD_REVIEW_OS" id_shop_group : "1" id_shop : "1" date_add : "2017-01-10 17:52:30" date_upd : "2017-01-12 12:14:38"
//		511 value : "on": "AUTHORIZE_AIM_CARD_VISA" id_shop_group : "1" id_shop : "1" date_add : "2017-01-10 17:54:31" date_upd : "2017-01-10 17:54:31"
//		512 value : "on" : "AUTHORIZE_AIM_CARD_MASTERCARD" id_shop_group : "1" id_shop : "1" date_add : "2017-01-10 17:54:31" date_upd : "2017-01-10 17:54:31"
//		513 value : "on" : "AUTHORIZE_AIM_CARD_AX" id_shop_group : "1" id_shop : "1" date_add : "2017-01-10 17:54:31" date_upd : "2017-01-10 17:54:31"
//		514 value : "mattyuma2017" : "AUTHORIZE_AIM_LOGIN_ID_CAD" id_shop_group : "1" id_shop : "1" date_add : "2017-01-10 17:54:31" date_upd : "2017-01-10 17:54:31"
//		515 value : "75Gbm4Y33Amtw5uD" : "AUTHORIZE_AIM_KEY_CAD" id_shop_group : "1" id_shop : "1" date_add : "2017-01-10 17:54:31" date_upd : "2017-01-10 17:54:31"
//		516 value : "1" : "MA_MERCHANT_ORDER" id_shop_group : "1" id_shop : "1" date_add : "2017-01-12 11:43:30" date_upd : "2017-01-12 11:44:18"
//		517 value : "0" : "MA_MERCHANT_OOS" id_shop_group : "1" id_shop : "1" date_add : "2017-01-12 11:43:30" date_upd : "2017-01-12 11:44:18"
//		518 value : "1" : "MA_CUSTOMER_QTY" id_shop_group : "1" id_shop : "1" date_add : "2017-01-12 11:43:30" date_upd : "2017-01-12 11:43:30"
//		519 value : "1": "MA_ORDER_EDIT" id_shop_group : "1" id_shop : "1" date_add : "2017-01-12 11:43:30" date_upd : "2017-01-12 11:43:30"
//		520 value : "1" : "MA_RETURN_SLIP" id_shop_group : "1" id_shop : "1" date_add : "2017-01-12 11:43:30" date_upd : "2017-01-12 11:43:30"
//		521 value : "sales@yumatechnical.com": "MA_MERCHANT_MAILS" id_shop_group : "1" id_shop : "1" date_add : "2017-01-12 11:43:30" date_upd : "2017-01-12 11:43:30"
//		522 value : "3" : "MA_LAST_QTIES" id_shop_group : "1" id_shop : "1" date_add : "2017-01-12 11:43:30" date_upd : "2017-01-12 11:44:18"
//		523 value : "8GHOFQUPM0AXSAIS" : "PS_FOLLOWUP_SECURE_KEY" id_shop_group : "1" id_shop : "1" date_add : "2017-01-12 11:44:50" date_upd : "2017-01-12 11:44:50"
//		524 value : "0" : "PS_FOLLOW_UP_ENABLE_1" id_shop_group : "1" id_shop : "1" date_add : "2017-01-12 11:44:50" date_upd : "2017-01-12 11:44:50"
//		525 value : "0" : "PS_FOLLOW_UP_ENABLE_2" id_shop_group : "1" id_shop : "1" date_add : "2017-01-12 11:44:50" date_upd : "2017-01-12 11:44:50"
//		526 value : "0" : "PS_FOLLOW_UP_ENABLE_3" id_shop_group : "1" id_shop : "1" date_add : "2017-01-12 11:44:50" date_upd : "2017-01-12 11:44:50"
//		527 value : "0" : "PS_FOLLOW_UP_ENABLE_4" id_shop_group : "1" id_shop : "1" date_add : "2017-01-12 11:44:50" date_upd : "2017-01-12 11:44:50"
//		528 value : "0" : "PS_FOLLOW_UP_AMOUNT_1" id_shop_group : "1" id_shop : "1" date_add : "2017-01-12 11:44:50" date_upd : "2017-01-12 11:44:50"
//		529 value : "0" : "PS_FOLLOW_UP_AMOUNT_2" id_shop_group : "1" id_shop : "1" date_add : "2017-01-12 11:44:50" date_upd : "2017-01-12 11:44:50"
//		530 value : "0" : "PS_FOLLOW_UP_AMOUNT_3" id_shop_group : "1" id_shop : "1" date_add : "2017-01-12 11:44:50" date_upd : "2017-01-12 11:44:50"
//		531 value : "0" : "PS_FOLLOW_UP_AMOUNT_4" id_shop_group : "1" id_shop : "1" date_add : "2017-01-12 11:44:50" date_upd : "2017-01-12 11:44:50"
//		532 value : "0" : "PS_FOLLOW_UP_DAYS_1" id_shop_group : "1" id_shop : "1" date_add : "2017-01-12 11:44:50" date_upd : "2017-01-12 11:44:50"
//		533 value : "0" : "PS_FOLLOW_UP_DAYS_2" id_shop_group : "1" id_shop : "1" date_add : "2017-01-12 11:44:50" date_upd : "2017-01-12 11:44:50"
//		534 value : "0" : "PS_FOLLOW_UP_DAYS_3" id_shop_group : "1" id_shop : "1" date_add : "2017-01-12 11:44:50" date_upd : "2017-01-12 11:44:50"
//		535 value : "0" : "PS_FOLLOW_UP_DAYS_4" id_shop_group : "1" id_shop : "1" date_add : "2017-01-12 11:44:50" date_upd : "2017-01-12 11:44:50"
//		536 value : "0" : "PS_FOLLOW_UP_THRESHOLD_3" id_shop_group : "1" id_shop : "1" date_add : "2017-01-12 11:44:50" date_upd : "2017-01-12 11:44:50"
//		537 value : "0" : "PS_FOLLOW_UP_DAYS_THRESHOLD_4" id_shop_group : "1" id_shop : "1" date_add : "2017-01-12 11:44:50" date_upd : "2017-01-12 11:44:50"
//		538 value : "0" : "PS_FOLLOW_UP_CLEAN_DB" id_shop_group : "1" id_shop : "1" date_add : "2017-01-12 11:44:50" date_upd : "2017-01-12 11:44:50"
//		539 value : "0.2" : "CONF_MY_AUTHORIZEAIM_FIXED" id_shop_group : "1" id_shop : "1" date_add : "2017-01-12 12:04:11" date_upd : "2017-01-12 12:04:11"
//		540 value : "2" : "CONF_MY_AUTHORIZEAIM_VAR" id_shop_group : "1" id_shop : "1" date_add : "2017-01-12 12:04:11" date_upd : "2017-01-12 12:04:11"
//		541 value : "0.2" : "CONF_MY_AUTHORIZEAIM_FIXED_FOREIGN" id_shop_group : "1" id_shop : "1" date_add : "2017-01-12 12:04:11" date_upd : "2017-01-12 12:04:11"
//		542 value : "2" : "CONF_MY_AUTHORIZEAIM_VAR_FOREIGN" id_shop_group : "1" id_shop : "1" date_add : "2017-01-12 12:04:11" date_upd : "2017-01-12 12:04:11"
//		543 value : "png" : "PS_IMAGE_QUALITY" id_shop_group : "1" id_shop : "1" date_add : "2017-01-12 17:51:33" date_upd : "2017-01-15 22:51:02"
//		544 value : "89" : "PS_SHOP_STATE_ID" id_shop_group : "1" id_shop : "1" date_add : "2017-01-18 18:05:30" date_upd : "2017-01-18 18:05:30"
		//		store.defaultCountryState = Int(store.configValue(forKey: "PS_SHOP_STATE_ID"))!
		let defaultCountryState = store.configValue(forKey: "PS_SHOP_STATE_ID")
//		if !defaultCountryState.isEmpty
//		{
//			store.defaultCountryState = Int(defaultCountryState)!
//		}
//		else
//		{
//			store.defaultCountryState = 0
//		}
		store.defaultCountryState = (!defaultCountryState.isEmpty) ? Int(defaultCountryState)! : 0
//		545 value : "Ontario" : "PS_SHOP_STATE" id_shop_group : "1" id_shop : "1" date_add : "2017-01-18 18:05:30" date_upd : "2017-01-18 18:05:30"
//		546 value : "1" : "PS_STATSDATA_PAGESVIEWS" id_shop_group : "1" id_shop : "1" date_add : "2017-02-05 10:51:28" date_upd : "2017-02-05 10:51:28"
//		547 value : "1" : "PS_SMARTY_CACHE" id_shop_group : "1" id_shop : "1" date_add : "2017-02-17 10:02:10" date_upd : "2017-02-17 10:02:10"
//		548 value : "1482124269" : "PS_IMG_UPDATE_TIME" id_shop_group : "1" id_shop : "2" date_add : "2016-12-18 23:08:07" date_upd : "2016-12-19 00:11:09"
//		549 value : "toners-cartridges-logo-14821204872.jpg" : "PS_LOGO" id_shop_group : "1" id_shop : "2" date_add : "2016-12-18 23:08:08" date_upd : "2016-12-18 23:08:08"
//		550 value : "326" : "SHOP_LOGO_HEIGHT" id_shop_group : "1" id_shop : "2" date_add : "2016-12-18 23:08:08" date_upd : "2016-12-18 23:08:08"
//		551 value : "1000" : "SHOP_LOGO_WIDTH" id_shop_group : "1" id_shop : "2" date_add : "2016-12-18 23:08:08" date_upd : "2016-12-18 23:08:08"
//		552 value : "Toners-Cartridges" : "PS_SHOP_NAME" id_shop_group : "1" id_shop : "2" date_add : "2016-12-18 23:21:46" date_upd : "2016-12-18 23:21:46"
//		553 value : "sales@toners-cartridges.ca": "PS_SHOP_EMAIL" id_shop_group : "1" id_shop : "2" date_add : "2016-12-18 23:21:46" date_upd : "2016-12-18 23:21:46"
//		554 value : "24 Hancock Cres" : "PS_SHOP_ADDR1" id_shop_group : "1" id_shop : "2" date_add : "2016-12-18 23:21:46" date_upd : "2016-12-18 23:21:46"
//		555 value : "M1R 2A3" : "PS_SHOP_CODE" id_shop_group : "1" id_shop : "2" date_add : "2016-12-18 23:21:46" date_upd : "2016-12-18 23:21:46"
//		556 value : "Scarborough" : "PS_SHOP_CITY" id_shop_group : "1" id_shop : "2" date_add : "2016-12-18 23:21:46" date_upd : "2016-12-18 23:21:46"
//		557 value : "647-956-6145" : "PS_SHOP_PHONE" id_shop_group : "1" id_shop : "2" date_add : "2016-12-18 23:21:46" date_upd : "2016-12-18 23:21:46"
//		558 value : "favicon-2.ico" : "PS_FAVICON" id_shop_group : "1" id_shop : "2" date_add : "2016-12-19 00:11:09" date_upd : "2016-12-19 00:11:09"
//		559 value : "1" : "PS_SMARTY_CACHE" id_shop_group : "1" id_shop : "2" date_add : "2016-12-19 11:47:08" date_upd : "2016-12-19 12:58:26"
//		560 value : "0" : "PS_CSS_THEME_CACHE" id_shop_group : "1" id_shop : "2" date_add : "2016-12-19 11:47:08" date_upd : "2016-12-19 12:58:26"
//		561 value : "0" : "PS_JS_THEME_CACHE" id_shop_group : "1" id_shop : "2" date_add : "2016-12-19 11:47:08" date_upd : "2016-12-19 12:58:26"
//		562 value : "0" : "PS_HTACCESS_CACHE_CONTROL" id_shop_group : "1" id_shop : "2" date_add : "2016-12-19 11:47:08" date_upd : "2016-12-19 12:58:26"
//		563 value : "7" : "PS_CCCJS_VERSION" id_shop_group : "1" id_shop : "2" date_add : "2016-12-19 11:47:50" date_upd : "2016-12-29 11:46:27"
//		564 value : "7" : "PS_CCCCSS_VERSION" id_shop_group : "1" id_shop : "2" date_add : "2016-12-19 11:47:50" date_upd : "2016-12-29 11:46:27"
//		565 value : "CAT27,CAT28,CAT29,CAT30,CAT31,CAT32,CAT33,CAT34,CAT35,CAT36,CAT15" : "MOD_BLOCKTOPMENU_ITEMS" id_shop_group : "1" id_shop : "2" date_add : "2016-12-19 11:54:33" date_upd : "2016-12-19 11:54:33"
//		566 value : "1" : "PS_SMARTY_FORCE_COMPILE" id_shop_group : "1" id_shop : "2" date_add : "2016-12-19 12:11:57" date_upd : "2016-12-19 12:58:26"
//		567 value : "0" : "PS_MEDIA_SERVERS" id_shop_group : "1" id_shop : "2" date_add : "2016-12-29 11:45:02" date_upd : "2016-12-29 11:46:26"
//		568	- value : nil : "PS_MEDIA_SERVER_1" id_shop_group : "1" id_shop : "2" date_add : "2016-12-29 11:45:02" date_upd : "2016-12-29 11:46:26"
//		569 value : "1" : "PS_SMARTY_LOCAL" id_shop_group : "1" id_shop : "2" date_add : "2016-12-29 12:00:56" date_upd : "2016-12-29 12:00:56"
//		570 value : "0" : "PS_SHOP_ENABLE" id_shop_group : "1" id_shop : "2" date_add : "2017-01-02 19:26:39" date_upd : "2017-03-06 14:04:21"
//		571	- value : nil : "PS_MAINTENANCE_IP" id_shop_group : "1" id_shop : "2" date_add : "2017-01-02 22:55:07" date_upd : "2017-01-02 22:55:07"
		//CHEQUE_NAME, CHEQUE_ADDRESS
		//BANK_WIRE_DETAILS, BANK_WIRE_OWNER, BANK_WIRE_ADDRESS, BANK_WIRE_RESERVATION_DAYS, BANK_WIRE_CUSTOM_TEXT
/**/
		store.locale = String(format: "%@_%@", store.defaultLangISO, store.defaultCountryISO.uppercased())
	}


	//MARK: Swiping Controls
	@objc private func handlePrev()
	{
		let nextId = 				max(pageControl.currentPage - 1, 0)
		let indexPath = 			IndexPath(item: nextId, section: 0)
		pageControl.currentPage = 	nextId
		collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
	}
	
	@objc private func handleNext()
	{
		let nextId = 				min(pageControl.currentPage + 1, pageContent.count - 1)
		let indexPath = 			IndexPath(item: nextId, section: 0)
		pageControl.currentPage = 	nextId
		collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
	}
	
	@objc private func handleCycle()
	{
		var nextId = 				pageControl.currentPage + 1
		if nextId > pageContent.count - 1		{	nextId = 0	}
		let indexPath = 			IndexPath(item: nextId, section: 0)
		pageControl.currentPage = 	nextId
		//		UIView.animate(withDuration: 2, animations:
		//			{
		//				tv.transform = CGAffineTransform(translationX: tv.frame.maxX, y: 200)
		//		})
		collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
	}
	
	
	//MARK: Drawing Methods
	fileprivate func setUpControls() -> UIStackView
	{
//		prevBtn.translatesAutoresizingMaskIntoConstraints = false
//		prevBtn.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
//
//		nextBtn.translatesAutoresizingMaskIntoConstraints = false
//		nextBtn.frame = CGRect(x: 0, y: 0, width: 100, height: 50)

		let stack = UIStackView(arrangedSubviews: [/*prevBtn, */pageControl/*, nextBtn*/])
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.distribution = .fillEqually
		view.addSubview(stack)

		stack.heightAnchor.constraint(equalToConstant: 50).isActive = true
//		if #available(iOS 11.0, *) {
//			NSLayoutConstraint.activate([
//				stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//				stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//				stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
//				])
//		} else {
			stack.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 150/*(view.frame.height/3)-1*/).isActive = true
			stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
			//stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
			if view.frame.height > view.frame.width
			{
				stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
				stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
			}
			else
			{
				stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
				stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
			}
//		}
		return stack
	}
	
	func drawIconPanel(iconText: String, labelText: String, actionSelector: Selector, canFade: Bool, canAction: Bool) -> UIView
	{
		let myIcon = UILabel()
		myIcon.translatesAutoresizingMaskIntoConstraints = false
		myIcon.attributedText = NSMutableAttributedString(string: iconText, attributes: R.attribute.iconText)
		myIcon.textAlignment = .center
		myIcon.shadowColor = R.color.YumaYel
		myIcon.shadowOffset = CGSize(width: 2, height: 2)
		
		let myLabel = UILabel()
		myLabel.translatesAutoresizingMaskIntoConstraints = false
		myLabel.text = R.string.login
		myLabel.textAlignment = .center
		myLabel.attributedText = NSMutableAttributedString(string: labelText, attributes: R.attribute.labelText)
		myLabel.shadowColor = R.color.YumaYel
		myLabel.shadowOffset = CGSize(width: 1, height: 1)
		myLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
		myLabel.numberOfLines = 3
		
		let myStack = UIStackView(arrangedSubviews: [myIcon, myLabel])
		myStack.translatesAutoresizingMaskIntoConstraints = false
		myStack.axis = UILayoutConstraintAxis.vertical
		myStack.backgroundColor = UIColor.lightText
		NSLayoutConstraint.activate([
			myIcon.topAnchor.constraint(equalTo: myStack.topAnchor),
			myIcon.leadingAnchor.constraint(equalTo: myStack.leadingAnchor),
			myIcon.trailingAnchor.constraint(equalTo: myStack.trailingAnchor),
			myIcon.heightAnchor.constraint(equalToConstant: 50)
			])
		
		if canFade && !Reachability.isConnectedToNetwork()
		{
			myStack.alpha = 0.2
			if canAction
			{
				myStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: actionSelector))
			}
		}
		else
		{
			myStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: actionSelector))
		}

		let myViewStack = UIView()
		myViewStack.translatesAutoresizingMaskIntoConstraints = false
		myViewStack.addSubview(myStack)
		NSLayoutConstraint.activate([
			myStack.topAnchor.constraint(equalTo: myViewStack.topAnchor),
			myStack.leadingAnchor.constraint(equalTo: myViewStack.leadingAnchor),
			myStack.bottomAnchor.constraint(equalTo: myViewStack.bottomAnchor),
			myStack.trailingAnchor.constraint(equalTo: myViewStack.trailingAnchor)
			])
		
		let myViewInner = UIView()
		myViewInner.translatesAutoresizingMaskIntoConstraints = false
		myViewInner.layer.borderColor = UIColor.lightGray.cgColor
		myViewInner.layer.borderWidth = 1
		myViewInner.addSubview(myViewStack)
		NSLayoutConstraint.activate([
			myViewStack.topAnchor.constraint(equalTo: myViewInner.topAnchor, constant: 2),
			myViewStack.leadingAnchor.constraint(equalTo: myViewInner.leadingAnchor, constant: 2),
			myViewStack.bottomAnchor.constraint(equalTo: myViewInner.bottomAnchor, constant: -2),
			myViewStack.trailingAnchor.constraint(equalTo: myViewInner.trailingAnchor, constant: -2)
			])

		let myViewOuter = UIView()
		myViewOuter.translatesAutoresizingMaskIntoConstraints = false
		myViewOuter.layer.borderColor = UIColor.lightGray.cgColor
		myViewOuter.layer.borderWidth = 1
		myViewOuter.addSubview(myViewInner)
		NSLayoutConstraint.activate([
			myViewInner.topAnchor.constraint(equalTo: myViewOuter.topAnchor, constant: 2),
			myViewInner.leadingAnchor.constraint(equalTo: myViewOuter.leadingAnchor, constant: 2),
			myViewInner.bottomAnchor.constraint(equalTo: myViewOuter.bottomAnchor, constant: -2),
			myViewInner.trailingAnchor.constraint(equalTo: myViewOuter.trailingAnchor, constant: -2)
			])

		let myView = UIView()
		myView.translatesAutoresizingMaskIntoConstraints = false
		myView.addSubview(myViewOuter)
		NSLayoutConstraint.activate([
			myViewStack.topAnchor.constraint(equalTo: myView.topAnchor, constant: 3),
			myViewStack.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 3),
			myViewStack.bottomAnchor.constraint(equalTo: myView.bottomAnchor, constant: -3),
			myViewStack.trailingAnchor.constraint(equalTo: myView.trailingAnchor, constant: -3),
			myView.heightAnchor.constraint(equalToConstant: 120),
			//myView.widthAnchor.constraint(equalToConstant: 90)	// trows wobbly
			])
		return myView
	}
	
	func drawIconPanel2(iconImage: UIImage, labelText: String, actionSelector: Selector, canFade: Bool, canAction: Bool) -> UIView
	{
		let myIcon = UIImageView(image: iconImage)
//		myIcon.addSubview(img)
		myIcon.translatesAutoresizingMaskIntoConstraints = false
//		myIcon.attributedText = NSMutableAttributedString(string: iconText, attributes: R.attribute.iconText)
//		myIcon.textAlignment = .center
		myIcon.shadowColor = R.color.YumaYel
		myIcon.shadowOffset = CGSize(width: 2, height: 2)
		
		let myLabel = UILabel()
		myLabel.translatesAutoresizingMaskIntoConstraints = false
		myLabel.text = R.string.login
		myLabel.textAlignment = .center
		myLabel.attributedText = NSMutableAttributedString(string: labelText, attributes: R.attribute.labelText)
		myLabel.shadowColor = R.color.YumaYel
		myLabel.shadowOffset = CGSize(width: 1, height: 1)
		myLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
		myLabel.numberOfLines = 3
		
		let myStack = UIStackView(arrangedSubviews: [myIcon, myLabel])
		myStack.translatesAutoresizingMaskIntoConstraints = false
		myStack.axis = UILayoutConstraintAxis.vertical
		myStack.backgroundColor = UIColor.lightText
		NSLayoutConstraint.activate([
			myIcon.topAnchor.constraint(equalTo: myStack.topAnchor),
			myIcon.leadingAnchor.constraint(equalTo: myStack.leadingAnchor),
			myIcon.trailingAnchor.constraint(equalTo: myStack.trailingAnchor),
			myIcon.heightAnchor.constraint(equalToConstant: 50)
			])
		
		if canFade && !Reachability.isConnectedToNetwork()
		{
			myStack.alpha = 0.2
			if canAction
			{
				myStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: actionSelector))
			}
		}
		else
		{
			myStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: actionSelector))
		}
		
		let myViewStack = UIView()
		myViewStack.translatesAutoresizingMaskIntoConstraints = false
		myViewStack.addSubview(myStack)
		NSLayoutConstraint.activate([
			myStack.topAnchor.constraint(equalTo: myViewStack.topAnchor),
			myStack.leadingAnchor.constraint(equalTo: myViewStack.leadingAnchor),
			myStack.bottomAnchor.constraint(equalTo: myViewStack.bottomAnchor),
			myStack.trailingAnchor.constraint(equalTo: myViewStack.trailingAnchor)
			])
		
		let myViewInner = UIView()
		myViewInner.translatesAutoresizingMaskIntoConstraints = false
		myViewInner.layer.borderColor = UIColor.lightGray.cgColor
		myViewInner.layer.borderWidth = 1
		myViewInner.addSubview(myViewStack)
		NSLayoutConstraint.activate([
			myViewStack.topAnchor.constraint(equalTo: myViewInner.topAnchor, constant: 2),
			myViewStack.leadingAnchor.constraint(equalTo: myViewInner.leadingAnchor, constant: 2),
			myViewStack.bottomAnchor.constraint(equalTo: myViewInner.bottomAnchor, constant: -2),
			myViewStack.trailingAnchor.constraint(equalTo: myViewInner.trailingAnchor, constant: -2)
			])
		
		let myViewOuter = UIView()
		myViewOuter.translatesAutoresizingMaskIntoConstraints = false
		myViewOuter.layer.borderColor = UIColor.lightGray.cgColor
		myViewOuter.layer.borderWidth = 1
		myViewOuter.addSubview(myViewInner)
		NSLayoutConstraint.activate([
			myViewInner.topAnchor.constraint(equalTo: myViewOuter.topAnchor, constant: 2),
			myViewInner.leadingAnchor.constraint(equalTo: myViewOuter.leadingAnchor, constant: 2),
			myViewInner.bottomAnchor.constraint(equalTo: myViewOuter.bottomAnchor, constant: -2),
			myViewInner.trailingAnchor.constraint(equalTo: myViewOuter.trailingAnchor, constant: -2)
			])
		
		let myView = UIView()
		myView.translatesAutoresizingMaskIntoConstraints = false
		myView.addSubview(myViewOuter)
		NSLayoutConstraint.activate([
			myViewStack.topAnchor.constraint(equalTo: myView.topAnchor, constant: 3),
			myViewStack.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 3),
			myViewStack.bottomAnchor.constraint(equalTo: myView.bottomAnchor, constant: -3),
			myViewStack.trailingAnchor.constraint(equalTo: myView.trailingAnchor, constant: -3),
			myView.heightAnchor.constraint(equalToConstant: 120),
			//myView.widthAnchor.constraint(equalToConstant: 90)	// trows wobbly
			])
		return myView
	}
	
	func drawIconPanel3(iconAttr: NSAttributedString, labelText: String, actionSelector: Selector, canFade: Bool, canAction: Bool) -> UIView
	{
		let myIcon = UILabel()
		//		myIcon.addSubview(img)
		myIcon.translatesAutoresizingMaskIntoConstraints = false
		myIcon.attributedText = iconAttr
		//		myIcon.textAlignment = .center
		myIcon.shadowColor = R.color.YumaYel
		myIcon.shadowOffset = CGSize(width: 2, height: 2)
		
		let myLabel = UILabel()
		myLabel.translatesAutoresizingMaskIntoConstraints = false
		myLabel.text = R.string.login
		myLabel.textAlignment = .center
		myLabel.attributedText = NSMutableAttributedString(string: labelText, attributes: R.attribute.labelText)
		myLabel.shadowColor = R.color.YumaYel
		myLabel.shadowOffset = CGSize(width: 1, height: 1)
		myLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
		myLabel.numberOfLines = 3
		
		let myStack = UIStackView(arrangedSubviews: [myIcon, myLabel])
		myStack.translatesAutoresizingMaskIntoConstraints = false
		myStack.axis = UILayoutConstraintAxis.vertical
		myStack.backgroundColor = UIColor.lightText
		NSLayoutConstraint.activate([
			myIcon.topAnchor.constraint(equalTo: myStack.topAnchor),
			myIcon.leadingAnchor.constraint(equalTo: myStack.leadingAnchor),
			myIcon.trailingAnchor.constraint(equalTo: myStack.trailingAnchor),
			myIcon.heightAnchor.constraint(equalToConstant: 50)
			])
		
		if canFade && !Reachability.isConnectedToNetwork()
		{
			myStack.alpha = 0.2
			if canAction
			{
				myStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: actionSelector))
			}
		}
		else
		{
			myStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: actionSelector))
		}
		
		let myViewStack = UIView()
		myViewStack.translatesAutoresizingMaskIntoConstraints = false
		myViewStack.addSubview(myStack)
		NSLayoutConstraint.activate([
			myStack.topAnchor.constraint(equalTo: myViewStack.topAnchor),
			myStack.leadingAnchor.constraint(equalTo: myViewStack.leadingAnchor),
			myStack.bottomAnchor.constraint(equalTo: myViewStack.bottomAnchor),
			myStack.trailingAnchor.constraint(equalTo: myViewStack.trailingAnchor)
			])
		
		let myViewInner = UIView()
		myViewInner.translatesAutoresizingMaskIntoConstraints = false
		myViewInner.layer.borderColor = UIColor.lightGray.cgColor
		myViewInner.layer.borderWidth = 1
		myViewInner.addSubview(myViewStack)
		NSLayoutConstraint.activate([
			myViewStack.topAnchor.constraint(equalTo: myViewInner.topAnchor, constant: 2),
			myViewStack.leadingAnchor.constraint(equalTo: myViewInner.leadingAnchor, constant: 2),
			myViewStack.bottomAnchor.constraint(equalTo: myViewInner.bottomAnchor, constant: -2),
			myViewStack.trailingAnchor.constraint(equalTo: myViewInner.trailingAnchor, constant: -2)
			])
		
		let myViewOuter = UIView()
		myViewOuter.translatesAutoresizingMaskIntoConstraints = false
		myViewOuter.layer.borderColor = UIColor.lightGray.cgColor
		myViewOuter.layer.borderWidth = 1
		myViewOuter.addSubview(myViewInner)
		NSLayoutConstraint.activate([
			myViewInner.topAnchor.constraint(equalTo: myViewOuter.topAnchor, constant: 2),
			myViewInner.leadingAnchor.constraint(equalTo: myViewOuter.leadingAnchor, constant: 2),
			myViewInner.bottomAnchor.constraint(equalTo: myViewOuter.bottomAnchor, constant: -2),
			myViewInner.trailingAnchor.constraint(equalTo: myViewOuter.trailingAnchor, constant: -2)
			])
		
		let myView = UIView()
		myView.translatesAutoresizingMaskIntoConstraints = false
		myView.addSubview(myViewOuter)
		NSLayoutConstraint.activate([
			myViewStack.topAnchor.constraint(equalTo: myView.topAnchor, constant: 3),
			myViewStack.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 3),
			myViewStack.bottomAnchor.constraint(equalTo: myView.bottomAnchor, constant: -3),
			myViewStack.trailingAnchor.constraint(equalTo: myView.trailingAnchor, constant: -3),
			myView.heightAnchor.constraint(equalToConstant: 120),
			//myView.widthAnchor.constraint(equalToConstant: 90)	// trows wobbly
			])
		return myView
	}

	func drawTopStack() -> UIStackView
	{
		let loginPanel = drawIconPanel3(iconAttr: Awesome.solid.user.asAttributedText(fontSize: 32, color: R.color.YumaRed, backgroundColor: .clear), labelText: R.string.login, actionSelector: #selector(loginTapped(_:)), canFade: false, canAction: true)
//		let loginPanel = drawIconPanel2(iconImage: Awesome.solid.handScissors.asImage(size: 30), labelText: R.string.login, actionSelector: #selector(loginTapped(_:)), canFade: false, canAction: true)
//		let loginPanel = drawIconPanel(iconText: FontAwesome.user.rawValue, labelText: R.string.login, actionSelector: #selector(loginTapped(_:)), canFade: false, canAction: true)
		loginPanel.widthAnchor.constraint(equalToConstant: 90).isActive = true
		let loginGap = UIView()
		let loginStack = UIStackView(arrangedSubviews: [loginPanel, loginGap])
		
		let myLogo = UIImageView(image: #imageLiteral(resourceName: "logo"))
		myLogo.translatesAutoresizingMaskIntoConstraints = false
		myLogo.contentMode = .scaleAspectFit
		myLogo.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(gotoDebug)))

		let cartPanel = drawIconPanel(iconText: FontAwesome.shoppingCart.rawValue, labelText: R.string.cart, actionSelector: #selector(cartTapped(_:)), canFade: true, canAction: true)
		cartPanel.widthAnchor.constraint(equalToConstant: 90).isActive = true
		let cartGap = UIView()
		let cartStack = UIStackView(arrangedSubviews: [cartGap, cartPanel])
		let topStack = UIStackView(arrangedSubviews: [loginStack, myLogo, cartStack])
		topStack.translatesAutoresizingMaskIntoConstraints = false
		topStack.distribution = UIStackViewDistribution.fillEqually
		//topStack.addArrangedSubview(loginStack)
		//topStack.addArrangedSubview(myLogo)
		//topStack.addArrangedSubview(cartStack)
		//loginStack.widthAnchor.constraint(equalToConstant: 90).isActive = true
		//loginStack.heightAnchor.constraint(equalToConstant: 120).isActive = true

//		NSLayoutConstraint.activate([
//			loginStack.topAnchor.constraint(equalTo: topStack.topAnchor),
//			loginStack.leadingAnchor.constraint(equalTo: topStack.leadingAnchor),
//			loginStack.widthAnchor.constraint(equalToConstant: 90),
//			loginStack.heightAnchor.constraint(equalToConstant: 120)
//			])
		return topStack
	}
	
	
	func drawButtonsTop() -> UIStackView
	{
		let topRow = UIStackView(arrangedSubviews: [
			drawIconPanel(iconText: FontAwesome.home.rawValue, 			labelText: R.string.en, 		actionSelector: #selector(enTapped(_:)), 				canFade: true, canAction: false),
			drawIconPanel(iconText: FontAwesome.certificate.rawValue, 	labelText: R.string.about, 		actionSelector: #selector(aboutTapped(_:)), 			canFade: true, canAction: false),
			drawIconPanel(iconText: FontAwesome.flag.rawValue, 			labelText: R.string.qc, 		actionSelector: #selector(qcTapped(_:)), 				canFade: true, canAction: false),
			drawIconPanel(iconText: FontAwesome.phone.rawValue, 		labelText: R.string.contact, 	actionSelector: #selector(contactTapped(_:)), 			canFade: false, canAction: true)
			])
		topRow.translatesAutoresizingMaskIntoConstraints = false
		topRow.distribution = UIStackViewDistribution.fillEqually
		topRow.spacing = 2
		return topRow
	}

	func drawButtonsBottom() -> UIStackView
	{
		let bottomRow = UIStackView(arrangedSubviews: [
			drawIconPanel(iconText: FontAwesome.print.rawValue, 	labelText: R.string.printers, 	actionSelector: #selector(printTapped(_:)), 		canFade: false, canAction: true),
			drawIconPanel(iconText: FontAwesome.laptop.rawValue, 	labelText: R.string.laptops, 	actionSelector: #selector(laptopTapped(_:)), 		canFade: false, canAction: true),
			drawIconPanel(iconText: FontAwesome.wrench.rawValue, 	labelText: R.string.services, 	actionSelector: #selector(servicesTapped(_:)), 		canFade: false, canAction: true),
			drawIconPanel(iconText: FontAwesome.cubes.rawValue, 	labelText: R.string.toners, 	actionSelector: #selector(tonersTapped(_:)), 		canFade: false, canAction: true)
			])
		bottomRow.translatesAutoresizingMaskIntoConstraints = false
		bottomRow.distribution = UIStackViewDistribution.fillEqually
		bottomRow.spacing = 2
		return bottomRow
	}
		
	func drawLayout()
	{
		let topStack = drawTopStack()
		topStack.translatesAutoresizingMaskIntoConstraints = false
		//topStack.backgroundColor = UIColor.green
		//view.addSubview(topStack)

		let buttonsTop = drawButtonsTop()
		let buttonsBottom = drawButtonsBottom()
		
		let buttons = UIStackView(arrangedSubviews: [buttonsTop, buttonsBottom])
		buttons.translatesAutoresizingMaskIntoConstraints = false
		buttons.distribution = UIStackViewDistribution.equalCentering
		buttons.spacing = 0
		if self.view.frame.height > self.view.frame.width	// do on rotate...
		{
			buttons.axis = UILayoutConstraintAxis.vertical
			buttons.heightAnchor.constraint(equalToConstant: 240).isActive = true
		}
		else
		{
			buttons.heightAnchor.constraint(equalToConstant: 120).isActive = true
		}
		buttonsTop.topAnchor.constraint(equalTo: buttons.topAnchor, constant: 0).isActive = true
		buttonsBottom.bottomAnchor.constraint(equalTo: buttons.bottomAnchor).isActive = true
		buttonsTop.widthAnchor.constraint(equalTo: buttonsBottom.widthAnchor, multiplier: 1).isActive = true
		//view.addSubview(buttons)

		let controls = setUpControls()
		controls.translatesAutoresizingMaskIntoConstraints = false
		//self.view.addSubview(controls)
		
		let collArea = UIView()
		collArea.translatesAutoresizingMaskIntoConstraints = false

		let mainStack = UIStackView(arrangedSubviews: [topStack, controls, collArea, buttons])
		mainStack.axis = UILayoutConstraintAxis.vertical
		mainStack.distribution = UIStackViewDistribution.fill
		mainStack.translatesAutoresizingMaskIntoConstraints = false
		self.view.addSubview(mainStack)
		if #available(iOS 11.0, *) {
			NSLayoutConstraint.activate([
				mainStack.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
				mainStack.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
				mainStack.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
				mainStack.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
				])
		} else {
			NSLayoutConstraint.activate([
				mainStack.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
				mainStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
				mainStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
				mainStack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
				])
		}

		//was above
		topStack.heightAnchor.constraint(equalToConstant: 120).isActive = true
		
		NSLayoutConstraint.activate([
			topStack.topAnchor.constraint(equalTo: mainStack.topAnchor),
			topStack.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor),
			topStack.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor),
			//topStack.heightAnchor.constraint(equalToConstant: 120),

			controls.topAnchor.constraint(equalTo: topStack.bottomAnchor),
			controls.leadingAnchor.constraint(equalTo: topStack.leadingAnchor),
			controls.trailingAnchor.constraint(equalTo: topStack.trailingAnchor),
			])
		NSLayoutConstraint.activate([
			collArea.topAnchor.constraint(equalTo: controls.bottomAnchor),
			collArea.leadingAnchor.constraint(equalTo: controls.leadingAnchor),
			collArea.trailingAnchor.constraint(equalTo: controls.trailingAnchor),
			collArea.bottomAnchor.constraint(equalTo: buttons.topAnchor),
			
			//buttons.topAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: -240),
			buttons.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor),
			buttons.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor),
//			if view.frame.height > view.frame.width
//			{
			buttons.bottomAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: 0),
			])
//		if #available(iOS 11.0, *) {
//			NSLayoutConstraint.activate([
//				topStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//				topStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//				topStack.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//				])
//		} else {
//			//			topStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
//			if view.frame.height > view.frame.width
//			{
//				topStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
//				topStack.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//				topStack.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//			}
//			else
//			{
//				topStack.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//				topStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
//				topStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
//			}
//		}

		//was above
//		if #available(iOS 11.0, *) {
//			NSLayoutConstraint.activate([
//				buttons.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -240),
//				buttons.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//				buttons.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//				buttons.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//				])
//		} else {
//			buttons.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
//			if view.frame.height > view.frame.width
//			{
//				buttons.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -240).isActive = true
//				buttons.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
//				buttons.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//				buttons.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//			}
//			else
//			{
//				buttons.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -120).isActive = true
//				buttons.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//				buttons.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
//				buttons.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
//			}
//		}
	}
	
}

//unused
class VerticalTopAlignLabel: UILabel
{
	override func drawText(in rect:CGRect)
	{
		guard let labelText = text else { 	return super.drawText(in: rect) 	}
		
		let attributedText = NSAttributedString(string: labelText, attributes: [NSAttributedStringKey.font: font])
		var newRect = rect
		newRect.size.height = attributedText.boundingRect(with: rect.size, options: .usesLineFragmentOrigin, context: nil).size.height
		
		if numberOfLines != 0
		{
			newRect.size.height = min(newRect.size.height, CGFloat(numberOfLines) * font.lineHeight)
		}
		super.drawText(in: newRect)
	}
	
}
