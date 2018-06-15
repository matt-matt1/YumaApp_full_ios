//
//  MyAccOH_Collection.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-06-14.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


extension MyAccOHViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
	func numberOfSections(in collectionView: UICollectionView) -> Int
	{
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		return store.orders.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MyAccOH_Cell
		cell.values(order: store.orders[indexPath.item])
		if self.view.frame.width > 500
		{
			cell.wideScreen = true
		}
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
	{
		let cell = collectionView.cellForItem(at: indexPath)
		UIView.animate(withDuration: 0.12, delay: 0, options: [], animations: {
			cell!.contentView.backgroundColor = .red
		}) { (done) in
			cell?.contentView.backgroundColor = .clear
		}
		store.flexView(view: cell!)
		let vc = UIStoryboard(name: "CustomerOrders", bundle: nil).instantiateViewController(withIdentifier: "OrderDetailsViewController") as! OrderDetailsViewController
		if store.orders.count > 0
		{
			vc.order = store.orders[indexPath.item]
			if store.orderDetails.count > 0
			{
				vc.details = store.orderDetails[indexPath.item]
			}
		}
		self.present(vc, animated: false, completion: nil)
	}
}
