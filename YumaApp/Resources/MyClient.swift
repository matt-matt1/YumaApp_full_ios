//
//  MovieClient.swift
//  ProtocolBasedNetworkingTutorialStarter
//
//  Created by Yuma Usa on 2018-03-18.
//  Copyright © 2018 James Rochabrun. All rights reserved.
//

import Foundation


class MyClient: APIClient
{
	let session: URLSession
	
	
	init(configuration: URLSessionConfiguration)
	{
		self.session = URLSession(configuration: configuration)
	}
	
	convenience init()
	{
		self.init(configuration: .default)
//		print(collect.addresses(addresses_filter.idCustomer, "3"))
	}
	
	//in the signature of the function in the success case we define the Class type thats is the generic one in the API
	func getREST(from RESTType: Resource, completion: @escaping (Result<Address?, APIError>) -> Void)
	{
		print("\(RESTType.base)\(RESTType.path)")
//		fetch(with: RESTType.request, decode:
//			{
//				json -> Address? in
//				guard let RESTType = json as? Address else { 	return  nil 	}
//				return RESTType
//			}, completion: completion
//		)
	}
	
}
