//
//  AddrCollectionViewCell.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-02.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class AddrCollectionViewCell: UICollectionViewCell
{
	@IBOutlet weak var aliasEdit: UITextField!
	@IBOutlet weak var aliasInvalid: UILabel!
	@IBOutlet weak var aliasBorder: UIView!
	@IBOutlet weak var addressEdit: UITextView!
	@IBOutlet weak var addressInvalid: UILabel!
	@IBOutlet weak var addressBorder: UIView!
	
	func setup(address: Address)
	{
		aliasInvalid.text = ""
		aliasBorder.borderColor = UIColor.white
		aliasBorder.borderWidth = 2
		addressInvalid.text = ""
		addressBorder.borderColor = UIColor.white
		addressBorder.borderWidth = 2
		aliasEdit.text = address.alias
		addressEdit.text = R.formatAddress(address)
	}
}
