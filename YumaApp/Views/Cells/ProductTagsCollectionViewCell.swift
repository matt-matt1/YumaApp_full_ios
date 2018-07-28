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
		NSLayoutConstraint.activate([
			label.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
			label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
			label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10),
			label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5)
			])
	}
}
