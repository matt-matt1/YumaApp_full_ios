//
//  URLResponse.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-06-18.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


extension URLResponse
{
	/// Return the status code in a URL response
	func getStatusCode() -> Int?
	{
		if let httpResponse = self as? HTTPURLResponse
		{
			return httpResponse.statusCode
		}
		return nil
	}
}
