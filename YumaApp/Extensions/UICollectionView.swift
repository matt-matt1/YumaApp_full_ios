//
//  UICollectionView.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-06-18.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


extension UICollectionView
{
	func deselectAllItems(animated: Bool = false)
	{
		for indexPath in self.indexPathsForSelectedItems ?? []
		{
			self.deselectItem(at: indexPath, animated: animated)
		}
	}
}
