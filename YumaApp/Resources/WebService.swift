//
//  WebService.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-28.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


enum Direction
{
	case ASC, DESC
}
enum OutputFormat
{
	case JSON
	case XML
}
enum Schema
{
	case blank
	case synopsis
}
enum APIResource: String
{
	case addresses
	case carriers = 					"CarrierList"
	case cartRules
	case carts
	case categories
	case combinations
	case configurations
	case contacts
	case contentManagementSystem
	case countries
	case currencies
	case customerMessages
	case customerThreads
	case customers
	case customizations
	case deliveries
	case employees
	case groups
	case guests
	case imageTypes
	case images
	case languages
	case manufacturers
	case messages
	case orderCarriers
	case orderDetails
	case orderHistories
	case orderInvoices
	case orderPayments
	case orderSlip
	case orderStates
	case orders
	case priceRanges
	case productCustomizationFields
	case productFeatureValues
	case productFeatures
	case productOptionValues
	case productOptions
	case productSuppliers
	case products = 					"JSONProducts"
	case search
	case shopGroups
	case shopUrls
	case shops
	case specificPriceRules
	case specificPrices
	case states = 						"CountryStates"
	case stockAvailables
	case stockMovementReasons
	case stockMovements
	case stocks
	case stores
	case suppliers
	case supplyOrderDetails
	case supplyOrderHistories
	case supplyOrderReceiptHistories
	case supplyOrderStates
	case supplyOrders
	case tags
	case taxRuleGroups
	case taxRules
	case taxes
	case translatedConfigurations
	case warehouseProductLocations
	case warehouses
	case weightRanges
	case zones
}


//eg.
//	var ws = WebService()
//	ws.startURL = R.string.WSbase
//	ws.resource = APIResource.carriers
//	ws.keyAPI = R.string.APIkey
//	ws.filter = ["firstname":["john"], "lastname":["DOE%"]]
//	ws.display = ["birthday"]
//	ws.sort = ["firstname" : Direction.DESC]
//	ws.limit = [6]
//	ws.printURL()

struct WebService
{
	/// Set String of the base url - including trailing '/' - eg. 'https://domain.com/api/'
	var startURL: 	String?
	/// Set the Resource name (String) - select from the enum 'APIResource'
	var resource: 	APIResource?
	/// Set the Resource ID (Integer)
	var id: 		Int = 			-1
	/// Set the XML String to post
	var xml: 		String?
	/// Set the filter that only affect rows where the column name (String) has field(s) that equal (Array of Any)
	var filter: 	[String : [Any]]?
	//eg.
	//	'filter[firstname]' => '[John]', 'filter[lastname]'  => '[DOE]'	ie. filter = [firstname:[John], lastname:[DOE]]
	//	'filter[name]' => '[appl]%'										ie. filter = [name:[appl%]]
	//	'filter[id]' => '[1,10]'										ie. filter = [id:[1,10]]
	/// Set the sort order of the rows by column name (String) using the Direction enum (ie. ASC or DESC)
	var sort: 		[String : Direction]?
	//eg.
	//	'sort'     => '[lastname_ASC]' 									ie. sort = [lastname:.ASC]
	/// Show only the column name(s) (Array of String), or instead show all columns ([full])
	var display: 	[String]?
	//eg.
	//	'display'  => 'full'											ie. display = [full]
	//	'display'    => '[lastname]'									ie. display = [lastname]
	/// Limit the result(s) to only #x rows - [(Int) #x], (optional) starting from row #y - [(Int) #y, (Int) #x]
	var limit: 		[Int]?
	//eg.
	//	'limit'    => '5'												ie. limit = [5]
	//	'limit'    => '9,5'												ie. limit = [9,5]
	/// Web Service (API) authorization token - inserts the parameter: ws_api=<~>
	var keyAPI: 	String?
	var extra: 		String?
	/// Set the output format - select from the OutputFormat enum (ie. XML or JSON)
	var outputAs: 	OutputFormat?
	/// Use to request a blank or blank-detailed (synopsis) resource layout - select from the Schema enum
	var schema: 	Schema?
	

	
//	func init(resource: APIResource, id: Int, filter: [String : [Any]]?, sort: [String : [Direction]]?, display: [String]?, limit: [Int]?)
//	{
//		self.resource = resource
//		self.id = id
//		self.filter = filter
//		self.sort = sort
//		self.display = display
//		self.limit = limit
//	}
	/// Display a list of all the properties beloging to the specified resource
	func listProperties(resource: APIResource) -> [String]
	{
		//let mirror = Mirror(reflecting: CarrierList.self)
		let mirror = Mirror(reflecting: resource.rawValue.self)
		let childs = mirror.children
		var keys: [String] = []
		keys.append("\(resource.rawValue):")
		for (key, _) in childs
		{
			keys.append(key!)
		}
		return keys
	}
	
	/// Form the URL from the previously set objects/parameters
	func makeURL() -> String
	{
		var output = ""
		if startURL != nil
		{
			output = startURL!
		}
		if self.resource != nil
		{
			output += "\(self.resource!)"
		}
		if self.id > -1
		{
			output += "/\(self.id)"
		}
		output += "?"
		if self.keyAPI != nil
		{
			output += "ws_key=\(keyAPI!)&"
		}
		if self.schema != nil
		{
			output += "schema=\(schema ?? Schema.blank)&"
		}
		else
		{
			if self.filter != nil
			{
				for fil in self.filter!
				{
					if !fil.key.isEmpty
					{
						for val in fil.value
						{
							output += "filter[\(fil.key)]="
							if let value = val as? String//type(of: val) == String.self
							{
	//							if val is String && (val as! String).first == "%"
								if value.first == "%"
								{
									output += "%"
								}
								output += "[\(value.replacingOccurrences(of: "%", with: ""))]"
	//							if val is String && (val as! String).last == "%"
								if value.last == "%"
								{
									output += "%"
								}
								output += "&"
							}
							else
							{
								output += "[\(val)]&"
							}
						}
					}
				}
			}
			if self.sort != nil
			{
				for s in sort!
				{
					output += "sort=[\(s.key)_\(s.value)]&"
				}
			}
			if self.display != nil
			{
				for d in display!
				{
					if d == "full"
					{
						output += "display=\(d)&"
					}
					else
					{
						output += "display=[\(d)]&"
					}
				}
			}
			if self.limit != nil
			{
				if limit?.count == 2
				{
					output += "limit=\(self.limit![0]),\(self.limit![1])&"
				}
				else if limit?.count == 1
				{
					output += "limit=\(self.limit![0])&"
				}
			}
		}
		if self.outputAs != nil
		{
			output += "output_format=\(outputAs ?? OutputFormat.XML)&"
		}
		if self.extra != nil
		{
			output += extra!
		}
		return String(output.dropLast())//.remove(at: output.index(before: output.endIndex))//.substring(to: output.index(before: output.endIndex))
	}
	
	func resource2(resource: String) -> String
	{
		var result = resource.dropLast()
		if result.last == "e"
		{
			result = result.dropLast()
		}
		return String(result)
	}
	
	/// Print the URL String - only for debugging purposes
	func printURL()
	{
		print(makeURL())
	}
	
	/// Delete a Resource (database row) having the ID, or mark the resource as deleted
	func delete(completionHandler: @escaping (HttpResult) -> Void)
	{
		guard self.resource != nil else
		{
			print("Error: attemped WebService().delete without setting resource")
			return
		}
		guard self.id > -1 else
		{
			print("Error: attemped WebService().delete without setting id")
			return
		}
		let http = Http()
		let url = URL(string: makeURL()/*String(format: "%@%@/%@", R.string.WSbase, resource as! CVarArg, id)*/)
		http.delete(url: url! as NSURL, headers: [:]) { (result) in
			print(result)
			completionHandler(result)
		}
	}
	
	/// Add a new Resource
	func add(completionHandler: @escaping (HttpResult) -> Void)
	{
		guard self.resource != nil else
		{
			print("Error: attemped WebService().add without setting resource")
			return
		}
		guard self.xml != nil else
		{
			print("Error: attemped WebService().get without setting xml")
			return
		}
		let http = Http()
		let url = URL(string: makeURL())
		let sendXML = xml?.replacingOccurrences(of: "\n", with: "")/*.replacingOccurrences(of: " ", with: "+")*/.data(using: .utf8)
		http.post(url: url! as NSURL, headers: [:], data: sendXML! as NSData) 	{ 	(result) in
			print(result)
			completionHandler(result)
		}
	}
	
	/// Update/edit a resource object having the ID using the supplied XML String
	func edit(completionHandler: @escaping (HttpResult) -> Void)
	{
		guard self.resource != nil else
		{
			print("Error: attemped WebService().edit without setting resource")
			return
		}
		guard self.id > -1 else
		{
			print("Error: attemped WebService().edit without setting id")
			return
		}
		guard self.xml != nil else
		{
			print("Error: attemped WebService().get without setting xml")
			return
		}
		let http = Http()
		let url = URL(string: makeURL())
		//let send = "xml=\(xml!)"
		let send = "\(xml!)"
		http.put(url: url! as NSURL, headers: [:], data: send.data(using: .utf8)! as NSData?) 	{ 	(result) in
			print(result)
			completionHandler(result)
		}
	}
	
	/// Returns object(s) belonging to the Resource; if the ID is given a specific row/object is returned
	mutating func get(completionHandler: @escaping (HttpResult) -> Void)
	{
		guard self.resource != nil else
		{
			print("Error: attemped WebService().get without setting resource")
			return
		}
		if self.id > -1
		{
			print("getting all records")
		}
//		guard self.id > -1 else
//		{
//			print("Error: attemped WebService().get without setting id")
//			return
//		}
		let http = Http()
		//let url = String(format: "%@%@/%@", R.string.WSbase, resource as! CVarArg, id)
		let myUrl = URL(string: makeURL()/*url*/)
		http.get(url: myUrl! as NSURL, headers: [:], data: nil) 	{ 	(result) in
			completionHandler(result)
		}
		self.schema = nil
	}
}
