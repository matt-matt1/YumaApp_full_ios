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
				myMain.attributedText = NSMutableAttributedString(string: unwrappedPage.caption1.uppercased(), attributes: R.attribute.caption1)
				mySub.attributedText = NSMutableAttributedString(string: unwrappedPage.caption2.uppercased(), attributes: R.attribute.caption2)
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
		return tv
	}()
	private let mySub: UITextView =
	{
		let tv = UITextView()
		tv.translatesAutoresizingMaskIntoConstraints = false
		tv.textColor = R.color.YumaYel
		tv.backgroundColor = UIColor.clear
		return tv
	}()


	override func prepareForReuse()
	{
		super.prepareForReuse()
		myImage.image = nil
	}

	override init(frame: CGRect)
	{
		super.init(frame: frame)
//		let myMainView = UIView()
//		myMainView.translatesAutoresizingMaskIntoConstraints = false
//		myMainView.addSubview(myMain)
		addSubview(myImage)
		myImage.clipsToBounds = true
		//self.myMain.layer.removeAllAnimations()
//		addSubview(myMainView)
		addSubview(myMain)
//		NSLayoutConstraint.activate([
//			myMainView.topAnchor.constraint(equalTo: myMain.topAnchor),
//			myMainView.leadingAnchor.constraint(equalTo: myMain.leadingAnchor),
//			myMainView.widthAnchor.constraint(equalToConstant: myMain.frame.width),
//			myMainView.heightAnchor.constraint(equalToConstant: myMain.frame.height)
//			])
//		UIView.animate(withDuration: 2.5, delay: 0.5, options: [.repeat], animations:
//			{
//				self.mySub.transform = CGAffineTransform(translationX: 100, y: self.mySub.frame.maxY)
//		}, completion: nil)
		//self.mySub.layer.removeAllAnimations()
		addSubview(mySub)
		//print("self is \(self.frame.width) x \(self.frame.height)")
		NSLayoutConstraint.activate([
			myImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			myImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 150),
			myImage.widthAnchor.constraint(equalToConstant: self.frame.width),
			myImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			myImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			myImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -260)
			//myImage.heightAnchor.constraint(equalToConstant: self.frame.height),
			])
		NSLayoutConstraint.activate([
//			myMainView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
			myMain.topAnchor.constraint(equalTo: self.topAnchor, constant: self.frame.height/2.3/*320*/),//caption1 finish y
//			myMainView.topAnchor.constraint(equalTo: myImage.topAnchor, constant: 200),//myMainView.frame.height),
			myMain.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -260),
//			myMainView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
//			myMainView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
			//myMain.topAnchor.constraint(equalTo: myImage.topAnchor, constant: -myMain.frame.height),
			myMain.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.frame.width/8.2/*50*/),//caption1 y
			myMain.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
			])
		NSLayoutConstraint.activate([
			//mySub.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
			mySub.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.frame.width/8.2/*50*/),//caption2 finish x
			//mySub.topAnchor.constraint(equalTo: myImage.topAnchor, constant: myImage.frame.height),//300),//self.frame.height*2/3),
			mySub.topAnchor.constraint(equalTo: self.topAnchor, constant: self.frame.height/2/*365*/),//caption2 y
			mySub.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
			mySub.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -260),
			])
//		print("self: \(self.frame.width) x \(self.frame.height)")
//		print("myImage: \(myImage.frame.width) x \(myImage.frame.height)")
//		print("myMainView: \(myMainView.frame.width) x \(myMainView.frame.height)")
//		print("myMain: \(myMain.frame.width) x \(myMain.frame.height)")
//		print("mySub: \(mySub.frame.width) x \(mySub.frame.height)")
		UIView.animate(withDuration: 3, delay: 0, options: [.repeat], animations:
			{
//				myMainView.frame.origin.y += 200
				self.myMain.frame.origin.y += 200
				//self.myMain.transform = CGAffineTransform(translationY: self.myMain.frame.maxX, x: 200)
				self.mySub.frame.origin.x += 120//self.mySub.frame.width
				//self.mySub.transform = CGAffineTransform(translationX: 100, y: self.mySub.frame.maxY)
		}, completion: nil)
		//self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: myMainView))
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}
