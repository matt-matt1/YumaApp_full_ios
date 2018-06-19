//
//  ProductsViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-06.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController, UIScrollViewDelegate
{
		//MARK: Files
	//ProductsViewControllerTaps.swift
	//ProductsViewControllerForm.swift
	//ProductsViewControllerMethods.swift
	
		//MARK: Outlets
	@IBOutlet weak var cartScroll: 	UIScrollView!
	@IBOutlet weak var stackLeft: 	UIStackView!
	@IBOutlet weak var scrollView: 	UIScrollView!
	@IBOutlet weak var navBar: 		UINavigationBar!
	@IBOutlet weak var navTitle: 	UINavigationItem!
	@IBOutlet weak var navClose: 	UIBarButtonItem!
	@IBOutlet weak var navHelp: 	UIBarButtonItem!
	@IBOutlet weak var leftLabel: 	UILabel!
	@IBOutlet weak var centerLabel: UILabel!
	@IBOutlet weak var rightLabel: 	UILabel!
	@IBOutlet weak var pageControl: UIPageControl!
	@IBOutlet weak var add2CartBtn: GradientButton!

	@IBOutlet weak var stackRight: 	UIStackView!
	@IBOutlet weak var totalAmt: 	UILabel!
	@IBOutlet weak var totalWt: 	UILabel!
	@IBOutlet weak var totalWtLbl: 	UILabel!
	@IBOutlet weak var totalPcs: 	UILabel!
	@IBOutlet weak var totalPcsLbl: UILabel!
	@IBOutlet weak var chkoutBtn: 	GradientButton!
		//MARK: Properties
	var pageTitle: 			String = 	""
	var pageImage = 					UIImage()
	let store = 						DataStore.sharedInstance

	let cellID = 						"cartCell"
	var latest: 			OrderRow?
	var latestIsUpdate = 				false
	var cartCellHeight: 	CGFloat = 	100
	var cartCellVSpace: 	CGFloat = 	5
	var total: 				Float = 	0
	var pcs: 				Int = 		0
	var wt: 				Float = 	0
	var collectionTags: 	UICollectionView!
	var collectionCats: 	UICollectionView!

	
		//MARK: Override Methods
	override func viewDidLoad()
	{
        super.viewDidLoad()
		store.imageDataCache.removeAllObjects()

		cartScroll.delegate = self
		scrollView.delegate = self
		scrollView.isPagingEnabled = true
		navTitle.title = pageTitle
		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
		add2CartBtn.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		chkoutBtn.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		navClose.title = FontAwesome.close.rawValue
		navClose.setTitleTextAttributes([
			NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)
			], for: UIControlState.normal)
		navClose.setTitleTextAttributes([
			NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)
			], for: UIControlState.highlighted)
		//navClose.tintColor = R.color.YumaYel
		navHelp.title = FontAwesome.questionCircle.rawValue
		navHelp.setTitleTextAttributes([
			NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)
			], for: UIControlState.normal)
		navHelp.setTitleTextAttributes([
			NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)
			], for: UIControlState.highlighted)
		//navHelp.tintColor = R.color.YumaYel
		if UIScreen.main.scale < 2
		{
			let spacer = UIBarButtonItem(title: "|", style: .plain, target: self, action: nil)
			spacer.tintColor = R.color.YumaRed
			spacer.setTitleTextAttributes([
				NSAttributedStringKey.foregroundColor : R.color.YumaRed
				], for: UIControlState.normal)
			spacer.setTitleTextAttributes([
				NSAttributedStringKey.foregroundColor : R.color.YumaRed
				], for: UIControlState.highlighted)
			navTitle.rightBarButtonItems?.append(spacer)
		}
		let cart = UIBarButtonItem(title: FontAwesome.shoppingCart.rawValue, style: .done, target: self, action: #selector(navCartAct(_:)))
		//cart.tintColor = R.color.YumaYel
		cart.setTitleTextAttributes([
			NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)
			], for: UIControlState.normal)
		cart.setTitleTextAttributes([
			NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)
			], for: UIControlState.highlighted)
		navTitle.rightBarButtonItems?.append(cart)
		centerLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(refresh)))
//		if self.view.frame.width > 400
//		{
//			stackRight.widthAnchor.constraint(lessThanOrEqualToConstant: 300).isActive = true
//		}
//		else
//		{
//			stackRight.widthAnchor.constraint(lessThanOrEqualToConstant: 200).isActive = true
//		}
		store.locale = "en_CA"	//configure locale
		if store.customer != nil && store.langs.count > 0
		{
			store.locale = "\(store.langs[Int((store.customer?.idLang)!)].isoCode ?? "")_\(store.countries[store.addresses[0].idCountry!].isoCode ?? "")"//combine lang iso with country iso
		}
//		store.myLang = 0
//		if let tryLang = Int(store.configValue(forKey: "PS_LANG_DEFAULT"))
//		{
//			store.myLang = tryLang
//		}
//		if store.products.count < 1 || store.forceRefresh
//		{
		//DONT NEED TO REFRESH EVERYTIME!
			store.forceRefresh = false
			refresh()	//load products
//		}
/////tableView
		//totalLbl.text = R.string.Total.uppercased()
		totalPcsLbl.text = R.string.pieces
		stackRight.widthAnchor.constraint(equalToConstant: self.view.frame.width * 1/4).isActive = true
		stackRight.layoutIfNeeded()
		stackLeft.layoutIfNeeded()
		cartScroll.layoutIfNeeded()
	}
	
	
	override func viewDidAppear(_ animated: Bool)
	{
		super.viewDidAppear(animated)
		(wt, pcs, totalAmt.text!) = populateCartTotal()
		totalWt.text = String(wt)
		totalPcs.text = String(pcs)
		cartScroll.subviews.forEach({ 	$0.removeFromSuperview() 	})
		if store.myOrderRows.count > 0
		{
			for i in 0..<store.myOrderRows.count
			{
				if store.myOrderRows.count > 1 && !latestIsUpdate
				{
					for scr in self.cartScroll.subviews
					{
						if type(of: scr) == CartCell.self
						{
							scr.frame.origin.y += self.cartCellHeight + (2*cartCellVSpace)
						}
					}
					self.drawCartItem(i)
				}
				else
				{
					if latestIsUpdate
					{
						let cell = self.cartScroll.viewWithTag(Int((latest?.product_id)!)!) as! CartCell
						cell.prodQty.text = latest?.product_quantity
						store.flexView(view: cell) { (done) in
							self.store.flexView(view: cell.prodQty.superview!)
						}
					}
					else
					{
						self.drawCartItem(i)
					}
				}
			}
		}
		if total > 1
		{
			chkoutBtn.alpha = 1
		}
		else
		{
			chkoutBtn.alpha = 0.2
		}
	}


		//MARK: Private Methods
	//ProductsViewControllerMethods.swift
	//ProductsViewControllerForm.swift
		//MARK: Actions
	//ProductsViewControllerTaps.swift
	
}
