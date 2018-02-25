//
//  DataStore.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-14.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation
import UIKit
//import SwiftyJSON

final class DataStore
{
	static let sharedInstance = DataStore()
	fileprivate init() {}

	var customer: [Customer] = []
	var addresses: [Addresses] = []
	var products: [aProduct] = []
	var printers2: [MyShops] = []
	var printers: [aProduct] = []
	var laptops: [aProduct] = []
	var toners: [aProduct] = []
	var myPrinters = [JSONProducts]()
	//var returnData: AnyObject
	
	
	func getCustomerDetails(from: String, completion: @escaping (Any) -> Void)
	{
		PSWebServices.getCustomer(from: from, completionHandler:
			{
				(customer) in
				
				if let _ = customer as? Bool
				{
					completion(false)
				}
				else
				{
					let cust = customer as! Customer
					self.customer.append(cust)
					completion(cust)
				}
			}
		)
	}
	
	func callGetCustomerDetails(from: String, completion: @escaping (Any) -> Void)
	{
		self.getCustomerDetails(from: from, completion:
			{
				(customer) in
				
				if let _ = customer as? Bool
				{
					completion(false)
				}
				else
				{
					OperationQueue.main.addOperation
						{
							completion(customer as! Customer)
						}
				}
			}
		)
	}
	
	func getAddresses(id_customer: Int, completion: @escaping (Addresses) -> Void)
	{
		PSWebServices.getAddresses(id_customer: id_customer, completionHandler:
			{
				(addresses) in
				
				self.addresses.append(addresses)
				//UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: addresses), forKey: "CustomerAddr")
				//UserDefaults.standard.set(addresses, forKey: "CustomerAddr")
				//UserDefaults.standard.synchronize()
				completion(addresses)
			}
		)
	}
	
	func callGetAddresses(id_customer: Int, completion: @escaping (Addresses) -> Void)
	{
		self.getAddresses(id_customer: id_customer, completion:
			{
				(addresses) in
				
				OperationQueue.main.addOperation
					{
							completion(addresses)
					}
			}
		)
	}
	
	func parse(JSON json: String) throws -> [String]?
	{
		guard let data = json.data(using: .utf8) else { 	return nil 	}
		
		guard let rootArray = try JSONSerialization.jsonObject(with: data, options : []) as? [[String: Any]]
			else { return nil }
		
		return rootArray
			.filter{ $0["success"] as? Int == 1}
			.map{ $0["nama_produk"] as! String }
	}

	func getPrinters3(completion: @escaping ([JSONProducts]) -> Void)
	{
		let url = "\(R.string.WSbase)products?filter[id_category_default]=[12]&\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		guard let myUrl = URL(string: url) else { 	return 	}
		URLSession.shared.dataTask(with: myUrl)
		{
			(data, response, err) in

			guard let data = data else {	return	}
			do
			{
				let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
//				json.
				print(json)
			}
			catch let jsonErr
			{
				print(jsonErr)
			}
		}
		//let data = try! Data(contentsOf: Bundle.main.url(forResource: "response", withExtension: "json")!)
	}
	func getPrinters3no(completion: @escaping ([JSONProducts]) -> Void)
	{
		let url = "\(R.string.WSbase)products?filter[id_category_default]=[12]&\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
//		let data = try! Data(contentsOf: Bundle.main.url(forResource: "response", withExtension: "json")!)
//		let JSON = try! JSONSerialization.jsonObject(with: data, options: [])
		get(fromUrl: url, customHeaders: nil, sendCookies: nil)
		{
			(printers) in
			
//			guard let printers = printers else
//			{
//				return
//			}
//			if let printers = printers as? [[String: Any]]
//			{
				do
				{
//					let json = try JSONSerialization.jsonObject(with: printers, options: .mutableContainers)
//					let json = try? JSON(data: printers as! Data)
//					for (index, subJson):(String, JSON) in json!
//					{
//						var myId: String?
//						if let idtry = subJson[0]["id"] as? Int
//						{
//							myId = "\(idtry)"
//						}
//						else if let idtry = subJson[0]["id"] as? String
//						{
//							myId = idtry
//						}
//					}
//					self.myPrinters = json as! [JSONProducts]
//					var myId: String?
//					if let idtry = printers[0]["id"] as? Int
//					{
//						myId = "\(idtry)"
//					}
//					else if let idtry = printers[0]["id"] as? String
//					{
//						myId = idtry
//					}
//					var dict = [String: Any]()
//					let json = JSON(parseJSON: printers)
//					var parent: String?
					//if let parentID = printers
//					let dict = try? JSONSerialization.jsonObject(with: printers, options: .allowFragments) as? [[String: Any]]
					self.myPrinters = try [JSONDecoder().decode(JSONProducts.self, from: printers as! Data)]
//					printers.NSValue(forKey: "parent") as? Int
//					{
//						parent = "\(parentID)"
//					}
					OperationQueue.main.addOperation
						{
							completion(self.myPrinters)
					}
				}
				catch
				{
					print("\(R.string.err) \(error).")//  whole response:\(String(describing: response))")
				}
//			}
		}
//		if let myUrl = URL(string: url)
//		{
//			URLSession.shared.dataTask(with: myUrl)
//			{
//				(data, response, error) in
//
//				do
//				{
//					self.myPrinters = try [JSONDecoder().decode(JSONProducts.self, from: data!)]
//				}
//				catch
//				{
//					print("\(R.string.err) \(error).")//  whole response:\(String(describing: response))")
//				}
//			}.resume()
//		}
//		PSWebServices.getPrinters3(url: url, completionHandler:
//			{
//				(addresses) in
//
//				self.addresses.append(addresses)
//				completion(addresses)
//		}
//		)
	}
	
//	func callGetPrinters3(completion: @escaping (Addresses) -> Void)
//	{
//		self.getPrinters3(completion:
//			{
//				(addresses) in
//				
//				OperationQueue.main.addOperation
//					{
//						completion(addresses)
//				}
//		}
//		)
//	}
	
	func getPrinters2(completion: @escaping (Any/*MyShops*/) -> Void)
	{
		PSWebServices.getPrinters2(completionHandler:
			{
				(printers) in
				
				self.printers2.append(printers)
				completion(printers)
			}
		)
	}
	func callGetPrinters2(completion: @escaping (Any/*MyShops*/) -> Void)
	{
		self.getPrinters2(completion:
			{
				(printers) in
				
//				self.printers2.append(printers)
				OperationQueue.main.addOperation
					{
						completion(printers)
				}
			}
		)
	}

	func getPrinters(completion: @escaping (Any/*[aProduct]*/) -> Void)
	{
		PSWebServices.getPrinters(completionHandler:
			{
				(printers) in

				self.printers = printers
//				self.printers.append(printers)
				completion(printers)
			}
		)
	}
	func callGetPrinters(completion: @escaping (Any/*[aProduct]*/) -> Void)
	{
		self.getPrinters(completion:
			{
				(printers) in
				
//				self.printers = printers
//				self.printers.append(printers)
				OperationQueue.main.addOperation
					{
						completion(printers)
				}
			}
		)
	}



	func get(fromUrl: String, customHeaders: [String : String]?, sendCookies: [String : String]?, completion: @escaping (Any) -> Void)
	{
		if let myUrl = URL(string: fromUrl)
		{
			var request = URLRequest(url: myUrl)
			request.httpMethod = "GET"
//			let token = UserDefaults.standard.string(forKey: "authToken")!
//			if token != ""
//			{
//				request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//			}
			if customHeaders != nil
			{
				for header in customHeaders!
				{
					request.addValue(header.value, forHTTPHeaderField: header.key)
				}
			}
			if sendCookies != nil
			{
				var cookies = ""
				for cookie in sendCookies!
				{
					cookies.append("\(cookie.key)=\"\(cookie.value)\";")
				}
				request.addValue(cookies, forHTTPHeaderField: "Cookie")
			}
			let task = URLSession.shared.dataTask(with: request)
			{
				(data, response, error) in

				if error != nil
				{
					print("\(R.string.err) \(String(describing: error))")
					completion(false)
					//return
				}
				if let httpResponse = response as? HTTPURLResponse
				{
					switch(httpResponse.statusCode)
					{
					case 200:
						guard let data = data else
						{
							return
						}
						completion(data)
						break
					case 401:
						print("401 Refresh token...")
						break
					default:
						print("statusCode: \(httpResponse.statusCode)")
						completion(false)
					}
				}
			}
			task.resume()
		}
	}
	

	func alertMessage(sender: Any, alerttitle: String, _ message: String)
	{
		let alertViewController = UIAlertController(title: alerttitle, message: message, preferredStyle: .alert)
		alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		let vc = sender as! UIViewController
		vc.present(alertViewController, animated: true, completion: nil)
	}
	
	func formatAddress(_ address: Address) -> String
	{
		var formed = ""
		if address.company != nil && address.company != ""
		{
			formed.append("\(address.company!)\n")
		}
		if address.firstname != nil && address.firstname != ""
		{
			formed.append("\(address.firstname!) ")
		}
		if address.lastname != nil && address.lastname != ""
		{
			formed.append(address.lastname!)
		}
		if address.firstname != nil && address.firstname != "" || address.lastname != nil && address.lastname != ""
		{
			formed.append("\n")
		}
		if address.address1 != ""
		{
			formed.append("\(address.address1)\n")
		}
		if address.address2 != nil && address.address2 != ""
		{
			formed.append("\(address.address2!)\n")
		}
		if address.city != nil && address.city != ""
		{
			formed.append("\(address.city!)\n")
		}
		if address.postcode != nil && address.postcode != ""
		{
			formed.append(address.postcode!)
		}
		if address.id_state != nil && address.id_state != ""
		{
			formed.append(address.id_state!)
		}
		if address.postcode != nil && address.postcode != "" || address.id_state != nil && address.id_state != ""
		{
			formed.append("\n")
		}
		if address.id_country != nil && address.id_country != ""
		{
			formed.append("\(address.id_country!)\n")
		}
		return formed
	}
	
	func trimJSONValueToArray(string: String) -> String
	{
		let pos1 = string.indexOf("[")
		let pos2 = string.lastIndexOf("]")!+1
		//print("pos1: \(pos1), pos2: \(pos2)\nin \(string)")
		let start = string.index(string.startIndex, offsetBy: pos1)
		let end = string.index(string.startIndex, offsetBy: pos2)
		let sub = string[start..<end]
		print(sub)
		return String(sub)
	}

}

extension URLResponse
{
	func getStatusCode() -> Int?
	{
		if let httpResponse = self as? HTTPURLResponse
		{
			return httpResponse.statusCode
		}
		return nil
	}
}

public extension KeyedDecodingContainer
{
	public func decode(_ type: Float.Type, forKey key: Key) throws -> Float
	{
		let stringValue = try self.decode(String.self, forKey: key)
		guard let floatValue = Float(stringValue) else
		{
			let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Could not parse JSON key \"\(key)\" (value=\(stringValue) to a Float")
			throw DecodingError.dataCorrupted(context)
		}
		return floatValue
	}

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
//		if let intValue = try self.decode(Int.self, forKey: key) as? Int
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
