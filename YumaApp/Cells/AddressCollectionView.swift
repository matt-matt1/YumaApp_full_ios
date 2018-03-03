//
//  AddressCollectionView.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-14.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class AddressCollectionView: UICollectionViewCell
{
	@IBOutlet weak var alias: UITextField!
	@IBOutlet weak var details: UITextView!
	
	
	func displayContent(header: String, address: String)
	{
		alias.text = header
		details.text = address
	}
}
