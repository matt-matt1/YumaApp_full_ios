//
//  ProductFeatureValues.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-23.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct ProductFeatureValues: Codable
{
	let product_feature_values: [ProductFeatureValue]?
}
struct ProductFeatureValue: Codable
{
	let id: 		Int?
	let id_feature: String?
	let custom: 	String?
	let value: 		String?
}
