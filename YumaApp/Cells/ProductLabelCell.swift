//
//  ProductLabelCell.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-06-16.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class ProductLabelCell: UICollectionViewCell
{
	var name: UILabel =
	{
		let view = UILabel()
		return view
	}()



	override init(frame: CGRect)
	{
		super.init(frame: frame)
//		setupView()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	
	func makeTag(string: String) -> UIView
	{
		let tagView = UIView()
		//tagView.translatesAutoresizingMaskIntoConstraints = false
		tagView.backgroundColor = R.color.YumaRed
		tagView.borderColor = R.color.YumaDRed
		//tag.borderWidth = 1
		tagView.cornerRadius = 5
		let tagHole = UIView()
		tagHole.translatesAutoresizingMaskIntoConstraints = false
		tagHole.backgroundColor = UIColor.white
		tagHole.borderColor = R.color.YumaDRed
		//tagHole.borderWidth = 1
		tagHole.shadowColor = UIColor.black
		tagHole.shadowOffset = CGSize(width: -1, height: -1)
		tagHole.shadowRadius = 2
		tagHole.shadowOpacity = 1
		let tagBlock1 = UIView()
		tagBlock1.translatesAutoresizingMaskIntoConstraints = false
		tagBlock1.backgroundColor = UIColor.white
		let tagBlock2 = UIView()
		tagBlock2.translatesAutoresizingMaskIntoConstraints = false
		tagBlock2.backgroundColor = UIColor.white
		let tagLbl = UILabel()
		tagLbl.translatesAutoresizingMaskIntoConstraints = false
		tagLbl.text = "   " + string + " "
		tagLbl.textColor = R.color.YumaYel
		tagLbl.font = UIFont.systemFont(ofSize: 11)
		tagView.addSubview(tagLbl)
		NSLayoutConstraint.activate([
			tagLbl.topAnchor.constraint(equalTo: tagView.topAnchor, constant: 5.5),
			tagLbl.leadingAnchor.constraint(equalTo: tagView.leadingAnchor, constant: 11),
			tagLbl.bottomAnchor.constraint(equalTo: tagView.bottomAnchor, constant: -5.5),
			tagLbl.trailingAnchor.constraint(equalTo: tagView.trailingAnchor, constant: -5),
			])
		tagView.addSubview(tagHole)
		NSLayoutConstraint.activate([
			tagHole.centerYAnchor.constraint(equalTo: tagView.centerYAnchor, constant: 0),
			tagHole.leadingAnchor.constraint(equalTo: tagView.leadingAnchor, constant: 9),
			tagHole.heightAnchor.constraint(equalToConstant: 4),
			tagHole.widthAnchor.constraint(equalToConstant: 4),
			])
		tagHole.cornerRadius = 5 / 2
		tagView.addSubview(tagBlock1)
		tagView.addSubview(tagBlock2)
		NSLayoutConstraint.activate([
			tagBlock1.topAnchor.constraint(equalTo: tagView.topAnchor, constant: -5),
			tagBlock1.leadingAnchor.constraint(equalTo: tagView.leadingAnchor, constant: -2),
			tagBlock1.bottomAnchor.constraint(equalTo: tagView.centerYAnchor, constant: 0),
			tagBlock1.widthAnchor.constraint(equalToConstant: 8),
			
			tagBlock2.topAnchor.constraint(equalTo: tagView.centerYAnchor, constant: 0),
			tagBlock2.leadingAnchor.constraint(equalTo: tagView.leadingAnchor, constant: -2),
			tagBlock2.bottomAnchor.constraint(equalTo: tagView.bottomAnchor, constant: 5),
			tagBlock2.widthAnchor.constraint(equalToConstant: 8),
			])
		tagBlock1.transform = CGAffineTransform(rotationAngle: .pi/180*45)
		tagBlock2.transform = CGAffineTransform(rotationAngle: -.pi/180*45)
//		tagView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.displayCat(_:))))
		return tagView
	}

	func setupView()
	{
		//
	}
}
