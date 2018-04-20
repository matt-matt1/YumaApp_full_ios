//
//  PSWebServices.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-13.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class PSWebServices: NSObject
{
	///return an Object containing the current customer
	class func getCustomer(from: String, completionHandler: @escaping (Any) -> Void)
	{
		if let myUrl = URL(string: from)
		{
			URLSession.shared.dataTask(with: myUrl)
			{ (data, response, err) in
				//if err
				//else if response.status_code != 200
				if let data = data
				{
					if data.count < 4
					{
						completionHandler(false)
						return
					}
					else
					{
//						var regex = NSRegularExpression(pattern: "<!--[\\s\\S]*-->", options: NSRegularExpression.Options.caseInsensitive, error: nil)!
						//let str = regex.stringByReplacingMatchesInString(data, options: nil, range: NSMakeRange(0, count(data)), withTemplate: "")
						let dataString = String(data: data, encoding: .utf8)
//						dataString = regex.stringByReplacingMatchesInString(dataString, options: nil, range: NSMakeRange(0, dataString?.count), withTemplate: "")
						var str = dataString?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
						str = str?.replacingOccurrences(of: "\n", with: "", options: .regularExpression, range: nil)
						UserDefaults.standard.set(str, forKey: "Customer")
						var myData: Data
						if dataString != str && str != nil
						{
							myData = str!.data(using: .utf8, allowLossyConversion: true)!
						}
						else
						{
							myData = data
						}
						//UserDefaults.standard.set(String(data: data, encoding: .utf8), forKey: "Customer")
						do
						{
							let customer = try JSONDecoder().decode(Customer.self, from: myData)
								//let _ = Global.customer.init(customer: customer)
								//UserDefaults.standard.set(customer, forKey: "Customer")
								//UserDefaults.standard.set(dataString, forKey: "CustomerString")
							completionHandler(customer)
						}
						catch let JSONerr
						{
							print("\(R.string.err) \(JSONerr)")
							return
						}
					}
				}
			}.resume()
		}
	}

	///return an Object containing a list of addresses belonging to a customer
	class func getAddresses(id_customer: Int, completionHandler: @escaping (Addresses) -> Void)
	{
		let url = "\(R.string.WSbase)/addresses"
		let myUrl = "\(url)?filter[id_customer]=[\(id_customer)]&\(R.string.APIfull)&\(R.string.APIjson)&\(R.string.API_key)"
		if let myUrl = URL(string: myUrl)
		{
			URLSession.shared.dataTask(with: myUrl)
			{ 	(data, response, err) in
//				if err
//				else if response.status_code != 200
				if let data = data
				{
					let dataStr = String(data: data, encoding: .utf8)
					UserDefaults.standard.set(dataStr, forKey: "AddressesCustomer\(id_customer)")
					do
					{
						let addresses = try JSONDecoder().decode(Addresses.self, from: data)
						completionHandler(addresses)
					}
					catch let JSONerr
					{
						print("\(R.string.err) \(JSONerr)")
					}
				}
				return
			}.resume()
		}
	}

	//self.objectToXML(object: object, head: "<?xml version=\"1.0\" encoding=\"UTF-8\"?>", wrapperHead: "<prestashop xmlns:xlink=\"http://www.w3.org/1999/xlink\"><addresses>", wrapperTail: "</addresses></prestashop>")
	///post an address to the web service
	class func postAddress(XMLStr: String, completion: @escaping ((Error?) -> Void))
	{
		let url = "\(R.string.WSbase)addresses?\(R.string.API_key)"
		if let myUrl = URL(string: url)
		{
			var request = URLRequest(url: myUrl)
			request.httpMethod = "POST"
			var headers = request.allHTTPHeaderFields ?? [:]
			headers["Content-Type"] = "text/xml;charset=utf-8"
//			headers["Content-Type"] = "application/json"
			request.allHTTPHeaderFields = headers
			//request.addValue("text/xml;charset=utf-8", forHTTPHeaderField: "Content-Type")

//			let encoder = JSONEncoder()
//			do
//			{
//				let jsonData = try encoder.encode(object)
//				request.httpBody = jsonData
//				print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body")
//			}
//			catch
//			{
//				completion(error)
//			}
			request.httpBody = XMLStr.data(using: .utf8)
			print("post: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body")
			
			let config = URLSessionConfiguration.default
			let session = URLSession(configuration: config)
			let task = session.dataTask(with: request)
			{
				(responseData, response, responseError) in
				guard responseError == nil else
				{
					completion(responseError)
					return
				}
				if let data = responseData, let utf8 = String(data: data, encoding: .utf8)
				{
					if let HTTPresponse = response as? HTTPURLResponse
					{
						print("status: ", String(HTTPresponse.statusCode))
						for header in HTTPresponse.allHeaderFields
						{
							print(header)
						}
					}
					print("response: ", utf8)
				}
				else
				{
					print("no data")
				}
			}
			task.resume()
		}
	}

	///return an Object containing a list of the orders
	class func getOrders(id_customer: Int, completionHandler: @escaping (Orders?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)orders?filter[id_customer]=[\(id_customer)]&\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			URLSession.shared.dataTask(with: myUrl)
			{
				(data, response, err) in
				//				if err
				//				else if response.status_code != 200
				if let data = data
				{
//					if saveName != nil && saveName != ""
//					{
					let dataStr = String(data: data, encoding: .utf8)
						UserDefaults.standard.set(dataStr, forKey: "OrderCustomer\(id_customer)")
//					}
					do
					{
						let myData = try JSONDecoder().decode(Orders.self, from: data)
//						print(myData)
						completionHandler(myData, nil)
					}
					catch let JSONerr
					{
						print("\(R.string.err) \(JSONerr)")
						completionHandler(nil, JSONerr)
					}
				}
				return
				}.resume()
		}
	}
	
	///return an Object containing a list of the languages
	class func getLangauages(completionHandler: @escaping (Languages?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)languages?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			URLSession.shared.dataTask(with: myUrl)
			{
				(data, response, err) in
				//				if err
				//				else if response.status_code != 200
				if let myData = data
				{
					//					if saveName != nil && saveName != ""
					//					{
					let dataStr = String(data: myData, encoding: .utf8)
					UserDefaults.standard.set(dataStr, forKey: "Languages")
					//					}
					do
					{
						let myData = try JSONDecoder().decode(Languages.self, from: myData)
						//						print(myData)
						completionHandler(myData, nil)
					}
					catch let JSONerr
					{
						print("\(R.string.err) \(JSONerr)")
						completionHandler(nil, JSONerr)
					}
				}
				return
				}.resume()
		}
	}
	
	///return an Object containing a list of the combinations
	class func getCurrencies(completionHandler: @escaping (Currencies?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)currencies?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			URLSession.shared.dataTask(with: myUrl)
			{
				(data, response, err) in
				//				if err
				//				else if response.status_code != 200
				if let myData = data
				{
					//					if saveName != nil && saveName != ""
					//					{
					let dataStr = String(data: myData, encoding: .utf8)
					UserDefaults.standard.set(dataStr, forKey: "Currencies")
					//					}
					do
					{
						let myData = try JSONDecoder().decode(Currencies.self, from: myData)
						//						print(myData)
						completionHandler(myData, nil)
					}
					catch let JSONerr
					{
						print("\(R.string.err) \(JSONerr)")
						completionHandler(nil, JSONerr)
					}
				}
				return
			}.resume()
		}
	}
	
	
	///return an Object containing a list of the combinations
	class func getCombinations(completionHandler: @escaping (Combinations?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)combinations?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			URLSession.shared.dataTask(with: myUrl)
			{
				(data, response, err) in
				//				if err
				//				else if response.status_code != 200
				if let myData = data
				{
					//					if saveName != nil && saveName != ""
					//					{
					let dataStr = String(data: myData, encoding: .utf8)
					UserDefaults.standard.set(dataStr, forKey: "Combinations")
					//					}
					do
					{
						let myData = try JSONDecoder().decode(Combinations.self, from: myData)
						//						print(myData)
						completionHandler(myData, nil)
					}
					catch let JSONerr
					{
						print("\(R.string.err) \(JSONerr)")
						completionHandler(nil, JSONerr)
					}
				}
				return
			}.resume()
		}
	}

	///return an Object containing a list of the manufacturers
	class func getManufacturers(completionHandler: @escaping (Manufacturers?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)manufacturers?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			URLSession.shared.dataTask(with: myUrl)
			{
				(data, response, err) in
				//				if err
				//				else if response.status_code != 200
				if let myData = data
				{
					//					if saveName != nil && saveName != ""
					//					{
					let dataStr = String(data: myData, encoding: .utf8)
					UserDefaults.standard.set(dataStr, forKey: "Manufacturers")
					//					}
					do
					{
						let myData = try JSONDecoder().decode(Manufacturers.self, from: myData)
						//						print(myData)
						completionHandler(myData, nil)
					}
					catch let JSONerr
					{
						print("\(R.string.err) \(JSONerr)")
						completionHandler(nil, JSONerr)
					}
				}
				return
				}.resume()
		}
	}
	
	///return an Object containing a list of the categories
	//class func getCategories(completionHandler: @escaping ([aCategory]?, Error?) -> Void)
	class func getCategories(completionHandler: @escaping (Categories?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)categories?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			URLSession.shared.dataTask(with: myUrl)
			{
				(data, response, err) in
				//				if err
				//				else if response.status_code != 200
				if let myData = data
				{
					//					if saveName != nil && saveName != ""
					//					{
					let dataStr = String(data: myData, encoding: .utf8)
					UserDefaults.standard.set(dataStr, forKey: "Categories")
					//					}
					do
					{
//						let myData = try JSONSerialization.jsonObject(with: myData, options: []) as! Categories//[String:AnyObject]
						//let array = result["categories"] as? [aCategory]
						//completionHandler(array, nil)
						//let myData = result as! Categories
						let myData = try JSONDecoder().decode(Categories.self, from: myData)
						//						print(myData)
						completionHandler(myData, nil)
					}
					catch let JSONerr
					{
						print("\(R.string.err) \(JSONerr)")
						completionHandler(nil, JSONerr)
					}
				}
				return
				}.resume()
		}
	}

	///return an Object containing a list of the order details
	class func getOrderDetails(id_order: Int, completionHandler: @escaping (OrderDetails?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)order_details?filter[id_order]=[\(id_order)]&\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			URLSession.shared.dataTask(with: myUrl)
			{
				(data, response, err) in
				//				if err
				//				else if response.status_code != 200
				if let myData = data
				{
					//					if saveName != nil && saveName != ""
					//					{
					let dataStr = String(data: myData, encoding: .utf8)
					UserDefaults.standard.set(dataStr, forKey: "Order\(id_order)Details")
					//					}
					do
					{
						let myData = try JSONDecoder().decode(OrderDetails.self, from: myData)
						//						print(myData)
						completionHandler(myData, nil)
					}
					catch let JSONerr
					{
						print("\(R.string.err) \(JSONerr)")
						completionHandler(nil, JSONerr)
					}
				}
				return
				}.resume()
		}
	}

	///return an Object containing a list of the order states
	class func getOrderStates(completionHandler: @escaping (OrderStates?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)order_states?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			URLSession.shared.dataTask(with: myUrl)
			{
				(data, response, err) in
				//				if err
				//				else if response.status_code != 200
				if let myData = data
				{
					//					if saveName != nil && saveName != ""
					//					{
					let dataStr = String(data: myData, encoding: .utf8)
					UserDefaults.standard.set(dataStr, forKey: "OrderStates")
					//					}
					do
					{
						let myData = try JSONDecoder().decode(OrderStates.self, from: myData)
						//						print(myData)
						completionHandler(myData, nil)
					}
					catch let JSONerr
					{
						print("\(R.string.err) \(JSONerr)")
						completionHandler(nil, JSONerr)
					}
				}
				return
				}.resume()
		}
	}
	
	///return an Object containing a list of the order carriers
	class func getOrderCarriers(completionHandler: @escaping ([OrderCarrier]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)order_carriers?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			URLSession.shared.dataTask(with: myUrl)
			{
				(data, response, err) in
				//				if err
				//				else if response.status_code != 200
				if let myData = data
				{
					//					if saveName != nil && saveName != ""
					//					{
					let dataStr = String(data: myData, encoding: .utf8)
					UserDefaults.standard.set(dataStr, forKey: "OrderCarriers")
					//					}
					do
					{
						let myData = try JSONDecoder().decode(OrderCarriers.self, from: myData)
						//						print(myData)
						completionHandler(myData.order_carriers, nil)
					}
					catch let JSONerr
					{
						print("\(R.string.err) \(JSONerr)")
						completionHandler(nil, JSONerr)
					}
				}
				return
				}.resume()
		}
	}

	///return an Object containing a list of the carts
	class func getCarts(id_customer: Int, completionHandler: @escaping (Carts?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)carts?filter[id_customer]=[\(id_customer)]&\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			URLSession.shared.dataTask(with: myUrl)
			{
				(data, response, err) in
				//				if err
				//				else if response.status_code != 200
				if let data = data
				{
					//					if saveName != nil && saveName != ""
					//					{
					let dataStr = String(data: data, encoding: .utf8)
					UserDefaults.standard.set(dataStr, forKey: "CartsCustomer\(id_customer)")
					//					}
					do
					{
						let myData = try JSONDecoder().decode(Carts.self, from: data)
						//						print(myData)
						completionHandler(myData, nil)
					}
					catch let JSONerr
					{
						print("\(R.string.err) \(JSONerr)")
						completionHandler(nil, JSONerr)
					}
				}
				return
				}.resume()
		}
	}

	///return an Object containing a list of the product options
	class func getProductOptions(completionHandler: @escaping (ProductOptions?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)product_options?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			URLSession.shared.dataTask(with: myUrl)
			{
				(data, response, err) in
				//				if err
				//				else if response.status_code != 200
				if let myData = data
				{
					//					if saveName != nil && saveName != ""
					//					{
					let dataStr = String(data: myData, encoding: .utf8)
					UserDefaults.standard.set(dataStr, forKey: "ProductOptions")
					//					}
					do
					{
						let myData = try JSONDecoder().decode(ProductOptions.self, from: myData)
						//						print(myData)
						completionHandler(myData, nil)
					}
					catch let JSONerr
					{
						print("\(R.string.err) \(JSONerr)")
						completionHandler(nil, JSONerr)
					}
				}
				return
			}.resume()
		}
	}

//	func buildAnswer(keys: [String]) throws -> Data
//	{
//		var result = [String: Any](minimumCapacity: keys.count)
//
//		for key in keys
//		{
//			let data = CRUD.shared.restoreKey(key: key)
//			result[key] = try JSONSerialization.jsonObject(with: data)
//		}
//		return try JSONSerialization.data(withJSONObject: result)
//	}
	
	///return an Object containing a list of the carriers
	class func getCarriers(from: String, completionHandler: @escaping (CarrierList?, Error?) -> Void)
	{
		if let myUrl = URL(string: from)
		{
			URLSession.shared.dataTask(with: myUrl)
			{
				(data, response, err) in
//				if err
//				else if response.status_code != 200
				if let myData = data
				{
//					if saveName != nil && saveName != ""
//					{
					let dataStr = String(data: myData, encoding: .utf8)
					UserDefaults.standard.set(dataStr, forKey: "Carriers")
//					}
					do
					{
						let myData = try JSONDecoder().decode(CarrierList.self, from: myData)
//						print(myData)
						completionHandler(myData, nil)
					}
					catch let JSONerr
					{
						print("\(R.string.err) \(JSONerr)")
						completionHandler(nil, JSONerr)
					}
				}
				return
				}.resume()
		}
	}

	///try
	class func convertJSONToObject<T>(fromUrl: String, toObject: T, saveName: String?, completionHandler: @escaping (Any) -> Void)
	{
		if let myUrl = URL(string: fromUrl)
		{
			URLSession.shared.dataTask(with: myUrl)
			{
				(data, response, err) in
				//				if err
				//				else if response.status_code != 200
				if let myData = data
				{
					if saveName != nil && saveName != ""
					{
						UserDefaults.standard.set(String(data: myData, encoding: .utf8), forKey: saveName!)
					}
//					do
//					{
//						let myData = try JSONDecoder().decode(T, from: myData)
						completionHandler(myData)
//					}
//					catch let JSONerr
//					{
//						print("\(R.string.err) \(JSONerr)")
//					}
				}
				return
				}.resume()
		}
	}
	
	struct FailableDecodable<Base : Decodable> : Decodable
	{
		let base: Base?
		
		init(from decoder: Decoder) throws
		{
			let container = try decoder.singleValueContainer()
			self.base = try? container.decode(Base.self)
		}
	}
	struct FailableCodableArray<Element : Codable> : Codable
	{
		var elements: [Element]
		
		init(from decoder: Decoder) throws
		{
			var container = try decoder.unkeyedContainer()
			
			var elements = [Element]()
			if let count = container.count
			{
				elements.reserveCapacity(count)
			}
			
			while !container.isAtEnd
			{
				if let element = try container
					.decode(FailableDecodable<Element>.self).base
				{
					elements.append(element)
				}
			}
			
			self.elements = elements
		}
		
		func encode(to encoder: Encoder) throws
		{
			var container = encoder.singleValueContainer()
			try container.encode(elements)
		}
	}
		
	///return an Object containing a list of all categories
	class func getCategories(completionHandler: @escaping (Any) -> Void)
	{
		let url = "\(R.string.WSbase)categories?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			URLSession.shared.dataTask(with: myUrl)
			{
				(data, response, err) in
				
				if let data = try? JSONSerialization.data(withJSONObject: data!, options: [])//data
				{
//					let dataString = String(data: data, encoding: .utf8)
//					print(dataString ?? R.string.err)
					do
					{
						let result = try JSONDecoder().decode([FailableDecodable<aCategory>].self, from: data).compactMap { $0.base }
						completionHandler(result)
					}
					catch let JSONerr
					{
						print("\(R.string.err) \(JSONerr)")
					}
				}
			}.resume()
		}
	}
	
	///return an Object containing a list of all countries
	class func getCountries(completionHandler: @escaping ([Country]) -> Void)
	{
		let url = "\(R.string.WSbase)countries?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			URLSession.shared.dataTask(with: myUrl)
			{
				(data, response, err) in
				
				if let data = data
				{
					//					let dataString = String(data: data, encoding: .utf8)
					//					print(dataString ?? R.string.err)
					do
					{
						let countries = try JSONDecoder().decode(Countries.self, from: data)
						completionHandler(countries.countries)
					}
					catch let JSONerr
					{
						print("\(R.string.err) \(JSONerr)")
					}
				}
				}.resume()
		}
	}
	
	///return the states belonging to id_country;  id_country is 0 return all states
	class func getStates(id_country: Int, completionHandler: @escaping ([CountryState]) -> Void)
	{
		var url = "\(R.string.WSbase)states?"
		if id_country > 0
		{
			url.append("filter[id_country]=[\(id_country)]&")
		}
		url.append("\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)")
		if let myUrl = URL(string: url)
		{
			URLSession.shared.dataTask(with: myUrl)
			{
				(data, response, err) in
				
				if let data = data
				{
					//					let dataString = String(data: data, encoding: .utf8)
					//					print(dataString ?? R.string.err)
					do
					{
						let states = try JSONDecoder().decode(CountryStates.self, from: data)
						completionHandler(states.states!)
					}
					catch let JSONerr
					{
						print("\(R.string.err) \(JSONerr)")
					}
				}
				}.resume()
		}
	}

	///return an object of the taxes
	class func getTaxes(completionHandler: @escaping (Taxes?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)taxes?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			URLSession.shared.dataTask(with: myUrl)
			{
				(data, response, err) in
				
				if let data = data
				{
					let dataString = String(data: data, encoding: .utf8)
					UserDefaults.standard.set(dataString, forKey: "Taxes")
					do
					{
						let taxes = try JSONDecoder().decode(Taxes.self, from: data)
						completionHandler(taxes, nil)
					}
					catch let JSONerr
					{
						//print("\(R.string.err) \(JSONerr)")
						completionHandler(nil, JSONerr)
					}
				}
				}.resume()
		}
	}

	///return an object of the configurations
	class func getConfigurations(completionHandler: @escaping (Configurations?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)configurations?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			URLSession.shared.dataTask(with: myUrl)
			{
				(data, response, err) in
				
				if let data = data
				{
					let dataString = String(data: data, encoding: .utf8)
					UserDefaults.standard.set(dataString, forKey: "Configurations")
					do
					{
						let configurations = try JSONDecoder().decode(Configurations.self, from: data)
						completionHandler(configurations, nil)
					}
					catch let JSONerr
					{
						completionHandler(nil, JSONerr)
					}
				}
				}.resume()
		}
	}

	///return an object of the tags
	class func getTags(completionHandler: @escaping (Tags?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)tags?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			URLSession.shared.dataTask(with: myUrl)
			{
				(data, response, err) in
				
				if let data = data
				{
					let dataString = String(data: data, encoding: .utf8)
					UserDefaults.standard.set(dataString, forKey: "Tags")
					do
					{
						let tags = try JSONDecoder().decode(Tags.self, from: data)
						completionHandler(tags, nil)
					}
					catch let JSONerr
					{
						//print("\(R.string.err) \(JSONerr)")
						completionHandler(nil, JSONerr)
					}
				}
				}.resume()
		}
	}

	///return an object of the tags
	class func getProductOptionValues(completionHandler: @escaping (ProductOptionValues?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)product_option_values?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			URLSession.shared.dataTask(with: myUrl)
			{
				(data, response, err) in
				
				if let data = data
				{
					//					let dataString = String(data: data, encoding: .utf8)
					//					print(dataString ?? R.string.err)
					do
					{
						let tags = try JSONDecoder().decode(ProductOptionValues.self, from: data)
						completionHandler(tags, nil)
					}
					catch let JSONerr
					{
						//print("\(R.string.err) \(JSONerr)")
						completionHandler(nil, JSONerr)
					}
				}
				}.resume()
		}
	}

	///return an object of the laptops
	class func getLaptops(completionHandler: @escaping ([aProduct]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)products?filter[id_category_default]=[14]&\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			URLSession.shared.dataTask(with: myUrl)
			{
				(data, response, err) in
				
				if let data = data
				{
					//					let dataString = String(data: data, encoding: .utf8)
					//					print(dataString ?? R.string.err)
					do
					{
						let products = try JSONDecoder().decode(JSONProducts.self, from: data)
						completionHandler(products.products!, nil)
					}
					catch let JSONerr
					{
						//print("\(R.string.err) \(JSONerr)")
						completionHandler(nil, JSONerr)
					}
				}
				}.resume()
		}
	}

	///return an object of the services
	class func getServices(completionHandler: @escaping ([aProduct]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)products?filter[id_category_default]=[15]&\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			URLSession.shared.dataTask(with: myUrl)
			{
				(data, response, err) in
				
				if let data = data
				{
//					let dataString = String(data: data, encoding: .utf8)
//					print(dataString ?? R.string.err)
					do
					{
						let products = try JSONDecoder().decode(JSONProducts.self, from: data)
						completionHandler(products.products!, nil)
					}
					catch let JSONerr
					{
						//print("\(R.string.err) \(JSONerr)")
						completionHandler(nil, JSONerr)
					}
				}
				}.resume()
		}
	}
	
	///return an object of the toners
	class func getToners(completionHandler: @escaping ([aProduct]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)products?filter[id_category_default]=[13]&\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			URLSession.shared.dataTask(with: myUrl)
			{
				(data, response, err) in
				
				if let data = data
				{
//					let dataString = String(data: data, encoding: .utf8)
//					print(dataString ?? R.string.err)
					do
					{
						let products = try JSONDecoder().decode(JSONProducts.self, from: data)
						completionHandler(products.products!, nil)
					}
					catch let JSONerr
					{
						//print("\(R.string.err) \(JSONerr)")
						completionHandler(nil, JSONerr)
					}
				}
			}.resume()
		}
	}
	
	///return an object of the printers
	class func getPrinters(completionHandler: @escaping ([aProduct]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)products?filter[id_category_default]=[12]&\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			URLSession.shared.dataTask(with: myUrl)
			{
				(data, response, err) in
				
				if let data = data
				{
//					let dataString = String(data: data, encoding: .utf8)
//					print(dataString ?? R.string.err)
					do
					{
						/*guard*/ let products = try JSONDecoder().decode(JSONProducts.self, from: data)
						//print(products)
						/*else
						{
						print("Error: couldn't decode JSON")
						return
						}*/
						//let printers = products.products
						//print("number of printers: \(String(describing: printers?.count))")
						//						let result = try JSONDecoder().decode(JSONProducts.self, from: data)
						//						{
						//						var todo = self
						//CRASHES:let printers = try JSONDecoder().decode(JSONProducts.self, from: data)
						//						guard let printers = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] else {	return 	}
						//							completionHandler(printers["products"]! as! [aProduct])
						completionHandler(products.products!, nil)
						//						}
					}
					catch let JSONerr
					{
						//print("\(R.string.err) \(JSONerr)")
						completionHandler(nil, JSONerr)
					}
				}
				}.resume()
		}
	}

	///return an object of the customer messages
	class func getCustomerMessages(completionHandler: @escaping ([CustomerMessage]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)customer_messages&\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			URLSession.shared.dataTask(with: myUrl)
			{
				(data, response, err) in
				
				if let data = data
				{
					//					let dataString = String(data: data, encoding: .utf8)
					//					print(dataString ?? R.string.err)
					do
					{
						let custmsgs = try JSONDecoder().decode(CustomerMessages.self, from: data)
						completionHandler(custmsgs.customer_messages!, nil)
					}
					catch let JSONerr
					{
						completionHandler(nil, JSONerr)
					}
				}
			}.resume()
		}
	}
	
	///return an object of the customer threads
	class func getCustomerThreads(completionHandler: @escaping ([CustomerThread]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)customer_threads&\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			URLSession.shared.dataTask(with: myUrl)
			{
				(data, response, err) in
				
				if let data = data
				{
					//					let dataString = String(data: data, encoding: .utf8)
					//					print(dataString ?? R.string.err)
					do
					{
						let threads = try JSONDecoder().decode(CustomerThreads.self, from: data)
						completionHandler(threads.customer_threads!, nil)
					}
					catch let JSONerr
					{
						completionHandler(nil, JSONerr)
					}
				}
				}.resume()
		}
	}

	///return an object of the contacts
	class func getContacts(completionHandler: @escaping ([Contact]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)contacts&\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			URLSession.shared.dataTask(with: myUrl)
			{
				(data, response, err) in
				
				if let data = data
				{
					//					let dataString = String(data: data, encoding: .utf8)
					//					print(dataString ?? R.string.err)
					do
					{
						let contacts = try JSONDecoder().decode(Contacts.self, from: data)
						completionHandler(contacts.contacts, nil)
					}
					catch let JSONerr
					{
						completionHandler(nil, JSONerr)
					}
				}
			}.resume()
		}
	}

	///try
	class func get__(resource: String, param: String?, decodeType: Any?, completionHandler: @escaping (Any?, Error?) -> Void)
	{
		let myUrl = "\(R.string.WSbase)\(resource)?\(param ?? "a=1")&\(R.string.APIfull)&\(R.string.APIjson)&\(R.string.API_key)"
		if let myUrl = URL(string: myUrl)
		{
			URLSession.shared.dataTask(with: myUrl)
			{ (data, response, err) in
//				if data != nil//let data = data
//				{
//					do
//					{
//						//let result = try JSONDecoder().decode(decodeType!, from: data)
//						//completionHandler(result, nil)
//					}
//					catch let JSONerr
//					{
//						//print("\(R.string.err) \(JSONerr)")
//						completionHandler(nil, JSONerr)
//					}
//				}
				}.resume()
		}
	}
	
	///try
	class func get___(id_customer: Int, completionHandler: @escaping (Addresses) -> Void)
	{
		let url = "\(R.string.WSbase)/addresses"
		let myUrl = "\(url)?filter[id_customer]=[\(id_customer)]&\(R.string.APIfull)&\(R.string.APIjson)&\(R.string.API_key)"
		if let myUrl = URL(string: myUrl)
		{
			URLSession.shared.dataTask(with: myUrl)
			{ (data, response, err) in
				if let data = data
				{
					do
					{
						let addresses = try JSONDecoder().decode(Addresses.self, from: data)
						completionHandler(addresses)
					}
					catch let JSONerr
					{
						print("\(R.string.err) \(JSONerr)")
					}
				}
				}.resume()
		}
	}
	
	/// Convert an object in XML using Prestashop's signature eg object2psxml(object: myAddress, resource: "addresses")
	class func object2psxml(object: Any, resource: String, resource2: String) -> String
	{
		return objectToXML(object: object, head: "<?xml version=\"1.0\" encoding=\"UTF-8\"?>", wrapperHead: "<prestashop xmlns:xlink=\"http://www.w3.org/1999/xlink\">\n<\(resource)>\n<\(resource2)>", wrapperTail: "</\(resource2)>\n</\(resource)>\n</prestashop>")
	}
	
	/// Convert an object in XML eg. objectToXML(object: myObj, head: "<?xml version=\"2.0\" encoding=\"ASCII\"?>", wrapperHead: "<my_wrapper>", wrapperTail: "</my_wrapper>")
	class func objectToXML(object: Any, head: String? = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>", wrapperHead: String? = nil, wrapperTail: String? = nil, prettyOutput: Bool = true) -> String
	{
		let start = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
		var xml = ""
		if head != nil
		{
			xml += head!
		}
		else
		{
			xml += start
		}
		if prettyOutput
		{
			xml += "\n"
		}
		if wrapperHead != nil
		{
			xml += wrapperHead!
		}
		if prettyOutput
		{
			xml += "\n"
		}
		let mirror = Mirror(reflecting: object)
		for (key, value) in mirror.children
		{
			if let key = key
			{
				if key == "id"
				{
					continue
				}
				if prettyOutput
				{
					xml += "\t"
				}
				xml += "<"
				xml += String(key)
				let val = value as? String
				if val != nil
				{
					var vcd = "<![CDATA["
					vcd += val!
					vcd += "]]>"
					if let intV = Int(val!), intV > 0
					{
						switch (key)
						{
						case "id_supplier":
							xml += " xlink:href=\"" + R.string.WSbase + "suppliers/\(val!)\""
							break
						case "id_country":
							xml += " xlink:href=\"" + R.string.WSbase + "countries/\(val!)\""
							break
						default:
							break
						}
					}
				}
				xml += ">"
				if let val = value as? String
				{
					xml += "<![CDATA["
					xml += val
					xml += "]]>"
				}
				xml += "</"
				xml += String(key)
				xml += ">"
				if prettyOutput
				{
					xml += "\n"
				}
			}
		}
		if wrapperTail != nil
		{
			xml += wrapperTail!
		}
		if prettyOutput
		{
			xml += "\n"
		}
		//print(xml)
		return xml
	}

}

extension String
{
	func indexOf(_ character: Character) -> Int
	{
		return (index(of: character)?.encodedOffset)!
	}
	func lastIndexOf(_ character: String) -> Int?
	{
		guard let index = range(of: character, options: .backwards) else { 	return nil 	}
		return self.distance(from: self.startIndex, to: index.lowerBound)
	}
	func substringBetween(_ fromCharacter: Character, _ toChartacter: String, exclusive: Bool = false) -> String
	{
		var pos1 = self.indexOf("[")
		var pos2 = self.lastIndexOf("]")!+1
		if exclusive
		{
			pos1 += 1
			pos2 -= 1
		}
		let start = self.index(self.startIndex, offsetBy: pos1)
		let end = self.index(self.startIndex, offsetBy: pos2)
		return String(self[start..<end])
	}
}

public extension KeyedDecodingContainer
{
	public func decode(_ type: Int.Type, forKey key: Key) throws -> Int
	{
		let stringValue = try self.decode(String.self, forKey: key)
		guard let floatValue = Int(stringValue) else
		{
			let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Could not parse JSON key \"\(key)\" (value=\(stringValue) to a Int")
			throw DecodingError.dataCorrupted(context)
		}
		return floatValue
	}
}


public protocol JSONDecodable
{
	associatedtype DecodableType// (Swift 2.3)
	
	static func decode(json: JSON) -> DecodableType?
	static func decode(json: JSON?) -> DecodableType?
	static func decode(json: [JSON]) -> [DecodableType?]
	static func decode(json: [JSON]?) -> [DecodableType?]
}
public extension JSONDecodable
{
	static func decode(json: JSON?) -> DecodableType? {
		guard let json = json else { return nil }
		return decode(json: json)
	}
	static func decode(json: [JSON]) -> [DecodableType?] {
		return json.map(decode)
	}
	static func decode(json: [JSON]?) -> [DecodableType?] {
		guard let json = json else { return [] }
		return decode(json: json)
	}
}
