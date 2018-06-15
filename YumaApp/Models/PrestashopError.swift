//
//  PrestashopError.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-06-13.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation
import SWXMLHash

//<?xml version=\"1.0\" encoding=\"UTF-8\"?>
//<prestashop xmlns:xlink=\"http://www.w3.org/1999/xlink\">
//<errors>
//<error>
//<code><![CDATA[127]]></code>
//<message><![CDATA[XML error : String could not be parsed as XML\nXML length : 0\nOriginal XML : ]]></message>
//</error>//
//</errors>
//</prestashop>

struct PSErrors
{
	let errors: [PSError]?
}
struct PSError: Codable, XMLIndexerDeserializable
{
	let code: String
	let message: String
	
	static func deserialize(_ node: XMLIndexer) throws -> PSError
	{
		return try PSError(code: node["code"].value(), message: node["message"].value())
	}
}
