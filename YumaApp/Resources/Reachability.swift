//
//  Reachability.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-21.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import SystemConfiguration
import Foundation

public class Reachability
{
	///	Usage:
	///
	///	if Reachability.isConnectedToNetwork(){
	///		print("Internet Connection Available!")
	///	}else{
	///		print("Internet Connection not Available!")
	///	}
	class func isConnectedToNetwork() -> Bool
	{
		var zeroAddress = 				sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
		zeroAddress.sin_len = 			UInt8(MemoryLayout.size(ofValue: zeroAddress))
		zeroAddress.sin_family = 		sa_family_t(AF_INET)
		
		let defaultRouteReachability = 	withUnsafePointer(to: &zeroAddress)
		{
			$0.withMemoryRebound(to: sockaddr.self, capacity: 1)
			{
				zeroSockAddress 		in
				SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
			}
		}
		
		var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
		if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false
		{
			return 						false
		}
		
		/* Only Working for WIFI
		let isReachable = flags == .reachable
		let needsConnection = flags == .connectionRequired
		
		return isReachable && !needsConnection
		*/
		
		// Working for Cellular and WIFI
		let isReachable = 				(flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
		let needsConnection = 			(flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
		let ret = 						(isReachable && !needsConnection)
		
		return 							ret
	}

	
	class func isInternetAvailable(website: String?, completionHandler: @escaping(Bool) -> Void)
	{
		// 1. Check the WiFi Connection
		guard isConnectedToNetwork() else
		{
			completionHandler(false)
			return
		}
		
		// 2. Check the Internet Connection
		var webAddress = "https://www.google.com" // Default Web Site
		if let _ = website
		{
			webAddress = website!
		}
		//guard let url = URL(string: webAddress) else
		guard URL(string: webAddress) != nil else
		{
			completionHandler(false)
			print("could not create url from: \(webAddress)")
			return
		}

//		let urlRequest = URLRequest(url: url)
//		let session = URLSession.shared
//		let task = session.dataTask(with: urlRequest, completionHandler:
//		{
//			(data, response, error) in
//
//			if error != nil || response == nil
//			{
//				completionHandler(false)
//			}
//			else
//			{
				completionHandler(true)
//			}
//		})
//		task.resume()
	}

}
