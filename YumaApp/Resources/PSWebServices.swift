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
	// MARK: Variables
	weak var timeout: Timer?
//	var task: URLSessionDataTask =
//	{
//		let sessionConfig = URLSessionConfiguration.default
//		sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
//		sessionConfig.timeoutIntervalForResource = TimeInterval(20)
//		return (Foundation.URLSession(configuration: sessionConfig) as? URLSessionDataTask)!//, delegate: self, delegateQueue: OperationQueue.main)
//	}()
//	var sessionWithTimeout: URLSession =
//	{
//		let sessionConfig = URLSessionConfiguration.default
//		sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
//		sessionConfig.timeoutIntervalForResource = TimeInterval(20)
//		return URLSession(configuration: sessionConfig)
//	}()
	
	
	// MARK: API resources
	///return an Object containing a list of addresses belonging to a customer - The Customer, Brand and Customer addresses
	class func getAddresses(id_customer: Int, completionHandler: @escaping (Addresses?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)addresses"
		let myUrl = "\(url)?filter[id_customer]=[\(id_customer)]&\(R.string.APIfull)&\(R.string.APIjson)&\(R.string.API_key)"
		if let myUrl = URL(string: myUrl)
		{
//			weak var timeout: Timer?
//			timeout?.invalidate()
//			timeout = .scheduledTimer(timeInterval: 3, target: self, repeats: false)
//			{
//				[weak self]
//				let err = NSError.init(domain: "", code: 504, userInfo: ["timeout" : nil])
//				completionHandler(nil, err)
//				return
//			}
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)//URLSession.shared.dataTask(with: myUrl)
			{ 	(data, response, err) in
//				if err
//				else if response.status_code != 200
				if let data = data
				{
					let dataStr = String(data: data, encoding: .utf8)
					UserDefaults.standard.set(dataStr, forKey: "AddressesCustomer\(id_customer)")
					if dataStr == "[]"
					{
						return
					}
					do
					{
						let addresses = try JSONDecoder().decode(Addresses.self, from: data)
						completionHandler(addresses, nil)
					}
					catch let JSONerr
					{
						//print("\(R.string.err) \(JSONerr)")
						completionHandler(nil, JSONerr)
					}
				}
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
				return
			}.resume()
		}
	}

	//self.objectToXML(object: object, head: "<?xml version=\"1.0\" encoding=\"UTF-8\"?>", wrapperHead: "<prestashop xmlns:xlink=\"http://www.w3.org/1999/xlink\"><addresses>", wrapperTail: "</addresses></prestashop>")
	///post an address to the web service
	class func postAddress(XMLStr: String, completion: @escaping ((Error?) -> Void))
	{
		let url = "\(R.string.WSbase)addresses"//?\(R.string.API_key)"
		if let myUrl = URL(string: url)
		{
			var request = URLRequest(url: myUrl)
			request.httpMethod = "PUT"//"POST"
			var headers = request.allHTTPHeaderFields ?? [:]
			headers["Content-Type"] = "text/xml;charset=utf-8"
			//headers["Accept"] = "text/xml;charset=utf-8"
			let authStr = String(format: "%@:", R.string.APIkey)
			let authData = authStr.data(using: String.Encoding.utf8)!
			let encodeAuth = authData.base64EncodedString()
			headers["Authorization"] = "Basic \(encodeAuth)"
			//headers["Content-Type"] = "application/x-www-form-urlencoded"
			//text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
//			headers["Content-Type"] = "application/json"
			headers["Accept"] = "application/json"
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
			//let creds = URLCredential(user: R.string.APIkey, password: "", persistence: URLCredential.Persistence.forSession)
			//request.addValue(creds, forHTTPHeaderField: "Authorization")
//			request.addValue("Basic \(R.string.APIkey)", forHTTPHeaderField: "Authorization")
			print("post: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body")
			print("request headers:")
			for header in headers
			{
				print(header)
			}
			
			let config = URLSessionConfiguration.default
			let session = URLSession(configuration: config)
//			session.timeoutIntervalForRequest = TimeInterval(15)
//			session.timeoutIntervalForResource = TimeInterval(20)
//			let sessionWithTimeout = URLSession(configuration: session)
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

	///return an Object containing a list of The Carriers
	class func getCarriers(from: String, completionHandler: @escaping (CarrierList?, Error?) -> Void)
	{
		if let myUrl = URL(string: from)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
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
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
				return
			}.resume()
		}
	}
	
	///return an object of the Cart rules management
	class func getCartRules(completionHandler: @escaping ([CartRule]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)cart_rules&\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
			{
				(data, response, err) in
				
				if let data = data
				{
					let dataString = String(data: data, encoding: .utf8)
					UserDefaults.standard.set(dataString, forKey: "CartRules")
					do
					{
						let items = try JSONDecoder().decode(CartRules.self, from: data)
						completionHandler(items.cart_rules, nil)
					}
					catch let JSONerr
					{
						completionHandler(nil, JSONerr)
					}
				}
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
			}.resume()
		}
	}
	
	///return an Object containing a list of the Customer's carts
	class func getCarts(id_customer: Int, completionHandler: @escaping (Carts?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)carts?filter[id_customer]=[\(id_customer)]&\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
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
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
				return
			}.resume()
		}
	}
	
	///return an Object containing a list of The product categories
	class func getCategories2(completionHandler: @escaping ([aCategory]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)categories?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
			{
				(data, response, err) in
				
				if let data = try? JSONSerialization.data(withJSONObject: data!, options: [])//data
				{
					let dataStr = String(data: data, encoding: .utf8)
					UserDefaults.standard.set(dataStr, forKey: "Categories")
					do
					{
						let result = try JSONDecoder().decode([FailableDecodable<aCategory>].self, from: data).compactMap { $0.base }
						completionHandler(result, nil)
					}
					catch let JSONerr
					{
						//print("\(R.string.err) \(JSONerr)")
						completionHandler(nil, JSONerr)
					}
				}
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
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
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
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
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
				return
			}.resume()
		}
	}
	
	///return an Object containing a list of the The product combinations
	class func getCombinations(completionHandler: @escaping (Combinations?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)combinations?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
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
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
				return
			}.resume()
		}
	}
	
	///return an object of the Shop configuration
	class func getConfigurations(completionHandler: @escaping (Configurations?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)configurations?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
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
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
			}.resume()
		}
	}
	
	///return an object of the Shop contacts
	class func getContacts(completionHandler: @escaping ([Contact]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)contacts&\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
			{
				(data, response, err) in
				
				if let data = data
				{
					let dataString = String(data: data, encoding: .utf8)
					UserDefaults.standard.set(dataString, forKey: "Contacts")
					do
					{
						//let contacts = try JSONDecoder().decode(Contacts.self, from: data)
						let result = try JSONDecoder().decode([FailableDecodable<Contact>].self, from: data).compactMap { $0.base }
						completionHandler(result, nil)
					}
					catch let JSONerr
					{
						completionHandler(nil, JSONerr)
					}
				}
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
			}.resume()
		}
	}
	
	///return an object of the Content management system
	class func getContentManagementSystem(completionHandler: @escaping ([aCMS]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)content_management_system&\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
			{
				(data, response, err) in
				
				if let data = data
				{
					let dataString = String(data: data, encoding: .utf8)
					UserDefaults.standard.set(dataString, forKey: "ContentManagementSystem")
					do
					{
						let items = try JSONDecoder().decode(CMS.self, from: data)
						completionHandler(items.content_management_system, nil)
					}
					catch let JSONerr
					{
						completionHandler(nil, JSONerr)
					}
				}
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
			}.resume()
		}
	}
	
	///return an Object containing a list of The countries
	class func getCountries(completionHandler: @escaping ([Country]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)countries?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
			{
				(data, response, err) in
				
				if let data = data
				{
					let dataString = String(data: data, encoding: .utf8)
					//					print(dataString ?? R.string.err)
					UserDefaults.standard.set(dataString, forKey: "Countries")
					do
					{
						let countries = try JSONDecoder().decode(Countries.self, from: data)
						completionHandler(countries.countries, nil)
					}
					catch let JSONerr
					{
						//print("\(R.string.err) \(JSONerr)")
						completionHandler(nil, JSONerr)
					}
				}
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
			}.resume()
		}
	}
	
	///return an Object containing a list of The currencies
	class func getCurrencies(completionHandler: @escaping (Currencies?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)currencies?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
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
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
				return
			}.resume()
		}
	}
	
	///return an object of the Customer services messages
	class func getCustomerMessages(completionHandler: @escaping ([CustomerMessage]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)customer_messages&\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
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
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
			}.resume()
		}
	}
	
	///return an object of the Customer services threads
	class func getCustomerThreads(completionHandler: @escaping ([CustomerThread]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)customer_threads&\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
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
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
			}.resume()
		}
	}
	
	///return an Object containing the current customer - The e-shop's customers
	class func getCustomer(from: String, completionHandler: @escaping (Any) -> Void)
	{
		if let myUrl = URL(string: from)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
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
//				else if let error = err
//				{
//					if DataStore.sharedInstance.debug > 5
//					{
//						print(error.localizedDescription)
//					}
//					completionHandler(nil, error)
//				}
			}.resume()
		}
	}
	
	///return an object of the Customization values
	class func getCustomization(completionHandler: @escaping ([Customization]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)customizations&\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
			{
				(data, response, err) in
				
				if let data = data
				{
					let dataString = String(data: data, encoding: .utf8)
					UserDefaults.standard.set(dataString, forKey: "Customizations")
					do
					{
						let items = try JSONDecoder().decode(Customizations.self, from: data)
						completionHandler(items.customizations, nil)
					}
					catch let JSONerr
					{
						completionHandler(nil, JSONerr)
					}
				}
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
			}.resume()
		}
	}

	///return an object of the Product delivery
	class func getDeliveries(completionHandler: @escaping ([Delivery]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)deliveries&\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
			{
				(data, response, err) in
				
				if let data = data
				{
					let dataString = String(data: data, encoding: .utf8)
					UserDefaults.standard.set(dataString, forKey: "Deliveries")
					do
					{
						let items = try JSONDecoder().decode(Deliveries.self, from: data)
						completionHandler(items.deliveries, nil)
					}
					catch let JSONerr
					{
						completionHandler(nil, JSONerr)
					}
				}
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
			}.resume()
		}
	}
	
	///return an object of The Employees
	class func getEmployees(completionHandler: @escaping ([Employee]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)employees&\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
			{
				(data, response, err) in
				
				if let data = data
				{
					let dataString = String(data: data, encoding: .utf8)
					UserDefaults.standard.set(dataString, forKey: "Employees")
					do
					{
						let items = try JSONDecoder().decode(Employees.self, from: data)
						completionHandler(items.employees, nil)
					}
					catch let JSONerr
					{
						completionHandler(nil, JSONerr)
					}
				}
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
			}.resume()
		}
	}
	
	///return an object of The customer's groups
	class func getGroups(completionHandler: @escaping ([Group]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)groups&\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
			{
				(data, response, err) in
				
				if let data = data
				{
					let dataString = String(data: data, encoding: .utf8)
					UserDefaults.standard.set(dataString, forKey: "Groups")
					do
					{
						let items = try JSONDecoder().decode(Groups.self, from: data)
						completionHandler(items.groups, nil)
					}
					catch let JSONerr
					{
						completionHandler(nil, JSONerr)
					}
				}
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
			}.resume()
		}
	}
	
	///return an object of The guests
	class func getGuests(completionHandler: @escaping ([Guest]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)guests&\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
			{
				(data, response, err) in
				
				if let data = data
				{
					let dataString = String(data: data, encoding: .utf8)
					UserDefaults.standard.set(dataString, forKey: "Guests")
					do
					{
						let items = try JSONDecoder().decode(Guests.self, from: data)
						completionHandler(items.guests, nil)
					}
					catch let JSONerr
					{
						completionHandler(nil, JSONerr)
					}
				}
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
			}.resume()
		}
	}
	
	///return an object of The image types
	class func getImageTypes(completionHandler: @escaping ([ImageType]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)image_types&\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
			{
				(data, response, err) in
				
				if let data = data
				{
					let dataString = String(data: data, encoding: .utf8)
					UserDefaults.standard.set(dataString, forKey: "ImageTypes")
					do
					{
						let items = try JSONDecoder().decode(ImageTypes.self, from: data)
						completionHandler(items.image_types, nil)
					}
					catch let JSONerr
					{
						completionHandler(nil, JSONerr)
					}
				}
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
			}.resume()
		}
	}
	
	//	///return an object of The images
	//	class func getImageTypes(completionHandler: @escaping ([Image_Type]?, Error?) -> Void)
	//	{
	//		let url = "\(R.string.WSbase)images&\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
	//		if let myUrl = URL(string: url)
	//		{
	//			URLSession.shared.dataTask(with: myUrl)
	//			{
	//				(data, response, err) in
	//
	//				if let data = data
	//				{
	//					let dataString = String(data: data, encoding: .utf8)
	//					UserDefaults.standard.set(dataString, forKey: "Images")
	//					do
	//					{
	//						let items = try JSONDecoder().decode(Image_Types.self, from: data)
	//						completionHandler(items, nil)	//	????
	//					}
	//					catch let JSONerr
	//					{
	//						completionHandler(nil, JSONerr)
	//					}
	//				}
	//			}.resume()
	//		}
	//	}
	
	///return an Object containing a list of the languages
	class func getLangauages(completionHandler: @escaping (Languages?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)languages?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
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
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
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
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
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
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
				return
			}.resume()
		}
	}
	
	///return an Object containing a list of the manufacturers
	class func getMessages(completionHandler: @escaping ([Message]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)messages?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
			{
				(data, response, err) in
				//				if err
				//				else if response.status_code != 200
				if let myData = data
				{
					//					if saveName != nil && saveName != ""
					//					{
					let dataStr = String(data: myData, encoding: .utf8)
					UserDefaults.standard.set(dataStr, forKey: "Messages")
					//					}
					do
					{
						let myData = try JSONDecoder().decode(Messages.self, from: myData)
						//						print(myData)
						completionHandler(myData.messages, nil)
					}
					catch let JSONerr
					{
						print("\(R.string.err) \(JSONerr)")
						completionHandler(nil, JSONerr)
					}
				}
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
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
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
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
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
				return
			}.resume()
		}
	}
	
//	///return an Object containing a list of the order credit slips
//	class func getOrderCreditSlips(id_customer: Int, completionHandler: @escaping (OrderSlips?, Error?) -> Void)
//	{
//		let url = "\(R.string.WSbase)order_slip?filter[id_customer]=[\(id_customer)]&\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
//		if let myUrl = URL(string: url)
//		{
//			URLSession.shared.dataTask(with: myUrl)
//			{
//				(data, response, err) in
//				//				if err
//				//				else if response.status_code != 200
//				if let myData = data
//				{
//					//					if saveName != nil && saveName != ""
//					//					{
//					let dataStr = String(data: myData, encoding: .utf8)
//					UserDefaults.standard.set(dataStr, forKey: "Customer\(id_customer)CreditSlips")
//					//					}
//					do
//					{
//						let myData = try JSONDecoder().decode(OrderSlips.self, from: myData)
//						//						print(myData)
//						completionHandler(myData, nil)
//					}
//					catch let JSONerr
//					{
//						print("\(R.string.err) \(JSONerr)")
//						completionHandler(nil, JSONerr)
//					}
//				}
//				return
//			}.resume()
//		}
//	}
	
	///return an Object containing a list of the order details
	class func getOrderDetails(id_order: Int, completionHandler: @escaping (OrderDetails?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)order_details?filter[id_order]=[\(id_order)]&\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
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
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
				return
			}.resume()
		}
	}

	///return an Object containing a list of the order histories
	class func getOrderHistories(completionHandler: @escaping ([OrderHistory]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)order_histories?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
			{
				(data, response, err) in
				//				if err
				//				else if response.status_code != 200
				if let myData = data
				{
					//					if saveName != nil && saveName != ""
					//					{
					let dataStr = String(data: myData, encoding: .utf8)
					UserDefaults.standard.set(dataStr, forKey: "OrderHistories")
					//					}
					do
					{
						let myData = try JSONDecoder().decode(OrderHistories.self, from: myData)
						//						print(myData)
						completionHandler(myData.order_histories, nil)
					}
					catch let JSONerr
					{
						print("\(R.string.err) \(JSONerr)")
						completionHandler(nil, JSONerr)
					}
				}
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
				return
			}.resume()
		}
	}
	
	///return an Object containing a list of the order invoices
	class func getOrderInvoices(completionHandler: @escaping ([OrderInvoice]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)order_invoices?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
			{
				(data, response, err) in
				//				if err
				//				else if response.status_code != 200
				if let myData = data
				{
					//					if saveName != nil && saveName != ""
					//					{
					let dataStr = String(data: myData, encoding: .utf8)
					UserDefaults.standard.set(dataStr, forKey: "OrderInvoices")
					//					}
					do
					{
						let myData = try JSONDecoder().decode(OrderInvoices.self, from: myData)
						//						print(myData)
						completionHandler(myData.invoices, nil)
					}
					catch let JSONerr
					{
						print("\(R.string.err) \(JSONerr)")
						completionHandler(nil, JSONerr)
					}
				}
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
				return
			}.resume()
		}
	}
	
	///return an Object containing a list of the order payments
	class func getOrderPayments(completionHandler: @escaping ([OrderPayment]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)order_payments?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
			{
				(data, response, err) in
				//				if err
				//				else if response.status_code != 200
				if let myData = data
				{
					//					if saveName != nil && saveName != ""
					//					{
					let dataStr = String(data: myData, encoding: .utf8)
					UserDefaults.standard.set(dataStr, forKey: "OrderPayments")
					//					}
					do
					{
						let myData = try JSONDecoder().decode(OrderPayments.self, from: myData)
						//						print(myData)
						completionHandler(myData.orderPayments, nil)
					}
					catch let JSONerr
					{
						print("\(R.string.err) \(JSONerr)")
						completionHandler(nil, JSONerr)
					}
				}
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
				return
			}.resume()
		}
	}
	
	///return an Object containing a list of the order slips for a customer
	class func getOrderSlips(id_customer: Int, completionHandler: @escaping ([OrderSlip]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)order_slip?filter[id_customer]=[\(id_customer)]&\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
			{
				(data, response, err) in
				//				if err
				//				else if response.status_code != 200
				if let myData = data
				{
					//					if saveName != nil && saveName != ""
					//					{
					let dataStr = String(data: myData, encoding: .utf8)
					UserDefaults.standard.set(dataStr, forKey: "OrderSlipsCustomer\(id_customer)")
					//					}
					if dataStr == "[]"
					{
						return
						//completionHandler(nil, nil)
					}
					do
					{
						let myData = try JSONDecoder().decode(OrderSlips.self, from: myData)
						//						print(myData)
						completionHandler(myData.orderSlips, nil)
					}
					catch let JSONerr
					{
						print("\(R.string.err) \(JSONerr)")
						completionHandler(nil, JSONerr)
					}
				}
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
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
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
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
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
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
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
			{
				(data, response, err) in
				//				if err
				//				else if response.status_code != 200
				if let data = data
				{
//					if saveName != nil && saveName != ""
//					{
					let dataStr = String(data: data, encoding: .utf8)
						UserDefaults.standard.set(dataStr, forKey: "OrdersCustomer\(id_customer)")
//					}
					do
					{
						let myData = try JSONDecoder().decode(Orders.self, from: data)
//						print(myData)
						completionHandler(myData, nil)
					}
					catch let JSONerr
					{
						if DataStore.sharedInstance.debug > 5
						{
							print("\(R.string.err) \(JSONerr)")
						}
						completionHandler(nil, JSONerr)
					}
				}
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
				return
			}.resume()
		}
	}

	///return an Object containing a list of the price_ranges
	class func getPriceRanges(completionHandler: @escaping ([PriceRange]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)price_ranges?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
			{
				(data, response, err) in
				//				if err
				//				else if response.status_code != 200
				if let data = data
				{
					//					if saveName != nil && saveName != ""
					//					{
					let dataStr = String(data: data, encoding: .utf8)
					UserDefaults.standard.set(dataStr, forKey: "PriceRanges")
					//					}
					do
					{
						let myData = try JSONDecoder().decode(PriceRanges.self, from: data)
						//						print(myData)
						completionHandler(myData.price_ranges, nil)
					}
					catch let JSONerr
					{
						print("\(R.string.err) \(JSONerr)")
						completionHandler(nil, JSONerr)
					}
				}
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
				return
			}.resume()
		}
	}
	
	///return an Object containing a list of the price_ranges
	class func getProductCustomizationFields(completionHandler: @escaping ([ProductCustomizationField]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)product_customization_fields?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
			{
				(data, response, err) in
				//				if err
				//				else if response.status_code != 200
				if let data = data
				{
					//					if saveName != nil && saveName != ""
					//					{
					let dataStr = String(data: data, encoding: .utf8)
					UserDefaults.standard.set(dataStr, forKey: "ProductCustomizationFields")
					//					}
					do
					{
						let myData = try JSONDecoder().decode(ProductCustomizationFields.self, from: data)
						//						print(myData)
						completionHandler(myData.product_customization_fields, nil)
					}
					catch let JSONerr
					{
						print("\(R.string.err) \(JSONerr)")
						completionHandler(nil, JSONerr)
					}
				}
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
				return
			}.resume()
		}
	}
	
	///return an Object containing a list of the price_ranges
	class func getProductFeatureValues(completionHandler: @escaping ([ProductFeatureValue]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)product_feature_values?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
			{
				(data, response, err) in
				//				if err
				//				else if response.status_code != 200
				if let data = data
				{
					//					if saveName != nil && saveName != ""
					//					{
					let dataStr = String(data: data, encoding: .utf8)
					UserDefaults.standard.set(dataStr, forKey: "ProductFeatureValues")
					//					}
					do
					{
						let myData = try JSONDecoder().decode(ProductFeatureValues.self, from: data)
						//						print(myData)
						completionHandler(myData.product_feature_values, nil)
					}
					catch let JSONerr
					{
						print("\(R.string.err) \(JSONerr)")
						completionHandler(nil, JSONerr)
					}
				}
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
				return
			}.resume()
		}
	}

	///return an Object containing a list of the price_ranges
	class func getProductFeatures(completionHandler: @escaping ([ProductFeature]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)product_features?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
			{
				(data, response, err) in
				//				if err
				//				else if response.status_code != 200
				if let data = data
				{
					//					if saveName != nil && saveName != ""
					//					{
					let dataStr = String(data: data, encoding: .utf8)
					UserDefaults.standard.set(dataStr, forKey: "ProductFeatures")
					//					}
					do
					{
						let myData = try JSONDecoder().decode(ProductFeatures.self, from: data)
						//						print(myData)
						completionHandler(myData.product_features, nil)
					}
					catch let JSONerr
					{
						print("\(R.string.err) \(JSONerr)")
						completionHandler(nil, JSONerr)
					}
				}
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
				return
			}.resume()
		}
	}

	///return an object of the product option values
	class func getProductOptionValues(completionHandler: @escaping (ProductOptionValues?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)product_option_values?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
			{
				(data, response, err) in
				
				if let data = data
				{
					let dataString = String(data: data, encoding: .utf8)
					//					print(dataString ?? R.string.err)
					UserDefaults.standard.set(dataString, forKey: "ProductOptionValues")
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
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
			}.resume()
		}
	}
	
	///return an Object containing a list of the product options
	class func getProductOptions(completionHandler: @escaping (ProductOptions?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)product_options?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
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
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
				return
			}.resume()
		}
	}

	///return an Object containing a list of the product Suppliers
	class func getProductSuppliers(completionHandler: @escaping ([ProductSupplier]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)product_options?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
			{
				(data, response, err) in
				if let myData = data
				{
					let dataStr = String(data: myData, encoding: .utf8)
					UserDefaults.standard.set(dataStr, forKey: "ProductSuppliers")
					do
					{
						let myData = try JSONDecoder().decode(ProductSuppliers.self, from: myData)
						completionHandler(myData.product_suppliers, nil)
					}
					catch let JSONerr
					{
						print("\(R.string.err) \(JSONerr)")
						completionHandler(nil, JSONerr)
					}
				}
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
				return
			}.resume()
		}
	}

	///return an object of the laptops (products in category 14)
	class func getLaptops(completionHandler: @escaping ([aProduct]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)products?filter[id_category_default]=[14]&\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
			{
				(data, response, err) in
				
				if let data = data
				{
					let dataStr = String(data: data, encoding: .utf8)
					UserDefaults.standard.set(dataStr, forKey: "Laptops")
					do
					{
						let products = try JSONDecoder().decode(FailableDecodable<JSONProducts>.self, from: data)
						completionHandler(products.base?.products!, nil)
					}
					catch let JSONerr
					{
						print("\(R.string.err) \(JSONerr)")
						completionHandler(nil, JSONerr)
					}
				}
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
			}.resume()
		}
	}
	
	///return an object of the services (products in category 15)
	class func getServices(completionHandler: @escaping ([aProduct]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)products?filter[id_category_default]=[15]&\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
			{
				(data, response, err) in
				
				if let data = data
				{
					let dataStr = String(data: data, encoding: .utf8)
					UserDefaults.standard.set(dataStr, forKey: "Services")
					do
					{
						let products = try JSONDecoder().decode(FailableDecodable<JSONProducts>.self, from: data)
						//completionHandler(products.products!, nil)
						completionHandler(products.base?.products!, nil)
					}
					catch let JSONerr
					{
						print(JSONerr)
						completionHandler(nil, JSONerr)
					}
				}
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
			}.resume()
		}
	}
	
	///return an object of the toners (products in category 13)
	class func getToners(completionHandler: @escaping ([aProduct]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)products?filter[id_category_default]=[13]&\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
			{
				(data, response, err) in
				
				if let data = data
				{
					let dataStr = String(data: data, encoding: .utf8)
					UserDefaults.standard.set(dataStr, forKey: "Toners")
					do
					{
						let products = try JSONDecoder().decode(FailableDecodable<JSONProducts>.self, from: data)
						//completionHandler(products.products!, nil)
						completionHandler(products.base?.products, nil)
					}
					catch let JSONerr
					{
						print(JSONerr)
						completionHandler(nil, JSONerr)
					}
				}
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
			}.resume()
		}
	}
	
	///return an object of the printers (products in category 12)
	class func getPrinters(completionHandler: @escaping ([aProduct]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)products?filter[id_category_default]=[12]&\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
			{
				(data, response, err) in
				
				if let data = data
				{
					if let dataStr = String(data: data, encoding: .utf8)
					{
						UserDefaults.standard.set(dataStr, forKey: "Printers")
//						let arrayStr = dataStr.substringBetween(":", "]")
//						let arrayData = arrayStr.data(using: .utf8)
//						do
//						{
//							let products = try JSONDecoder().decode([aProduct].self, from: arrayData!)
//							completionHandler(products, nil)
//						}
//						catch let JSONerr
//						{
//							print(JSONerr)
//							completionHandler(nil, JSONerr)
//						}
					}
					///////
					do
					{
						let products = try JSONDecoder().decode(FailableDecodable<JSONProducts>.self, from: data)
						completionHandler(products.base?.products, nil)
					}
					catch let JSONerr
					{
						print(JSONerr)
						completionHandler(nil, JSONerr)
					}
				}
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
			}.resume()
		}
	}

	///return an object of the search
	class func getSearch(completionHandler: @escaping ([aSearch]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)search?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
			{
				(data, response, err) in
				
				if let data = data
				{
					let dataStr = String(data: data, encoding: .utf8)
					UserDefaults.standard.set(dataStr, forKey: "Search")
					do
					{
						let items = try JSONDecoder().decode(Search.self, from: data)
						completionHandler(items.search, nil)
					}
					catch let JSONerr
					{
						completionHandler(nil, JSONerr)
					}
				}
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
			}.resume()
		}
	}
	
	///return an object of the Shop groups from multi-shop feature
	class func getShopGroups(completionHandler: @escaping ([ShopGroup]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)shop_groups?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
			{
				(data, response, err) in
				
				if let data = data
				{
					let dataStr = String(data: data, encoding: .utf8)
					UserDefaults.standard.set(dataStr, forKey: "ShopGroups")
					do
					{
						let items = try JSONDecoder().decode(ShopGroups.self, from: data)
						completionHandler(items.shop_groups, nil)
					}
					catch let JSONerr
					{
						completionHandler(nil, JSONerr)
					}
				}
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
			}.resume()
		}
	}

	///return an object of the Shop URLs from multi-shop feature
	class func getShopUrls(completionHandler: @escaping ([ShopUrl]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)shop_urls?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
			{
				(data, response, err) in
				
				if let data = data
				{
					let dataStr = String(data: data, encoding: .utf8)
					UserDefaults.standard.set(dataStr, forKey: "ShopUrls")
					do
					{
						let items = try JSONDecoder().decode(ShopUrls.self, from: data)
						completionHandler(items.shop_urls, nil)
					}
					catch let JSONerr
					{
						completionHandler(nil, JSONerr)
					}
				}
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
			}.resume()
		}
	}
	
	///return an object of the Shops from multi-shop feature
	class func getShops(completionHandler: @escaping ([Shop]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)shops?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
			{
				(data, response, err) in
				
				if let data = data
				{
					let dataStr = String(data: data, encoding: .utf8)
					UserDefaults.standard.set(dataStr, forKey: "Shops")
					do
					{
						let items = try JSONDecoder().decode(Shops.self, from: data)
						completionHandler(items.shops, nil)
					}
					catch let JSONerr
					{
						completionHandler(nil, JSONerr)
					}
				}
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
			}.resume()
		}
	}
	
	///return an object of the Specific price management
	class func getSpecificPriceRules(completionHandler: @escaping ([SpecificPriceRule]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)specific_price_rules?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
			{
				(data, response, err) in
				
				if let data = data
				{
					let dataStr = String(data: data, encoding: .utf8)
					UserDefaults.standard.set(dataStr, forKey: "SpecificPriceRules")
					do
					{
						let items = try JSONDecoder().decode(SpecificPriceRules.self, from: data)
						completionHandler(items.specific_price_rules, nil)
					}
					catch let JSONerr
					{
						completionHandler(nil, JSONerr)
					}
				}
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
			}.resume()
		}
	}
	
	///return an object of the Specific price management
	class func getSpecificPrices(completionHandler: @escaping ([SpecificPrice]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)specific_prices?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
			{
				(data, response, err) in
				
				if let data = data
				{
					let dataStr = String(data: data, encoding: .utf8)
					UserDefaults.standard.set(dataStr, forKey: "SpecificPrices")
					do
					{
						let items = try JSONDecoder().decode(SpecificPrices.self, from: data)
						completionHandler(items.specific_prices, nil)
					}
					catch let JSONerr
					{
						completionHandler(nil, JSONerr)
					}
				}
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
			}.resume()
		}
	}
	
	///return the states belonging to id_country;  id_country is 0 return all states
	class func getStates(id_country: Int, completionHandler: @escaping ([CountryState]?, Error?) -> Void)
	{
		var url = "\(R.string.WSbase)states?"
		if id_country > 0
		{
			url.append("filter[id_country]=[\(id_country)]&")
		}
		url.append("\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)")
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
			{
				(data, response, err) in
				
				if let data = data
				{
					let dataString = String(data: data, encoding: .utf8)
					//					print(dataString ?? R.string.err)
					UserDefaults.standard.set(dataString, forKey: "States")
					do
					{
						let states = try JSONDecoder().decode(CountryStates.self, from: data)
						completionHandler(states.states!, nil)
					}
					catch let JSONerr
					{
						//print("\(R.string.err) \(JSONerr)")
						completionHandler(nil, JSONerr)
					}
				}
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
			}.resume()
		}
	}
	
	//stock_availables
	//stock_movement_reasons
	//stock_movements
	//stocks
	//stores
	//suppliers
	//supply_order_details
	//supply_order_histories
	//supply_order_receipt_histories
	//supply_order_states
	//supply_orders
	
	///return an object of the tags
	class func getTags(completionHandler: @escaping (Tags?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)tags?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
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
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
			}.resume()
		}
	}
	
	//tax_rule_groups
	//tax_rules
	
	///return an object of the taxes
	class func getTaxes(completionHandler: @escaping (Taxes?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)taxes?\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		if let myUrl = URL(string: url)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
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
				else if let error = err
				{
					if DataStore.sharedInstance.debug > 5
					{
						print(error.localizedDescription)
					}
					completionHandler(nil, error)
				}
			}.resume()
		}
	}
	
	//translated_configurations
	//warehouse_product_locations
	//warehouses
	//weight_ranges
	//zones
	
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
	
	///try
	class func convertJSONToObject<T>(fromUrl: String, toObject: T, saveName: String?, completionHandler: @escaping (Any) -> Void)
	{
		if let myUrl = URL(string: fromUrl)
		{
			let sessionConfig = URLSessionConfiguration.default
			sessionConfig.timeoutIntervalForRequest = TimeInterval(15)
			sessionConfig.timeoutIntervalForResource = TimeInterval(20)
			let sessionWithTimeout = URLSession(configuration: sessionConfig)
			sessionWithTimeout.dataTask(with: myUrl)
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
//				else if let error = err
//				{
//					if DataStore.sharedInstance.debug > 5
//					{
//						print(error.localizedDescription)
//					}
//					completionHandler(nil, error)
//				}
				return
				}.resume()
		}
	}
	
	struct FailableDecodable<Base : Decodable> : Decodable
	{
		let base: Base?
		
		init(from decoder: Decoder) throws
		{
			do
			{
				let container = try decoder.singleValueContainer()
				self.base = try? container.decode(Base.self)
			}
			catch
			{
				assertionFailure("\(R.string.err) \(error)")
				self.base = nil
			}
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
	class func object2psxml(object: Any, resource: String, resource2: String, omit: [String], nilValue: String) -> String
	{
		var wrapperHead = "<prestashop xmlns:xlink=\"http://www.w3.org/1999/xlink\">\n"
		if !resource.isEmpty
		{
			wrapperHead += "<\(resource)>\n"
		}
		if !resource2.isEmpty
		{
			wrapperHead += "<\(resource2)>"
		}
		var wrapperTail = ""
		if !resource.isEmpty
		{
			wrapperTail += "<\(resource)>\n"
		}
		if !resource2.isEmpty
		{
			wrapperTail += "<\(resource2)>"
		}
		wrapperTail += "\n</prestashop>"
		return objectToXML(object: object, head: "<?xml version=\"1.0\" encoding=\"UTF-8\"?>", wrapperHead: wrapperHead, wrapperTail: wrapperTail, omit: omit, nilValue: nilValue)
	}
	
	fileprivate static func doXMLMiddle(_ prettyOutput: Bool, _ xml: inout String, _ object: Any, _ omit: [String], _ nilValue: String, printTabs: Bool = false) {
		if prettyOutput
		{
			xml += "\n"
		}
		let mirror = Mirror(reflecting: object)
		for (key, value) in mirror.children
		{
			if let key = key
			{
				var skipped = false
				for skip in omit
				{
					if key == skip
					{
						skipped = true
						break
						//continue
					}
				}
				if !skipped
				{
					if key != "some"
					{
						if prettyOutput && printTabs
						{
							xml += "\t"
						}
						xml += "<"
						xml += String(key)
					//						let val = value as? String
					//						if val != nil
					//						{
					//							var vcd = "<![CDATA["
					//							vcd += val!
					//							vcd += "]]>"
					//		//					if let intV = Int(val!), intV > 0
					//		//					{
					//		//						switch (key)
					//		//						{
					//		//						case "id_supplier":
					//		//							xml += " xlink:href=\"" + R.string.WSbase + "suppliers/\(val!)\""
					//		//							break
					//		//						case "id_country":
					//		//							xml += " xlink:href=\"" + R.string.WSbase + "countries/\(val!)\""
					//		//							break
					//		//						default:
					//		//							break
					//		//						}
					//		//					}
					//						}
						xml += ">"
					}
//					let valueType = type(of: value)
					if value is String
					{
						if value as? String != nil
						{
							xml += "<![CDATA["
							xml += value as! String
							xml += "]]>"
						}
						else
						{
							xml += "<![CDATA[\(nilValue)]]>"
						}
					}
					else if value is Int
					{
						if value as? Int != nil
						{
							xml += String(value as! Int)// "\(value)"
						}
						else
						{
							xml += "\(nilValue)"
						}
					}
//					else if value is Bool
//					{
//						//						xml += "<![CDATA["
//						let val: Bool = (value == true) ? "true" : "falue"
//						xml += val
//						//						xml += "]]>"
//					}
//					else if value is Bool
//					{
//						//
//					}
//					else if let val = value
//					{
//						xml += "null"
//					}
					else //if value is CustomerAssociations
					{
						if value as? Bool != nil
						{
							xml += nilValue
						}
						else
						{
							doXMLMiddle(prettyOutput, &xml, value, omit, nilValue)
						}
					}
//					else
//					{
//						xml += "null"
//					}
					if key != "some"
					{
						xml += "</"
						xml += String(key)
						xml += ">"
						if prettyOutput
						{
							xml += "\n"
						}
					}
				}
			}
		}
	}
	
	/// Convert an object in XML eg. objectToXML(object: myObj, head: "<?xml version=\"2.0\" encoding=\"ASCII\"?>", wrapperHead: "<my_wrapper>", wrapperTail: "</my_wrapper>")
	class func objectToXML(object: Any, head: String? = "<?xml+version=\"1.0\"+encoding=\"UTF-8\"?>", wrapperHead: String? = nil, wrapperTail: String? = nil, omit: [String], prettyOutput: Bool = true, nilValue: String) -> String
	{
//		let start = "<?xml+version=\"1.0\"+encoding=\"UTF-8\"?>"
		//var xml = "xml="
		var xml = ""
		if head != nil
		{
			xml += head!
		}
//		else
//		{
//			xml += start
//		}
		if prettyOutput
		{
			xml += "\n"
		}
		if wrapperHead != nil
		{
			xml += wrapperHead!
		}
		doXMLMiddle(prettyOutput, &xml, object, omit, nilValue)
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
