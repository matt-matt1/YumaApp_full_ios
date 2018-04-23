//
//  ImageTypes.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-23.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct ImageTypes: Codable
{
	let image_types: [ImageType]?
}
struct ImageType: Codable
{
	let id:				Int?//!
	let name: 			String?//!
	let width: 			String?//!
	let height: 		String?//!
	let categories: 	String?//Bool
	let products: 		String?//Bool
	let manufacturers: 	String?//Bool
	let suppliers: 		String?//Bool
	let stores: 		String?//Bool
}
