//
//  ParserBase.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-06-29.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


class ParserBase: NSObject, XMLParserDelegate
{
	var currentElement: String = ""
	var foundCharacters = ""
	weak var parent: ParserBase? = nil
	
	func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
	{
		currentElement = elementName
	}
	
	func parser(_ parser: XMLParser, foundCharacters string: String)
	{
		self.foundCharacters += string
	}

}
