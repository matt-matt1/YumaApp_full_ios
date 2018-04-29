//
//  Http.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-28.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


class Http
{
	/// Returns a web service(API) object
	func get(url: NSURL, headers: Dictionary<String, String>, data: NSData?, completionHandler: ((HttpResult) -> Void)!)
	{
		action("GET", url: url, headers: headers, data: data) 	{ 	(result) in
			completionHandler(result)
		}
	}

	/// Used to edit(UPDATE) an existing object by sending the entire object
	func put(url: NSURL, headers: Dictionary<String, String>, data: NSData?, completionHandler: ((HttpResult) -> Void)!)
	{
		action("PUT", url: url, headers: headers, data: data) 	{ 	(result) in
			completionHandler(result)
		}
	}
	
	/// Delete an object using the object id
	func delete(url: NSURL, headers: Dictionary<String, String>, completionHandler: ((HttpResult) -> Void)!)
	{
//		do
//		{
			action("DELETE", url: url, headers: headers, data: nil) 	{ 	(result) in
				completionHandler(result)
			}
//		}
//		catch let err
//		{
//			print(err)
//		}
	}
	
	/// Used to create a web servicve(API) object. Request a blank object first
	func post(url: NSURL, headers: Dictionary<String, String>, data: Dictionary<String, String>, completionHandler: ((HttpResult) -> Void)!)
	{
		var sendHeaders = headers
		let keys = headers.keys
		var found = false
		for key in keys
		{
			if key == "Content-Type"
			{
				found = true
				break
			}
		}
		if !found
		{
			sendHeaders.updateValue("application/x-www-form-urlencoded", forKey: "Content-Type")
		}
		//let data = try? JSONSerialization.data(withJSONObject: data)
		var str = ""
		for (k, v) in data
		{
			str.append("\(k)=\(v)&")
		}
		let postStr = str.dropLast()
		//let postStr = String(format: "%@&%@", data.keys, data.values)
		let data = postStr.data(using: .utf8)
		action("POST", url: url, headers: sendHeaders, data: data! as NSData) 	{ 	(result) in
			completionHandler(result)
		}
	}

	func action(_ verb: String, url: NSURL, headers: Dictionary<String, String>, data: NSData?, completionHandler: ((HttpResult) -> Void)!)
	{
		let httpRequest = NSMutableURLRequest(url: url as URL)
		httpRequest.httpMethod = verb
		
		for (headerKey, headerValue) in headers
		{
			httpRequest.setValue(headerValue, forHTTPHeaderField: headerKey)
		}
		if data != nil
		{
			let task = URLSession.shared.uploadTask(with: httpRequest as URLRequest, from: data! as Data) 	{ 	(data, response, error) in
				if data != nil && error == nil
				{
					completionHandler(HttpResult(data: data as NSData?, request: httpRequest, response: response, error: error as NSError?))
				}
				else
				{
					print("\(error.debugDescription)")// (\(error?.localizedDescription ?? ""))")
					if data != nil
					{
						print(String(data: data!, encoding: .utf8))
					}
				}
			}
			task.resume()
		}
		else
		{
			let task = URLSession.shared.dataTask(with: httpRequest as URLRequest) 	{ 	(data, response, error) in
				completionHandler(HttpResult(data: data as NSData?, request: httpRequest, response: response, error: error as NSError?))
			}
			task.resume()
		}
	}
}


class HttpResult
{
	var request: 	NSURLRequest?
	var response: 	HTTPURLResponse?
	var data: 		NSData?
	var error: 		NSError?
	var statusCode: Int = 0
	var success: 	Bool = false
	var headers: 	Dictionary<String, String>
	{
		get
		{
			if let responseValue = response
			{
				return responseValue.allHeaderFields as! Dictionary<String,String>
			}
			else
			{
				return Dictionary<String, String>()
			}
		}
	}
	
	init(data: NSData?, request: NSURLRequest, response: URLResponse?, error : NSError?)
	{
		self.data = data
		self.request = request
		self.response = response as! HTTPURLResponse?
		self.error = error
		self.success = false
		
		if error != nil
		{
			print("Http.\(request.httpMethod!): \(String(describing: request.url))")
			print("Error: \(error!.localizedDescription)")
		}
		else
		{
			if let responseValue = self.response
			{
				statusCode = responseValue.statusCode
				if statusCode >= 200 && statusCode < 300
				{
					success = true
				}
				else
				{
					print("Http.\(request.httpMethod!) \(String(describing: request.url))")
					print("Status: \(statusCode)")
					if let jsonError: AnyObject = jsonObject
					{
						do
						{
							let errData = try JSONSerialization.data(withJSONObject: jsonError, options:JSONSerialization.WritingOptions.prettyPrinted)
							let errMessage = NSString(data: errData, encoding: String.Encoding.utf8.rawValue)
							print("Error: \(String(describing: errMessage))")
						}
						catch let err
						{
							print(err)
						}
					}
				}
			}
		}
	}
	
	var jsonObject: AnyObject?
	{
		var resultJsonObject: AnyObject?
		if let contentType = headers["Content-Type"]
		{
			if contentType.contains("application/json")
			{
				do
				{
					resultJsonObject = try JSONSerialization.jsonObject(with: data! as Data, options: .allowFragments) as AnyObject?
				}
				catch let jsonError
				{
					print(jsonError)
				}
			}
		}
		return resultJsonObject
	}
}
