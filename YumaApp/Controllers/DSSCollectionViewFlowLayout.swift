//
//  DSSCollectionViewFlowLayout.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-08-05.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

@objc(DSSCollectionViewFlowLayout)
class DSSCollectionViewFlowLayout: UICollectionViewFlowLayout
{
	// MARK: Public Properties
	var placeEqualSpaceAroundAllCells: Bool = false


	// MARK: Overriden Methods
	override func prepare()
	{
		super.prepare()
		if self.placeEqualSpaceAroundAllCells
		{
			var contentByItems: ldiv_t
			let contentSize: CGSize = self.collectionViewContentSize
			let itemSize = self.itemSize

			if UICollectionViewScrollDirection.vertical == self.scrollDirection
			{
				contentByItems = ldiv_t(quot: Int(contentSize.width), rem: Int(itemSize.width))
			}
			else
			{
				contentByItems = ldiv_t(quot: Int(contentSize.height), rem: Int(itemSize.height))
			}

//			let layoutSpacingValueRaw = CGFloat(contentByItems.rem) / CGFloat(contentByItems.quot + 1)
//			let layoutSpacingValueNum = NSInteger(layoutSpacingValueRaw)
//			let layoutSpacingValue = CGFloat(layoutSpacingValueNum)
			let layoutSpacingValue: CGFloat = CGFloat(NSInteger(CGFloat(contentByItems.rem) / CGFloat(contentByItems.quot + 1)))
			let originalMinimumLineSpacing = self.minimumLineSpacing
			let originalMinimumInteritemSpacing = self.minimumInteritemSpacing
			let originalSectionInset = self.sectionInset

			if ((layoutSpacingValue != originalMinimumLineSpacing) ||
				(layoutSpacingValue != originalMinimumInteritemSpacing) ||
				(layoutSpacingValue != originalSectionInset.left) ||
				(layoutSpacingValue != originalSectionInset.right) ||
				(layoutSpacingValue != originalSectionInset.bottom) ||
				(layoutSpacingValue != originalSectionInset.top))
			{
				let insetsForItem = UIEdgeInsets(top: layoutSpacingValue, left: layoutSpacingValue, bottom: layoutSpacingValue, right: layoutSpacingValue)
				self.minimumLineSpacing = layoutSpacingValue
				self.minimumInteritemSpacing = layoutSpacingValue
				self.sectionInset = insetsForItem
			}
		}
	}
}
