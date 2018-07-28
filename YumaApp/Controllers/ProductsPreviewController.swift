//
//  ProductsCollectionViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-07-26.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


class ProductsPreviewController: UIViewController
{
	var stack: UIStackView =
	{
		let lbl = UIStackView()
		return lbl
	}()
	let cellId = "prodColl"
//	let headerId = "prodCollHeader"
//	let footerId = "prodCollFooter"
	let products: [aProduct] = []
	var collectionView: UICollectionView =
	{
		let layout = UICollectionViewFlowLayout()
//		layout.scrollDirection = .horizontal
		layout.minimumLineSpacing = 8
		let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
//		view.translatesAutoresizingMaskIntoConstraintsvarfalse
		view.backgroundColor = UIColor.lightGray//.white
//		view.isPagingEnabled = true
		view.shadowColor = UIColor.darkGray
		view.shadowOffset = .zero
		view.shadowRadius = 3
		view.shadowOpacity = 0.7
		return view
	}()
	let numberCellsPerRow: CGFloat = 2
	/// Amount reduced from the whole width, before divided by numberCellPerRow. Minimum value is 10
	let verticalDividerWidth: CGFloat = 10
	let minCellWidth: CGFloat = 120
	let maxCellWidth: CGFloat = 1000
	let minCellHeight: CGFloat = 200
	let maxCellHeight: CGFloat = 500
	let store = DataStore.sharedInstance
//	let headerCell = ProductsPreviewHeaderCell()
	//	let footerCell = ProvartsPreviewFooterCell()
	var header: UIStackView =
	{
		let lbl = UIStackView()
		return lbl
	}()
	let headerLbl: UILabel =
	{
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.font = UIFont.boldSystemFont(ofSize: 21)
		lbl.textAlignment = .center
		lbl.text = "\(R.string.prod) \(R.string.list)"
		lbl.textColor = R.color.YumaYel
		lbl.backgroundColor = R.color.YumaRed
		return lbl
	}()
	var headerStack2: UIStackView!
	let leftLbl: UILabel =
	{	//	says updated
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.font = UIFont.systemFont(ofSize: 14)
		lbl.textAlignment = .center
		lbl.text = "Left"
		lbl.backgroundColor = R.color.YumaRed
		return lbl
	}()
	let centerLbl: UILabel =
	{	//	holds refresh button
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.font = UIFont.systemFont(ofSize: 21)
		lbl.textAlignment = .center
		lbl.text = "Center"
		lbl.backgroundColor = R.color.YumaRed
		return lbl
	}()
	let rightLbl: UILabel =
	{	//	holds the date
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.font = UIFont.systemFont(ofSize: 16)
		lbl.textAlignment = .center
		lbl.text = "Right"
		lbl.backgroundColor = R.color.YumaRed
		return lbl
	}()
	let footer: UILabel =
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


	override func viewDidLoad()
	{
		super.viewDidLoad()

		headerLbl.text = R.string.printers
		refresh()
//		if #available(iOS 10.0, *) {
//			collectionView.prefetchDataSource = self
//		}
		collectionView.register(ProductsPreviewCell.self, forCellWithReuseIdentifier: cellId)
//		collectionView.register(ProductsPreviewHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
//		collectionView.register(ProductsPreviewFooterCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerId)
		headerStack2 = UIStackView(arrangedSubviews: [leftLbl, centerLbl, rightLbl, UIView(frame: .zero)])
		headerStack2.distribution = .fillProportionally
		rightLbl.isUserInteractionEnabled = true
		rightLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(refresh)))
		header = UIStackView(arrangedSubviews: [headerLbl, headerStack2])
		header.axis = .vertical
		stack = UIStackView(arrangedSubviews: [header, collectionView, footer])
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
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
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
				self.centerLbl.text = FontAwesome.repeat.rawValue
				self.centerLbl.font = R.font.FontAwesomeOfSize(pointSize: 21)
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
				self.collectionView.delegate = self
				self.collectionView.dataSource = self
		}
	}

	@objc func refresh()//(_ sender: Any)
	{
		if Reachability.isConnectedToNetwork()
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
					myAlertDialog(self, title: R.string.err, message: R.string.no_data, cancelTitle: R.string.dismiss.uppercased(), cancelAction: {
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
//		return 7
		return self.store.products.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProductsPreviewCell
		if indexPath.item > 0 && indexPath.item < self.store.products.count
		{
			let prod = self.store.products[indexPath.item]
			cell.fillData(prod)
		}
		return cell
	}

//	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
//	{	//	Apply header / footer cell id
//		if kind == UICollectionElementKindSectionHeader
//		{
//			let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
//			return header
//		}
//		else
//		{
//			let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath)
//			return footer
//		}
//	}
//
//	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
//	{	//	Header size
//		return CGSize(width: view.frame.width, height: 50)
//	}
//
//	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize
//	{	//	Footer size
//		return CGSize(width: view.frame.width, height: 50)
//	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
	{	//	Collection cell's size
		return CGSize(width: max(((view.frame.width - verticalDividerWidth) / numberCellsPerRow), minCellWidth), height: max(minCellHeight, min(max(((view.frame.width - verticalDividerWidth) / numberCellsPerRow), minCellWidth), maxCellHeight)) + 40)
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
	{
		let productDetailsViewController = ProductDetailsViewController()
		if indexPath.item > 0 && indexPath.item < self.store.products.count
		{
			productDetailsViewController.prod = self.store.products[indexPath.item]
		}
		self.present(productDetailsViewController, animated: true, completion: nil)
	}

	// MARK: UICollectionViewDataSourcePrefetching
	
//	func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath])
//	{
//		for indexPath in indexPaths
//		{
//			let prod = self.store.products[indexPath.row]
////			asyncFetcher.
//		}
//	}
}
