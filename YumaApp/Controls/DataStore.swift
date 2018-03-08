//
//  DataStore.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-14.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation
import UIKit

final class DataStore
{
	static let sharedInstance = DataStore()
	fileprivate init() {}

	var customer: Customer?
	var addresses: [Address] = []
	var products: [aProduct] = []
	var printers: [aProduct] = []
	var laptops: [aProduct] = []
	var toners: [aProduct] = []
	var services: [aProduct] = []
	var carriers: [Carrier] = []
	var states: [CountryState] = []
	var countries: [Country] = []
	var orderStates: [OrderState] = []
	var orders: [Orders] = []
	var myOrderRows: [OrderRow] = []
	var myCartRows: [CartRow] = []
	var myOrder: [Orders] = []
	var myCart: [Carts] = []
	
	
	func callGetCustomerDetails(from: String, completion: @escaping (Any) -> Void)
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
					self.customer = customer as? Customer
					completion(customer)
				}
			}
		)
	}
	
	func callGetCarriers(completion: @escaping (Any) -> Void)
	{
		let url = "\(R.string.WSbase)/carriers"
		let myUrl = "\(url)?\(R.string.APIfull)&\(R.string.APIjson)&\(R.string.API_key)"
		PSWebServices.getCarriers(from: myUrl, /*to: CarrierList.self,*/ completionHandler:
			{
				(object) in//)(dataStr, object) in
				
				let dataStr = UserDefaults.standard.string(forKey: "Carriers")
				let tempCarr: String = self.trimJSONValueToArray(string: dataStr!)
				let tempObj: [Carrier]
				do
				{
					tempObj = try JSONDecoder().decode([Carrier].self, from: tempCarr.data(using: .utf8)!)
					for carr in tempObj
					{
						self.carriers.append(carr)
					}
					completion(tempObj)
				}
				catch let jsonErr
				{
					print(jsonErr)
				}
			}
		)
	}

	
	func callGetAddresses(id_customer: Int, completion: @escaping (Addresses) -> Void)
	{
		PSWebServices.getAddresses(id_customer: id_customer, completionHandler:
			{
				(addresses) in
				
				for addresses in addresses.addresses!
				{
					self.addresses.append(addresses)
				}
				completion(addresses)
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

	func callGetCountries(completion: @escaping (Any) -> Void)
	{
		PSWebServices.getCountries(completionHandler:
			{
				(countries) in
				
				self.countries = countries
				completion(countries)
			}
		)
	}

	func callGetStates(id_country: Int, completion: @escaping (Any) -> Void)
	{
		PSWebServices.getStates(id_country: id_country, completionHandler:
			{
				(states) in
				
				self.states = states
				completion(states)
			}
		)
	}

	func getOrders(id_customer: Int, completion: @escaping (Any?, Error?) -> Void)
	{
		PSWebServices.getOrders(id_customer: id_customer, completionHandler:
			{
				(result, err) in
				
				if err != nil
				{
					let dataStr = UserDefaults.standard.string(forKey: "OrderStates")
					let tempCarr: String = self.trimJSONValueToArray(string: dataStr!)
					let tempObj: [Orders]
					do
					{
						tempObj = try JSONDecoder().decode([Orders].self, from: tempCarr.data(using: .utf8)!)
						for os in tempObj
						{
							self.orders.append(os)
						}
						OperationQueue.main.addOperation
							{
								completion(tempObj, nil)
							}
					}
					catch let jsonErr
					{
						print(jsonErr)
						OperationQueue.main.addOperation
							{
								completion(nil, jsonErr)
							}
					}
				}
				else
				{
					OperationQueue.main.addOperation
						{
							completion(nil, err)
						}
				}
			}
		)
	}

	func getOrderStates(completion: @escaping (Any?, Error?) -> Void)
	{
		PSWebServices.getOrderStates(completionHandler:
			{
				(states, err) in
				
				if err != nil
				{
					let dataStr = UserDefaults.standard.string(forKey: "OrderStates")
					let tempCarr: String = self.trimJSONValueToArray(string: dataStr!)
					let tempObj: [OrderState]
					do
					{
						tempObj = try JSONDecoder().decode([OrderState].self, from: tempCarr.data(using: .utf8)!)
						for os in tempObj
						{
							self.orderStates.append(os)
						}
						OperationQueue.main.addOperation
							{
								completion(tempObj, nil)
							}
					}
					catch let jsonErr
					{
						print(jsonErr)
						OperationQueue.main.addOperation
							{
								completion(nil, jsonErr)
							}
					}
				}
				else
				{
					OperationQueue.main.addOperation
						{
							completion(nil, err)
						}
				}
			}
		)
	}

	func callGetPrinters(completion: @escaping (Any) -> Void)
	{
		PSWebServices.getPrinters(completionHandler:
			{
				(printers) in
				
				self.printers = printers
				self.products = printers
				completion(printers)
			}
		)
	}

	func callGetLaptops(completion: @escaping (Any) -> Void)
	{
		PSWebServices.getLaptops(completionHandler:
			{
				(laptops) in
				
				self.laptops = laptops
				self.products = laptops
				completion(laptops)
			}
		)
	}
	
	func callGetServices(completion: @escaping (Any) -> Void)
	{
		PSWebServices.getServices(completionHandler:
			{
				(services) in
				
				self.services = services
				self.products = services
				completion(services)
			}
		)
	}
	
	func callGetToners(completion: @escaping (Any) -> Void)
	{
		PSWebServices.getToners(completionHandler:
			{
				(toners) in
				
				self.toners = toners
				self.products = toners
				completion(toners)
			}
		)
	}


	///try
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
	
	
	//common methods
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
		if address.firstname != ""
		{
			formed.append("\(address.firstname) ")
		}
		if address.lastname != ""
		{
			formed.append(address.lastname)
		}
		if address.firstname != "" || address.lastname != ""
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
		if address.city != ""
		{
			formed.append("\(address.city)\n")
		}
		if address.postcode != nil && address.postcode != ""
		{
			formed.append("\(address.postcode!)")
		}
		if address.id_state != nil && address.id_state != ""
		{
			if address.postcode != nil && address.postcode != ""
			{
				formed.append("  ")
			}
			if self.countries.count > 0
			{
				var stateName = ""
				for c in self.states
				{
					if c.id == Int(address.id_state!)
					{
						stateName = c.name!
						break
					}
				}
				formed.append("\(stateName)")
			}
			else
			{
				formed.append(address.id_state!)
			}
		}
		if address.postcode != nil && address.postcode != "" || address.id_state != nil && address.id_state != ""
		{
			formed.append("\n")
		}
		if address.id_country != ""
		{
			if self.countries.count > 0
			{
				var country = ""
				for c in self.countries
				{
					if c.id == Int(address.id_country)
					{
						country = c.name![0].value!
						break
					}
				}
				formed.append("\(country)\n")
			}
			else
			{
				formed.append("\(address.id_country)\n")
			}
		}
		return formed
	}
	
	
	func getImageFromUrl(url: URL, session: URLSession, completion: @escaping (Data?, URLResponse?, Error?) -> ())
	{
		let task = session.dataTask(with: url)
		{
			(data, response, error) in
			
			if let e = error
			{
				print("Error Occurred: \(e)")
			}
			else
			{
				if (response as? HTTPURLResponse) != nil
				{
					if let _ = data
					{
						completion(data, response, error)
					}
					else
					{
						print("Image file is currupted")
					}
				}
				else
				{
					print("No response from server")
				}
			}
		}
		task.resume()
	}

	
	func trimJSONValueToArray(string: String) -> String
	{
		let pos1 = string.indexOf("[")
		let pos2 = string.lastIndexOf("]")!+1
		//print("pos1: \(pos1), pos2: \(pos2)\nin \(string)")
		let start = string.index(string.startIndex, offsetBy: pos1)
		let end = string.index(string.startIndex, offsetBy: pos2)
		let sub = string[start..<end]
		//print(sub)
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
