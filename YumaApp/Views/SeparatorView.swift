//
//  SeparatorView.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-07-24.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class SeparatorView: UICollectionReusableView
{
	override init(frame: CGRect)
	{
		super.init(frame: frame)
		self.backgroundColor = .red
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
	
	override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes)
	{
		self.frame = layoutAttributes.frame
	}

}
