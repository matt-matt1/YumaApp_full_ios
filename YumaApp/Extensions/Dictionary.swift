//
//  Dictionary.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-06-18.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


extension Dictionary where Key: ExpressibleByStringLiteral
{
	subscript<Index: RawRepresentable>(index: Index) -> Value? where Index.RawValue == String
	{
		get {	return self[index.rawValue as! Key]			}
		set {	self[index.rawValue as! Key] = newValue		}
	}
}

