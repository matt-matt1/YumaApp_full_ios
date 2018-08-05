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
//	let mutableAttributedString = NSMutableAttributedString(string: "")
//	let label: UILabel =
//	{
//		let view = UILabel()
//		view.tintColor = UIColor.gray
//		view.textAlignment = .center
//		return view
//	}()
	let imageView: UIImageView =
	{
		let view = UIImageView()
		view.tintColor = UIColor.gray
		return view
	}()
	override var isHighlighted: Bool
	{
		didSet
		{
//			let yellowAttr = [NSAttributedStringKey.foregroundColor : R.color.YumaYel]
//			let grayAttr = [NSAttributedStringKey.foregroundColor : UIColor.gray]
			imageView.tintColor = isHighlighted ? R.color.YumaYel/*UIColor.yellow*/ : UIColor.gray
//			label.attributedText.removeAttribute(NSAttributedStringKey.foregroundColor, range: NSRange(location: 0, length: label.text?.count))
//			if label.text != nil
//			{
//				label.attributedText = isHighlighted ? NSAttributedString(string: label.text!, attributes: [NSAttributedStringKey.foregroundColor : R.color.YumaYel], NSAttributedStringKey.paragraphStyle) : NSAttributedString(string: label.text!, attributes: [NSAttributedStringKey.foregroundColor : UIColor.gray])
//			}
		}
	}
	override var isSelected: Bool
	{
		didSet
		{
			imageView.tintColor = isSelected ? R.color.YumaYel/*UIColor.yellow*/ : UIColor.gray
//			label.attributedText.removeAttribute(NSAttributedStringKey.foregroundColor, range: NSRange(location: 0, length: label.text?.count))
//			if label.text != nil
//			{
//				label.attributedText = isHighlighted ? NSAttributedString(string: label.text!, attributes: [NSAttributedStringKey.foregroundColor : R.color.YumaYel]) : NSAttributedString(string: label.text!, attributes: [NSAttributedStringKey.foregroundColor : UIColor.gray])
//			}
		}
	}


	override func setupViews()
	{
		super.setupViews()
		addSubview(imageView)
//		addSubview(label)
		addConstraintsWithFormat(format: "H:[v0(30)]", views: imageView)
		addConstraintsWithFormat(format: "V:[v0(30)]", views: imageView)
		addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
		addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
//		addConstraintsWithFormat(format: "H:[v0(30)]", views: label)
//		addConstraintsWithFormat(format: "V:[v0(30)]", views: label)
	}
}
