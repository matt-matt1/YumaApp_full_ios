//
//  CheckoutCollection.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-05-02.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class CheckoutCollection: UICollectionViewController, UICollectionViewDelegateFlowLayout
{
	lazy var menuBar: MenuBar =
		{
			let view = MenuBar()
			view.checkoutCollection = self
			return view
		}()
	let array = ["1", "2", "3", "4"]

	
	override func viewDidLoad()
	{
        super.viewDidLoad()
		navigationItem.title = R.string.Chkout
		navigationController?.navigationBar.isTranslucent = false
		setupCollectionView()
		setupMenuBar()
    }
	
	private func setupCollectionView()
	{
		if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
		{
			flowLayout.scrollDirection = .horizontal
		}
		collectionView?.backgroundColor = UIColor.white
		collectionView?.register(CheckoutStepsCell.self, forCellWithReuseIdentifier: "CheckoutCollectionCellId")
		collectionView?.isPagingEnabled = true
		collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
		collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
	}
	
	private func setupMenuBar()
	{
		view.addSubview(menuBar)
		view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
		view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
		menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
//		if #available(iOS 11.0, *)
//		{
//		}
//		else
//		{
//		}
	}
	
	override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
	{
		let iconNum = targetContentOffset.pointee.x / view.frame.width
		let indexPath = NSIndexPath(item: Int(iconNum), section: 0)
		menuBar.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: [])
	}
	
	func scrollTo(_ index: Int)
	{
		let indexPath = NSIndexPath(item: index, section: 0)
		collectionView?.scrollToItem(at: indexPath as IndexPath, at: []/*UICollectionViewScrollPosition.bottom*/, animated: true)
	}
	
	override func scrollViewDidScroll(_ scrollView: UIScrollView)
	{
		menuBar.hbLeft?.constant = scrollView.contentOffset.x / 4
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		return 4
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CheckoutCollectionCellId", for: indexPath) as! CheckoutStepsCell
		cell.label.text = array[indexPath.item]
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
	{
		return CGSize(width: view.frame.width, height: view.frame.height - 50 - 1)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
	{
		return 0
	}
	
}
