//
//  ProductsViewControllerMethods.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-05-09.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


extension ProductsViewController
{
	func populateCartTotal() -> (Float, Int, String)
	{
		total = 0
		pcs = 0
		wt = 0
		for row in store.myOrderRows
		{
			//total += (Double(Int(row.product_quantity!)!) * Double(row.product_price!)!)
			total += (Float(Int(row.product_quantity!)!) * Float(row.product_price!)!)
			pcs += Int(row.product_quantity!)!
			for p in store.products
			{
				if String(p.id) == row.product_id! && p.weight != nil
				{
					wt += p.weight!
					//					let prodWeight = NumberFormatter().number(from: p.weight!)?.doubleValue
					//					if let prodWeight = prodWeight
					//					{
					//						wt += Double(prodWeight)
					//					}
					break
				}
			}
			//			totalWt.text = "\(wt)"
			//		wt = 0
			//		pcs = 0
			//		total = 0
			//		var i = 0
			//		for row in store.myOrderRows
			//		{
			//			total += (Double(Int(row.product_quantity!)!) * Double(row.product_price!)!)
			//			pcs += Int(row.product_quantity!)!
			//			var prod: aProduct?
			//			for p in store.products
			//			{
			//				if String(p.id!) == row.product_id!
			//				{
			//					prod = p
			//				}
			//			}
			//			if prod != nil
			//			{
			//				wt += Double((prod?.weight!)!)!
			//			}
			////			totalWt.text = "\(wt)"
			////////////////////////
			////			total = total + (Double(Int(row.product_quantity!)!) * Double(row.product_price!)!)
			////			pcs = pcs + Int(row.product_quantity!)!
			////			for p in store.products
			////			{
			////				if p.id! == Int(row.product_id!)!
			////				{
			////					wt += (p.weight?.toDouble())!
			////					break
			////				}
			////			}
			//			let prodWeight = NumberFormatter().number(from: store.products[i].weight!)?.doubleValue
			//			if let prodWeight = prodWeight
			//			{
			//				wt = wt + Double(prodWeight)
			//			}
			//			i += 1
		}
		let totalDbl = total as NSNumber
		let totalStr = store.formatCurrency(amount: totalDbl, iso: store.locale)
		return (wt, pcs, totalStr)
	}
	
	func drawCartItem(_ i: Int? = nil)
	{
		print("cart cell width is:\(cartScroll.frame.width)")
		let view = CartCell(frame: CGRect(x: 0, y: cartCellVSpace, width: min(300, cartScroll.frame.width), height: cartCellHeight))
		cartScroll.contentSize.height += cartCellHeight + (2*cartCellVSpace)
		if i != nil
		{
			latest = store.myOrderRows[i!]
		}
		let name = latest?.product_name//thisOrder.productName//prod.name![0].value
		view.prodName.text = name
		view.prodName.lineBreakMode = .byTruncatingHead
		view.tag = Int((latest?.product_id)!)!
		//		if prod.showPrice != "0" && Double(prod.price!)! > 0
		//		{
		//			view.prodPrice.text = prod.price
		//		}
		//		else
		//		{
		//			view.prodPrice.text = R.string.noPrice
		//		}
		view.prodImage.contentMode = UIViewContentMode.scaleAspectFit
		//let allScrollInners = self.scrollView.getAllSubviews() as! [CustomView]
		//let prodView = allScrollInners[pageControl.currentPage]
		//let allImageViews = self.scrollView.subviews[pageControl.currentPage+2].getAllSubviews() as [UIImageView]
		//			let allImageViews = prodView.getAllSubviews() as [UIImageView]
		//view.prodImage.image = allImageViews[0].image
		//while (prod_image == nil) {}	//WAIT UNTIL prod_image IS NOT NIL
		//		if self.prod_image != nil
		//		{
		//			view.prodImage.image = UIImage(data: self.prod_image!)
		//		}
		/*		else*/ if latest?.productImage != nil
		{
			view.prodImage.image = UIImage(data: (latest?.productImage)!)
		}
		//print("prod.quantity=\(prod.quantity)")
		view.prodQty.text = latest?.product_quantity//thisOrder.productQuantity//prod.quantity
		cartScroll.addSubview(view)
		//prod_2
		//		var categoryStr = ""//"\(store.categories[Int(prod.idCategoryDefault)])"
		//		if store.categories.count > 0
		//		{
		//			var catList: [String] = []
		//			for catId in (prod.associations?.categories)!
		//			{
		//				for c in store.categories
		//				{
		//					if c.id == Int(catId.id)
		//					{
		//						let name = c.name![store.myLang].value!
		//						catList.append(name)
		//						categoryStr.append("> \(name) ")
		//					}
		//				}
		//				//categoryStr.append("> \(store.categories[Int(catId.id!)!]) ")
		//			}
		//		}
	}
	
	/////tableView
	func putItemInCart()
	{
		let (wt, pcs, tot) = populateCartTotal()
		totalAmt.text = tot
		totalPcs.text = "\(pcs)"
		if store.products.count > 0
		{
			let date = Date()
			if store.myOrder != nil
			{
				if latest != nil
				{
					store.myOrder?.associations?.order_rows?.append(latest!)	//update stored order
				}
			}
			else															//create a new order
			{
				//store.myOrder = try? Order(from: Decoder.self as! Decoder)
				store.myOrder = Order(id: 0, id_address_delivery: "", id_address_invoice: "", id_cart: "", id_currency: "", id_lang: store.customer?.id_lang, id_customer: store.customer?.id_customer, id_carrier: "", current_state: "", module: "", invoice_number: "", invoice_date: "", delivery_number: "", delivery_date: "", valid: "", date_add: "\(date)", date_upd: "\(date)", shipping_number: "", id_shop_group: "", id_shop: "", secure_key: "", payment: "", recyclable: "", gift: "", gift_message: "", mobile_theme: "", total_discounts: "", total_discounts_tax_incl: "", total_discounts_tax_excl: "", total_paid: "", total_paid_tax_incl: "", total_paid_tax_excl: "", total_paid_real: "", total_products: "\(pcs)", total_products_wt: "\(wt)", total_shipping: "", total_shipping_tax_incl: "", total_shipping_tax_excl: "", carrier_tax_rate: "", total_wrapping: "", total_wrapping_tax_incl: "", total_wrapping_tax_excl: "", round_mode: "", round_type: "", conversion_rate: "", reference: "", associations: OrdersAssociations(order_rows: store.myOrderRows))
				//				store.myOrder = Order(id: 0, idAddressDelivery: "", idAddressInvoice: "", idCart: "", idCurrency: "", idLang: store.customer?.id_lang, idCustomer: store.customer?.id_customer, idCarrier: "", currentState: "", module: "", invoiceNumber: "", invoiceDate: "", deliveryNumber: "", deliveryDate: "", valid: "", dateAdd: "\(date)", dateUpd: "\(date)", shippingNumber: "", idShopGroup: "", idShop: "", secureKey: "", payment: "", recyclable: "", gift: "", giftMessage: "", mobileTheme: "", totalDiscounts: "", totalDiscountsTaxIncl: "", totalDiscountsTaxExcl: "", totalPaid: "", totalPaidTaxIncl: "", totalPaidTaxExcl: "", totalPaidReal: "", totalProducts: "\(pcs)", totalProductsWt: "\(wt)", totalShipping: "", totalShippingTaxIncl: "", totalShippingTaxExcl: "", carrierTaxRate: "", totalWrapping: "", totalWrappingTaxIncl: "", totalWrappingTaxExcl: "", roundMode: "", roundType: "", conversionRate: "", reference: "", associations: Associations_OrderRows(order_rows: store.myOrderRows))
			}
			//print(store.myOrder)
			//print("cartScroll.frame=\(self.cartScroll.frame.width)x\(self.cartScroll.frame.height)")
			//self.cartScroll.contentSize.width = self.cartScroll.frame.width
			if store.myOrderRows.count > 1 && !latestIsUpdate//self.cartScroll.contentSize.height > 104
			{
				UIView.animate(withDuration: 0.5, animations: {
					for scr in self.cartScroll.subviews
					{
						if type(of: scr) == CartCell.self
						{
							scr.frame.origin.y += self.cartCellHeight + (2*self.cartCellVSpace)//10//104
						}
					}
				}) { (done) in
					self.drawCartItem()
				}
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
					self.drawCartItem()
				}
			}
		}
		//		if tableView != nil
		//		{
		//			tableView.beginUpdates()
		//			tableView.reloadData()
		//			tableView.endUpdates()
		//			tableView.layoutIfNeeded()
		//		}
	}
	
	func scrollViewDidScroll(_ scrollView: UIScrollView)
	{
		if scrollView == self.scrollView
		{
			//print("scrollViewDidScroll-self:\(self.view.frame.width), scroll:\(self.scrollView.frame.width), stack:\(self.stackLeft.frame.width), offset:\(scrollView.contentOffset.x)")
			//			pageControl.currentPage = Int(scrollView.contentOffset.x / self.scrollView.frame.width)
			pageControl.currentPage = Int(round(scrollView.contentOffset.x / self.scrollView.frame.width))
		}
	}


	func cannotGet()
	{
		OperationQueue.main.addOperation
			{
				let alert = 					UIAlertController(title: R.string.err, message: R.string.empty, preferredStyle: .alert)
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
				coloredBG.alpha = 				0.4
				coloredBG.frame = 				self.view.bounds
				self.view.addSubview(coloredBG)
				blurFxView.frame = 				self.view.bounds
				blurFxView.alpha = 				0.5
				blurFxView.autoresizingMask = 	[.flexibleWidth, .flexibleHeight]
				self.view.addSubview(blurFxView)
				alert.addAction(UIAlertAction(title: R.string.dismiss.uppercased(), style: .default, handler: { (action) in
					coloredBG.removeFromSuperview()
					blurFxView.removeFromSuperview()
					self.dismiss(animated: false, completion: nil)
				}))
				self.present(alert, animated: true, completion:
					{
				})
		}
	}

	fileprivate func gotProducts()
	{
		//DispatchQueue.main.asyncAfter(deadline: .now() + 30)
		OperationQueue.main.addOperation
			{
				self.leftLabel.text = " \(R.string.updated)"
				self.centerLabel.text = FontAwesome.repeat.rawValue
				self.centerLabel.font = R.font.FontAwesomeOfSize(pointSize: 21)
				let date = Date()
				let df = DateFormatter()
				df.locale = Locale(identifier: self.store.locale)
				df.dateFormat = "dd MMM yyyy  h:mm:ss a"
				self.rightLabel.text = "\(df.string(from: date)) "
				self.pageControl.currentPageIndicatorTintColor = R.color.YumaRed
				self.pageControl.pageIndicatorTintColor = R.color.YumaYel
				self.pageControl.numberOfPages = self.store.products.count
				print("found \(self.store.products.count) products")
				//print(self.store.products)
				if self.store.products.count < 1
				{
					self.cannotGet()
				}
				print("self view width:\(self.view.frame.width), scrollView.width=\(self.scrollView.frame.width)")
				self.scrollView.contentSize.width = self.scrollView.frame.width * CGFloat(self.store.products.count)
				self.insertData()
		}
	}
	
	@objc func refresh()//(_ sender: Any)
	{
		if Reachability.isConnectedToNetwork()
		{
			let sv = UIViewController.displaySpinner(onView: self.view)
			leftLabel.text = ""
			centerLabel.text = "\(R.string.updating) ..."
			rightLabel.text = ""
			pageControl.pageIndicatorTintColor = UIColor.clear
			pageControl.currentPageIndicatorTintColor = .clear
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
					OperationQueue.main.addOperation
						{
							let alert = 					UIAlertController(title: R.string.err, message: R.string.no_data, preferredStyle: .alert)
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
							coloredBG.alpha = 				0.4
							coloredBG.frame = 				self.view.bounds
							self.view.addSubview(coloredBG)
							blurFxView.frame = 				self.view.bounds
							blurFxView.alpha = 				0.5
							blurFxView.autoresizingMask = 	[.flexibleWidth, .flexibleHeight]
							self.view.addSubview(blurFxView)
							alert.addAction(UIAlertAction(title: R.string.dismiss.uppercased(), style: .default, handler: { (action) in
								coloredBG.removeFromSuperview()
								blurFxView.removeFromSuperview()
								self.dismiss(animated: false, completion: nil)
							}))
							alert.addAction(UIAlertAction(title: R.string.tryAgain.uppercased(), style: .default, handler: { (action) in
								coloredBG.removeFromSuperview()
								blurFxView.removeFromSuperview()
								self.dismiss(animated: false, completion: nil)
								self.refresh()
							}))
							self.present(alert, animated: true, completion:
								{
							})
					}
				}
			}
			switch navTitle.title
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
				print("unknown products cat. title(\(navTitle.title ?? "")), bad instantantion of products VC")
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
	
	func insertData()
	{
		var i = 0
		//let id_lang = (store.customer != nil) ? Int((store.customer?.id_lang)!)! : 0
		for prod in store.products
		{
			if prod.active != nil && prod.active!// == "1"
			{
				let view = CustomView(frame: CGRect(x: 10 + (self.scrollView.frame.width * CGFloat(i)), y: 0, width: self.scrollView.frame.width - 20, height: self.scrollView.frame.height))
				print("self:\(self.view.frame.width), scroll:\(self.scrollView.frame.width)")
				//				print("language id:\(id_lang)")
				//view.clipsToBounds = true
				//view.sizeToFit()
				view.prodName.text = store.valueById(object: prod.name!, id: store.myLang)//prod.name![store.myLang].value
				view.prodName.textColor = R.color.YumaRed
				//view.prodName.tag = prod.id!
				view.tag = i
				view.prodId = prod.id
				if prod.showPrice != nil && prod.showPrice! /*!= "0"*/ && prod.price != nil && prod.price! > 0
				{
					//let prodPrice = NumberFormatter().number(from: prod.price!)?.doubleValue
					let prodPrice = prod.price
					view.prodPrice.text = store.formatCurrency(amount: prodPrice! as NSNumber, iso: store.locale)
				}
				else
				{
					view.prodPrice.text = R.string.noPrice
				}
				view.prodImage.contentMode = UIViewContentMode.scaleAspectFit
				//			view.imageFrame.shadowColor = UIColor.gray
				//			view.imageFrame.shadowOffset = CGSize(width: 3, height: 3)
				//			view.imageFrame.shadowRadius = 5
				//			view.imageFrame.shadowOpacity = 1
				if prod.associations?.imageData != nil
				{
					view.prodImage.image = UIImage(data: (prod.associations?.imageData)!)
				}
				else
				{
					let imgName = prod.associations?.images![0].id//primary image
					var imageName = "\(R.string.URLbase)img/p"
					for ch in imgName!
					{
						imageName.append("/\(ch)")
					}
					imageName.append("/\(imgName ?? "").jpg")
					if let imageFromCache = store.imageDataCache.object(forKey: imageName as AnyObject)
					{
						view.prodImage.image = UIImage(data: (imageFromCache as? Data)!)
					}
					else
					{
						store.getImageFromUrl(url: URL(string: imageName)!, session: URLSession(configuration: .default), completion:
							{
								(data, response, error) in
								
								guard let data = data, error == nil else { return }
								DispatchQueue.main.async()
									{
										let i = view.tag - 10
										let imageToCache = UIImage(data: data)
										self.store.imageDataCache.setObject(imageToCache!, forKey: imageName as AnyObject)
										view.prodImage.image = imageToCache
										//view.prodImage.image = UIImage(data: data)
										//self.prod_image = data
										if i < self.store.products.count
										{
											self.store.products[i].associations?.imageData = data
										}
								}
						})
					}
				}
				let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(expandPicture(_:)))
				gestureRecognizer.numberOfTapsRequired = 2
				view.addGestureRecognizer(gestureRecognizer)
				//				view.detailsBtn.text = R.string.details
				//second section
				//			let view2 = CustomView2(frame: CGRect(x: 10 + (self.scrollView.frame.width * CGFloat(i)), y: 0, width: self.scrollView.frame.width - 20, height: self.scrollView.frame.height))
				//			view2.desc.text = prod.description![id_lang].value
				//			view2.desc.isEditable = false
				//			view2.descShort.text = prod.descriptionShort![id_lang].value
				//			view2.descShort.isEditable = false
				//			//let image = store.manufacturers[Int(prod.idManufacturer!)!]
				//			if (prod.associations?.categories)!.count > 0
				//			{
				//				for cat in (prod.associations?.categories)!
				//				{
				//					if let num = Int(cat.id)
				//					{
				//						let myCat = store.categories[num]
				//						let label = UILabel()
				//						label.text = myCat.name![id_lang].value
				//						view2.catsSV.addArrangedSubview(label)
				//					}
				//				}
				//			}
				//			if (prod.associations?.tags)!.count > 0
				//			{
				//				for tag in (prod.associations?.tags)!
				//				{
				//					if let num = Int(tag.id)
				//					{
				//						let myCat = store.tags[num]
				//						let label = UILabel()
				//						label.text = myCat.name
				//						view2.tagsSV.addArrangedSubview(label)
				//					}
				//				}
				//			}
				//			if store.shares.count > 0
				//			{
				//				for share in store.shares
				//				{
				//					if share.thumb != nil && share.link != nil
				//					{
				//						let image = UIImageView()	//append image if has a thumb & link
				//						image.image = UIImage(data: (share.thumb?.data(using: .utf8))!)
				//						image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickShare(_:))))
				//						image.tag = share.id
				//						view2.tagsSV.addArrangedSubview(image)
				//					}
				//					else
				//					{
				//						let label = UILabel()	//otherwise append a name label
				//						label.text = share.name[id_lang].value
				//						label.tag = share.id
				//						view2.tagsSV.addArrangedSubview(label)
				//					}
				//				}
				//			}
				if prod.associations != nil && prod.associations?.categories != nil && (prod.associations?.categories?.count)! > 0
				{
					//let stack = formCategoriesView(categorieIDs: (prod.associations?.categories)!)
					view.categoriesView.addArrangedSubview(formCategoriesView(categorieIDs: (prod.associations?.categories)!))
					view.categoriesView.translatesAutoresizingMaskIntoConstraints = false
					NSLayoutConstraint.activate([
						view.categoriesView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
						view.categoriesView.trailingAnchor.constraint(lessThanOrEqualTo: view.categoriesView.trailingAnchor, constant: 0)
						])
//					view.addConstraintsWithFormat(format: "H:|[v0]", views: view.categoriesView)
//					view.addConstraintsWithFormat(format: "V:[v0]", views: view.categoriesView)
				}
				if prod.associations != nil && prod.associations?.tags != nil && (prod.associations?.tags?.count)! > 0
				{
					//view.tagsView.translatesAutoresizingMaskIntoConstraints = false
					//temp
					let stack = formTagsView(tagIDs: (prod.associations?.tags)!, maxWidth: self.scrollView.frame.width, maxHeight: self.scrollView.frame.height)
					stack.translatesAutoresizingMaskIntoConstraints = false
					//print("stack frame x:\(stack.frame.origin.x), y:\(stack.frame.origin.y), w:\(stack.frame.width), h:\(stack.frame.height)")
					//print("stack bounds x:\(stack.bounds.origin.x), y:\(stack.bounds.origin.y), w:\(stack.bounds.width), h:\(stack.bounds.height)")
					//let scroll = UIScrollView(frame: CGRect(x: 0/*stack.frame.origin.x*/, y: 0/*stack.frame.origin.y*/, width: self.scrollView.frame.width/*stack.frame.width*/, height: self.scrollView.frame.height/*stack.frame.height*/))
					//print("scroll frame x:\(scroll.frame.origin.x), y:\(scroll.frame.origin.y), w:\(scroll.frame.width), h:\(scroll.frame.height)")
					//print("scroll bounds x:\(scroll.bounds.origin.x), y:\(scroll.bounds.origin.y), w:\(scroll.bounds.width), h:\(scroll.bounds.height)")
					//scroll.translatesAutoresizingMaskIntoConstraints = false
					//scroll.delegate = self
					//scroll.addSubview(stack)
					//stack.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 0).isActive = true
					//stack.topAnchor.constraint(equalTo: scroll.topAnchor, constant: 0).isActive = true
//					stack.heightAnchor.constraint(equalToConstant: scroll.contentSize.height).isActive = true
//					stack.widthAnchor.constraint(equalToConstant: scroll.contentSize.width).isActive = true
					//stack.trailingAnchor.constraint(equalTo: scroll.trailingAnchor, constant: 0).isActive = true
					//stack.bottomAnchor.constraint(equalTo: scroll.bottomAnchor, constant: 0).isActive = true
					view.tagsView.addArrangedSubview(stack)
					//view.tagsView.addArrangedSubview(scroll)
					//view.tagsView.translatesAutoresizingMaskIntoConstraints = false
//					view.addConstraintsWithFormat(format: "H:|[v0]", views: view.tagsView)
//					view.addConstraintsWithFormat(format: "V:[v0]", views: view.tagsView)
//					NSLayoutConstraint.activate([
//						view.tagsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//						view.tagsView.trailingAnchor.constraint(lessThanOrEqualTo: view.tagsView.trailingAnchor, constant: 0)
//						])
					//^ causes many errors:
					//					2018-04-26 11:29:03.375743-0400 YumaApp[4629:89804] [LayoutConstraints] Unable to simultaneously satisfy constraints.
					//					Probably at least one of the constraints in the following list is one you don't want.
					//					Try this:
					//					(1) look at each constraint and try to figure out which you don't expect;
					//					(2) find the code that added the unwanted constraint or constraints and fix it.
					//					(Note: If you're seeing NSAutoresizingMaskLayoutConstraints that you don't understand, refer to the documentation for the UIView property translatesAutoresizingMaskIntoConstraints)
					//					(
					//					"<NSAutoresizingMaskLayoutConstraint:0x6040002904a0 h=--& v=--& YumaApp.CustomView:0x7fe328416580.width == 251.333   (active)>",
					//					"<NSLayoutConstraint:0x6040002982e0 H:|-(11)-[UILabel:0x7fe325ea0f40'   Lexmark ']   (active, names: '|':UIView:0x7fe325ea0780 )>",
					//					"<NSLayoutConstraint:0x604000298380 UILabel:0x7fe325ea0f40'   Lexmark '.trailing == UIView:0x7fe325ea0780.trailing - 5   (active)>",
					//					"<NSLayoutConstraint:0x604000298920 H:|-(11)-[UILabel:0x7fe325ea19e0'   Printer ']   (active, names: '|':UIView:0x7fe325ea1220 )>",
					//					"<NSLayoutConstraint:0x6040002989c0 UILabel:0x7fe325ea19e0'   Printer '.trailing == UIView:0x7fe325ea1220.trailing - 5   (active)>",
					//					"<NSLayoutConstraint:0x604000298f60 H:|-(11)-[UILabel:0x7fe325ea2480'   Laser ']   (active, names: '|':UIView:0x7fe325ea1cc0 )>",
					//					"<NSLayoutConstraint:0x604000299000 UILabel:0x7fe325ea2480'   Laser '.trailing == UIView:0x7fe325ea1cc0.trailing - 5   (active)>",
					//					"<NSLayoutConstraint:0x6040002995a0 H:|-(11)-[UILabel:0x7fe325ea2f20'   Trolly ']   (active, names: '|':UIView:0x7fe325ea2760 )>",
					//					"<NSLayoutConstraint:0x604000299640 UILabel:0x7fe325ea2f20'   Trolly '.trailing == UIView:0x7fe325ea2760.trailing - 5   (active)>",
					//					"<NSLayoutConstraint:0x604000299be0 H:|-(11)-[UILabel:0x7fe325ea39c0'   Extra Tray ']   (active, names: '|':UIView:0x7fe325ea3200 )>",
					//					"<NSLayoutConstraint:0x604000299c80 UILabel:0x7fe325ea39c0'   Extra Tray '.trailing == UIView:0x7fe325ea3200.trailing - 5   (active)>",
					//					"<NSLayoutConstraint:0x60400029a220 H:|-(11)-[UILabel:0x7fe325ea4460'   Duplexer ']   (active, names: '|':UIView:0x7fe325ea3ca0 )>",
					//					"<NSLayoutConstraint:0x60400029a2c0 UILabel:0x7fe325ea4460'   Duplexer '.trailing == UIView:0x7fe325ea3ca0.trailing - 5   (active)>",
					//					"<NSLayoutConstraint:0x60400029a860 H:|-(11)-[UILabel:0x7fe325ea4f00'   Scan ']   (active, names: '|':UIView:0x7fe325ea4740 )>",
					//					"<NSLayoutConstraint:0x60400029a900 UILabel:0x7fe325ea4f00'   Scan '.trailing == UIView:0x7fe325ea4740.trailing - 5   (active)>",
					//					"<NSLayoutConstraint:0x60400029afe0 H:|-(11)-[UILabel:0x7fe325ea59a0'   Fax ']   (active, names: '|':UIView:0x7fe325ea51e0 )>",
					//					"<NSLayoutConstraint:0x60400029b080 UILabel:0x7fe325ea59a0'   Fax '.trailing == UIView:0x7fe325ea51e0.trailing - 5   (active)>",
					//					"<NSLayoutConstraint:0x60400029b620 H:|-(11)-[UILabel:0x7fe325ea6440'   Copy ']   (active, names: '|':UIView:0x7fe325ea5c80 )>",
					//					"<NSLayoutConstraint:0x60400029b6c0 UILabel:0x7fe325ea6440'   Copy '.trailing == UIView:0x7fe325ea5c80.trailing - 5   (active)>",
					//					"<NSLayoutConstraint:0x60400029bc60 H:|-(11)-[UILabel:0x7fe325ea6ee0'   Network capable ']   (active, names: '|':UIView:0x7fe325ea6720 )>",
					//					"<NSLayoutConstraint:0x60400029bd00 UILabel:0x7fe325ea6ee0'   Network capable '.trailing == UIView:0x7fe325ea6720.trailing - 5   (active)>",
					//					"<NSLayoutConstraint:0x60400029c2a0 H:|-(11)-[UILabel:0x7fe325ea7980'   In-built Memory ']   (active, names: '|':UIView:0x7fe325ea71c0 )>",
					//					"<NSLayoutConstraint:0x60400029c340 UILabel:0x7fe325ea7980'   In-built Memory '.trailing == UIView:0x7fe325ea71c0.trailing - 5   (active)>",
					//					"<NSLayoutConstraint:0x60c00028e150 UIStackView:0x7fe328419420.width == YumaApp.CustomView:0x7fe328416580.width   (active)>",
					//					"<NSLayoutConstraint:0x60400028de30 'UISV-alignment' UIStackView:0x7fe3284185b0.leading == UIStackView:0x7fe3284178d0.leading   (active)>",
					//					"<NSLayoutConstraint:0x60400028e010 'UISV-alignment' UIStackView:0x7fe3284185b0.trailing == UIStackView:0x7fe3284178d0.trailing   (active)>",
					//					"<NSLayoutConstraint:0x60400028f2d0 'UISV-alignment' UIStackView:0x7fe328419000.leading == UIStackView:0x7fe328419210.leading   (active)>",
					//					"<NSLayoutConstraint:0x60400028f3c0 'UISV-alignment' UIStackView:0x7fe328419000.trailing == UIStackView:0x7fe328419210.trailing   (active)>",
					//					"<NSLayoutConstraint:0x604000287ee0 'UISV-canvas-connection' UIStackView:0x7fe325ea0570.leading == UIView:0x7fe325ea0780.leading   (active)>",
					//					"<NSLayoutConstraint:0x604000288070 'UISV-canvas-connection' H:[UIView:0x7fe325ea71c0]-(0)-|   (active, names: '|':UIStackView:0x7fe325ea0570 )>",
					//					"<NSLayoutConstraint:0x60400028da20 'UISV-canvas-connection' UIStackView:0x7fe3284178d0.leading == UIStackView:0x7fe325ea0570.leading   (active)>",
					//					"<NSLayoutConstraint:0x60400028dac0 'UISV-canvas-connection' H:[UIStackView:0x7fe325ea0570]-(0)-|   (active, names: '|':UIStackView:0x7fe3284178d0 )>",
					//					"<NSLayoutConstraint:0x60400028de80 'UISV-canvas-connection' UIStackView:0x7fe328419210.leading == UIStackView:0x7fe3284185b0.leading   (active)>",
					//					"<NSLayoutConstraint:0x60400028ded0 'UISV-canvas-connection' H:[UIStackView:0x7fe3284185b0]-(0)-|   (active, names: '|':UIStackView:0x7fe328419210 )>",
					//					"<NSLayoutConstraint:0x60400028f050 'UISV-canvas-connection' UIStackView:0x7fe328419420.leading == UIStackView:0x7fe328419000.leading   (active)>",
					//					"<NSLayoutConstraint:0x60400028f1e0 'UISV-canvas-connection' H:[UIStackView:0x7fe328419000]-(0)-|   (active, names: '|':UIStackView:0x7fe328419420 )>",
					//					"<NSLayoutConstraint:0x604000288020 'UISV-spacing' H:[UIView:0x7fe325ea0780]-(8)-[UIView:0x7fe325ea1220]   (active)>",
					//					"<NSLayoutConstraint:0x6040002880c0 'UISV-spacing' H:[UIView:0x7fe325ea1220]-(8)-[UIView:0x7fe325ea1cc0]   (active)>",
					//					"<NSLayoutConstraint:0x604000288110 'UISV-spacing' H:[UIView:0x7fe325ea1cc0]-(8)-[UIView:0x7fe325ea2760]   (active)>",
					//					"<NSLayoutConstraint:0x604000288200 'UISV-spacing' H:[UIView:0x7fe325ea2760]-(8)-[UIView:0x7fe325ea3200]   (active)>",
					//					"<NSLayoutConstraint:0x60400028b4f0 'UISV-spacing' H:[UIView:0x7fe325ea3200]-(8)-[UIView:0x7fe325ea3ca0]   (active)>",
					//					"<NSLayoutConstraint:0x604000288250 'UISV-spacing' H:[UIView:0x7fe325ea3ca0]-(8)-[UIView:0x7fe325ea4740]   (active)>",
					//					"<NSLayoutConstraint:0x60400028b3b0 'UISV-spacing' H:[UIView:0x7fe325ea4740]-(8)-[UIView:0x7fe325ea51e0]   (active)>",
					//					"<NSLayoutConstraint:0x60400028b6d0 'UISV-spacing' H:[UIView:0x7fe325ea51e0]-(8)-[UIView:0x7fe325ea5c80]   (active)>",
					//					"<NSLayoutConstraint:0x60400028b7c0 'UISV-spacing' H:[UIView:0x7fe325ea5c80]-(8)-[UIView:0x7fe325ea6720]   (active)>",
					//					"<NSLayoutConstraint:0x60400028b590 'UISV-spacing' H:[UIView:0x7fe325ea6720]-(8)-[UIView:0x7fe325ea71c0]   (active)>"
					//					)
					//
					//					Will attempt to recover by breaking constraint
					//					<NSLayoutConstraint:0x60400029c340 UILabel:0x7fe325ea7980'   In-built Memory '.trailing == UIView:0x7fe325ea71c0.trailing - 5   (active)>
					//
					//					Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
					//					The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
					//let stack = UIStackView()
					//stack.translatesAutoresizingMaskIntoConstraints = false
					//stack.addArrangedSubview(formTagsView(tagIDs: (prod.associations?.tags)!))
					//view.tagsView.addSubview(stack)
					//					NSLayoutConstraint.activate([
					//						//										stack.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 0),
					//						//stack.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 3),
					//						//stack.heightAnchor.constraint(equalToConstant: 5),
					//						//stack.widthAnchor.constraint(equalToConstant: self.scrollView.frame.width),
					//						stack.widthAnchor.constraint(equalToConstant: view.tagsView.frame.width),
					//						])
				}
				var attrText: NSAttributedString
				if prod.description != nil && store.valueById(object: prod.description!, id: store.myLang) != nil//prod.description![store.myLang].value != nil
				{
					attrText = try! NSAttributedString(
						data: (store.valueById(object: prod.description!, id: store.myLang)?.data(using: .utf8, allowLossyConversion: true)!)!,//prod.description![store.myLang].value?.data(using: String.Encoding.utf8, allowLossyConversion: true)!)!,
						options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
						documentAttributes: nil)
					view.descLong.attributedText = attrText
					view.descLong.textColor = UIColor.gray
					view.descLong.numberOfLines = 0
					view.descLong.lineBreakMode = NSLineBreakMode.byTruncatingTail
					view.descLong.sizeToFit()
				}
				if prod.descriptionShort != nil && store.valueById(object: prod.descriptionShort!, id: store.myLang) != nil//prod.descriptionShort![store.myLang].value != nil
				{
					attrText = try! NSAttributedString(
						data: (store.valueById(object: prod.descriptionShort!, id: store.myLang)?.data(using: .utf8, allowLossyConversion: true)!)!,//)(prod.descriptionShort![store.myLang].value?.data(using: String.Encoding.utf8, allowLossyConversion: true)!)!,
						options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,],
						documentAttributes: nil)
					view.descShort.attributedText = attrText
					view.descShort.textColor = UIColor.gray
					view.descShort.numberOfLines = 0
					view.descShort.lineBreakMode = NSLineBreakMode.byTruncatingTail
					view.descShort.sizeToFit()
				}
				//				view.linkRewrite = prod.link_rewrite![store.myLang].value!
				if prod.associations != nil && prod.associations?.combinations != nil && (prod.associations?.combinations?.count)! > 0
				{
					view.combinationsView.addArrangedSubview(formCombinationView(combinationsIDs: (prod.associations?.combinations)!))
				}
				if prod.associations != nil && prod.associations?.images != nil && (prod.associations?.images?.count)! > 0
				{
					view.imagesView.addArrangedSubview(formImageViews(imageIDs: (prod.associations?.images)!))
				}
				if prod.associations != nil && prod.associations?.product_option_values != nil && (prod.associations?.product_option_values?.count)! > 0
				{
					view.productOptionValuesView.addArrangedSubview(formProductOptionValues(ValueIDs: (prod.associations?.product_option_values)!))
				}
				view.tag = i + 10
				self.scrollView.addSubview(view)
//				let downScroll = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.scrollView.frame.width-10, height: self.scrollView.frame.height-40))
//				downScroll.addSubview(view)
//				downScroll.delegate = self
//				downScroll.showsHorizontalScrollIndicator = false
//				self.scrollView.addSubview(downScroll)
//				NSLayoutConstraint.activate([
//					downScroll.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 0),
//					downScroll.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 0),
//					downScroll.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: 0),
//					downScroll.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: 0)
//					])
//				downScroll.contentSize.width = /*self.scrollView.frame.width*/min(self.scrollView.frame.width-20, view.frame.width)
//				downScroll.contentSize.height = /*self.scrollView.frame.height*/view.frame.height
				i += 1
			}
		}
	}

	@objc func expandPicture(_ sender: UITapGestureRecognizer)
	{
		let vc = ImageWindow()
		let index: Int = (sender.view?.tag)! - 10
		let prod = store.products[index]
		if prod.name != nil && store.valueById(object: prod.name!, id: store.myLang) != nil//prod.name![store.myLang].value != nil
		{
			//print(prod.name![store.myLang].value!)
			vc.titleLabel.text = store.valueById(object: prod.name!, id: store.myLang)//prod.name?[store.myLang].value
			if prod.associations?.imageData != nil
			{
				vc.imageView.image = UIImage(data: (prod.associations?.imageData)!)
			}
			else
			{
				let imgName = prod.associations?.images![0].id//primary image
				var imageName = "\(R.string.URLbase)img/p"
				for ch in imgName!
				{
					imageName.append("/\(ch)")
				}
				imageName.append("/\(imgName ?? "").jpg")
				if let imageFromCache = store.imageDataCache.object(forKey: imageName as AnyObject)
				{
					vc.imageView.image = UIImage(data: (imageFromCache as? Data)!)
				}
				else
				{
					store.getImageFromUrl(url: URL(string: imageName)!, session: URLSession(configuration: .default), completion:
						{
							(data, response, error) in
							
							guard let data = data, error == nil else { return }
							DispatchQueue.main.async()
								{
									//let i = view.tag - 10
									let imageToCache = UIImage(data: data)
									self.store.imageDataCache.setObject(imageToCache!, forKey: imageName as AnyObject)
									vc.imageView.image = imageToCache
									//view.prodImage.image = UIImage(data: data)
									//self.prod_image = data
									if index < self.store.products.count
									{
										self.store.products[index].associations?.imageData = data
									}
							}
					})
				}
			}
		}
		vc.buttonSingle.setTitle(R.string.dismiss, for: .normal)
		vc.modalTransitionStyle = .crossDissolve
		vc.modalPresentationStyle = .overCurrentContext
		self.present(vc, animated: true, completion: nil)
	}
}
