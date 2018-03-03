//
//  Tag.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-03.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct myTag: Decodable
{
	let id: Int
	let id_lang: String
	let name: String
}
struct Tags: Decodable
{
	let tags: [myTag]
}
