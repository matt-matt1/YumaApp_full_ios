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
	var customers = [PS_Customer]()
	var addresses = [PS_Address]()
	
	
	override func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
	{
		switch elementName
		{
		case "errors":
			let error = PS_Error()
			self.errors.append(error)
			parser.delegate = error
			error.parent = self
			break
		case "customer":
			let customer = PS_Customer()
			self.customers.append(customer)
			parser.delegate = customer
			customer.parent = self
			break
		case "customers":
			let customer = PS_Customer()
			self.customers.append(customer)
			parser.delegate = customer
			customer.parent = self
			break
		case "address":
			let address = PS_Address()
			self.addresses.append(address)
			parser.delegate = address
			address.parent = self
			break
		case "addresses":
			let address = PS_Address()
			self.addresses.append(address)
			parser.delegate = address
			address.parent = self
			break
		default:
			break
		}
//		if elementName == "errors"
//		{
//			let error = PS_Error()
//			self.errors.append(error)
//
//			parser.delegate = error
//			error.parent = self
//		}
//		else if elementName == "customer"
//		{
//			let customer = PS_Customer()
//			self.customers.append(customer)
//
//			parser.delegate = customer
//			customer.parent = self
//		}
	}

}
