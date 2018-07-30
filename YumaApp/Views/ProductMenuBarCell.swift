//
//  ProductMenuBarCell.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-07-29.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class ProductMenuBarCell: BaseCell
{
	let imageView: UIImageView =
	{
		let view = UIImageView()
//		view.tintColor = UIColor.gray
		return view
	}()
	override var isHighlighted: Bool
	{
		didSet
		{
			imageView.tintColor = isHighlighted ? R.color.YumaYel : UIColor.black
		}
	}
	override var isSelected: Bool
	{
		didSet
		{
			imageView.borderColor = isSelected ? R.color.YumaYel : UIColor.black
		}
	}


	override func setupViews()
	{
		super.setupViews()
		addSubview(imageView)
		addConstraintsWithFormat(format: "H:[v0(30)]", views: imageView)
		addConstraintsWithFormat(format: "V:[v0(30)]", views: imageView)
		addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
		addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
	}
}
