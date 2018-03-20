//
//  Endpoint.swift
//  ProtocolBasedNetworkingTutorialStarter
//
//  Created by Yuma Usa on 2018-03-18.
//  Copyright © 2018 James Rochabrun. All rights reserved.
//

import Foundation

protocol Endpoint
{
	var base: String { 			get 	}
	var path: String { 			get		}
//	var resource: String { 		get		}
//	var filter: String { 		get 	}
//	var extraParams: String { 	get 	}
}

extension Endpoint
{
	var apiKey: String
	{
		return R.string.API_key
	}
	
	var urlComponents: URLComponents
	{
		var components = URLComponents(string: base)!
		components.path = "\(path)&\(apiKey)"
		components.query = ""//\(apiKey)&\(extraParams)"
//		components.path = "\(resource)"
//		components.query = "\(apiKey)&\(filter)&\(extraParams)"
		return components
	}
	
	var request: URLRequest
	{
		let url = urlComponents.url!
		return URLRequest(url: url)
	}
}

