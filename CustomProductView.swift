//
//  CustomProductView.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-12.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


class CustomView: UIView	// product cell view
{
	let prodImage: UIImageView =
	{
		let iv = UIImageView()
		iv.translatesAutoresizingMaskIntoConstraints = false
		iv.contentMode = .scaleAspectFit
		return iv
	}()
	let prodName: UILabel =
	{
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.textAlignment = .center
		lbl.font = UIFont.boldSystemFont(ofSize: 25)
		return lbl
	}()
	let prodPrice: UILabel =
	{
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.font = UIFont.systemFont(ofSize: 21)
		lbl.textAlignment = .center
		return lbl
	}()
	let detailsBtn: UILabel =
	{
		let btn = UILabel()
		btn.translatesAutoresizingMaskIntoConstraints = false
		btn.textColor = .white
		btn.backgroundColor = .red
		btn.textAlignment = .center
		return btn
	}()
	let detailsView: UIView =
	{
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	let imageView: UIView =
	{
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	let imageFrame: UIView =
	{
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	
	override init(frame: CGRect)
	{
		super.init(frame: frame)
		
		detailsView.addSubview(detailsBtn)
		NSLayoutConstraint.activate([
			detailsBtn.topAnchor.constraint(equalTo: detailsView.topAnchor),
			detailsBtn.trailingAnchor.constraint(equalTo: detailsView.trailingAnchor),//, constant: 5),
			detailsBtn.leadingAnchor.constraint(equalTo: detailsView.trailingAnchor, constant: -80),
			detailsBtn.heightAnchor.constraint(equalToConstant: 21),
			])
		
		//		imageFrame.shadowColor = UIColor.gray
		//		imageFrame.shadowOffset = CGSize(width: 1, height: 1)
		//		imageFrame.shadowRadius = 5
		//		imageFrame.shadowOpacity = 1
		imageFrame.addSubview(prodImage)
		NSLayoutConstraint.activate([
			prodImage.topAnchor.constraint(equalTo: imageFrame.topAnchor/*, constant: 5*/),
			prodImage.trailingAnchor.constraint(equalTo: imageFrame.trailingAnchor/*, constant: -5*/),
			prodImage.leadingAnchor.constraint(equalTo: imageFrame.leadingAnchor/*, constant: 5*/),
			prodImage.bottomAnchor.constraint(equalTo: imageFrame.bottomAnchor/*, constant: -5*/),
			])
		
		//		imageView.shadowColor = UIColor.red
		//		imageView.shadowOffset = CGSize(width: 1, height: 1)
		//		imageView.shadowRadius = 5
		//		imageView.shadowOpacity = 1
		imageView.addSubview(imageFrame)
		NSLayoutConstraint.activate([
			imageFrame.topAnchor.constraint(equalTo: imageView.topAnchor/*, constant: 5*/),
			imageFrame.trailingAnchor.constraint(equalTo: imageView.trailingAnchor/*, constant: -5*/),
			imageFrame.leadingAnchor.constraint(equalTo: imageView.leadingAnchor/*, constant: 5*/),
			imageFrame.bottomAnchor.constraint(equalTo: imageView.bottomAnchor/*, constant: -5*/),
			])
		
		let stack = UIStackView(arrangedSubviews: [imageView, prodName, prodPrice, detailsView])
		stack.axis = .vertical
		stack.spacing = (self.frame.height > 400) ? (self.frame.height > 800) ? 15 : 10 : 5
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.distribution = UIStackViewDistribution.fill
		//stack.alignment = UIStackViewAlignment.center
		stack.backgroundColor = .gray
		
		NSLayoutConstraint.activate([
			prodImage.leadingAnchor.constraint(equalTo: stack.leadingAnchor),//, constant: 5),//),//
			prodImage.topAnchor.constraint(equalTo: stack.topAnchor),
			prodImage.trailingAnchor.constraint(equalTo: stack.trailingAnchor),//, constant: 5),
			
			prodName.leadingAnchor.constraint(equalTo: stack.leadingAnchor),//, constant: 5),
			prodName.trailingAnchor.constraint(equalTo: stack.trailingAnchor),//, constant: 5),
			prodName.heightAnchor.constraint(equalToConstant: 30),
			
			prodPrice.leadingAnchor.constraint(equalTo: stack.leadingAnchor),//, constant: 5),
			prodPrice.trailingAnchor.constraint(equalTo: stack.trailingAnchor),//, constant: 5),
			prodPrice.heightAnchor.constraint(equalToConstant: 25),
			
			detailsView.leadingAnchor.constraint(equalTo: stack.leadingAnchor),//, constant: 5),
			detailsView.trailingAnchor.constraint(equalTo: stack.trailingAnchor),//, constant: 5),
			detailsView.heightAnchor.constraint(equalToConstant: 20),
			])
		
		self.addSubview(stack)
		NSLayoutConstraint.activate([
			stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			stack.topAnchor.constraint(equalTo: self.topAnchor),
			stack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
			stack.widthAnchor.constraint(equalTo: self.widthAnchor/*, constant: -20*/),
			])
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

