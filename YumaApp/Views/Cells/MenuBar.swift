//
//  MenuBar.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-05-02.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//
import UIKit


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


	override init(frame: CGRect)
	{
		super.init(frame: frame)
		
		collectionView.register(MenuCell.self, forCellWithReuseIdentifier: "MenuBarCellId")
		addSubview(collectionView)
		if #available(iOS 11.0, *)
		{
			addConstraintsWithFormat(format: "H:|-\(safeAreaInsets.left)-[v0]|", views: collectionView)
		}
		else
		{
			addConstraintsWithFormat(format: "H:|-0-[v0]|", views: collectionView)
		}
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
		addSubview(hb)
		hbLeft = hb.leftAnchor.constraint(equalTo: self.leftAnchor)
		NSLayoutConstraint.activate([
			hb.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			hb.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4),
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
		return 4
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuBarCellId", for: indexPath) as! MenuCell
		//cell.iconView.image = UIImage(named: array[indexPath.item])?.withRenderingMode(.alwaysTemplate)
		cell.iconView.text = array[indexPath.item]
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
			return CGSize(width: (frame.width - safeAreaInsets.left - safeAreaInsets.right) / 4, height: frame.height)
		}
		else
		{
			return CGSize(width: (frame.width - 0 - 0) / 4, height: frame.height)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
