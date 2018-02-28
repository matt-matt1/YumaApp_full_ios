//
//  AddressCollectionViewCell.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-28.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class AddressCollectionViewCell: UICollectionViewCell
{
	let store = DataStore.sharedInstance
	var page: Address?
	{
		didSet
		{
			myAlias.text = page?.alias
			myAddress.text = store.formatAddress(page!)
		}
	}
	private var myAlias: UITextView =
	{
		let tv = UITextView()
		return tv
	}()
	private var myAddress: UITextView =
	{
		let tv = UITextView()
		return tv
	}()

	
	override init(frame: CGRect)
	{
		super.init(frame: frame)
		let myStack = UIStackView(arrangedSubviews: [myAlias, myAddress])
		myAlias.translatesAutoresizingMaskIntoConstraints = false
		myAddress.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			myAlias.topAnchor.constraint(equalTo: myStack.topAnchor, constant: 0)
			])
		addSubview(myStack)
		myStack.translatesAutoresizingMaskIntoConstraints = false
		myStack.axis = UILayoutConstraintAxis.vertical
		myStack.spacing = 20
		NSLayoutConstraint.activate([
			myStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 150),
			//myStack.widthAnchor.constraint(equalToConstant: self.frame.width-40),
			myStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
			myStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20),
			//myStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -260),
			//myImage.heightAnchor.constraint(equalToConstant: self.frame.height),
			])
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
