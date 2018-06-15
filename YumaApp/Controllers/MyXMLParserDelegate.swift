//
//  MyXMLParserDelegate.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-06-13.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


class MyXMLParserDelegate: UIViewController, XMLParserDelegate
{
	var parser = XMLParser()


    override func viewDidLoad()
	{
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
	{
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

	func XmlToObject(data: Data) -> String
	{
		let result = ""
		return result
	}

	func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:])
	{
		if (elementName=="House")
		{
//			let house = House()
			for string in attributeDict
			{
//				let strvalue = string.value as NSString
				switch string.key
				{
				case "id":
//					house.id = strvalue.integerValue
					break
				case "name":
//					house.name = strvalue as String
					break
				case "location":
//					house.location = strvalue as String
					break
				default:
					break
				}
			}
//			housearray.append(house)
		}
	}

	func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
	{
		//
	}

	func parser(_ parser: XMLParser, foundCharacters string: String)
	{
		//
	}

	func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error)
	{
		print("failure error: ", parseError)
	}

}
