//
//  ProductFeatures.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-23.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct ProductFeatures: Codable
{
	let product_features: [ProductFeature]?
}
struct ProductFeature: Codable
{
	let id: 		Int?
	let position: 	String?
	let name: 		String?
}
