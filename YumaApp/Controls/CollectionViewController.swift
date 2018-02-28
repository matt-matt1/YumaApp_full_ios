//
//  CollectionViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-12.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


private let productReuseIdentifier = "Cell"


class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout
{
	var myProducts: [myProduct] = [
		myProduct(id: 1, name: "Hello", imageName: "sdf", price: "$23.00", desc: ""),
		myProduct(id: 2, name: "Again", imageName: "sdf", price: "$42.00", desc: ""),
		myProduct(id: 3, name: "Pkl", imageName: "sdf", price: "$1.00", desc: "")
	]
	
	
    override func viewDidLoad()
	{
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

		//collectionView?.backgroundColor = .white
		collectionView?.isPagingEnabled = true
        self.collectionView!.register(ProductViewCell.self, forCellWithReuseIdentifier: productReuseIdentifier)
    }

    override func didReceiveMemoryWarning()
	{
        super.didReceiveMemoryWarning()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int
	{
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
        return myProducts.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productReuseIdentifier, for: indexPath) as! ProductViewCell
		cell.backgroundColor = indexPath.item % 2 == 0 ? .red : .green
		let page = myProducts[indexPath.item]
		cell.page = page
//		cell.prodImage = UIImageView(image: UIImage(named: page.imageName))
//		cell.prodName.text = page.name
//		cell.prodPrice.text = page.price
        return cell
    }
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
	{
		return 0
	}
	
	// MARK: UICollectionViewDelegateFlowLayout
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
	{
		return CGSize(width: view.frame.width, height: view.frame.height)
	}

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
