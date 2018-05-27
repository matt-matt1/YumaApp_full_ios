//
//  SwipingController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-24.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit
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
	let prevBtn: 			UIButton =
	{
		let button = 		UIButton(type: .system)
		button.setTitle("PREV", for: .normal)
		button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
		return button
	}()
	let nextBtn: 			UIButton =
	{
		let button = 		UIButton(type: .system)
		button.setTitle("NEXT", for: .normal)
		button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
		return button
	}()
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
		setDefaults()
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
							print("got \((items as! [OrderState]?)?.count ?? 0) order states")
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
							print("got \((items as! [OrderCarrier]?)?.count ?? 0) order_carriers")
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
					print("decoded \(store.orderCarriers.count) order_carriers")
				}
				catch let JSONerr
				{
					print("\(R.string.err) \(JSONerr)")
				}
			}
		}
		else
		{
			print("data store has \(store.orderCarriers.count) order_carriers")
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
							print("got \((items)?.count ?? 0) product_option_values")
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
					print("decoded \(store.productOptionValues.count) product_option_values")
				}
				catch let JSONerr
				{
					print("\(R.string.err) \(JSONerr)")
				}
			}
		}
		else
		{
			print("data store has \(store.tags.count) product_option_values")
		}
	}


	func setDefaults()
	{
		store.defaultCurr = Int(store.configValue(forKey: "PS_CURRENCY_DEFAULT"))!
		store.myLang = Int(store.configValue(forKey: "PS_LANG_DEFAULT"))!
		store.defaultCountry = Int(store.configValue(forKey: "PS_COUNTRY_DEFAULT"))!
		store.defaultCountryISO = store.configValue(forKey: "PS_LOCALE_COUNTRY")
		store.defaultLangISO = store.configValue(forKey: "PS_LOCALE_LANGUAGE")
		store.idShop = Int(store.configValue(forKey: "PS_SHOP_DEFAULT"))!
		store.idDefaultGroup = Int(store.configValue(forKey: "PS_CUSTOMER_GROUP"))!
		store.custOptin = Int(store.configValue(forKey: "PS_CUSTOMER_OPTIN"))!
		store.custBDate = Int(store.configValue(forKey: "PS_CUSTOMER_BIRTHDATE"))!
		store.preventReorderFromHist = Int(store.configValue(forKey: "PS_DISALLOW_HISTORY_REORDERING"))!
		store.displayWeight = Int(store.configValue(forKey: "PS_DISPLAY_PRODUCT_WEIGHT"))!
		store.displayDiscPrice = Int(store.configValue(forKey: "PS_DISPLAY_DISCOUNT_PRICE"))!
		//CHEQUE_NAME, CHEQUE_ADDRESS
		//BANK_WIRE_DETAILS, BANK_WIRE_OWNER, BANK_WIRE_ADDRESS, BANK_WIRE_RESERVATION_DAYS, BANK_WIRE_CUSTOM_TEXT
		store.defaultCountryState = Int(store.configValue(forKey: "PS_SHOP_STATE_ID"))!
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
	
	func drawTopStack() -> UIStackView
	{
		let loginPanel = drawIconPanel(iconText: FontAwesome.user.rawValue, labelText: R.string.login, actionSelector: #selector(loginTapped(_:)), canFade: false, canAction: true)
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
