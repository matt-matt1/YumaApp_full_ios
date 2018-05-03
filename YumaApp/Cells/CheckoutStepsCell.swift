//
//  CheckoutStepsCell.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-05-02.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


class CheckoutStepsCell: UICollectionViewCell
{
	let label: UILabel =
		{
			let view = UILabel()
			view.translatesAutoresizingMaskIntoConstraints = false
			view.textColor = UIColor.blue
			view.textAlignment = .center
			view.font = UIFont.systemFont(ofSize: 30)
			return view
		}()
	
	
	override init(frame: CGRect)
	{
		super.init(frame: frame)
		setupContents()
	}
	
	func setupContents()
	{
		self.layer.borderColor = UIColor.cyan.cgColor
		self.label.borderWidth = 3
		addSubview(label)
		addConstraintsWithFormat(format: "H:|[v0]|", views: label)
		addConstraintsWithFormat(format: "V:|[v0]|", views: label)
		//addConstraint(NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
		//addConstraint(NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
		//addConstraint(NSLayoutConstraint(item: label, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0))
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
