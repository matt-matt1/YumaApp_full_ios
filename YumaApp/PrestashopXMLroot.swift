//
//  PrestashopXMLroot.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-06-29.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


class PrestashopXMLroot: ParserBase
{
//	var count = 0
	var errors = [PS_Error]()
	
	
	override func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
//		print("processing <\(elementName)> tag from Prestashop")
		
//		if elementName == "prestashop"
//		{
//			if let c = Int(attributeDict["count"]!)
//			{
//				self.count = c
//			}
//		}
		if elementName == "errors"
		{
			let error = PS_Error()
			self.errors.append(error)
			
			parser.delegate = error
			error.parent = self
		}
	}

}
