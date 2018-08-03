//
//  SwipingControllerCollection.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-01.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


extension SwipingController
{
	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator)
	{
//		if size.height < size.width
//		{
//			buttonsB
//		}
		//super.viewWillTransition(to: size, with: coordinator)
		coordinator.animate(alongsideTransition:
			{
				(_) in
				
				self.collectionView?.collectionViewLayout.invalidateLayout()
				
				if self.pageControl.currentPage == 0
				{
					self.collectionView?.contentOffset = .zero
				}
				else
				{
					let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
					self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
				}
			}
		)
		{
			(_) in
		}
	}
	
//	override func numberOfSections(in collectionView: UICollectionView) -> Int
//	{
//		return 1
//	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return pageContent.count
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
	{
		return 0
	}
	
	@objc /*override*/ func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
	{
		print("collectionView.contentSize.height=\(collectionView.contentSize.height)")
//		print("collectionViewLayout.collectionViewContentSize.height=\(collectionViewLayout.collectionViewContentSize.height)")
		return CGSize(width: view.frame.width, height: view.frame.height)
//		return CGSize(width: view.frame.width/*UICollectionViewFlowLayout.collectionViewWidthWithoutInsets*/, height: /*collectionView.contentSize.height - collectionViewLayout.collectionViewContentSize.height - 1*/view.frame.height)
	}
	
	@objc override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PageCell
		cell.page = pageContent[indexPath.item]
		cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: pageContent[indexPath.item].target))
		return cell
	}

//	var collectionViewWidthWithoutInsets: CGFloat
//	{
//		get
//		{
//			guard let collectionView = self.collectionView else { return 0 }
//			let collectionViewSize = collectionView.bounds.size
//			let widthWithoutInsets = collectionViewSize.width
//				- self.sectionInset.left - self.sectionInset.right
//				- collectionView.contentInset.left - collectionView.contentInset.right
//			return widthWithoutInsets
//		}
//	}

}
