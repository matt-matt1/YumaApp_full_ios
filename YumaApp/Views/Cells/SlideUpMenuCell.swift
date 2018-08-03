//
//  SlideUpMenuCell.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-07-23.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class SlideUpMenuCell: BaseCell
{
	override var isHighlighted: Bool
	{
		didSet
		{
			if iconLabel.text != nil
			{
				UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
		//			backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
		//			nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.darkGray
		//			iconLabel.textColor = isHighlighted ? UIColor.white : UIColor.darkGray
					self.backgroundColor = self.isHighlighted ? R.color.YumaRed : UIColor.white
					self.nameLabel.textColor = self.isHighlighted ? R.color.YumaYel : R.color.YumaRed
					self.iconLabel.textColor = self.isHighlighted ? R.color.YumaYel : R.color.YumaRed
				}, completion: nil)
			}
		}
	}
	var contents: IconPanel?
	{
		didSet
		{
			if contents != nil
			{
				nameLabel.text = contents?.text
				iconLabel.font = R.font.FontAwesomeOfSize(pointSize: 20)
				if contents!.icon != nil && !contents!.icon!.isEmpty
				{
					iconLabel.text = contents?.icon
				}
				else if contents!.iconAttr != nil
				{
					iconLabel.attributedText = contents?.iconAttr
				}
			}
		}
	}
	let nameLabel: UILabel =
	{
		let view = UILabel()
		view.textColor = R.color.YumaRed//UIColor.darkGray
		view.font = UIFont.systemFont(ofSize: 14)
		return view
	}()
	let iconLabel: UILabel =
	{
		let view = UILabel()
		view.textColor = R.color.YumaRed//UIColor.darkGray
		return view
	}()
	let line: UIView =
	{
		let view = UIView()
		return view
	}()


	override func setupViews()
	{
		super.setupViews()
		addSubview(nameLabel)
		addSubview(iconLabel)
		addConstraintsWithFormat(format: "H:|-10-[v0(30)]-10-[v1]|", views: iconLabel, nameLabel)
		addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
		addConstraintsWithFormat(format: "V:[v0(30)]", views: iconLabel)
		addConstraint(NSLayoutConstraint(item: iconLabel, attribute: .centerY, relatedBy: .equal, toItem: nameLabel, attribute: .centerY, multiplier: 1, constant: 0))
	}
}
