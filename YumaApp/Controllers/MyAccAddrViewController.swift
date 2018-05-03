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
		/*
Unable to simultaneously satisfy constraints.
Probably at least one of the constraints in the following list is one you don't want.
Try this:
(1) look at each constraint and try to figure out which you don't expect;
(2) find the code that added the unwanted constraint or constraints and fix it.
(
"<NSLayoutConstraint:0x16d1ff80 V:|-(0)-[UIStackView:0x18199b50]   (Names: '|':UIView:0x16e9ddf0 )>",
"<NSLayoutConstraint:0x16db2650 UIView:0x16e9ddf0.top == UIView:0x16ed6830.topMargin>",
"<NSLayoutConstraint:0x16db2680 UINavigationBar:0x16d14490.top == UIView:0x16ed6830.top + 20>",
"<NSLayoutConstraint:0x16edc880 'UISV-canvas-connection' UIStackView:0x18199b50.top == UINavigationBar:0x16d14490.top>"
)

Will attempt to recover by breaking constraint
<NSLayoutConstraint:0x16edc880 'UISV-canvas-connection' UIStackView:0x18199b50.top == UINavigationBar:0x16d14490.top>
*/
//		if #available(iOS 11.0, *)
//		{
//			navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//		}
//		else
//		{
//			navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
//		}
		getAddress()
		pageControl.numberOfPages = addresses.count
		pageControl.currentPage = 0
		collectionView?.isPagingEnabled = true
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		collectionView.collectionViewLayout = layout
		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)	//navigation
		navTitle.title = "\(R.string.my_account) \(R.string.Addr)"
		navHelp.title = FontAwesome.questionCircle.rawValue
		navHelp.setTitleTextAttributes([NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)], for: .normal)
		buttonLeft.setTitle(R.string.edit.uppercased(), for: .normal)
		buttonLeft.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		buttonRight.setTitle(R.string.delete.uppercased(), for: .normal)
		buttonRight.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
	}
	
	
	override func viewDidAppear(_ animated: Bool)
	{
		super.viewDidAppear(animated)
		collectionView.reloadData()
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
					(addresses, error) in
					
					if error != nil
					{
						print(error!)
					}
					else
					{
						for addresses in (addresses?.addresses!)!
						{
							self.addresses.append(addresses)
						}
						UIViewController.removeSpinner(spinner: loading)
						//print(self.addresses)
					}
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
		let vc = UIStoryboard(name: "AddrStoryboard", bundle: nil).instantiateViewController(withIdentifier: "AddressExpandedViewController") as! AddressExpandedViewController
		vc.address = self.addresses[pageControl.currentPage]
		present(vc, animated: false, completion: nil)
	}
	@IBAction func buttonRightAct(_ sender: Any)
	{
		DispatchQueue.main.async
			{
				let alert = UIAlertController(title: R.string.rusure, message: "\(R.string.delete) \"\(self.addresses[self.pageControl.currentPage].alias)\"", preferredStyle: .alert)
				let coloredBG = 				UIView()
				let blurFx = 					UIBlurEffect(style: .dark)
				let blurFxView = 				UIVisualEffectView(effect: blurFx)
				alert.titleAttributes = 		[NSAttributedString.StringAttribute(key: .foregroundColor, value: R.color.YumaRed)]
				alert.messageAttributes = 		[NSAttributedString.StringAttribute(key: .foregroundColor, value: UIColor.darkGray)]
				alert.view.superview?.backgroundColor = R.color.YumaRed
				alert.view.shadowColor = 		R.color.YumaDRed
				alert.view.shadowOffset = 		.zero
				alert.view.shadowRadius = 		5
				alert.view.shadowOpacity = 		1
				alert.view.backgroundColor = 	R.color.YumaYel
				alert.view.cornerRadius = 		15
				coloredBG.backgroundColor = 	R.color.YumaRed
				coloredBG.alpha = 				0.3
				coloredBG.frame = 				self.view.bounds
				self.view.addSubview(coloredBG)
				blurFxView.frame = 				self.view.bounds
				blurFxView.alpha = 				0.5
				blurFxView.autoresizingMask = 	[.flexibleWidth, .flexibleHeight]
				self.view.addSubview(blurFxView)
				alert.addAction(UIAlertAction(title: R.string.cancel.uppercased(), style: .default, handler: { (action) in
					coloredBG.removeFromSuperview()
					blurFxView.removeFromSuperview()
				}))
				alert.addAction(UIAlertAction(title: R.string.delete.uppercased(), style: .destructive, handler: { (action) in
					//print("delete item:\(self.addresses[self.pageControl.currentPage].alias),\(self.store.formatAddress(self.addresses[self.pageControl.currentPage]))")
					coloredBG.removeFromSuperview()
					blurFxView.removeFromSuperview()
					self.addresses[self.pageControl.currentPage].deleted = "1"
					self.collectionView.reloadData()
					var edited = self.addresses[self.pageControl.currentPage]
					print("address was deleted \(edited.deleted ?? "")")
					edited.deleted = "1"
//					let encoder = JSONEncoder()
//					encoder.outputFormatting = .prettyPrinted
//					let data = try? encoder.encode(edited)
//					print(String(data: data!, encoding: .utf8)!)
					let str = PSWebServices.object2psxml(object: edited, resource: "addresses", resource2: "address", excludeId: false)
//					let str = PSWebServices.objectToXML(object: edited, head: "<?xml version=\"1.0\" encoding=\"UTF-8\"?>", wrapperHead: "<prestashop xmlns:xlink=\"http://www.w3.org/1999/xlink\"><addresses>", wrapperTail: "</addresses></prestashop>")
					PSWebServices.postAddress(XMLStr: str)
					{
						(error) in
						if let error = error
						{
							print("fatal error: ", String(error.localizedDescription))
						}
					}
				}))
				self.present(alert, animated: true, completion:
					{
				})
		}
//		store.Alert(fromView: self, title: R.string.rusure, titleColor: R.color.YumaRed, /*titleBackgroundColor: , titleFont: ,*/ message: nil, /*messageColor: , messageBackgroundColor: , messageFont: ,*/ dialogBackgroundColor: R.color.YumaYel, backgroundBackgroundColor: R.color.YumaDRed, /*backgroundBlurStyle: , backgroundBlurFactor: ,*/ borderColor: R.color.YumaDRed, borderWidth: 1, /*cornerRadius: ,*/ shadowColor: R.color.YumaDRed, /*shadowOffset: , shadowOpacity: ,*/ shadowRadius: 5, /*alpha: ,*/ hasButton1: true, button1Title: R.string.delete.uppercased(), /*button1Style: , button1Color: , button1Font: ,*/ button1Action: {
//				self.addresses[self.pageControl.currentPage].deleted = "1"
//				print(R.string.deld)
//			}, hasButton2: true, button2Title: R.string.cancel.uppercased()/*, button2Style: , button2Color: , button2Font: , button2Action: */)
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
//		for i in indexPath.item ..< addresses.count
//		{
		let i = indexPath.item//var i = indexPath.item
//		while i < addresses.count
//		{
//			if addresses[i].deleted == nil || addresses[i].deleted == ""
//			{
				cell.setup(address: addresses[i])
//				break
//			}
//			i += 1
//		}
//		for addr in addresses
//		{
//			if addr.deleted == nil || addr.deleted != ""
//			{
//				cell.setup(address: addr)
//			}
//		}
//		cell.setup(address: addresses[indexPath.item])
		//pageControl.currentPage = indexPath.item
		return cell
	}
	
	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
	{
		pageControl.currentPage = Int(ceil(targetContentOffset.pointee.x / collectionView.frame.width))
	}
	
//	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
//	{
//		return 0
//	}
	
	// MARK: UICollectionViewDelegateFlowLayout
	
//	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//		return 4
//	}
//	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//		return 1
//	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
	{
		//print("collView height was=\(view.frame.height), now=\(view.frame.height/3*2)")
		return CGSize(width: view.frame.width-20, height: /*max(300,*/ view.frame.height/5*3/*-300*//*-220*//*)*/)
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
