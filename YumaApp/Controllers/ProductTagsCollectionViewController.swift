//
//  ProductTagsCollectionViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-07-27.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


private let reuseIdentifier = "ProductTagsCell"


class ProductTagsCollectionViewController: UIViewController
{
//	let cellId = "prodDetails"
	var collectionView: UICollectionView =
	{
		let layout = UICollectionViewFlowLayout()
		//		layout.scrollDirection = .horizontal
		layout.minimumLineSpacing = 10
		let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.red
		//		view.isPagingEnabled = true
		return view
	}()


	override func viewDidLoad()
	{
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView.register(ProductTagsCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension ProductTagsCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
	// MARK: UICollectionViewDataSource
	func numberOfSections(in collectionView: UICollectionView) -> Int
	{
		return 1
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		return 10
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProductTagsCollectionViewCell
		return cell
	}
	////


	// MARK: UICollectionViewDelegate
	
	/*
	// Uncomment this method to specify if the specified item should be highlighted during tracking
	override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
	return true
	}
	*/
	
	/*
	// Uncomment this method to specify if the specified item should be selected
	override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
	return true
	}
	*/
	
	/*
	// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
	override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
	return false
	}
	
	override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
	return false
	}
	
	override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
	
	}
	*/
	
}
