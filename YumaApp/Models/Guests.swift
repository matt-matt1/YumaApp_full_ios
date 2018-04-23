//
//  Guests.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-23.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct Guests: Codable
{
	let guests: [Guest]?
}
struct Guest: Codable
{
	let id: Int?
}
