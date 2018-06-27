//
//  CustomerOrdersVC.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-13.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit
//import SwiftDataTables


class CustomerOrdersVC: UIViewController, UIScrollViewDelegate
{
	@IBOutlet weak var navBar: UINavigationBar!
	@IBOutlet weak var navTitle: UINavigationItem!
	@IBOutlet weak var navClose: UIBarButtonItem!
	@IBOutlet weak var navHelp: UIBarButtonItem!
	@IBOutlet weak var mainStack: UIStackView!
	@IBOutlet weak var errorView: UIView!
	@IBOutlet weak var errorMessage: UILabel!
	@IBOutlet weak var scrollView: UIScrollView!
	//	@IBOutlet weak var insertHere: UIStackView!
	let store = DataStore.sharedInstance
	var creditSlips: Bool = false
	let scrollView2: UIScrollView = {
		let v = UIScrollView()
		v.translatesAutoresizingMaskIntoConstraints = false
		v.backgroundColor = .cyan
//		v.shadowColor = UIColor.darkGray
//		v.shadowOffset = .zero
//		v.shadowRadius = 5
//		//v.shadowOpacity = 1
		return v
	}()
	var built: UIView!


	override func viewDidLoad()
	{
		super.viewDidLoad()
		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
		navHelp.title = FontAwesome.questionCircle.rawValue
		navHelp.setTitleTextAttributes([NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)], for: .normal)
		navHelp.setTitleTextAttributes([
			NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)
			], for: UIControlState.highlighted)
		setupGestureRecognizer()
		if creditSlips
		{
			doCreditSlips()
		}
		else
		{
			doOrderHistory()
		}
	}
	

//	override func viewDidLayoutSubviews()
//	{
//		super.viewDidLayoutSubviews()
////		let top = topLayoutGuide.length
////		let bottom = bottomLayoutGuide.length
////		self.mainStackView.frame = CGRect(x: 0, y: top, width: view.frame.width, height: view.frame.height - top - bottom).insetBy(dx: 10, dy: 10)
////		DispatchQueue.main.async()
////		{
////
////			self.scrollView.frame =  self.view.bounds
////			self.scrollView.contentSize = CGSize(width: self.view.bounds.width, height: self.segmentedControl.frame.origin.y + self.segmentedControl.frame.height + 50)
////		}
////		print(scrollView.contentSize)
//	}


	func doCreditSlips()
	{
		navTitle.title = R.string.CreditSlips
//		getOrderDetails()
		if false && store.orders.count > 0
		{
			if errorView != nil && errorView.superview != nil
			{
				errorView.superview?.removeFromSuperview()
				//errorView.superview?.layoutIfNeeded()
			}
			drawCSTable()
		}
		else
		{
			if errorView != nil && errorView.superview != nil
			{
				errorMessage.text = R.string.noCreditSlips
			}
			myAlertDialog(self, title: R.string.empty, message: R.string.tryAgain, cancelTitle: R.string.cancel.uppercased(), cancelAction: nil, okTitle: R.string.tryAgain.uppercased(), okAction: {
			}) {
			}
//			DispatchQueue.main.async
//			{
//				let alert = UIAlertController(title: R.string.empty, message: R.string.tryAgain, preferredStyle: .alert)
//				let coloredBG = 				UIView()
//				let blurFx = 					UIBlurEffect(style: .dark)
//				let blurFxView = 				UIVisualEffectView(effect: blurFx)
//				alert.titleAttributes = 		[NSAttributedString.StringAttribute(key: .foregroundColor, value: R.color.YumaRed)]
//				alert.messageAttributes = 		[NSAttributedString.StringAttribute(key: .foregroundColor, value: UIColor.darkGray)]
//				alert.view.superview?.backgroundColor = R.color.YumaRed
//				alert.view.shadowColor = 		R.color.YumaDRed
//				alert.view.shadowOffset = 		.zero
//				alert.view.shadowRadius = 		5
//				alert.view.shadowOpacity = 		1
//				alert.view.backgroundColor = 	R.color.YumaYel
//				alert.view.cornerRadius = 		15
//				coloredBG.backgroundColor = 	R.color.YumaRed
//				coloredBG.alpha = 				0.3
//				coloredBG.frame = 				self.view.bounds
//				self.view.addSubview(coloredBG)
//				blurFxView.frame = 				self.view.bounds
//				blurFxView.alpha = 				0.5
//				blurFxView.autoresizingMask = 	[.flexibleWidth, .flexibleHeight]
//				self.view.addSubview(blurFxView)
//				alert.addAction(UIAlertAction(title: R.string.cancel.uppercased(), style: .default, handler: { (action) in
//					coloredBG.removeFromSuperview()
//					blurFxView.removeFromSuperview()
//				}))
//				alert.addAction(UIAlertAction(title: R.string.tryAgain.uppercased(), style: .destructive, handler: { (action) in
////						print("delete item:\(self.addresses[self.pageControl.currentPage].alias),\(self.store.formatAddress(self.addresses[self.pageControl.currentPage]))")
//					coloredBG.removeFromSuperview()
//					blurFxView.removeFromSuperview()
////						self.addresses[self.pageControl.currentPage].deleted = "1"
////						//write address update via api
////						self.collectionView.reloadData()
//				}))
//				self.present(alert, animated: true, completion:
//					{
//				})
//			}
		}
	}
	
	
	func drawCSTable()
	{
//		let myTable = MakeTable(/*frame: CGRect(x: tableStack.frame.origin.x, y: tableStack.frame.origin.y, width: tableStack.frame.width, height: tableStack.frame.height)*/)//frame: CGRect(x: 5, y: 100, width: 500, height: 200))
		let myData = store.orders
		let myTableStructure =
			MyTable(caption: R.string.orderHistoryTop,
					captionGap: 		10,
					captionAttributes: 	[NSAttributedStringKey.foregroundColor : UIColor.darkGray,
											NSAttributedStringKey.font : UIFont.systemFont(ofSize: 13)],
					columnSpacing: 		10,
					headerRowGap: 		15,
					headerAttributes: 	[NSAttributedStringKey.foregroundColor : UIColor.black,
										   NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12)],
					dataRowSpacing: 	10,
					dataRowAttributes: 	[NSAttributedStringKey.font : UIFont.systemFont(ofSize: 11)],
					columns: 			[
						MyTableColumn(key: 				"reference",
									  headerText: 		"\(R.string.order) \(R.string.ref)",
							headerAttributes: nil,
							dataLinkTo: 		#selector(self.rowDetails(_:)),
							dataReplaceWith: 	nil,
							dataAttributes: 	[NSAttributedStringKey.foregroundColor : UIColor.darkGray],
							calculate: 	{ 	(str) -> String in return str 	}
						),
						MyTableColumn(key: 				"date_add",
									  headerText: 		R.string.date,
									  headerAttributes: nil,
									  dataLinkTo: 		#selector(self.rowDetails(_:)),
									  dataReplaceWith: 	nil,
									  dataAttributes: 	[NSAttributedStringKey.foregroundColor : UIColor.darkGray],
									  calculate:		{ 	(str) in
										let df = DateFormatter()
										df.locale = Locale(identifier: self.store.locale)
										df.dateFormat = "dd MMM YYYY"
										if let date = df.date(from: str)
										{
											return "\(df.string(from: date))"
										}
										return str
						}),
						MyTableColumn(key: 				"total_paid",
									  headerText: 		R.string.tPrice,
									  headerAttributes: nil,
									  dataLinkTo: 		#selector(self.rowDetails(_:)),
									  dataReplaceWith: 	nil,
									  dataAttributes: 	[NSAttributedStringKey.foregroundColor : UIColor.darkGray],
									  calculate:		{ 	(str) in
										if let currency = Double(str)
										{
											return self.store.formatCurrency(amount: NSNumber(value: currency), iso: self.store.locale)
										}
										return str
						}),//total_paid_tax_excl
						MyTableColumn(key: 				"payment",
									  headerText: 		R.string.payment,
									  headerAttributes: nil,
									  dataLinkTo: 		#selector(self.rowDetails(_:)),
									  dataReplaceWith: 	nil,
									  dataAttributes: 	[NSAttributedStringKey.foregroundColor : UIColor.darkGray],
									  calculate: 		{ 	(str) -> String in return str 	}),
						MyTableColumn(key: 				"current_state",
									  headerText: 		R.string.status,
									  headerAttributes: nil,
									  dataLinkTo: 		#selector(self.rowDetails(_:)),
									  dataReplaceWith: 	nil,
									  dataAttributes: 	[NSAttributedStringKey.foregroundColor : UIColor.darkGray],
									  calculate: 		{ 	(str) -> String in return str 	}),
						MyTableColumn(key: 				"invoice_number",
									  headerText: 		R.string.inv,
									  headerAttributes: nil,
									  dataLinkTo: 		#selector(self.rowDetails(_:)),
									  dataReplaceWith: 	nil,
									  dataAttributes: 	[NSAttributedStringKey.foregroundColor : UIColor.darkGray],
									  calculate: 		{ 	(str) -> String in return str 	}),
						MyTableColumn(key: 				nil,
									  headerText: 		nil,
									  headerAttributes: nil,
									  dataLinkTo: 		#selector(self.rowDetails(_:)), dataReplaceWith: R.string.details,
									  dataAttributes: 	[NSAttributedStringKey.foregroundColor : R.color.YumaRed],
									  calculate: 		{ 	(str) -> String in return str 	}),
						MyTableColumn(key: 				nil,
									  headerText: 		nil,
									  headerAttributes: nil,
									  dataLinkTo: 		#selector(self.rowReorder(_:)),
									  dataReplaceWith: 	R.string.reorder,
									  dataAttributes: 	[NSAttributedStringKey.foregroundColor : R.color.YumaRed],
									  calculate: 		{ 	(str) -> String in return str 	}),
						]
		)
		//self.view.addSubview(myTable.buildView())
		//		print("x:\(tableStack.frame.origin.x), y:\(tableStack.frame.origin.y), w:\(tableStack.frame.width), h:\(tableStack.frame.height)")
//		let built = myTable.buildView()
		built = MakeTable(frame: .zero, structure: myTableStructure, data: myData)
//		//built.sizeToFit()
//		//built.translatesAutoresizingMaskIntoConstraints = false
//		print("built(frame)-x:\(built.frame.origin.x), y:\(built.frame.origin.y), w:\(built.frame.width), h:\(built.frame.height)")
//		print("built(bounds)-x:\(built.bounds.origin.x), y:\(built.bounds.origin.y), w:\(built.bounds.width), h:\(built.bounds.height)")
		//			let built = myTable
		//		let stack = UIStackView()
		//		stack.translatesAutoresizingMaskIntoConstraints = false
		//		stack.addArrangedSubview(built)
		//		scrollView.addSubview(stack)
		//insertHere.addArrangedSubview(built)
		scrollView.addSubview(built)
		//		scrollView.contentSize.width = built.frame.width
		//		mainStack.insertArrangedSubview(built, at: 0)
		let gap = mainStack.subviews[0] as UIView
		print("gap-x:\(gap.frame.origin.x), y:\(gap.frame.origin.y), w:\(gap.frame.width), h:\(gap.frame.height)")
		let button = mainStack.subviews[2] as UIView
		print("button-x:\(button.frame.origin.x), y:\(button.frame.origin.y), w:\(button.frame.width), h:\(button.frame.height)")
		//	x:0.0, y:0.0, w:814.0, h:5.0
		print("scrollView-x:\(scrollView.frame.origin.x), y:\(scrollView.frame.origin.y), w:\(scrollView.frame.width), h:\(scrollView.frame.height)")
		//	x:0.0, y:81.0, w:814.0, h:10.0
		print("mainStack-x:\(mainStack.frame.origin.x), y:\(mainStack.frame.origin.y), w:\(mainStack.frame.width), h:\(mainStack.frame.height)")
		//	mainStack.subviews[1] x:0.0, y:10.0, w:87.0, h:30.0
		//	mainStack.subviews[0] x:0.0, y:0.0, w:814.0, h:5.0
		//insertHere.translatesAutoresizingMaskIntoConstraints = false
		//self.tableStack.addArrangedSubview(built)
		//print("x:\(tableStack.frame.origin.x), y:\(tableStack.frame.origin.y), w:\(tableStack.frame.width), h:\(tableStack.frame.height)")
		//tableStack.superview?.addSubview(built)
		NSLayoutConstraint.activate([
			built.topAnchor.constraint(equalTo: scrollView.topAnchor),
			built.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
			built.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
			built.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
			
			//	built.topAnchor.constraint(equalTo: gap.topAnchor, constant: 100),
			//	built.leadingAnchor.constraint(equalTo: gap.leadingAnchor, constant: 100),
			//built.bottomAnchor.constraint(equalTo: insertHere.bottomAnchor, constant: ),
			//built.trailingAnchor.constraint(equalTo: insertHere.trailingAnchor, constant: ),
			
			//			built.topAnchor.constraint(equalTo: (tableStack.superview?.topAnchor)!),
			//			built.leadingAnchor.constraint(equalTo: (tableStack.superview?.leadingAnchor)!),
			//			built.bottomAnchor.constraint(equalTo: (tableStack.superview?.bottomAnchor)!),
			//			built.trailingAnchor.constraint(equalTo: (tableStack.superview?.trailingAnchor)!),
			
			//			built.topAnchor.constraint(equalTo: insertHere.topAnchor),
			//			built.leadingAnchor.constraint(equalTo: insertHere.leadingAnchor),
			//			built.bottomAnchor.constraint(equalTo: insertHere.bottomAnchor),
			//			built.trailingAnchor.constraint(equalTo: insertHere.trailingAnchor),
			
			//			stack.topAnchor.constraint(equalTo: scrollView.topAnchor),
			//			stack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
			//			stack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
			//			stack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
			])
		//		self.tableStack.layoutIfNeeded()
		//		tableStack.superview?.constraints.forEach({ (constraint) in
		//			if constraint.firstAnchor == NSLayoutAnchor.constraint(heightAnchor
		//			{
		//				constraint.isActive = false
		//			}
		//		})
		//		tableStack.superview?.constraints.first { $0.firstAnchor == heightAnchor }?.isActive = false
		//		tableStack.superview?.removeConstraint(NSLayoutConstraint(item: <#T##Any#>, attribute: <#T##NSLayoutAttribute#>, relatedBy: <#T##NSLayoutRelation#>, toItem: <#T##Any?#>, attribute: <#T##NSLayoutAttribute#>, multiplier: <#T##CGFloat#>, constant: <#T##CGFloat#>))
		//.heightAnchor.constraint(equalToConstant: built.frame.height).isActive = true
	}

	
	func doOrderHistory()
	{
		navTitle.title = R.string.OrdHist
		getOrderDetails()
		if store.orders.count > 0
		{
			//			errorView.isHidden = true
			if errorView != nil && errorView.superview != nil
			{
				errorView.superview?.removeFromSuperview()
			}
			//			self.view.layoutIfNeeded()
			if errorView != nil && errorView.superview != nil
			{
				//errorView.superview?.layoutIfNeeded()
			}
			//			if insertHere != nil
			//			{
			drawOHTable()
			//			}
		}
		else
		{
			if errorView != nil && errorView.superview != nil
			{
				errorMessage.text = R.string.noOrderHist
			}
			myAlertDialog(self, title: R.string.empty, message: R.string.tryAgain, cancelTitle: R.string.cancel.uppercased(), cancelAction: nil, okTitle: R.string.tryAgain.uppercased(), okAction: {
			}) {
			}
//			DispatchQueue.main.async
//			{
//				let alert = UIAlertController(title: R.string.empty, message: R.string.tryAgain, preferredStyle: .alert)
//				let coloredBG = 				UIView()
//				let blurFx = 					UIBlurEffect(style: .dark)
//				let blurFxView = 				UIVisualEffectView(effect: blurFx)
//				alert.titleAttributes = 		[NSAttributedString.StringAttribute(key: .foregroundColor, value: R.color.YumaRed)]
//				alert.messageAttributes = 		[NSAttributedString.StringAttribute(key: .foregroundColor, value: UIColor.darkGray)]
//				alert.view.superview?.backgroundColor = R.color.YumaRed
//				alert.view.shadowColor = 		R.color.YumaDRed
//				alert.view.shadowOffset = 		.zero
//				alert.view.shadowRadius = 		5
//				alert.view.shadowOpacity = 		1
//				alert.view.backgroundColor = 	R.color.YumaYel
//				alert.view.cornerRadius = 		15
//				coloredBG.backgroundColor = 	R.color.YumaRed
//				coloredBG.alpha = 				0.3
//				coloredBG.frame = 				self.view.bounds
//				self.view.addSubview(coloredBG)
//				blurFxView.frame = 				self.view.bounds
//				blurFxView.alpha = 				0.5
//				blurFxView.autoresizingMask = 	[.flexibleWidth, .flexibleHeight]
//				self.view.addSubview(blurFxView)
//				alert.addAction(UIAlertAction(title: R.string.cancel.uppercased(), style: .default, handler: { (action) in
//					coloredBG.removeFromSuperview()
//					blurFxView.removeFromSuperview()
//				}))
//				alert.addAction(UIAlertAction(title: R.string.tryAgain.uppercased(), style: .destructive, handler: { (action) in
//					//						print("delete item:\(self.addresses[self.pageControl.currentPage].alias),\(self.store.formatAddress(self.addresses[self.pageControl.currentPage]))")
//					coloredBG.removeFromSuperview()
//					blurFxView.removeFromSuperview()
//					//						self.addresses[self.pageControl.currentPage].deleted = "1"
//					//						//write address update via api
//					//						self.collectionView.reloadData()
//				}))
//				self.present(alert, animated: true, completion:
//					{
//				})
//			}
		}
		
		let inputField = InputField()
		scrollView.addSubview(inputField)
//		view.addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: inputField)
//		view.addConstraintsWithFormat(format: "V:|-10-[v0]-10-|", views: inputField)
		scrollView.addConstraint(NSLayoutConstraint(item: inputField, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1, constant: 0))
		scrollView.addConstraint(NSLayoutConstraint(item: inputField, attribute: .left, relatedBy: .equal, toItem: scrollView, attribute: .left, multiplier: 1, constant: 0))
		scrollView.addConstraint(NSLayoutConstraint(item: inputField, attribute: .right, relatedBy: .equal, toItem: scrollView, attribute: .right, multiplier: 1, constant: 0))
		scrollView.addConstraint(NSLayoutConstraint(item: inputField, attribute: .height, relatedBy: .equal, toItem: scrollView, attribute: .height, multiplier: 1, constant: 0))
		view.layoutIfNeeded()
//		NSLayoutConstraint.activate([
//			inputField.topAnchor.constraint(equalTo: scrollView.topAnchor),
//			inputField.leftAnchor.constraint(equalTo: mainStack.leftAnchor),
//			inputField.rightAnchor.constraint(equalTo: mainStack.rightAnchor),
//			inputField.bottomAnchor.constraint(equalTo: mainStack.bottomAnchor),
//			])
	}
	
	
	func drawOHTable()
	{
//		let myTable = MakeTable(/*frame: CGRect(x: tableStack.frame.origin.x, y: tableStack.frame.origin.y, width: tableStack.frame.width, height: tableStack.frame.height)*/)//frame: CGRect(x: 5, y: 100, width: 500, height: 200))
		let myTableData = store.orders
		let myTableStructure =
			MyTable(caption: R.string.orderHistoryTop,
					captionGap: 		10,
					captionAttributes: 	[NSAttributedStringKey.foregroundColor : UIColor.darkGray,
										NSAttributedStringKey.font : UIFont.systemFont(ofSize: 13)],
					columnSpacing: 		10,
					headerRowGap: 		15,
					headerAttributes: 	[NSAttributedStringKey.foregroundColor : UIColor.black,
										   NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12)],
					dataRowSpacing: 	10,
					dataRowAttributes: 	[NSAttributedStringKey.font : UIFont.systemFont(ofSize: 11)],
					columns: 			[
						MyTableColumn(key: 				"reference",
									  headerText: 		"\(R.string.order) \(R.string.ref)",
									  headerAttributes: nil,
									  dataLinkTo: 		#selector(self.rowDetails(_:)),
									  dataReplaceWith: 	nil,
									  dataAttributes: 	[NSAttributedStringKey.foregroundColor : UIColor.darkGray],
									  calculate: 	{ 	(str) -> String in return str 	}
						),
						MyTableColumn(key: 				"date_add",
									  headerText: 		R.string.date,
									  headerAttributes: nil,
									  dataLinkTo: 		#selector(self.rowDetails(_:)),
									  dataReplaceWith: 	nil,
									  dataAttributes: 	[NSAttributedStringKey.foregroundColor : UIColor.darkGray],
									  calculate:		{ 	(str) in
											let df = DateFormatter()
											df.locale = Locale(identifier: self.store.locale)
											df.dateFormat = "dd MMM YYYY"
											if let date = df.date(from: str)
											{
												return "\(df.string(from: date))"
											}
											return str
										}),
						MyTableColumn(key: 				"total_paid",
									  headerText: 		R.string.tPrice,
									  headerAttributes: nil,
									  dataLinkTo: 		#selector(self.rowDetails(_:)),
									  dataReplaceWith: 	nil,
									  dataAttributes: 	[NSAttributedStringKey.foregroundColor : UIColor.darkGray],
									  calculate:		{ 	(str) in
											if let currency = Double(str)
											{
												return self.store.formatCurrency(amount: NSNumber(value: currency), iso: self.store.locale)
											}
											return str
									}),//total_paid_tax_excl
						MyTableColumn(key: 				"payment",
									  headerText: 		R.string.payment,
									  headerAttributes: nil,
									  dataLinkTo: 		#selector(self.rowDetails(_:)),
									  dataReplaceWith: 	nil,
									  dataAttributes: 	[NSAttributedStringKey.foregroundColor : UIColor.darkGray],
									  calculate: 		{ 	(str) -> String in return str 	}),
						MyTableColumn(key: 				"current_state",
									  headerText: 		R.string.status,
									  headerAttributes: nil,
									  dataLinkTo: 		#selector(self.rowDetails(_:)),
									  dataReplaceWith: 	nil,
									  dataAttributes: 	[NSAttributedStringKey.foregroundColor : UIColor.darkGray],
									  calculate: 		{ 	(str) -> String in return str 	}),
						MyTableColumn(key: 				"invoice_number",
									  headerText: 		R.string.inv,
									  headerAttributes: nil,
									  dataLinkTo: 		#selector(self.rowDetails(_:)),
									  dataReplaceWith: 	nil,
									  dataAttributes: 	[NSAttributedStringKey.foregroundColor : UIColor.darkGray],
									  calculate: 		{ 	(str) -> String in return str 	}),
						MyTableColumn(key: 				nil,
									  headerText: 		nil,
									  headerAttributes: nil,
									  dataLinkTo: 		#selector(self.rowDetails(_:)), dataReplaceWith: R.string.details,
									  dataAttributes: 	[NSAttributedStringKey.foregroundColor : R.color.YumaRed],
									  calculate: 		{ 	(str) -> String in return str 	}),
						MyTableColumn(key: 				nil,
									  headerText: 		nil,
									  headerAttributes: nil,
									  dataLinkTo: 		#selector(self.rowReorder(_:)),
									  dataReplaceWith: 	R.string.reorder,
									  dataAttributes: 	[NSAttributedStringKey.foregroundColor : R.color.YumaRed],
									  calculate: 		{ 	(str) -> String in return str 	}),
				]
		)
		//self.view.addSubview(myTable.buildView())
//		print("x:\(tableStack.frame.origin.x), y:\(tableStack.frame.origin.y), w:\(tableStack.frame.width), h:\(tableStack.frame.height)")
//		let sv = UIScrollView()
//		sv.translatesAutoresizingMaskIntoConstraints = false
//		myTable.returnTable()
//		let built = myTable//.returnTable()//buildView()
		built = MakeTable(frame: .zero, structure: myTableStructure, data: myTableData)
		built.translatesAutoresizingMaskIntoConstraints = false
		//built.sizeToFit()
		//built.translatesAutoresizingMaskIntoConstraints = false
//		print("built(frame)-x:\(built.frame.origin.x), y:\(built.frame.origin.y), w:\(built.frame.width), h:\(built.frame.height)")
		print("built(bounds)-x:\(built.bounds.origin.x), y:\(built.bounds.origin.y), w:\(built.bounds.width), h:\(built.bounds.height)")
		//			let built = myTable
//		let stack = UIStackView()
//		stack.translatesAutoresizingMaskIntoConstraints = false
//		stack.addArrangedSubview(built)
		//scrollView.addSubview(stack)
		scrollView.delegate = self
		scrollView.minimumZoomScale = 0.1
		scrollView.maximumZoomScale = 4.0
		scrollView.zoomScale = 1.0
//		scrollView2.addSubview(built)
		scrollView.contentSize = built.bounds.size
		scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		scrollView.addSubview(built)
		scrollView.addConstraintsWithFormat(format: "H:|-5-[v0]-5-|", views: built)
		scrollView.addConstraintsWithFormat(format: "V:|-5-[v0]-5-|", views: built)
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		mainStack.addConstraintsWithFormat(format: "H:|-5-[v0]-5-|", views: scrollView)
		mainStack.addConstraintsWithFormat(format: "V:|-20-[v0]-20-|", views: scrollView)
//		scrollView2.contentSize = CGSize(width: built.frame.width, height: built.frame.height)
//		built.leadingAnchor.constraint(equalTo: scrollView2.leadingAnchor).isActive = true
//		built.topAnchor.constraint(equalTo: scrollView2.topAnchor).isActive = true
//		built.widthAnchor.constraint(equalTo: scrollView2.widthAnchor).isActive = true
//		built.heightAnchor.constraint(equalTo: scrollView2.heightAnchor).isActive = true
//		mainStack.heightAnchor.constraint(equalTo: scrollView2.heightAnchor, constant: 10).isActive = true
//		mainStack.addSubview(scrollView2)
//		NSLayoutConstraint.activate([
//			scrollView2.leftAnchor.constraint(equalTo: mainStack.leftAnchor, constant: 0),
//			scrollView2.topAnchor.constraint(equalTo: mainStack.topAnchor, constant: 5),
//			scrollView2.rightAnchor.constraint(equalTo: mainStack.rightAnchor, constant: 0),
//			scrollView2.bottomAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: 5),
//			])
		//insertHere.addArrangedSubview(built)
		//mainStack.addSubview(built)
//		mainStack.translatesAutoresizingMaskIntoConstraints = false
		//scrollView.translatesAutoresizingMaskIntoConstraints = false
//		sv.addSubview(built)
//		mainStack.addArrangedSubview(sv)
//		mainStack.addConstraintsWithFormat(format: "H:|-10-[v0]", views: sv)
//		mainStack.addConstraintsWithFormat(format: "V:|-10-[v0]", views: sv)
//		mainStack.addConstraint(NSLayoutConstraint(item: built, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1, constant: 10))
//		mainStack.addConstraint(NSLayoutConstraint(item: built, attribute: .left, relatedBy: .equal, toItem: scrollView, attribute: .left, multiplier: 1, constant: 10))
//		view.addConstraint(NSLayoutConstraint(item: built, attribute: .height, relatedBy: .equal, toItem: scrollView, attribute: .height, multiplier: 1, constant: 0))
//		view.addConstraint(NSLayoutConstraint(item: built, attribute: .top, relatedBy: .equal, toItem: mainStack, attribute: .top, multiplier: 1, constant: 10))
//		view.addConstraint(NSLayoutConstraint(item: built, attribute: .left, relatedBy: .equal, toItem: mainStack, attribute: .left, multiplier: 1, constant: 10))
//		sv.layoutIfNeeded()
//		built.layoutIfNeeded()
//		mainStack.layoutIfNeeded()
//		view.layoutIfNeeded()
//		scrollView.contentSize.width = built.frame.width
//		mainStack.insertArrangedSubview(built, at: 0)
		print("mainStack-x:\(mainStack.frame.origin.x), y:\(mainStack.frame.origin.y), w:\(mainStack.frame.width), h:\(mainStack.frame.height)")
		//	mainStack.subviews[1] x:0.0, y:10.0, w:87.0, h:30.0
		//	mainStack.subviews[0] x:0.0, y:0.0, w:814.0, h:5.0
		let gap = mainStack.subviews[0] as UIView
		print("gap-x:\(gap.frame.origin.x), y:\(gap.frame.origin.y), w:\(gap.frame.width), h:\(gap.frame.height)")
		print("error-x:\(errorView.frame.origin.x), y:\(errorView.frame.origin.y), w:\(errorView.frame.width), h:\(errorView.frame.height)")
		print("scrollView-x:\(scrollView.frame.origin.x), y:\(scrollView.frame.origin.y), w:\(scrollView.frame.width), h:\(scrollView.frame.height)")
		//	x:0.0, y:81.0, w:814.0, h:10.0
		let button = mainStack.subviews[2] as UIView
		print("button-x:\(button.frame.origin.x), y:\(button.frame.origin.y), w:\(button.frame.width), h:\(button.frame.height)")
		//	x:0.0, y:0.0, w:814.0, h:5.0
		//insertHere.translatesAutoresizingMaskIntoConstraints = false
		//self.tableStack.addArrangedSubview(built)
		//print("x:\(tableStack.frame.origin.x), y:\(tableStack.frame.origin.y), w:\(tableStack.frame.width), h:\(tableStack.frame.height)")
		//tableStack.superview?.addSubview(built)
//		NSLayoutConstraint.activate([
//			built.topAnchor.constraint(equalTo: scrollView.topAnchor),
//			built.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//			built.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//			built.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//
//		//	built.topAnchor.constraint(equalTo: gap.topAnchor, constant: 100),
//		//	built.leadingAnchor.constraint(equalTo: gap.leadingAnchor, constant: 100),
//			//built.bottomAnchor.constraint(equalTo: insertHere.bottomAnchor, constant: ),
//			//built.trailingAnchor.constraint(equalTo: insertHere.trailingAnchor, constant: ),
//
////			built.topAnchor.constraint(equalTo: (tableStack.superview?.topAnchor)!),
////			built.leadingAnchor.constraint(equalTo: (tableStack.superview?.leadingAnchor)!),
////			built.bottomAnchor.constraint(equalTo: (tableStack.superview?.bottomAnchor)!),
////			built.trailingAnchor.constraint(equalTo: (tableStack.superview?.trailingAnchor)!),
//
////			built.topAnchor.constraint(equalTo: insertHere.topAnchor),
////			built.leadingAnchor.constraint(equalTo: insertHere.leadingAnchor),
////			built.bottomAnchor.constraint(equalTo: insertHere.bottomAnchor),
////			built.trailingAnchor.constraint(equalTo: insertHere.trailingAnchor),
//
////			stack.topAnchor.constraint(equalTo: scrollView.topAnchor),
////			stack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
////			stack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
////			stack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//		])
//		self.tableStack.layoutIfNeeded()
//		tableStack.superview?.constraints.forEach({ (constraint) in
//			if constraint.firstAnchor == NSLayoutAnchor.constraint(heightAnchor
//			{
//				constraint.isActive = false
//			}
//		})
//		tableStack.superview?.constraints.first { $0.firstAnchor == heightAnchor }?.isActive = false
//		tableStack.superview?.removeConstraint(NSLayoutConstraint(item: <#T##Any#>, attribute: <#T##NSLayoutAttribute#>, relatedBy: <#T##NSLayoutRelation#>, toItem: <#T##Any?#>, attribute: <#T##NSLayoutAttribute#>, multiplier: <#T##CGFloat#>, constant: <#T##CGFloat#>))
		//.heightAnchor.constraint(equalToConstant: built.frame.height).isActive = true
	}
	
	
	func getOrderDetails()
	{
		if store.customer != nil && store.orderDetails.count < 1
		{
			var i = 0
			for order in store.orders
			{
				let id_order = Int(order.id!)
				let ord = UserDefaults.standard.string(forKey: "Order\(id_order)Details")
				if ord == nil || ord == ""
					//		if UserDefaults.standard.string(forKey: "OrdersCustomer\(id_customer)") == ""
				{	//perform http get
					store.getOrderDetails(id_order: id_order)
					{
						(orders, err) in
						
						if err != nil
						{
							print(err!)
							return
						}
						if let orders = orders
						{
							let array = (orders as? OrderDetails)?.orderDetails
							for member in array!
							{
								self.store.orderDetails.append(member)
							}
							//let ords = ord?.count
							print("got api details for order \(id_order)")
						}
					}
				}
				else
				{
					//decode json string "ord"
					let tempStr: String = store.trimJSONValueToArray(string: ord!)
					let tempObj: [OrderDetail]
					do
					{
						tempObj = try JSONDecoder().decode([OrderDetail].self, from: tempStr.data(using: .utf8)!)
//						for ords in tempObj
//						{
							store.orderDetails.append(tempObj[0])//ords)
//						}
					}
					catch let jsonErr
					{
						print(jsonErr)
					}
					print("decoding details for order \(id_order)")
				}
				i += 1
			}
			//print("got details for \(i) orders")
		}
	}


	func viewForZooming(in scrollView: UIScrollView) -> UIView?
	{
		return built
	}


	func setupGestureRecognizer()
	{
		let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(recognizer:)))
		doubleTap.numberOfTapsRequired = 2
		scrollView.addGestureRecognizer(doubleTap)
	}


	@objc func handleDoubleTap(recognizer: UITapGestureRecognizer)
	{
		if (scrollView.zoomScale > scrollView.minimumZoomScale)
		{
			scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
		}
		else
		{
			scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
		}
	}


	//https://stackoverflow.com/questions/24844681/list-of-classs-properties-in-swift
//	static func getKeysAndTypes(forObject:Any?) -> Dictionary<String,String>
//	{
//		var answer:Dictionary<String,String> = [:]
//		var counts = UInt32();
//		let properties = class_copyPropertyList(object_getClass(forObject), &counts);
//		for i in 0..<counts {
//			let property = properties?.advanced(by: Int(i)).pointee;
//
//			let cName = property_getName(property!);
//			let name = String(cString: cName)
//
//			let cAttr = property_getAttributes(property!)!
//			let attr = String(cString:cAttr).components(separatedBy: ",")[0].replacingOccurrences(of: "T", with: "");
//			answer[name] = attr;
//			print("ID: \(property.unsafelyUnwrapped.debugDescription): Name \(name), Attr: \(attr)")
//		}
//		return answer;
//	}
	
	
	@objc func rowDetails(_ sender: UITapGestureRecognizer)
	{
		print(sender)
		if store.orderDetails.count > 1
		{
			//
		}
		else
		{
			myAlertDialog(self, title: R.string.no_data, message: "", cancelTitle: nil, cancelAction: nil, okTitle: nil, okAction: {
			}) {
			}
//			DispatchQueue.main.async
//				{
//					let alert = UIAlertController(title: R.string.no_data, message: nil, preferredStyle: .alert)
//					let coloredBG = 				UIView()
//					let blurFx = 					UIBlurEffect(style: .dark)
//					let blurFxView = 				UIVisualEffectView(effect: blurFx)
//					alert.titleAttributes = 		[NSAttributedString.StringAttribute(key: .foregroundColor, value: R.color.YumaRed)]
//					alert.messageAttributes = 		[NSAttributedString.StringAttribute(key: .foregroundColor, value: UIColor.darkGray)]
//					alert.view.superview?.backgroundColor = R.color.YumaRed
//					alert.view.shadowColor = 		R.color.YumaDRed
//					alert.view.shadowOffset = 		.zero
//					alert.view.shadowRadius = 		5
//					alert.view.shadowOpacity = 		1
//					alert.view.backgroundColor = 	R.color.YumaYel
//					alert.view.cornerRadius = 		15
//					coloredBG.backgroundColor = 	R.color.YumaRed
//					coloredBG.alpha = 				0.3
//					coloredBG.frame = 				self.view.bounds
//					self.view.addSubview(coloredBG)
//					blurFxView.frame = 				self.view.bounds
//					blurFxView.alpha = 				0.5
//					blurFxView.autoresizingMask = 	[.flexibleWidth, .flexibleHeight]
//					self.view.addSubview(blurFxView)
//					alert.addAction(UIAlertAction(title: R.string.cancel.uppercased(), style: .default, handler: { (action) in
//						coloredBG.removeFromSuperview()
//						blurFxView.removeFromSuperview()
//					}))
////					alert.addAction(UIAlertAction(title: R.string.delete.uppercased(), style: .destructive, handler: { (action) in
////						print("delete item:\(self.addresses[self.pageControl.currentPage].alias),\(self.store.formatAddress(self.addresses[self.pageControl.currentPage]))")
////						coloredBG.removeFromSuperview()
////						blurFxView.removeFromSuperview()
////						self.addresses[self.pageControl.currentPage].deleted = "1"
////						//write address update via api
////						self.collectionView.reloadData()
////					}))
//					self.present(alert, animated: true, completion:
//						{
//					})
//			}
//			store.Alert(fromView: self, title: R.string.no_data, titleColor: R.color.YumaRed, /*titleBackgroundColor: <#T##UIColor?#>, titleFont: <#T##UIFont?#>,*/ message: nil, /*messageColor: <#T##UIColor?#>, messageBackgroundColor: <#T##UIColor?#>, messageFont: <#T##UIFont?#>,*/ dialogBackgroundColor: R.color.YumaYel, backgroundBackgroundColor: R.color.YumaRed, /*backgroundBlurStyle: <#T##UIBlurEffectStyle?#>, backgroundBlurFactor: <#T##CGFloat?#>,*/ borderColor: R.color.YumaDRed, borderWidth: 1, /*cornerRadius: <#T##CGFloat?#>,*/ shadowColor: R.color.YumaDRed, /*shadowOffset: <#T##CGSize?#>, shadowOpacity: <#T##Float?#>, shadowRadius: <#T##CGFloat?#>, alpha: <#T##CGFloat?#>,*/ hasButton1: true, button1Title: R.string.cancel/*, button1Style: <#T##UIAlertActionStyle?#>, button1Color: <#T##UIColor?#>, button1Font: <#T##UIFont?#>, button1Action: <#T##DataStore.Closure_Void?##DataStore.Closure_Void?##() -> Void#>, hasButton2: <#T##Bool#>, button2Title: <#T##String?#>, button2Style: <#T##UIAlertActionStyle?#>, button2Color: <#T##UIColor?#>, button2Font: <#T##UIFont?#>, button2Action: <#T##DataStore.Closure_Void?##DataStore.Closure_Void?##() -> Void#>*/)
		}
	}
	
	@objc func rowReorder(_ sender: UITapGestureRecognizer)
	{
		myAlertDialog(self, title: R.string.order, message: "", cancelTitle: nil, cancelAction: nil, okTitle: R.string.delete.uppercased(), okAction: {
		}) {
		}
//		DispatchQueue.main.async
//			{
//				let alert = UIAlertController(title: R.string.order, message: nil, preferredStyle: .alert)
//				let coloredBG = 				UIView()
//				let blurFx = 					UIBlurEffect(style: .dark)
//				let blurFxView = 				UIVisualEffectView(effect: blurFx)
//				alert.titleAttributes = 		[NSAttributedString.StringAttribute(key: .foregroundColor, value: R.color.YumaRed)]
//				alert.messageAttributes = 		[NSAttributedString.StringAttribute(key: .foregroundColor, value: UIColor.darkGray)]
//				alert.view.superview?.backgroundColor = R.color.YumaRed
//				alert.view.shadowColor = 		R.color.YumaDRed
//				alert.view.shadowOffset = 		.zero
//				alert.view.shadowRadius = 		5
//				alert.view.shadowOpacity = 		1
//				alert.view.backgroundColor = 	R.color.YumaYel
//				alert.view.cornerRadius = 		15
//				coloredBG.backgroundColor = 	R.color.YumaRed
//				coloredBG.alpha = 				0.3
//				coloredBG.frame = 				self.view.bounds
//				self.view.addSubview(coloredBG)
//				blurFxView.frame = 				self.view.bounds
//				blurFxView.alpha = 				0.5
//				blurFxView.autoresizingMask = 	[.flexibleWidth, .flexibleHeight]
//				self.view.addSubview(blurFxView)
//				alert.addAction(UIAlertAction(title: R.string.cancel.uppercased(), style: .default, handler: { (action) in
//					coloredBG.removeFromSuperview()
//					blurFxView.removeFromSuperview()
//				}))
//				//					alert.addAction(UIAlertAction(title: R.string.delete.uppercased(), style: .destructive, handler: { (action) in
//				//						print("delete item:\(self.addresses[self.pageControl.currentPage].alias),\(self.store.formatAddress(self.addresses[self.pageControl.currentPage]))")
//				//						coloredBG.removeFromSuperview()
//				//						blurFxView.removeFromSuperview()
//				//						self.addresses[self.pageControl.currentPage].deleted = "1"
//				//						//write address update via api
//				//						self.collectionView.reloadData()
//				//					}))
//				self.present(alert, animated: true, completion:
//					{
//				})
//		}
	}
	

	@IBAction func tempDetailsAct(_ sender: Any)
	{
		let vc = UIStoryboard(name: "CustomerOrders", bundle: nil).instantiateViewController(withIdentifier: "OrderDetailsViewController") as! OrderDetailsViewController
		if store.orders.count > 0
		{
			vc.order = store.orders[0]
			if store.orderDetails.count > 0
			{
				vc.details = store.orderDetails[0]
			}
		}
		self.present(vc, animated: false, completion: nil)
	}
	@IBAction func navCloseAct(_ sender: Any)
	{
		self.dismiss(animated: false, completion: nil)
	}
	@IBAction func navHelpAct(_ sender: Any)
	{
		let viewC = Assistance()
		if creditSlips
		{
			viewC.array = R.array.help_my_account_credit_slips_guide
		}
		else
		{
			viewC.array = R.array.help_my_account_order_history_guide
		}
		viewC.title = "\(R.string.OrdHist.capitalized) \(R.string.help.capitalized)"
		viewC.modalTransitionStyle = .crossDissolve
		viewC.modalPresentationStyle = .overCurrentContext
		self.present(viewC, animated: true, completion: nil)
	}
	
}

