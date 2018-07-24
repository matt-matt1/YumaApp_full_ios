//
//  CustomFlowLayout.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-07-24.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


private let separatorDecorationView = "separator"

class CustomFlowLayout: UICollectionViewFlowLayout
{
	override func awakeFromNib()
	{
		super.awakeFromNib()
		register(SeparatorView.self, forDecorationViewOfKind: separatorDecorationView)
		minimumLineSpacing = 2
	}
	
	override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]?
	{
		let layoutAttributes = super.layoutAttributesForElements(in: rect) ?? []
		let lineWidth = self.minimumLineSpacing
		
		var decorationAttributes: [UICollectionViewLayoutAttributes] = []
		
		// skip first cell
		for layoutAttribute in layoutAttributes where layoutAttribute.indexPath.item > 0
		{
			let separatorAttribute = UICollectionViewLayoutAttributes(forDecorationViewOfKind: separatorDecorationView,
																	  with: layoutAttribute.indexPath)
			let cellFrame = layoutAttribute.frame
			separatorAttribute.frame = CGRect(x: cellFrame.origin.x,
											  y: cellFrame.origin.y - lineWidth,
											  width: cellFrame.size.width,
											  height: lineWidth)
			separatorAttribute.zIndex = Int.max
			decorationAttributes.append(separatorAttribute)
		}
		return layoutAttributes + decorationAttributes
	}

}
