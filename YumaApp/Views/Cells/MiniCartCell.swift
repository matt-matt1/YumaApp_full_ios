//
//  MiniCartCell.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-31.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


class MiniCartCell: UIView
{
	let imageView: UIImageView =
	{
		let iv = UIImageView()
		iv.translatesAutoresizingMaskIntoConstraints = false
		iv.backgroundColor = UIColor.blue
		iv.contentMode = .scaleAspectFit
		return iv
	}()
	private let imageFrame: UIView =
	{
		let ifr = UIView()
		ifr.translatesAutoresizingMaskIntoConstraints = false
		ifr.backgroundColor = UIColor.cyan
		return ifr
	}()
	let qtyView: UIView =
	{
		let qv = UIView()
		qv.translatesAutoresizingMaskIntoConstraints = false
		qv.backgroundColor = R.color.YumaRed
		qv.justRound(corners: [UIRectCorner.bottomRight], radius: 10)
		return qv
	}()
	let qtyLabel: UILabel =
	{
		let ql = UILabel()
		ql.translatesAutoresizingMaskIntoConstraints = false
		ql.textColor = R.color.YumaYel
		ql.font = UIFont.systemFont(ofSize: 10)
		ql.sizeToFit()
		//ql.center.x =
		return ql
	}()
	
	
	override init(frame: CGRect)
	{
		super.init(frame: frame)
		
		self.translatesAutoresizingMaskIntoConstraints = false
		imageFrame.addSubview(imageView)
		self.addSubview(imageFrame)
		qtyView.addSubview(qtyLabel)
		self.addSubview(qtyView)
		NSLayoutConstraint.activate([
			imageView.leftAnchor.constraint(equalTo: imageFrame.leftAnchor, constant: 5),
			imageView.topAnchor.constraint(equalTo: imageFrame.topAnchor),
			imageView.rightAnchor.constraint(equalTo: imageFrame.rightAnchor, constant: 5),
			imageView.bottomAnchor.constraint(equalTo: imageFrame.bottomAnchor),
			
			imageFrame.leftAnchor.constraint(equalTo: self.leftAnchor),
			imageFrame.topAnchor.constraint(equalTo: self.topAnchor),
			imageFrame.rightAnchor.constraint(equalTo: self.rightAnchor),
			imageFrame.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			
			qtyLabel.leadingAnchor.constraint(equalTo: qtyView.leadingAnchor),
			qtyLabel.topAnchor.constraint(equalTo: qtyView.topAnchor),
			qtyLabel.centerXAnchor.constraint(equalTo: qtyView.centerXAnchor),
			qtyLabel.centerYAnchor.constraint(equalTo: qtyView.centerYAnchor),
			
			qtyView.leftAnchor.constraint(equalTo: self.leftAnchor),
			qtyView.topAnchor.constraint(equalTo: self.topAnchor),
			qtyView.widthAnchor.constraint(equalToConstant: 30),
			qtyView.heightAnchor.constraint(equalToConstant: 30),
			])
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
