//
//  ProductsCollectionViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-07-26.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit
import AwesomeEnum


class ProductsPreviewController: UIViewController
{
	var tabsBar: TabBarController?
	var stack: UIStackView =
	{
		let lbl = UIStackView()
		return lbl
	}()
	let cellId = "prodColl"
	let headerId = "prodCollHeader"
	let footerId = "prodCollFooter"
	let products: [aProduct] = []
	let headerTitle: UILabel =
	{
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.textAlignment = .center
		lbl.text = R.string.laserPrints
		lbl.textAlignment = .left
		lbl.lineBreakMode = .byWordWrapping
		lbl.numberOfLines = 0
		return lbl
	}()
	let headerTitleShadow: NSShadow =
	{
		let view = NSShadow()
		view.shadowColor = UIColor.gray
		view.shadowOffset = CGSize(width: 2, height: 2)
		view.shadowBlurRadius = 3
		return view
	}()
	let toTopButton: UIButton =
	{
		let view = UIButton()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.setImage(Awesome.solid.arrowCircleUp.asImage(size: 32), for: .normal)
		view.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
		view.setTitle(R.string.gotop, for: .normal)
		view.borderColor = R.color.YumaRed
		view.borderWidth = 2
		view.setTitleColor(R.color.YumaDRed, for: .normal)
		return view
	}()
	var prodsCollection: UICollectionView =
	{
		let layout = DSSCollectionViewFlowLayout()//UICollectionViewFlowLayout()
		layout.minimumLineSpacing = 8
//		layout.estimatedItemSize = CGSize(width: 200, height: 200)
//		layout.placeEqualSpaceAroundAllCells = true
		let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
		view.backgroundColor = UIColor(hex: "dedede")//.lightGray//.white
		view.shadowColor = UIColor.darkGray
		view.shadowOffset = .zero
		view.shadowRadius = 3
		view.shadowOpacity = 0.7
		return view
	}()
	var panelsCollection: UICollectionView =
	{
		let layout = DSSCollectionViewFlowLayout()//UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.minimumLineSpacing = 8
		layout.placeEqualSpaceAroundAllCells = false
		let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
		//		view.translatesAutoresizingMaskIntoConstraintsvarfalse
//		view.backgroundColor = UIColor.lightGray//.white
		view.isPagingEnabled = true
		view.shadowColor = UIColor.darkGray
		view.shadowOffset = .zero
		view.shadowRadius = 3
		view.shadowOpacity = 0.7
		return view
	}()
	let numberCellsPerRow: CGFloat = 2
	/// Amount reduced from the whole width, before divided by numberCellPerRow. Minimum value is 10
	let minCellWidth: CGFloat = 120
	let maxCellWidth: CGFloat = 1000
	let minCellHeight: CGFloat = 200
	let maxCellHeight: CGFloat = 600
	let cellsBottomMargin: CGFloat = 5
	let cellsLeftMargin: CGFloat = 5
	let cellsTopMargin: CGFloat = 5
	let cellsRightMargin: CGFloat = 5
	let cellLeftMargin: CGFloat = 0
	let cellRightMargin: CGFloat = 0	// for every cell
	let store = DataStore.sharedInstance
	let headerCell = ProductsPreviewHeaderCell()
	//	let footerCell = ProvartsPreviewFooterCell()
	var header: UIStackView!
	let headerLbl: UILabel =
	{
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = R.color.YumaRed
		view.text = "\(R.string.prod) \(R.string.list)"
		view.textColor = R.color.YumaYel
		view.textAlignment = .center
		view.layer.masksToBounds = true
		let titleShadow: NSShadow =
		{
			let view = NSShadow()
			view.shadowColor = UIColor.black
			view.shadowOffset = CGSize(width: 1, height: 1)
			return view
		}()
		view.attributedText = NSAttributedString(string: view.text!, attributes: [NSAttributedStringKey.font : UIFont(name: "AvenirNext-Bold", size: 20)!, NSAttributedStringKey.shadow : titleShadow])
		view.font = UIFont(name: "ArialRoundedMTBold", size: 20)
		view.shadowColor = UIColor.black
		view.shadowRadius = 3
		view.shadowOffset = CGSize(width: 1, height: 1)
		view.shadowOpacity = 0.9
		return view
	}()
	var updateLine: UIStackView!
	let leftLbl: UILabel =
	{	//	says updated
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.font = UIFont.systemFont(ofSize: 15)
		lbl.textAlignment = .center
		lbl.text = "Left"
		lbl.backgroundColor = UIColor.red//R.color.YumaRed
		lbl.textColor = UIColor.white
		return lbl
	}()
	let centerLbl: UILabel =
	{	//	holds refresh button
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.font = UIFont.systemFont(ofSize: 21)
		lbl.textAlignment = .center
		lbl.text = "Center"
		lbl.backgroundColor = UIColor.red//R.color.YumaRed
		lbl.textColor = R.color.YumaYel
		return lbl
	}()
	let rightLbl: UILabel =
	{	//	holds the date
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.font = UIFont.systemFont(ofSize: 16)
		lbl.textAlignment = .center
		lbl.text = "Right"
		lbl.backgroundColor = UIColor.red//R.color.YumaRed
		lbl.textColor = UIColor.white
		return lbl
	}()
	var footer: UIStackView!
	let footerLbl: UILabel =
	{
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.font = UIFont.systemFont(ofSize: 21)
		lbl.textAlignment = .center
		lbl.text = "Tap a product for more details"
		lbl.textColor = R.color.YumaYel
		lbl.backgroundColor = R.color.YumaRed
		lbl.shadowColor = UIColor.darkGray
		lbl.shadowOffset = .zero
		lbl.shadowRadius = 1
		lbl.shadowOpacity = 0.2
		return lbl
	}()
	let panelTitles: [String] = [R.string.printers, R.string.laptops, R.string.services, R.string.toners]
	lazy var menuBar: ProductsMenuBar =
		{
			let view = ProductsMenuBar()
			view.translatesAutoresizingMaskIntoConstraints = false
			view.productsController = self
			return view
	}()
	var headerImageView: UIImageView =
	{
		let view = UIImageView()
		view.translatesAutoresizingMaskIntoConstraints = false
//		view.backgroundColor = UIColor.white
		view.contentMode = .top//.scaleAspectFit
		view.clipsToBounds = true
		view.image = UIImage(named: "home-slider-printers")
		return view
	}()
	let headerImageBase: UIView =
	{
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.black
		return view
	}()


	// MARK: Overrides

	override func viewDidLoad()
	{
		super.viewDidLoad()

		view.backgroundColor = UIColor.lightGray
//		print()
		navigationController?.navigationBar.topItem?.title = R.string.printers
		if headerLbl.text == "\(R.string.prod) \(R.string.list)"
		{
			headerLbl.text = R.string.printers
		}
		refresh()
//		if #available(iOS 10.0, *) {
//			collectionView.prefetchDataSource = self
//		}
		prodsCollection.register(ProductsPreviewCell.self, forCellWithReuseIdentifier: cellId)
//		panelsCollection.register(ProductsPanel, forCellWithReuseIdentifier: "")
		prodsCollection.register(UICollectionViewCell.self/*ProductsPreviewHeaderCell.self*/, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
		prodsCollection.register(UICollectionViewCell.self/*ProductsPreviewFooterCell.self*/, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerId)
		toTopButton.addTapGestureRecognizer {
			UIView.animate(withDuration: 0.5, animations: {
				self.prodsCollection.contentOffset.y = 0
			})
			//.scrollToItem(at: IndexPath(item: 0, section: 0), at: UICollectionViewScrollPosition.top, animated: true)
		}
		updateLine = UIStackView(arrangedSubviews: [leftLbl, centerLbl, rightLbl, UIView(frame: .zero)])
		updateLine.distribution = .fillProportionally
		centerLbl.isUserInteractionEnabled = true
		centerLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(refresh)))
//		header = UIStackView(arrangedSubviews: [headerLbl, updateLine])
//		header.axis = .vertical
		header = UIStackView(arrangedSubviews: [/*headerLbl,*/ menuBar])
		header.axis = .vertical
		header.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
		footer = UIStackView(arrangedSubviews: [footerLbl, updateLine])
		footer.axis = .vertical
		prodsCollection.contentInset = UIEdgeInsets(top: 0/*cellsTopMargin*/, left: cellsLeftMargin, bottom: cellsBottomMargin, right: cellsRightMargin)
		(prodsCollection.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset = UIEdgeInsets(top: 0, left: cellLeftMargin, bottom: 0, right: cellRightMargin)
		stack = UIStackView(arrangedSubviews: [header, prodsCollection, footer])
		stack.axis = .vertical
		stack.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(stack)
		NSLayoutConstraint.activate([
			stack.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 0),
			stack.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: 0),
			stack.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor, constant: 0),
			stack.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: 0),
			])
	}
	
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?)
	{
		super.traitCollectionDidChange(previousTraitCollection)
		
		guard let previousTraitCollection = previousTraitCollection, traitCollection.verticalSizeClass != previousTraitCollection.verticalSizeClass ||
			traitCollection.horizontalSizeClass != previousTraitCollection.horizontalSizeClass else {
				return
		}
		if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular
		{
			// iPad portrait and landscape
		}
		if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular
		{
			// iPhone portrait
		}
		if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .compact
		{
			// iPhone landscape
		}
		menuBar.collectionView.collectionViewLayout.invalidateLayout()
//		menuBar.collectionView.reloadData()
//		let selectedIndexPath = menuBar.collectionView.indexPathsForSelectedItems != nil ? menuBar.collectionView.indexPathsForSelectedItems! : [IndexPath(item: 0, section: 0)]
		if let selectedIndex = menuBar.collectionView.indexPathsForSelectedItems?[0].item
		{
//			print("reselected menuBar item: \(selectedIndex).")
			scrollToMenuIndex(selectedIndex)
		}
//		menuBar.horizontalBar.invalidateIntrinsicContentSize()
	}

	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator)
	{
		super.viewWillTransition(to: size, with: coordinator)
		prodsCollection.collectionViewLayout.invalidateLayout()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func scrollViewDidScroll(_ scrollView: UIScrollView)
	{
		guard scrollView != prodsCollection 	else 	{ 	return 	}
		let x = scrollView.contentOffset.x / CGFloat(menuBar.images.count)
		menuBar.horizontalBarLeftConstraint?.constant = x
	}
	
	func scrollToMenuIndex(_ menuIndex: Int)
	{
		let indexPath = NSIndexPath(item: menuIndex, section: 0)
//		panelsCollection.scrollToItem(at: indexPath as IndexPath, at: UICollectionViewScrollPosition.left, animated: true)
		menuBar.collectionView.scrollToItem(at: indexPath as IndexPath, at: UICollectionViewScrollPosition.left, animated: true)
	}
	
	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
	{
		guard scrollView != prodsCollection 	else 	{ 	return 	}
		let indexPath = NSIndexPath(item: Int(targetContentOffset.pointee.x / view.frame.width), section: 0)
		menuBar.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.left)
		headerLbl.text = panelTitles[indexPath.item]
//		refresh(/*nil, {
//			//			self.productPanelCell.collectionView.reloadData()
//			//			UIWindow().rootViewController = self
//		}*/)
	}
	
	func cannotGet()
	{
		myAlertOnlyDismiss(self, title: R.string.err, message: R.string.empty)
	}

	fileprivate func gotProducts()
	{
		OperationQueue.main.addOperation
			{
				self.leftLbl.text = " \(R.string.updated)"
				self.centerLbl.attributedText = Awesome.solid.syncAlt.asAttributedText(fontSize: 16, color: R.color.YumaYel, backgroundColor: UIColor.clear)
				//self.centerLbl.text = FontAwesome.repeat.rawValue
//				self.centerLbl.font = R.font.FontAwesomeOfSize(pointSize: 21)
//				self.rightLbl.font = R.font.FontAwesomeOfSize(pointSize: 21)
				let date = Date()
				let df = DateFormatter()
				df.locale = Locale(identifier: self.store.locale)
				df.dateFormat = "dd MMM yyyy  h:mm:ss a"
				self.rightLbl.text = "\(df.string(from: date)) "
				print("found \(self.store.products.count) products")
				guard self.store.products.count > 0 else
				{
					self.cannotGet()
					return
				}
				self.prodsCollection.delegate = self
				self.prodsCollection.dataSource = self
				self.prodsCollection.reloadData()
		}
	}

	@objc func refresh()//(_ sender: Any)
	{
		if Reachability/*.isInternetAvailable(website: nil, completionHandler: { (_) in
		})*/.isConnectedToNetwork()
		{
			let sv = UIViewController.displaySpinner(onView: self.view)
			leftLbl.text = ""
			centerLbl.text = "\(R.string.updating) ..."
			rightLbl.text = ""
			let completeionFunc: (Any?, Error?) -> Void =
			{
				(products, error) in
				
				UIViewController.removeSpinner(spinner: sv)
				if error == nil
				{
					self.gotProducts()
				}
				else
				{
					myAlertDialog(self, title: R.string.err, message: "\(R.string.no_data) (\(error?.localizedDescription ?? ""))", cancelTitle: R.string.dismiss.uppercased(), cancelAction: {
						self.dismiss(animated: false, completion: nil)
					}, okTitle: R.string.tryAgain.uppercased(), okAction: {
						self.dismiss(animated: false, completion: nil)
						self.refresh()
					}) {
					}
				}
			}
			switch headerLbl.text//navTitle.title
			{
			case R.string.printers?:
				store.callGetPrinters(completion: completeionFunc)
				break
			case R.string.laptops?:
				store.callGetLaptops(completion: completeionFunc)
				break
			case R.string.toners?:
				store.callGetToners(completion: completeionFunc)
				break
			case R.string.services?:
				store.callGetServices(completion: completeionFunc)
				break
			default:
				print("unknown products cat. title")
				completeionFunc(store.products, nil)
			}
		}
		else if store.products.count > 0
		{
			self.gotProducts()
			//try cache
		}
		else
		{
			self.cannotGet()
		}
	}

}



extension ProductsPreviewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout//, UICollectionViewDataSourcePrefetching
{
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		if collectionView == prodsCollection
		{
			return self.store.products.count
		}
		else if collectionView == panelsCollection
		{
			return self.panelTitles.count
		}
		else
		{
			return 0
		}
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
		if collectionView == prodsCollection
		{
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProductsPreviewCell
			cell.btnTapAction = {
				() in
				print("Add to cart button tapped in cell", indexPath)
				// start your edit process here...
			}
			if indexPath.item > -1 && indexPath.item < self.store.products.count
			{
				let prod = self.store.products[indexPath.item]
				cell.fillData(prod)
			}
			return cell
		}
		else if collectionView == panelsCollection
		{
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
			return cell
		}
		else
		{
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
			return cell
		}
	}

	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
	{	//	Apply header / footer cell id
		guard collectionView == prodsCollection 	else 	{ 	return UICollectionReusableView() 	}
		if kind == UICollectionElementKindSectionHeader
		{
			let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
			headerCell.subviews.forEach { (view) in
				view.removeFromSuperview()
			}
			let headerTitleAttrs: [NSAttributedStringKey : Any] =
				[NSAttributedStringKey.font : UIFont(name: "AvenirNext-Bold", size: 36)!,
				 NSAttributedStringKey.shadow : headerTitleShadow,
				 NSAttributedStringKey.strokeColor : R.color.YumaRed,
				 NSAttributedStringKey.foregroundColor : R.color.YumaYel,
				 NSAttributedStringKey.strokeWidth : -3.5
			]
			switch headerLbl.text
			{
			case R.string.printers?:
				headerImageView.image = UIImage(named: "home-slider-printers")
				headerTitle.attributedText = NSAttributedString(string: R.string.laserPrints.uppercased(), attributes: headerTitleAttrs)
				break
			case R.string.laptops?:
				headerImageView.image = UIImage(named: "home-slider-laptops")
				headerTitle.attributedText = NSAttributedString(string: R.string.compLaptops.uppercased(), attributes: headerTitleAttrs)
				break
			case R.string.toners?:
				headerImageView.image = UIImage(named: "home-slider-cartridges")
				headerTitle.text = R.string.qltyCarts
				headerTitle.attributedText = NSAttributedString(string: R.string.qltyCarts.uppercased(), attributes: headerTitleAttrs)
				break
			case R.string.services?:
				headerImageView.image = nil
//				header.addSubview(UIImageView(image: UIImage(named: "")))
				headerTitle.attributedText = NSAttributedString(string: R.string.services.uppercased(), attributes: headerTitleAttrs)
				break
			default:
				print("unknown products cat. title")
			}
			if headerImageView.image != nil
			{
				headerCell.addSubview(headerImageView)
			}
			headerCell.addSubview(headerTitle)
			if headerImageView.image != nil
			{
				NSLayoutConstraint.activate([
					headerImageView.topAnchor.constraint(equalTo: headerCell.topAnchor, constant: 0),
					headerImageView.centerXAnchor.constraint(equalTo: headerCell.centerXAnchor, constant: 0),
					headerImageView.heightAnchor.constraint(equalToConstant: min(view.frame.height / 3, (headerImageView.image != nil ? (headerImageView.image?.size.height)! + cellsTopMargin : 215))),
					])
				let maskLayer = CAGradientLayer()
				maskLayer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: min(view.frame.height / 3, (headerImageView.image != nil ? (headerImageView.image?.size.height)! + cellsTopMargin : 215)))//headerImageView.bounds
				maskLayer.shadowRadius = 15
				maskLayer.shadowPath = CGPath(roundedRect: maskLayer.frame.insetBy(dx: 0, dy: 55), cornerWidth: 0, cornerHeight: 0, transform: nil)
				maskLayer.shadowOpacity = 1
				maskLayer.shadowOffset = CGSize.zero
				maskLayer.shadowColor = UIColor.white.cgColor
				headerImageView.layer.mask = maskLayer
			}
			NSLayoutConstraint.activate([
				headerTitle.leadingAnchor.constraint(equalTo: headerCell.leadingAnchor, constant: view.frame.width * 0.12),
				headerTitle.trailingAnchor.constraint(equalTo: headerCell.trailingAnchor, constant: -view.frame.width * 0.02/*15*/),
//				headerTitle.topAnchor.constraint(equalTo: headerCell.topAnchor, constant: 0),
//				headerTitle.bottomAnchor.constraint(equalTo: headerCell.bottomAnchor, constant: 0),
				headerTitle.centerYAnchor.constraint(equalTo: headerCell.centerYAnchor, constant: 0),
				])
			headerTitle.alpha = 0
			UIView.animate(withDuration: 3.275, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [UIViewAnimationOptions.repeat, .curveEaseOut], animations: {
				self.headerTitle.center.y += headerCell.center.y
				self.headerTitle.alpha = 1
			}) { (_) in
			}
			if headerImageView.image != nil
			{
				headerCell.addSubview(headerImageBase)
				NSLayoutConstraint.activate([
					headerImageBase.bottomAnchor.constraint(equalTo: headerCell.bottomAnchor, constant: 0),
					headerImageBase.heightAnchor.constraint(equalToConstant: 1),
					headerImageBase.leadingAnchor.constraint(equalTo: headerImageView.leadingAnchor, constant: 0),
					headerImageBase.trailingAnchor.constraint(equalTo: headerImageView.trailingAnchor, constant: 0),
					])
			}
			return headerCell
		}
		else
		{
			let footerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath)
			footerCell.addSubview(toTopButton)
			NSLayoutConstraint.activate([
				toTopButton.topAnchor.constraint(equalTo: footerCell.topAnchor, constant: 5),
				toTopButton.leadingAnchor.constraint(equalTo: footerCell.leadingAnchor, constant: 0),
				toTopButton.bottomAnchor.constraint(equalTo: footerCell.bottomAnchor, constant: 0),
				toTopButton.trailingAnchor.constraint(equalTo: footerCell.trailingAnchor, constant: 0),
				])
			return footerCell
		}
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
	{	//	Header size
		switch headerLbl.text//navTitle.title
		{
		case R.string.printers?:
			return CGSize(width: view.frame.width, height: min(view.frame.height / 3, (headerImageView.image != nil ? (headerImageView.image?.size.height)! + cellsTopMargin : 215)))
		case R.string.laptops?:
			return CGSize(width: view.frame.width, height: min(view.frame.height / 3, (headerImageView.image != nil ? (headerImageView.image?.size.height)! + cellsTopMargin : 215)))
		case R.string.toners?:
			return CGSize(width: view.frame.width, height: min(view.frame.height / 3, (headerImageView.image != nil ? (headerImageView.image?.size.height)! + cellsTopMargin : 215)))
		case R.string.services?:
			return CGSize(width: view.frame.width, height: 35)
		default:
			return CGSize(width: view.frame.width, height: min(view.frame.height / 3, (headerImageView.image != nil ? (headerImageView.image?.size.height)! + cellsTopMargin : 215)))
		}
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize
	{	//	Footer size
		return CGSize(width: min(300, view.frame.width), height: 50)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
	{	//	Collection cell's size
		if collectionView == prodsCollection
		{
			var leftX: CGFloat = 0
			var rightX: CGFloat = 0
			if #available(iOS 11.0, *)
			{
				leftX = (UIApplication.shared.keyWindow?.safeAreaInsets.left)!
				rightX = (UIApplication.shared.keyWindow?.safeAreaInsets.right)!
			}
			else
			{
				leftX = 0
				rightX = 0
			}
//			print("leftX=\(leftX), rightX=\(rightX)")
//			let cellWidth = max((view.frame.width / numberCellsPerRow) - (cellsRightMargin * min(1, (numberCellsPerRow - 1))) - cellsLeftMargin, minCellWidth)
			let cellWidth = max(((view.frame.width - leftX - rightX) / numberCellsPerRow) - (cellsRightMargin * min(1, (numberCellsPerRow - 1))) - cellsLeftMargin, minCellWidth)
			return CGSize(width: cellWidth, height: max(minCellHeight, min(cellWidth - cellsTopMargin - cellsBottomMargin, maxCellHeight)) + 93 / UIScreen.main.scale)
		}
		else if collectionView == panelsCollection	// each panel has whole view
		{
			return CGSize(width: view.frame.width, height: view.frame.height)
		}
		else
		{
			return CGSize(width: view.frame.width, height: view.frame.height)
		}
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
	{
		if collectionView == prodsCollection	//	selected a product
		{
			let productDetailsViewController = ProductDetailsViewController()
//			if productDetailsViewController.add2cart.
			if indexPath.item > -1 && indexPath.item < self.store.products.count
			{
				productDetailsViewController.prod = self.store.products[indexPath.item]
			}
			self.present(productDetailsViewController, animated: true, completion: nil)
		}
		else if collectionView == panelsCollection	//	ignore panel
		{
		}
		else
		{
		}
	}

}
