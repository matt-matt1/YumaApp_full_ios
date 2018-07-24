//
//  Array.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-07-21.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


extension Array
{
	//https://stackoverflow.com/questions/25827033/how-do-i-convert-a-swift-array-to-a-string
	var toString: String?
	{
		do
		{
			let data = try JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])
			return String(data: data, encoding: .utf8)
		}
		catch
		{
			return nil
		}
	}
	func implode(_ separator: String=", ") -> String
	{
		var str = ""
		for val in self
		{
			str += "\(val)" + separator
		}
		return String(str.dropLast())
	}
}
