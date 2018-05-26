//
//  CheckoutCollection.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-05-02.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class CheckoutCollection: UICollectionViewController, UICollectionViewDelegateFlowLayout
{
	let store = DataStore.sharedInstance
	var customer: Customer?
	static let noteName = Notification.Name("fromCheckoutCollCell")
	var checkoutCollection = self
	lazy var menuBar: MenuBar =
		{
			let view = MenuBar()
			view.checkoutCollection = self
			return view
		}()
	var navBar = UINavigationBar()
	var navClose = UIBarButtonItem()
	var navHelp = UIBarButtonItem()

	
	// MARK: Overrides
	override func viewDidLoad()
	{
        super.viewDidLoad()
		//setupBackground()
		setupNavigation()
		setupCollectionView()
		setupMenuBar()
		getCustomer()
		NotificationCenter.default.addObserver(self, selector: #selector(doAction), name: CheckoutCollection.noteName, object: nil)
    }


	override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
	{
		let iconNum = targetContentOffset.pointee.x / view.frame.width
		let indexPath = NSIndexPath(item: Int(iconNum), section: 0)
		menuBar.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: [])
	}


	override func scrollViewDidScroll(_ scrollView: UIScrollView)
	{
		menuBar.hbLeft?.constant = scrollView.contentOffset.x / 4
	}


	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		return 4
	}


	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CheckoutCollectionCellId", for: indexPath) as! CheckoutStepsCell
		cell.setupContents(indexPath.item/*, vc: self*/)
		return cell
	}


	// MARK: Methods
	private func setupNavigation()
	{
		navBar = (navigationController?.navigationBar)!
		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
		let navBarTop = navBar.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor)
		navBarTop.priority = UILayoutPriority(rawValue: 750)
		//navBarTop.isActive = true
		let navBarTop2 = navBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20)
		navBarTop2.priority = UILayoutPriority(rawValue: 250)
		//navBarTop2.isActive = true
		//navBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
//		navBar.heightAnchor.constraint(equalToConstant: 46).isActive = true
		//navClose = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(doDismiss(_:)))
		navClose = UIBarButtonItem(title: FontAwesome.times.rawValue, style: UIBarButtonItemStyle.done, target: self, action: #selector(doDismiss(_:)))
		navClose.setTitleTextAttributes([NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)], for: .normal)
		navClose.setTitleTextAttributes([
			NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)
			], for: UIControlState.highlighted)
		navHelp = UIBarButtonItem(title: FontAwesome.questionCircle.rawValue, style: UIBarButtonItemStyle.done, target: self, action: #selector(doHelp(_:)))
		navHelp.setTitleTextAttributes([NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)], for: .normal)
		navHelp.setTitleTextAttributes([
			NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)
			], for: UIControlState.highlighted)
		navigationItem.rightBarButtonItems = [navHelp]
		navigationItem.leftBarButtonItems = [navClose]
		navigationItem.title = R.string.Chkout
		//navigationController?.navigationBar.isTranslucent = false
	}

	
	private func getCustomer()
	{
		if store.customer == nil || store.customer?.lastname == ""
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
			let caStr = UserDefaults.standard.string(forKey: "Customer")
			//			let caStr = UserDefaults.standard.string(forKey: "CustomerAddresses")
			//			if caStr == ""
			//			{
			//				let loading = UIViewController.displaySpinner(onView: self.view)
			//				//if store.addresses.count == 0
			//				store.
			//			}
			//			else
			//			{
			var decoded: Customer
			if caStr != nil
			{
				do
				{
					decoded = try JSONDecoder().decode(Customer.self, from: (caStr?.data(using: .utf8))!)
					self.customer = decoded
					store.customer = decoded
				}
				catch let jsonErr
				{
					print(jsonErr)
				}
			}
		}
		else
		{
			self.customer = store.customer
		}
	}


	private func setupCollectionView()
	{
		if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
		{
			flowLayout.scrollDirection = .horizontal
		}
		collectionView?.backgroundColor = UIColor.lightGray//white
		collectionView?.register(CheckoutStepsCell.self, forCellWithReuseIdentifier: "CheckoutCollectionCellId")
		//collectionView?.register(StepsCell.self, forCellWithReuseIdentifier: "StepsCellId")
		collectionView?.isPagingEnabled = true
		collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
		collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
	}


	private func setupMenuBar()
	{
		view.addSubview(menuBar)
		view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
		view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
		menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
//		if #available(iOS 11.0, *)
//		{
//		}
//		else
//		{
//		}
	}


	func scrollTo(_ index: Int)
	{
		let indexPath = NSIndexPath(item: index, section: 0)
		collectionView?.scrollToItem(at: indexPath as IndexPath, at: [], animated: true)
	}


	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
	{
		return CGSize(width: view.frame.width, height: view.frame.height - 50 - 1)
	}


	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
	{
		return 0
	}


	// MARK: Actions
	@objc func doAction(notify: Notification)
	{
		let dest = notify.object as! UIViewController
		self.present(dest, animated: false, completion: nil)
	}

	@objc func doDismiss(_ sender: UITapGestureRecognizer)
	{
		self.dismiss(animated: false, completion: nil)
	}

	@objc func doHelp(_ sender: UITapGestureRecognizer)
	{
		let viewC = Assistance()
		viewC.array = R.array.help_checkout_guide
		viewC.modalTransitionStyle   = .crossDissolve
		viewC.modalPresentationStyle = .overCurrentContext
		self.present(viewC, animated: true, completion: nil)
	}
	
}
