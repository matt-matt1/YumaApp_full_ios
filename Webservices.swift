//
//  Webservices.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-07.
//  https://stackoverflow.com/questions/24321165/make-rest-api-call-in-swift
//

import Foundation
import Alamofire


class WebServices: NSObject
{
	// MARK: - Login Variables
	var loginData: NSDictionary?
	var addrData: NSDictionary?
	var Data: NSDictionary?
	
	
	class func myLogin(userName: String, password: String, completion: @escaping (_ response : AnyObject?, _ message: String?, _ success: Bool)-> ())
	{
		let url = "\(R.string.URLbase)en/module/my_login/json?email=\(userName)&passwd=\(password)"
		let params = ["":""]
		WebServices.postWebService(urlString: url, params: params as [String : AnyObject]) { (response, message, status) in
			let result = WebServices()
			if let data = response as? NSDictionary
			{
//				print(data)
				result.loginData = data
				completion(result, "Success", true)
			}
			else
			{
				completion("" as AnyObject?, "Failed", false)
			}
		}
	}
	
	class func getAddresses(id_customer: Int, completion: @escaping (_ response : AnyObject?, _ message: String?, _ success: Bool)-> ())
	{
		var url = "\(R.string.WSbase)/addresses"
		if id_customer > -1
		{
			url.append("?\(id_customer)&")
		}
		else
		{
			url.append("?")
		}
		url.append("\(R.string.APIfull)&\(R.string.APIjson)&\(R.string.API_key)")
		let params = ["":""]
		WebServices.alamofireFunction(urlString: url, method: .get, paramters: params as [String : AnyObject])
		{
			(response, message, status) in
			print(response ?? "Output (WebServices.getAddresses)")
			let result = WebServices()
			if let data = response as? NSDictionary
			{
				print(data)
				result.addrData = data
				completion(result, "Success", true)
			}
			else
			{
				completion("" as AnyObject?, "Failed", false)
			}
		}
	}
	
	class func getPrinters(completion: @escaping (_ response : AnyObject?, _ message: String?, _ success: Bool)-> ())
	{
		let url = "\(R.string.WSbase)products?filter[id_category_default]=[12]&\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		let params = ["":""]
		WebServices.alamofireFunction(urlString: url, method: .get, paramters: params as [String : AnyObject])
		{
			(response, message, status) in

			print(response ?? "Output (getPrinters)")
			let result = WebServices()
			if let data = response as? NSDictionary
			{
				print(data)
				result.Data = data
				completion(result, "Success", true)
			}
			else
			{
				completion("" as AnyObject?, "Failed", false)
			}
		}
	}
	
	class func getLaptops(completion: @escaping (_ response : AnyObject?, _ message: String?, _ success: Bool)-> ())
	{
		let url = "\(R.string.WSbase)products?filter[id_category_default]=[14]&\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		//&\(R.string.APIjson)
		//&\(R.string.APIfull)
		let params = ["":""]
		WebServices.alamofireFunction(urlString: url, method: .get, paramters: params as [String : AnyObject])
		{
			(response, message, status) in

			let result = WebServices()
			if let data = response as? NSDictionary
			{
				print(data)
				result.Data = data
				completion(result, "Success", true)
			}
			else
			{
				completion("" as AnyObject?, "Failed", false)
			}
		}
	}
	
	class func getServices(completion: @escaping (_ response : AnyObject?, _ message: String?, _ success: Bool)-> ())
	{
		let url = "\(R.string.WSbase)products?filter[id_category_default]=[15]&\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		let params = ["":""]
		WebServices.alamofireFunction(urlString: url, method: .get, paramters: params as [String : AnyObject])
		{
			(response, message, status) in
			
			let result = WebServices()
			if let data = response as? NSDictionary
			{
				print(data)
				result.Data = data
				completion(result, "Success", true)
			}
			else
			{
				completion("" as AnyObject?, "Failed", false)
			}
		}
	}
	
	class func getToners(completion: @escaping (_ response : AnyObject?, _ message: String?, _ success: Bool)-> ())
	{
		let url = "\(R.string.WSbase)products?filter[id_category_default]=[14]&\(R.string.API_key)&\(R.string.APIjson)&\(R.string.APIfull)"
		let params = ["":""]
		WebServices.alamofireFunction(urlString: url, method: .get, paramters: params as [String : AnyObject])
		{
			(response, message, status) in
			
			let result = WebServices()
			if let data = response as? NSDictionary
			{
				print(data)
				result.Data = data
				completion(result, "Success", true)
			}
			else
			{
				completion("" as AnyObject?, "Failed", false)
			}
		}
	}
	

	//MARK :- Post
	class func postWebService(urlString: String, params: [String : AnyObject], completion: @escaping (_ response: AnyObject?, _ message: String?, _ success: Bool)-> Void)
	{
		alamofireFunction(urlString: urlString, method: .post, paramters: params) { (response, message, success) in
			if response != nil
			{
				completion(response as AnyObject?, "", true)
			} else
			{
				completion(nil, "", false)
			}
		}
	}
	
	
	class func alamofireFunction(urlString: String, method: Alamofire.HTTPMethod, paramters: [String : AnyObject], completion: @escaping (_ response: AnyObject?, _ message: String?, _ success: Bool) -> Void)
	{
		if method == Alamofire.HTTPMethod.post
		{
			Alamofire.request(urlString, method: .post, parameters: paramters, encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
				
				print(urlString)
				if response.result.isSuccess
				{
					completion(response.result.value as AnyObject?, "", true)
				}
				else
				{
					completion(nil, "", false)
				}
			}
		}
		else
		{
			Alamofire.request(urlString).responseJSON { (response) in
				
				if response.result.isSuccess
				{
					completion(response.result.value as AnyObject?, "", true)
				}
				else
				{
					completion(nil, "", false)
				}
			}
		}
	}
	
	
	//Mark:-Cancel
	class func cancelAllRequests()
	{
		Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
			dataTasks.forEach { 		$0.cancel()	 }
			uploadTasks.forEach { 		$0.cancel()	 }
			downloadTasks.forEach { 	$0.cancel()	 }
		}
	}
}
