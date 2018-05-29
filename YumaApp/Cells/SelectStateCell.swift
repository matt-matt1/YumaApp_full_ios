////
////  SelectStateCell.swift
////  YumaApp
////
////  Created by Yuma Usa on 2018-05-29.
////  Copyright © 2018 Yuma Usa. All rights reserved.
////
//
//import UIKit
//
//class SelectStateCell: UITableViewCell
//{
//	//	let titleLabel: UITextView =
//	//	{
//	//		let view = UITextView()
//	//		view.translatesAutoresizingMaskIntoConstraints = false
//	//		let attr = NSMutableAttributedString(string: view.text, attributes: [:])
//	//		view.attributedText = attr
//	//		view.textAlignment = .center
//	//		view.font = UIFont.systemFont(ofSize: 20)
//	//		view.textColor = UIColor.darkGray
//	//		view.isEditable = false
//	//		view.isScrollEnabled = false
//	//		return view
//	//	}()
//	let titleLabel: UILabel =
//	{
//		let view = UILabel()
//		view.translatesAutoresizingMaskIntoConstraints = false
//		//		let attr = NSMutableAttributedString(string: view.text!, attributes: [:])
//		//		view.attributedText = attr
//		view.textAlignment = .center
//		view.font = UIFont.systemFont(ofSize: 20)
//		view.textColor = UIColor.darkGray
//		//		view.isEditable = false
//		//		view.isScrollEnabled = false
//		return view
//	}()
//	
//	
//	func setupViews()
//	{
//		addSubview(titleLabel)
//		addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: titleLabel)
//		addConstraintsWithFormat(format: "V:[v0]", views: titleLabel)
//		addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
//	}
//	
//}
