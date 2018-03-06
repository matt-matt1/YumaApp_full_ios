//
//  States.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-03.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct CountryState: Decodable
{
	let id: 			Int?//!
	let id_zone: 		String?//!
	let id_country: 	String?//!
	let iso_code: 		String?//!..7
	let name: 			String?//!..32
	let active: 		String?//Bool
}
struct CountryStates: Decodable
{
	let states: [CountryState]?
}
