//
//  ProductTags.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-06-16.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


class ProductTagsCollection: UICollectionView
{
	var numberOfCells = 0
	var array: [String] = []
	var coll: UICollectionView!


	init(frame: CGRect, layout: UICollectionViewFlowLayout)
	{
		super.init(frame: frame, collectionViewLayout: layout)
	}
	
	required init?(coder aDecoder: NSCoder)
	{
//		fatalError("init(coder:) has not been implemented")
		super.init(coder: aDecoder)
	}
	
	convenience init(/*numberOfCells: Int,*/ arrayOfStrings: [String])
	{
		self.init(frame: .zero, layout: UICollectionViewFlowLayout())
//		self.numberOfCells = numberOfCells
		self.array = arrayOfStrings
		self.coll = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
		for num in 0 ..< arrayOfStrings.count//numberOfCells
		{
			let cell = ProductLabelCell()
//			let cell = coll.dequeueReusableCell(withReuseIdentifier: "ProdTagCell", for: IndexPath(item: num, section: 0))// as! ProductLabelCell
			cell.makeTag(string: array[num])
			coll.addSubview(cell)
		}
	}
}



class ProductTagsLayout: UICollectionViewFlowLayout
{
	let innerSpace: CGFloat = 1.0
	let numberOfCellsPerRow: CGFloat = 3
	override var itemSize: CGSize
	{
		set
		{
			self.itemSize = CGSize(width:itemWidth(), height:itemWidth())
		}
		get
		{
			return CGSize(width:itemWidth(),height:itemWidth())
		}
	}
	let store = DataStore.sharedInstance


	override init()
	{
		super.init()
		self.scrollDirection = .vertical
		self.minimumLineSpacing = innerSpace
		self.minimumInteritemSpacing = innerSpace
	}

	required init?(coder aDecoder: NSCoder)
	{
//		fatalError("init(coder:) has not been implemented")
		super.init(coder: aDecoder)
	}

	func itemWidth() -> CGFloat
	{
		return (collectionView!.frame.size.width/self.numberOfCellsPerRow) - innerSpace
	}

//	func numberOfItemsInSection(_ section: Int)
//	{
//		return collectionView(collectionView!, numberOfItemsInSection: section)
//	}
//
//
//	func cellForItemAt()
//	{
//
//	}
}


extension ProductTagsCollection: UICollectionViewDelegate, UICollectionViewDataSource
{
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		return numberOfCells
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProdTagCell", for: indexPath) as! ProductLabelCell
		/*let tagView =*/ cell.makeTag(string: array[indexPath.item])
		return cell
	}
	
	//
}


//ProductLabelCell
