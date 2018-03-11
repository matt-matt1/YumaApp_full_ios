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
						let dataString = String(data: data, encoding: .utf8)
						UserDefaults.standard.set(dataString, forKey: "Customer")
						//UserDefaults.standard.set(String(data: data, encoding: .utf8), forKey: "Customer")
						do
						{
							let customer = try JSONDecoder().decode(Customer.self, from: data)
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
				if let myData = data
				{
//					if saveName != nil && saveName != ""
//					{
					let dataStr = String(data: myData, encoding: .utf8)
						UserDefaults.standard.set(dataStr, forKey: "Orders\(id_customer)")
//					}
					do
					{
						let myData = try JSONDecoder().decode(Orders.self, from: myData)
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
	class func getCarriers(from: String, completionHandler: @escaping (/*String,*/ CarrierList) -> Void)
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
						completionHandler(/*dataStr!,*/ myData)
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
	
	///return an Object containing a list of all categories
	class func getCategories(completionHandler: @escaping ([aProduct]) -> Void)
	{
		let url = "\(R.string.WSbase)categories?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
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
						completionHandler(products.products!)
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

	///return an object of the laptops
	class func getLaptops(completionHandler: @escaping ([aProduct]) -> Void)
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
						completionHandler(products.products!)
					}
					catch let JSONerr
					{
						print("\(R.string.err) \(JSONerr)")
					}
				}
				}.resume()
		}
	}

	///return an object of the services
	class func getServices(completionHandler: @escaping ([aProduct]) -> Void)
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
						completionHandler(products.products!)
					}
					catch let JSONerr
					{
						print("\(R.string.err) \(JSONerr)")
					}
				}
				}.resume()
		}
	}
	
	///return an object of the toners
	class func getToners(completionHandler: @escaping ([aProduct]) -> Void)
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
						completionHandler(products.products!)
					}
					catch let JSONerr
					{
						print("\(R.string.err) \(JSONerr)")
					}
				}
			}.resume()
		}
	}
	
	///return an object of the printers
	class func getPrinters(completionHandler: @escaping ([aProduct]) -> Void)
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
						completionHandler(products.products!)
						//						}
					}
					catch let JSONerr
					{
						print("\(R.string.err) \(JSONerr)")
					}
				}
				}.resume()
		}
	}
	
	///try
	class func get__(id_customer: Int, completionHandler: @escaping (Addresses) -> Void)
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
