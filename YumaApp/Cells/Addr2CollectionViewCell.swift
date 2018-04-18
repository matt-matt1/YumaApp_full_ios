//
//  Addr2CollectionViewCell.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-18.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class Addr2CollectionViewCell: UICollectionViewCell
{
	@IBOutlet weak var aliasEdit: UITextField!
	@IBOutlet weak var aliasInvalid: UILabel!
	@IBOutlet weak var aliasBorder: UIView!
	@IBOutlet weak var addressEdit: UITextView!
	@IBOutlet weak var addressBorder: UIView!
	
	
	func setup(address: Address)
	{
		aliasInvalid.text = ""
		aliasBorder.borderColor = UIColor.white
		aliasBorder.borderWidth = 2
		addressBorder.borderColor = UIColor.white
		addressBorder.borderWidth = 2
		aliasEdit.text = address.alias
		addressEdit.text = DataStore.sharedInstance.formatAddress(address)//R.formatAddress(address)
		if address.deleted != nil && address.deleted != "" && address.deleted != "0"
		{
			let cellView = aliasBorder.superview?.superview
			//			let deleted = UILabel(frame: CGRect(x: 0, y: ((aliasBorder?.superview?.frame.height)!/2)-20, width: aliasEdit.frame.width, height: 40))
			let deleted = UILabel(frame: CGRect(x: 0, y: 50, width: aliasBorder.frame.width, height: 40))
			deleted.backgroundColor = R.color.YumaRed.withAlphaComponent(0.7)
			deleted.text = R.string.deld
			deleted.textAlignment = .center
			deleted.textColor = R.color.YumaYel
			cellView?.addSubview(deleted)
			deleted.transform.rotated(by: CGFloat(Double.pi / 180 * 50))
		}
	}

}
