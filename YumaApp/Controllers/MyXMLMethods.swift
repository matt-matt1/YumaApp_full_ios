//
//  MyXMLMethods.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-06-13.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import SWXMLHash
import UIKit


class MyXMLMethods: NSObject
{
	func enumerate(_ indexer: XMLIndexer)
	{
		for child in indexer.children
		{
			print(child.element!.name)
			enumerate(child)
		}
	}
}
