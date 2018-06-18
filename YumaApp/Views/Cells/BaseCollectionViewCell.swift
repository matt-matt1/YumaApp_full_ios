//
//  BaseCollectionViewCell.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-05-02.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


class BaseCell: UICollectionViewCell
{
	override init(frame: CGRect)
	{
		super.init(frame: frame)
		setupViews()
	}
	
	func setupViews()
	{
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		super.init(coder: aDecoder)
		setupViews()
		//fatalError("init(coder:) has not been implemented")
	}
	
}

