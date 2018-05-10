//
//  CustomCollectionViewCell.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-13.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

@IBDesignable
class CustomCollectionViewCell: UICollectionViewCell
{
	@IBOutlet weak var label: UILabel!
	
	
	required init?(coder aDecoder: NSCoder)
	{
		super.init(coder: aDecoder)
		setup()
	}
	
	override init(frame: CGRect)
	{
		super.init(frame: frame)
		setup()
	}
	
	func setup()
	{
		self.layer.borderWidth = 1.0
		self.layer.borderColor = UIColor.black.cgColor
		self.layer.cornerRadius = 5
		
	}
}
