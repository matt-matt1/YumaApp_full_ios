//
//  MyAccAddrViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-15.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


class MyAccAddrViewController: UIViewController
{
	@IBOutlet weak var buttonLeft: GradientButton!
	@IBOutlet weak var buttonRight: GradientButton!
	@IBOutlet weak var navBar: UINavigationBar!
	@IBOutlet weak var navTitle: UINavigationItem!
	@IBOutlet weak var navClose: UIBarButtonItem!
	@IBOutlet weak var navHelp: UIBarButtonItem!
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var pageControl: UIPageControl!
	
	let store = DataStore.sharedInstance
	var cellID = "addrCell"
	var addresses: [Address] = []
	var id_customer = 3
	
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		if #available(iOS 11.0, *) {
			navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		} else {
			navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
		}
		getAddress()
		pageControl.numberOfPages = addresses.count
		pageControl.currentPage = 0
		collectionView?.isPagingEnabled = true
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		collectionView.collectionViewLayout = layout
		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)	//navigation
		navTitle.title = "\(R.string.my_account) \(R.string.Addr)"
		buttonLeft.setTitle(R.string.edit.uppercased(), for: .normal)
		buttonLeft.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		buttonRight.setTitle(R.string.delete.uppercased(), for: .normal)
		buttonRight.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
	}
	
	func getAddress()
	{
		if store.addresses.count < 1
		{
			//			if store.customer.count > 0
			//			{
			//				//id_customer = Int(store.customer[0].id_customer!) ?? 3
			//				id_customer = Int(store.customer[0].id_customer!)!
			//			}
			//			else
			//			{
			//				id_customer = 3
			//			}
			let caStr = UserDefaults.standard.string(forKey: "AddressesCustomer\(store.customer?.id_customer ?? "0")")
			//			let caStr = UserDefaults.standard.string(forKey: "CustomerAddresses")
			if caStr == nil || caStr == ""
			{
				let loading = UIViewController.displaySpinner(onView: self.view)
				//if store.addresses.count == 0
				store.callGetAddresses(id_customer: id_customer)
				{
					(addresses) in
					
					for address in addresses.addresses!
					{
						self.addresses.append(address)
					}
					UIViewController.removeSpinner(spinner: loading)
					//print(self.addresses)
				}
			}
			else
			{
				var decoded: [Address]
				do
				{
					decoded = try JSONDecoder().decode([Address].self, from: (caStr?.data(using: .utf8))!)
					self.addresses = decoded
				}
				catch let jsonErr
				{
					print(jsonErr)
				}
			}
		}
		else
		{
			self.addresses = store.addresses
		}
	}
	
//	override func didReceiveMemoryWarning()
//	{
//		super.didReceiveMemoryWarning()
//	}
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using [segue destinationViewController].
	// Pass the selected object to the new view controller.
	}
	*/
	
	// MARK: UICollectionViewDataSource
	
//	override func numberOfSections(in collectionView: UICollectionView) -> Int
//	{
//		return 1
//	}
	
	
	@IBAction func navCloseAct(_ sender: Any)
	{
		self.dismiss(animated: false, completion: nil)
	}
	@IBAction func navHelpAct(_ sender: Any)
	{
	}
	@IBAction func buttonLeftAct(_ sender: Any)
	{
		self.dismiss(animated: false, completion: nil)
	}
	@IBAction func buttonRightAct(_ sender: Any)
	{
		self.dismiss(animated: false, completion: nil)
	}

	
}

extension MyAccAddrViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
	//UICollectionViewDatasource methods
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		return addresses.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AddrCollectionViewCell
		cell.setup(address: addresses[indexPath.item])
		//pageControl.currentPage = indexPath.item
		return cell
	}
	
	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
	{
		pageControl.currentPage = Int(ceil(targetContentOffset.pointee.x / collectionView.frame.width))
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
	{
		return 0
	}
	
	// MARK: UICollectionViewDelegateFlowLayout
	
//	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//		return 4
//	}
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
	{
		return CGSize(width: view.frame.width-20, height: max(300, view.frame.height-220))
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
