//
//  MenuBar.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-05-02.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//
import UIKit
import AwesomeEnum


class MenuBar: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
	var hbLeft: NSLayoutConstraint?
	var checkoutCollection: CheckoutCollection?
	lazy var collectionView: UICollectionView =
		{
			let layout = UICollectionViewFlowLayout()
			let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
			view.backgroundColor = R.color.YumaDRed//UIColor.red
			view.dataSource = self
			view.delegate = self
			return view
		}()
	let array = ["1"/*FontAwesome.user.rawValue*/,
				 "2"/*FontAwesome.listAlt.rawValue*/,
				 /*"\u{f48b}"*/"3"/*FontAwesome.ship.rawValue*/,
				 "4"/*FontAwesome.usd.rawValue*/]
	let imageArray = [
		Awesome.regular.idCard.asImage(size: 20).withRenderingMode(UIImageRenderingMode.alwaysTemplate),
		Awesome.solid.mapMarkedAlt.asImage(size: 20).withRenderingMode(UIImageRenderingMode.alwaysTemplate),
		Awesome.solid.shippingFast.asImage(size: 20).withRenderingMode(UIImageRenderingMode.alwaysTemplate),
		Awesome.solid.handHoldingUsd.asImage(size: 20).withRenderingMode(UIImageRenderingMode.alwaysTemplate)
	]
	let titlesArray = [
		"\(R.string.checkOut) - \(R.string.chk1)",//Personal Information
		"\(R.string.checkOut) - \(R.string.chk2)",//Delivery Address
		"\(R.string.checkOut) - \(R.string.chk3)",//Shipping Method
		"\(R.string.checkOut) - \(R.string.chk4)"]//Payment Method


	override init(frame: CGRect)
	{
		super.init(frame: frame)
		
		backgroundColor = R.color.YumaDRed//UIColor.red
		collectionView.register(MenuCell.self, forCellWithReuseIdentifier: "MenuBarCellId")
		addSubview(collectionView)
		collectionView.leadingAnchor.constraint(equalTo: safeLeadingAnchor, constant: 0).isActive = true
		collectionView.trailingAnchor.constraint(equalTo: safeTrailingAnchor, constant: 0).isActive = true
		addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
		let selected = NSIndexPath(item: 0, section: 0)
		collectionView.selectItem(at: selected as IndexPath, animated: false, scrollPosition: [])
		setupHBar()
	}
	
	func setupHBar()
	{
		let hb = UIView()
		hb.backgroundColor = UIColor(white: 0.9, alpha: 1)
		hb.translatesAutoresizingMaskIntoConstraints = false
//		hb.alignmentRectInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
		addSubview(hb)
		var leftX: CGFloat = 0
		var rightX: CGFloat = 0
		if #available(iOS 11.0, *)
		{
			leftX = (UIApplication.shared.keyWindow?.safeAreaInsets.left)!
			rightX = (UIApplication.shared.keyWindow?.safeAreaInsets.right)!
		}
		else
		{
			leftX = 0
			rightX = 0
		}
//		print("leftX=\(leftX), rightX=\(rightX)")
		hb.widthAnchor.constraint(equalToConstant: ((UIApplication.shared.keyWindow?.frame.width)! - leftX - rightX) / CGFloat(array.count)).isActive = true
		hbLeft = hb.leadingAnchor.constraint(equalTo: self.safeLeadingAnchor, constant: leftX)
		NSLayoutConstraint.activate([
			hb.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//			hb.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4),
			hb.heightAnchor.constraint(equalToConstant: 4),
			])
		hbLeft?.isActive = true
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
	{
//		let x = CGFloat(indexPath.item) * frame.width / 4
//		hbLeft?.constant = x
//		UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//			self.layoutIfNeeded()
//		}, completion: nil)
		checkoutCollection?.scrollTo(indexPath.item)
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		return array.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuBarCellId", for: indexPath) as! MenuCell
		//cell.iconView.image = UIImage(named: array[indexPath.item])?.withRenderingMode(.alwaysTemplate)
		cell.iconView.text = array[indexPath.item]
		if self.frame.width > 500
		{
			cell.iconImageView.image = imageArray[indexPath.item]
		}
		(UIApplication.shared.keyWindow?.rootViewController as? TabBarController)?.navTitle.title = titlesArray[indexPath.item]
		cell.tick.alpha = cell.ticked.contains(indexPath.item) ? 0.5 : 0.15
//		cell.iconView.font = R.font.FontAwesomeOfSize(pointSize: 20)
		//let myMutableString = NSMutableAttributedString(string: "\(indexPath.item+1).", attributes: [:])
		//myMutableString.append(NSAttributedString(string: array[indexPath.item], attributes: [NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 20)]))
		//cell.iconView.attributedText = myMutableString
		
		cell.tintColor = R.color.YumaRed
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
	{
		return 0
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
	{
		if #available(iOS 11.0, *)
		{
			return CGSize(width: (frame.width - safeAreaInsets.left - safeAreaInsets.right) / CGFloat(array.count), height: frame.height)
		}
		else
		{
			return CGSize(width: (frame.width - 0 - 0) / CGFloat(array.count), height: frame.height)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
