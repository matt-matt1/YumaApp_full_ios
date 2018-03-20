//
//  Languages.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-17.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


struct Language : Codable
{
	let id: Int?
	let name: String?
	let isoCode: String?
	let locale: String?
	let languageCode: String?
	let active: String?
	let isRtl: String?
	let dateFormatLite: String?
	let dateFormatFull: String?
	
	enum MemberKeys: String, CodingKey
	{
		case id
		case name
		case isoCode = "iso_code"
		case locale
		case languageCode = "language_code"
		case active
		case isRtl = "is_rtl"
		case dateFormatLite = "date_forma_lLite"
		case dateFormatFull = "date_forma_full"
	}
}

struct Languages : Codable
{
	let languages: [Language]?
}
