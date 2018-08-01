//
//  ProductTagsCollectionViewCell.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-07-27.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class ProductTagsCollectionViewCell: BaseCell//UICollectionViewCell
{
	let label: UILabel =
	{
		let view = UILabel()
		view.backgroundColor = UIColor.blue
		return view
	}()


	override func setupViews()
	{
		super.setupViews()
		addSubview(label)
		self.addConstraintsWithFormat(format: "H:|-20-[v0]-10-|", views: label)
		self.addConstraintsWithFormat(format: "V:|-2-[v0]-2-|", views: label)
//		NSLayoutConstraint.activate([
//			label.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
//			label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
//			label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
//			label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
//			])
	}
}
