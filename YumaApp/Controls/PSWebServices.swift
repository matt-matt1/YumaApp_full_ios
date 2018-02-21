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

	class func getCustomer(from: String, completionHandler: @escaping (Customer) -> Void)
	{
		if let myUrl = URL(string: from)
		{
			URLSession.shared.dataTask(with: myUrl)
			{ (data, response, err) in
				//if err
				//else if response.status_code != 200
				if let data = data
				{
					if data.count < 3
					{
						return
					}
					else
					{
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

	
	class func getAddresses(id_customer: Int, completionHandler: @escaping (Addresses) -> Void)
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
						guard let products = try? JSONDecoder().decode(JSONProducts.self, from: data)
							else
							{
								print("Error: couldn't decode JSON")
								return
							}
						let printers = products.products
						print("number of printers: \(String(describing: printers?.count))")
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
