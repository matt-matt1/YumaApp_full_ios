//
//  PS_CustomerAssocations.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-06-30.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class PS_CustomerAssocations: ParserBase
{
	var groups = ""
	
	
	func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
	{
		//		print("processing <\(elementName)> tag from error")
		
		if elementName == "groups"
		{
			self.groups = foundCharacters
		}
		else if elementName == "error"
		{
			parser.delegate = self.parent
		}
		foundCharacters = ""
	}
	
}
