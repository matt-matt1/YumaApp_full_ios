//
//  PageCell.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-24.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell
{
	var page: Slide?
	{
		didSet
			{
				guard let unwrappedPage = page else 	{ 	return 	}
				myImage.image = UIImage(named: unwrappedPage.image)
				myMain.attributedText = NSMutableAttributedString(string: unwrappedPage.caption1, attributes: R.attribute.caption1)
				mySub.attributedText = NSMutableAttributedString(string: unwrappedPage.caption1, attributes: R.attribute.caption2)
			}
	}
	
	private let myImage: UIImageView =
	{
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleAspectFit
		return image
	}()
	private let myMain: UITextView =
	{
		let tv = UITextView()
		tv.translatesAutoresizingMaskIntoConstraints = false
		tv.textColor = R.color.YumaYel
		tv.backgroundColor = UIColor.clear
//		UIView.animate(withDuration: 2, animations:
//			{
//				tv.transform = CGAffineTransform(translationX: tv.frame.maxX, y: 200)
//			})
		return tv
	}()
	private let mySub: UITextView =
	{
		let tv = UITextView()
		tv.translatesAutoresizingMaskIntoConstraints = false
		tv.textColor = R.color.YumaYel
		tv.backgroundColor = UIColor.clear
//		UIView.animate(withDuration: 2, animations:
//			{
//				tv.transform = CGAffineTransform(translationX: 200, y: 200)
//		})
		return tv
	}()

	override init(frame: CGRect)
	{
		super.init(frame: frame)
		addSubview(myImage)
		myImage.clipsToBounds = true
		addSubview(myMain)
		addSubview(mySub)
		NSLayoutConstraint.activate([
			myImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			myImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
			myImage.widthAnchor.constraint(equalToConstant: self.frame.width),
			myImage.heightAnchor.constraint(equalToConstant: self.frame.height),
			
			myMain.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
			myMain.topAnchor.constraint(equalTo: myImage.topAnchor, constant: 200),
			myMain.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
			myMain.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
			
			mySub.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
			mySub.topAnchor.constraint(equalTo: myImage.topAnchor, constant: 250),
			mySub.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
			mySub.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
			])
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}
