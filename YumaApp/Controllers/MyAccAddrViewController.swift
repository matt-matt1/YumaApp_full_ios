//
//  MyAccAddrViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-15.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"


class MyAccAddrViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout
{
	let store = DataStore.sharedInstance
	var addresses: [Address] = []

	var collView: UICollectionView!
//	var myProducts: [myProduct] = [
//		myProduct(id: 1, name: "Hello", imageName: "sdf", price: "$23.00", desc: ""),
//		myProduct(id: 2, name: "Again", imageName: "sdf", price: "$42.00", desc: ""),
//		myProduct(id: 3, name: "Pkl", imageName: "sdf", price: "$1.00", desc: "")
//	]
//	let alarmCollectionView:UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
//	let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
	
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		// Uncomment the following line to preserve selection between presentations
		// self.clearsSelectionOnViewWillAppear = false
		
		//collectionView?.backgroundColor = .white
		
//		layout.scrollDirection = UICollectionViewScrollDirection.vertical
//		alarmCollectionView.setCollectionViewLayout(layout, animated: true)
//		alarmCollectionView.delegate = self
//		alarmCollectionView.dataSource = self
//		alarmCollectionView.backgroundColor = UIColor.clear
//		//self.addSubview(alarmCollectionView)
		
		let layout = UICollectionViewFlowLayout()
		layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
		layout.itemSize = CGSize(width: 222, height: 411)
		
//		collView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
		collView.delegate   = self
		collView.dataSource = self
		collView.isPagingEnabled = true
		collView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
		collView.backgroundColor = UIColor.white
//		self.view.addSubview(collView)
		
		//collectionView?.isPagingEnabled = true
		//self.collectionView!.register(ProductViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
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
		return addresses.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MyAccAddrCell
		cell.backgroundColor = indexPath.item % 2 == 0 ? .red : .green
		let page = addresses[indexPath.item]
		cell.aliasField.text = page.alias
		cell.addressField.text = R.formatAddress(page)

//		cell.page = page
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


/*
class MyAccAddrViewController: UICollectionView, UICollectionViewDelegateFlowLayout
//UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
	let store = DataStore.sharedInstance
	var addresses: [Address] = []


	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		return store.addresses.count
	}
	
	private func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MyAccAddrCell
		for address in addresses
		{
			cell.aliasField.text = address.alias
			cell.addressField.text = R.formatAddress(address)
		}
		return cell
	}
	
//	/*override */func viewWillAppear(_ animated: Bool)
//	{
//		super.viewWillAppear(animated)
//
//		let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//		layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
//		layout.itemSize = CGSize(width: 60, height: 60)
//
//		let myCollectionView:UICollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
//		myCollectionView.dataSource = self
//		myCollectionView.delegate = self
//		myCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
//		myCollectionView.backgroundColor = UIColor.white
//		self.view.addSubview(myCollectionView)
//	}
	
    override func viewDidLoad()
	{
        super.viewDidLoad()

        addresses = store.addresses[0].addresses
		collectionView?.isPagingEnabled = true
		self.collectionView!.register(ProductViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    /*override */func didReceiveMemoryWarning()
	{
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


class Cell: UICollectionViewCell {
	
	@IBOutlet weak var imageView: UIImageView!
	
	override var bounds: CGRect {
		didSet {
			self.layoutIfNeeded()
		}
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		self.imageView.layer.masksToBounds = true
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		self.setCircularImageView()
	}
	
	func setCircularImageView() {
		self.imageView.layer.cornerRadius = CGFloat(roundf(Float(self.imageView.frame.size.width / 2.0)))
	}
}
*/
