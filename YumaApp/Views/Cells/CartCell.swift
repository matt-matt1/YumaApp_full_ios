//
//  CartCell.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-13.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


class CartCell: UIView
{
	let prodImage: UIImageView =
	{
		let iv = UIImageView(/*frame: CGRect(x: 0, y: 0, width: 253, height: 100)*/)
		iv.translatesAutoresizingMaskIntoConstraints = false
		//iv.sizeToFit()
		return iv
	}()
	let prodName: UILabel =
	{
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.isUserInteractionEnabled = false
		lbl.lineBreakMode = NSLineBreakMode.byTruncatingHead
		//lbl.adjustsFontSizeToFitWidth = true
		lbl.textAlignment = .center
		lbl.font = UIFont.init(name: "AvenirNext-Bold", size: 14)//.boldSystemFont(ofSize: 25)
		lbl.textColor = R.color.YumaRed
		lbl.shadowColor = R.color.YumaYel
		lbl.shadowOffset = CGSize(width: 1, height: 1)
		lbl.shadowRadius = 4.0
		//lbl.shadowOpacity = 1
		//lbl.sizeToFit()
		return lbl
	}()
	//	let prodPrice: UILabel =
	//	{
	//		let lbl = UILabel()
	//		lbl.translatesAutoresizingMaskIntoConstraints = false
	//		lbl.font = UIFont.systemFont(ofSize: 21)
	//		lbl.textAlignment = .center
	//		return lbl
	//	}()
	private let imageView: UIView =
	{
		let view = UIView(/*frame: CGRect(x: 0, y: 0, width: 253, height: 100)*/)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	//	let imageFrame: UIView =
	//	{
	//		let view = UIView()
	//		view.translatesAutoresizingMaskIntoConstraints = false
	//		return view
	//	}()
	let prodGap: UIView =
	{
		let view = UIView(/*frame: CGRect(x: 0, y: 136, width: 253, height: 3)*/)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	let prodLine: UIView =
	{
		let view = UIView(/*frame: CGRect(x: 0, y: 139, width: 253, height: 1)*/)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	private let prodQtyView: UIView =
	{
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = R.color.YumaYel
		view.cornerRadius = 10
		view.shadowColor = R.color.YumaDRed
		view.shadowOffset = CGSize(width: 1, height: 1)
		view.shadowRadius = 1
		view.shadowOpacity = 0.9
		return view
	}()
	let prodQty: UILabel =
	{
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.isUserInteractionEnabled = false
		view.lineBreakMode = NSLineBreakMode.byTruncatingTail
		view.textAlignment = .center
		view.font = UIFont.boldSystemFont(ofSize: 10)//UIFont.systemFont(ofSize: 10)
		view.textColor = R.color.YumaRed
//		view.shadowColor = R.color.YumaDRed
//		view.shadowOffset = CGSize(width: 1, height: 1)
//		view.shadowRadius = 3
		return view
	}()
	
	
	override init(frame: CGRect)
	{
		super.init(frame: frame)
		imageView.addSubview(prodImage)
		prodQtyView.addSubview(prodQty)
		imageView.addSubview(prodQtyView)
		NSLayoutConstraint.activate([
			prodImage.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
			prodImage.topAnchor.constraint(equalTo: imageView.topAnchor),
			prodImage.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
			prodImage.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),

			prodQty.leadingAnchor.constraint(equalTo: prodQtyView.leadingAnchor),
			prodQty.topAnchor.constraint(equalTo: prodQtyView.topAnchor),
			prodQty.trailingAnchor.constraint(equalTo: prodQtyView.trailingAnchor),
			prodQty.bottomAnchor.constraint(equalTo: prodQtyView.bottomAnchor),
			
			prodQtyView.topAnchor.constraint(equalTo: imageView.topAnchor),
			prodQtyView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
			prodQtyView.widthAnchor.constraint(equalToConstant: 20),
			prodQtyView.heightAnchor.constraint(equalToConstant: 20),
			])

		prodGap.heightAnchor.constraint(equalToConstant: 3).isActive = true
		prodLine.backgroundColor = UIColor(hex: "#DCDCDC", alpha: 1)
		prodLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
		
		let stack = UIStackView(arrangedSubviews: [prodName, imageView, /*prodGap,*/ prodLine])
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		
		self.addSubview(stack)
		NSLayoutConstraint.activate([
			prodName.topAnchor.constraint(equalTo: stack.topAnchor),
			prodName.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
			prodName.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
			prodName.heightAnchor.constraint(equalToConstant: 20),
//			prodName.bottomAnchor.constraint(equalTo: imageView.topAnchor),
			
			imageView.topAnchor.constraint(equalTo: prodName.bottomAnchor),
			imageView.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
//			imageView.bottomAnchor.constraint(equalTo: prodGap.topAnchor),
			imageView.bottomAnchor.constraint(equalTo: prodLine.topAnchor),
			//imageView.heightAnchor.constraint(equalToConstant: stack.frame.height-prodGap.frame.height-prodLine.frame.height-prodName.frame.height),
			
//			prodGap.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
			//prodGap.topAnchor.constraint(equalTo: stack.topAnchor),
//			prodGap.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
			
			prodLine.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
			//prodLine.topAnchor.constraint(equalTo: stack.topAnchor),
			prodLine.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
			prodLine.bottomAnchor.constraint(equalTo: stack.bottomAnchor),
			
			stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			stack.topAnchor.constraint(equalTo: self.topAnchor),
			stack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 5),
			stack.widthAnchor.constraint(equalTo: self.widthAnchor/*, constant: -20*/),
			
			//prodImage.heightAnchor.constraint(lessThanOrEqualToConstant: stack.frame.height),
			])
		//print("gap=\(prodGap.bounds.height), line=\(prodLine.bounds.height), name=\(prodName.bounds.height)")
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}
