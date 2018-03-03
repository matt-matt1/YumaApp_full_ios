//
//  Endpoint.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-03.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


protocol Endpoint {
	var base: String { get }
	var path: String { get }
}
extension Endpoint {
	var apiKey: String {
		return "api_key=34a92f7d77a168fdcd9a46ee1863edf1"
	}
	
	var urlComponents: URLComponents {
		var components = URLComponents(string: base)!
		components.path = path
		components.query = apiKey
		return components
	}
	
	var request: URLRequest {
		let url = urlComponents.url!
		return URLRequest(url: url)
	}
}
