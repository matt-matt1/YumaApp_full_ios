//
//  Customizations.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-23.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation

struct Customizations: Codable
{
	let customizations: [Customization]?
}
struct Customization: Codable
{
	let id: Int?
}
