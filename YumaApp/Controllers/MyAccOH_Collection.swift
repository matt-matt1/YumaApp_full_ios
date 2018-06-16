//
//  MyAccOH_Collection.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-06-14.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


extension MyAccOHViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
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

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
	{
		guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
			return .zero
		}
		
		let cellCount = CGFloat(collectionView.numberOfItems(inSection: section))
		
		if cellCount > 0
		{
			let cellWidth = flowLayout.itemSize.width + flowLayout.minimumInteritemSpacing
			
			let totalCellWidth = cellWidth * cellCount
			let contentWidth = collectionView.frame.size.width - collectionView.contentInset.left - collectionView.contentInset.right - flowLayout.headerReferenceSize.width - flowLayout.footerReferenceSize.width
			
			if (totalCellWidth < contentWidth)	// one row?
			{
				let padding = (contentWidth - totalCellWidth + flowLayout.minimumInteritemSpacing) / 2.0
				return UIEdgeInsetsMake(0, padding, 0, padding)
			}
		}
		return minCollEdgeInsets//UIEdgeInsets(top: 20, left: 8, bottom: 20, right: 8)
	}
}
