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
//	func stripJSONObjToJSONArray(json: String) -> String
//	{
//		//let start = json.index(of: "[")
//		let start = json.index(json.startIndex, offsetBy: 13)
//		let finish = json.index(json.endIndex, offsetBy: -2)
//		let range = start..<finish
//		let mySub = json[range]
//		return String(mySub)
//	}

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
						UserDefaults.standard.set(String(data: data, encoding: .utf8), forKey: "Customer")
						//let dataString = String(data: data, encoding: .utf8)
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

	
//	func decodeJSONData(_ jsonData: Data) -> Any// Addresses
//	{
//		do
//		{
//			let addresses = try JSONDecoder().decode(Addresses.self, from: jsonData)
//			return addresses
//		}
//		catch let JSONerr
//		{
//			print("\(R.string.err) \(JSONerr)")
//		}
//		return false
//	}
	
	class func getAddresses(id_customer: Int, completionHandler: @escaping (Addresses) -> Void)
	//class func getAddresses(id_customer: Int, completionHandler: @escaping ([Address]) -> Void)
	{
		let url = "\(R.string.WSbase)/addresses"
		let myUrl = "\(url)?filter[id_customer]=[\(id_customer)]&\(R.string.APIfull)&\(R.string.APIjson)&\(R.string.API_key)"
		if let myUrl = URL(string: myUrl)
		{
			URLSession.shared.dataTask(with: myUrl)
			{ (data, response, err) in
//				if err
//				else if response.status_code != 200
				if let data = data
				{
					//let wholeStr = String(data: data, encoding: .utf8)
					//let trimmed = wholeStr?.substringBetween("[", "]")
					//UserDefaults.standard.set(trimmed, forKey: "CustAddr")
//					let dataString = String(data: data, encoding: .utf8)
//					print(dataString ?? R.string.err)
//					let addresses = decodeJSONData(json: data)
//					if addresses as Bool == false
//					{
//						return
//					}
//					else
//					{
//						completionHandler(Addresses)
//					}
//					let str = String(data: data, encoding: .utf8)
//					UserDefaults.standard.set(str, forKey: "CustomerAddresses")
					UserDefaults.standard.set(String(data: data, encoding: .utf8), forKey: "CustomerAddresses")
					do
					{
						//let data: Data = Data(trimmed)
						let addresses = try JSONDecoder().decode(Addresses.self, from: data)
						//let addresses = try JSONDecoder().decode([Address].self, from: (trimmed?.data(using: .utf8))!)
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
	
	class func getCarriers(from: String, completionHandler: @escaping ([Carrier]) -> Void)
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
						let myData = try JSONDecoder().decode([Carrier].self, from: myData)
						completionHandler(myData)
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
					do
					{
//						let myData = try JSONDecoder().decode(T, from: myData)
						completionHandler(myData)
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
	
	class func getPrinters3(url: String, completionHandler: @escaping (Addresses) -> Void)
	{
		let url = "\(R.string.WSbase)products?filter[id_category_default]=[12]&\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			URLSession.shared.dataTask(with: myUrl)
			{
				(data, response, err) in
				
				//				if err
				//				else if response.status_code != 200
				if let data = data
				{
					//					let dataString = String(data: data, encoding: .utf8)
					//					print(dataString ?? R.string.err)
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
	

	
	class func getPrinters(completionHandler: @escaping ([aProduct]) -> Void)
	{
		let url = "\(R.string.WSbase)products?filter[id_category_default]=[12]&\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			URLSession.shared.dataTask(with: myUrl)
			{ (data, response, err) in
				if let data = data
				{
					let dataString = String(data: data, encoding: .utf8)
					print(dataString ?? R.string.err)
					do
					{
						/*guard*/ let products = try JSONDecoder().decode(JSONProducts.self, from: data)
						print(products)
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
//						completionHandler(result.products!)
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
//	class func getPrinters(completionHandler: @escaping ([aProduct]) -> Void)
//	{
//		let url = "\(R.string.WSbase)products?filter[id_category_default]=[12]&\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
//		if let myUrl = URL(string: url)
//		{
//			URLSession.shared.dataTask(with: myUrl)
//			{ (data, response, err) in
//				if let data = data
//				{
//					let dataString = String(data: data, encoding: .utf8)
//					print(dataString ?? R.string.err)
//					do
//					{
//						//CRASHES:let printers = try JSONDecoder().decode(JSONProducts.self, from: data)
//						guard let printers = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] else {	return 	}
//						completionHandler(printers["products"]! as! [aProduct])
//					}
//					catch let JSONerr
//					{
//						print("\(R.string.err) \(JSONerr)")
//					}
//				}
//				}.resume()
//		}
//	}
	class func getPrinters2(completionHandler: @escaping (MyShops) -> Void)
	{
		let url = "http://yumatechnical.com/en/module/my_feeder/prodjson?id_category=12&orderby=position&orderway=asc"
		if let myUrl = URL(string: url)
		{
			URLSession.shared.dataTask(with: myUrl)
			{ (data, response, err) in
				if let data = data
				{
					let dataString = String(data: data, encoding: .utf8)
					print(dataString ?? R.string.err)
					do
					{
						let myShops = try JSONDecoder().decode(MyShops.self, from: data)
						let _ = myShops.shop
						//completionHandler(myShops)
					}
					catch let JSONerr
					{
						print("\(R.string.err) \(JSONerr)")
					}
				}
				}.resume()
		}
	}

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
//	public func decode(_ type: Float.Type, forKey key: Key) throws -> Float
//	{
//		let stringValue = try self.decode(String.self, forKey: key)
//		guard let floatValue = Float(stringValue) else
//		{
//			let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Could not parse JSON key \"\(key)\" (value=\(stringValue) to a Float")
//			throw DecodingError.dataCorrupted(context)
//		}
//		return floatValue
//	}

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

//	public func decode(_ type: String.Type, forKey key: Key) throws -> String
//	{
//		let intValue = try self.decode(Int.self, forKey: key)
//		{
//			let stringValue = "\(intValue)"
//		}/* else
//		{
//			let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Could not parse JSON key \"\(key)\" (value=\(stringValue) to a Int")
//			throw DecodingError.dataCorrupted(context)
//		}*/
//		return stringValue
//	}

}


public protocol JSONDecodable
{
//	typealias DecodableType // (Swift 2.2)
	associatedtype DecodableType// (Swift 2.3)
	
	static func decode(json: JSON) -> DecodableType?
	static func decode(json: JSON?) -> DecodableType?
	static func decode(json: [JSON]) -> [DecodableType?]
	static func decode(json: [JSON]?) -> [DecodableType?]
}
//extension Location: JSONDecodable {
//
//	static func decode(json: JSON) -> Location? {
//		let label = parseString(json, key: "label")
//		let data = LocationData.decode(json["data"] as? JSON)
//		return Location(label: label,
//						data: data)
//	}
//}
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
	
//	public func parseString(input: JSON, key: String) -> String? {
//		return input[key] >>>= { $0 as? String }
//	}
//	func parseNumber(input: JSON, key: String) -> NSNumber? {
//		return input[key] >>>= { $0 as? NSNumber }
//	}
//	public func parseBool(input: JSON, key: String) -> Bool? {
//		return parseNumber(input: input, key: key).map { $0.boolValue }
//	}
//	public func parseInt(input: JSON, key: String) -> Int? {
//		return parseNumber(input: input, key: key).map { $0.intValue }
//	}
//	public func parseFloat(input: JSON, key: String) -> Float? {
//		return parseNumber(input: input, key: key).map { $0.floatValue }
//	}
//	public func parseDouble(input: JSON, key: String) -> Double? {
//		return parseNumber(input: input, key: key).map { $0.doubleValue }
//	}
}
