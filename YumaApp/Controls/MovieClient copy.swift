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
	}
	
	//in the signature of the function in the success case we define the Class type thats is the generic one in the API
	func getREST(from RESTType: PSREST, completion: @escaping (Result<MovieFeedResult?, APIError>) -> Void)
	{
		fetch(with: RESTType.request, decode:
			{
				json -> MovieFeedResult? in
				guard let movieFeedResult = json as? MovieFeedResult else { 	return  nil 	}
				return movieFeedResult
			}, completion: completion
		)
	}
}
