//
//  Tax.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-03.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct Tax: Decodable
{
	let id: String
}
struct Taxes: Decodable
{
	let taxes: [Tax]
}
