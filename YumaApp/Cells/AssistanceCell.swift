//
//  AssistanceCell.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-05-06.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class AssistanceCell: UICollectionViewCell
{
	let titleLabel: UITextView =
	{
		let view = UITextView()
		view.translatesAutoresizingMaskIntoConstraints = false
		let attr = NSMutableAttributedString(string: view.text, attributes: [:])
		view.attributedText = attr
		view.textAlignment = .center
		view.font = UIFont.systemFont(ofSize: 20)
		view.textColor = UIColor.darkGray
		view.isEditable = false
		view.isScrollEnabled = false
		return view
	}()
	//let buttonLeft: UIButton


	override init(frame: CGRect)
	{
		super.init(frame: frame)
		setupViews()
	}
	
	func setupViews()
	{
		addSubview(titleLabel)
		addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: titleLabel)
//		addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: profileImageView)
//		addConstraintsWithFormat(format: "V:|-16-[v0]-8-|", views: titleLabel)
		addConstraintsWithFormat(format: "V:|-16-[v0]", views: titleLabel)
//		addConstraintsWithFormat(format: "H:|[v0]|", views: seperatorView)
		
//		addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbImageView, attribute: .bottom, multiplier: 1, constant: 8))
//		addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: profileImageView, attribute: .right, multiplier: 1, constant: 8))
//		addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbImageView, attribute: .right, multiplier: 1, constant: 0))
//		titleHeightConstaint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20)
//		addConstraint(titleHeightConstaint!)
//
//		addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
//		addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .left, relatedBy: .equal, toItem: profileImageView, attribute: .right, multiplier: 1, constant: 8))
//		addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .right, relatedBy: .equal, toItem: thumbImageView, attribute: .right, multiplier: 1, constant: 0))
//		addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
		addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		super.init(coder: aDecoder)
		//fatalError("init(coder:) has not been implemented")
	}
}
