//
//  Search.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-23.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct Search: Codable
{
	let search: [aSearch]?
}
struct aSearch: Codable
{
	let id: 		Int?
	let language: 	String?
	let query: 		String?
}
