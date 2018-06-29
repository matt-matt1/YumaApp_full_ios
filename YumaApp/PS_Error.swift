//
//  PS_Error.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-06-29.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


class PS_Error: ParserBase
{
	var message = ""
	var code = 0


	func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
	{
//		print("processing <\(elementName)> tag from error")
		
		if elementName == "message"
		{
			self.message = foundCharacters
		}
		else if elementName == "code"
		{
			if let l = Int(foundCharacters)
			{
				self.code = l
			}
		}
		else if elementName == "error"
		{
			parser.delegate = self.parent
		}
		foundCharacters = ""
	}

}
