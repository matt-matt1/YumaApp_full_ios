//
//  PropertyNames.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-15.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


protocol PropertyNames
{
	func propertyNames() -> [String]
}

extension PropertyNames
{
	func propertyNames() -> [String]
	{
		return Mirror(reflecting: self).children.compactMap { $0.label }
	}
}
