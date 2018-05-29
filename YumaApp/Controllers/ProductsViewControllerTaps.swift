//
//  ProductsViewControllerTaps.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-05-09.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

extension ProductsViewController
{
	@objc func clickShare(_ sender: UITapGestureRecognizer)
	{
		//let asdf = sender.view?.superview?.subviews
		let share: Int = (sender.view?.subviews.count)!
		let url = URL(string: store.shares[share].link!)
		let label = UILabel()
		label.text = ""
		print("share: \(share) link to:\(String(describing: url))")
		URLSession.shared.dataTask(with: url!)
		{
			(data, response, error) in
			//			if error != nil
			//			{
			//				if let data = data
			//				{
			//
			//				}
			//			}
		}
	}
	
	@objc func displayCat(_ sender: UITapGestureRecognizer)
	{
		var prodList: [aProduct] = []
		var label = ""
		if sender.view?.subviews != nil
		{	//is a tag
			label = (sender.view?.subviews[0] as! UILabel).text!.trimmingCharacters(in: .whitespaces)
			var tagId: Int = -1
			for t in store.tags
			{
				if t.name == label
				{
					tagId = t.id!
					break
				}
			}
			for prod in store.products
			{
				if prod.associations != nil && prod.associations?.tags != nil
				{
					for t in (prod.associations?.tags)!
					{
						if t.id == "\(tagId)"
						{
							prodList.append(prod)
						}
					}
				}
			}
		}
		else
		{	//is a category
			label = (sender.view as! UILabel).text!
			var catId: Int = -1
			for c in store.tags
			{
				if c.name == label
				{
					catId = c.id!
					break
				}
			}
			for prod in store.products
			{
				if prod.associations != nil && prod.associations?.categories != nil
				{
					for t in (prod.associations?.categories)!
					{
						if t.id == "\(catId)"
						{
							prodList.append(prod)
						}
					}
				}
			}
		}
		if prodList.count > 0
		{
			store.flexView(view: sender.view!)
			store.forceRefresh = true
			//		UIView.animate(withDuration: 1, animations:
			//			{
			//				sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
			//		})//ProductsStoryboard//ProductsViewController
			store.products = prodList
			let vc = UIStoryboard(name: "Products", bundle: nil).instantiateInitialViewController() as! ProductsViewController?
			let layout = UICollectionViewFlowLayout()
			layout.scrollDirection = .horizontal
			vc?.pageTitle = "\(R.string.printers)-\(label)"
			self.present(vc!, animated: true, completion: (() -> Void)?
				{
					//				sender.view?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
					//				sender.view?.backgroundColor = UIColor.white
				})
		}
		else
		{
			store.Alert(fromView: self, title: "\(navTitle.title ?? "") \"\(label)\"", titleColor: R.color.YumaRed, message: R.string.empty, dialogBackgroundColor: R.color.YumaYel, backgroundBackgroundColor: R.color.YumaDRed, borderColor: R.color.YumaRed, borderWidth: 2, button1Title: R.string.dismiss)
		}
	}
	
	//MARK: Actions
	/////tableView
	@IBAction func chkoutBtnAct(_ sender: Any)
	{
		guard chkoutBtn.alpha == 1 else { 	return 	}
		//		store.flexView(view: self.viewCartBtn)
		//		sender.view?.backgroundColor = R.color.YumaRed
		//		UIView.animate(withDuration: 1, animations:
		//			{
		//				sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		//			})
		store.myOrder?.total_products_wt = String(wt)
		store.myOrder?.total_paid_tax_excl = String(total)
		store.myOrder?.total_products = String(pcs)
		//		let vc = UIStoryboard(name: "Checkout", bundle: nil).instantiateInitialViewController() as! CheckoutViewController
		let layout = UICollectionViewFlowLayout()
		//layout.scrollDirection = .horizontal
		let vc = UINavigationController(rootViewController: CheckoutCollection(collectionViewLayout: layout))
		//		let vc = UIStoryboard(name: "CheckoutCollection", bundle: nil).instantiateInitialViewController() as! CheckoutCollection
		//let vc = UIStoryboard(name: "CheckoutTabsViewController", bundle: nil).instantiateInitialViewController() as! CheckoutTabsViewController
		//vc.selectedViewController = vc.viewControllers?[2]
		self.present(vc, animated: false, completion: (() -> Void)?
			{
				//				sender.view?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
				//				sender.view?.backgroundColor = UIColor.white
			})
	}
	/////
	//	@IBAction func viewCartBtnAct(_ sender: Any)
	//	{
	//		guard viewCartBtn.alpha == 1 else { 	return 	}
	//		store.flexView(view: self.viewCartBtn)
	////		sender.view?.backgroundColor = R.color.YumaRed
	////		UIView.animate(withDuration: 1, animations:
	////			{
	////				sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
	////			})
	//		let vc = UIStoryboard(name: "CartStoryboard", bundle: nil).instantiateInitialViewController() as UIViewController!
	//		self.present(vc!, animated: false, completion: (() -> Void)?
	//			{
	////				sender.view?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
	////				sender.view?.backgroundColor = UIColor.white
	//			})
	//	}
	@objc func navCartAct(_ sender: Any)
	{
		let vc = UIStoryboard(name: "CartStoryboard", bundle: nil).instantiateInitialViewController() as! CartViewController?
		self.present(vc!, animated: false, completion: nil)
	}
	@IBAction func navHelpAct(_ sender: Any)
	{
		let viewC = Assistance()
		viewC.array = R.array.help_product_list_guide
		viewC.title = "\(R.string.prod.capitalized) \(R.string.help.capitalized)"
		viewC.modalTransitionStyle = .crossDissolve
		viewC.modalPresentationStyle = .overCurrentContext
		self.present(viewC, animated: true, completion: nil)
	}
	@IBAction func navCloseAct(_ sender: Any)
	{
		self.dismiss(animated: false, completion: nil)
	}
	@IBAction func add2CartBtnAct(_ sender: Any)
	{
		totalPcsLbl.alpha = 1
		totalPcs.alpha = 1
		var prod_image: Data?
		store.flexView(view: self.add2CartBtn)
		//		let from = sender as! UIView
		//let allScrollInners = self.scrollView.getAllSubviews()
		//let prodView = allScrollInners[pageControl.currentPage]
		var qty = 1
		var count = 0
		var found = false
		//let prod = ((sender as! UIButton).superview as! UIStackView).superview as! UIStackView
		//let num = Int(scrollView.contentOffset.x / self.scrollView.frame.width)
		let prod: aProduct = store.products[pageControl.currentPage]
		let imgName = prod.associations?.images![0].id
		if prod.associations?.imageData != nil
		{
			prod_image = prod.associations?.imageData
		}
		else
		{
			var imageName = "\(R.string.URLbase)img/p"
			for ch in imgName!
			{
				imageName.append("/\(ch)")
			}
			imageName.append("/\(imgName ?? "").jpg")
			//			if let imageFromCache = store.imageDataCache.object(forKey: imageName as AnyObject)
			//			{
			//				prod_image = imageFromCache as? Data
			//			}
			//			else
			//			{
			store.getImageFromUrl(url: URL(string: imageName)!, session: URLSession(configuration: .default), completion:
				{
					(data, response, error) in
					
					guard let data = data, error == nil else { return }
					DispatchQueue.main.async()
						{
							let imageToCache = data as AnyObject//UIImage(data: data)
							//							self.store.imageDataCache.setObject(imageToCache, forKey: imageName as AnyObject)
							prod_image = imageToCache as? Data
							//prod_image = data
					}
			}
			)
			//			}
		}
		//if Int((NumberFormatter().number(from: prod.price!)?.doubleValue)!) > 0 && chkoutBtn.alpha != 1
		if prod.price != nil && prod.price! > 0 && chkoutBtn.alpha != 1
		{
			chkoutBtn.alpha = 1
		}
		count = max(store.myOrderRows.count, 0)
		for i in 0..<store.myOrderRows.count
		{
			//check if product already exists
			if Int(store.myOrderRows[i].product_id!) == prod.id
			{
				qty = Int(store.myOrderRows[i].product_quantity!)!
				//print("qty was \(qty)")
				store.myOrderRows[i].product_quantity = "\(qty + 1)"
				latest = store.myOrderRows[i]
				latestIsUpdate = true
				found = true
				print("update cart: \(qty) x \(prod.name![0].value ?? "")")
				break
			}
		}
		if found == false
		{
			print("add 2 cart: \(qty) x \(prod.name![0].value ?? "")")
			//			if prod_image == nil
			//			{
			//				if prod.associations?.imageData != nil
			//				{
			//					self.prod_image = prod.associations?.imageData
			//				}
			//				else
			//				{
			//					var imageName = "\(R.string.URLbase)img/p"
			//					for ch in imgName!
			//					{
			//						imageName.append("/\(ch)")
			//					}
			//					imageName.append("/\(imgName ?? "").jpg")
			//					store.getImageFromUrl(url: URL(string: imageName)!, session: URLSession(configuration: .default), completion:
			//						{
			//							(data, response, error) in
			//
			//							guard let data = data, error == nil else { return }
			//							DispatchQueue.main.async()
			//								{
			//									self.prod_image = data
			//							}
			//						}
			//					)
			//				}
			//			}
			let row = OrderRow(id: "\(count)", product_id: "\(prod.id)", product_attribute_id: prod.cacheHasAttachments! == true ? "1" : "", product_quantity: "\(qty)", product_name: "\(store.valueById(object: prod.name!, id: store.myLang) ?? "")", product_reference: String(prod.reference!), product_ean13: String(prod.ean13!), product_isbn: String(prod.isbn!), product_upc: String(prod.upc!), product_price: String(prod.price!), unit_price_tax_incl: String(prod.price!), unit_price_tax_excl: String(prod.price!), productImage: prod_image)//prod.name![store.myLang].value ?? ""
			store.myOrderRows.append(row)
			latest = row
			latestIsUpdate = false
		}
		//		let dblPrice = Double(prod.price!)!
		//		if dblPrice > 0 && viewCartBtn.alpha != 1
		//		{
		//			viewCartBtn.alpha = 1
		//		}
		//		print("scrollView.width=\(self.scrollView.frame.width), scrollView.height=\(self.scrollView.frame.height), ",
		//			"stackLeft.width=\(self.stackLeft.frame.width), stackLeft.height=\(self.stackLeft.frame.height)",
		//			"scrollView.x=\(self.scrollView.frame.origin.x), scrollView.y=\(self.scrollView.frame.origin.y), ",
		//			"stackLeft.x=\(self.stackLeft.frame.origin.x), stackLeft.y=\(self.stackLeft.frame.origin.y)")
		//		let sourceView = self.scrollView.subviews[0]
		//		let copiedView: UIView = sourceView.copyView()
		//		sourceView.alpha = 0.3
		//		let copiedView = UIView(frame: self.scrollView.frame)
		//		for sv in self.scrollView.subviews
		//		{
		//			copiedView.addSubview(sv.copyView())
		//		}
		//		copiedView.alpha = 0.8
		//return
		if self.scrollView.subviews[pageControl.currentPage+2].subviews.count > 0
		{
			let animateView = try self.scrollView.subviews[pageControl.currentPage+2].subviews[0].subviews[0]
			//let animateView = (prodView.subviews.first?.subviews.first)!
			//^^ product in scrollv, primary group, image in UIView (inner View frame, UImageView)
			//NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! T
			//let imageCopy = animateView.subviews[0].subviews[0].copy() as! UIImageView
			//imageCopy.transform = CGAffineTransform.init(translationX: 100, y: 0)
			
			//		let cellHeight: CGFloat = 100
			//print(allImageViews.first)
			//		let mirror = allImageViews.first?.image
			//let copy = allImageViews.first?.copyView()
			//		let replicatorLayer = CAReplicatorLayer()
			//		replicatorLayer.frame.size = (copy?.frame.size)!
			//		replicatorLayer.masksToBounds = true
			//		self.view.addSubview(replicatorLayer)
			//print(copy)
			//		let imageCopy = copy?.copy()
			//		print(imageCopy)
			//mirror.transform = CGAffineTransform(translationX: 100, y: 0)
			
			//self.stackRight.addArrangedSubview(added)
			//		func listSubviewsOfView(view:UIView)
			//		{
			//			// Get the subviews of the view
			//			let subviews = view.subviews
			//			// Return if there are no subviews
			//			if subviews.count == 0 {
			//				return
			//			}
			//			for subview : AnyObject in subviews
			//			{
			//				// Do what you want to do with the subview
			//				print(subview)
			//				// List the subviews of subview
			//				listSubviewsOfView(view: subview as! UIView)
			//			}
			//		}
			//		listSubviewsOfView(view: copy!)//self.scrollView.subviews[pageControl.currentPage+2])
			let beforeAnimation = animateView.transform							//save state
			//		let originalFrame = self.scrollView.frame
			let beforeCenterX = animateView.center.x
			let beforeCenterY = animateView.center.y
			animateView.alpha = 0.5												//dim
			UIView.animate(withDuration: 0.3, animations:
				{
					//			copiedView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
					animateView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)	//reduce
			},
						   completion:
				{
					_ in
					
					UIView.animate(withDuration: 0.65, /*delay: 1.0, usingSpringWithDamping: CGFloat(0), initialSpringVelocity: CGFloat(0), options: [.curveEaseInOut,.allowUserInteraction],*/ animations:
						{
							//				copiedView.center.x += self.stackLeft.center.x + 100
							//				copiedView.center.y -= self.stackLeft.center.y - 50
							animateView.center.x += self.stackLeft.center.x + 100
							animateView.center.y -= self.stackLeft.center.y - 50		//move towards cart
					},
								   completion:
						{
							_ in
							/*
							self.cartScroll.contentSize.height = cellHeight
							let view = MiniCartCell(frame: CGRect(x: 0, y: 5, width: 100/*self.cartScroll.frame.width*/, height: cellHeight - 10))
							//usually in for row in store.myOrderRow - ^y = i * cellHeight
							self.cartScroll.addSubview(view)
							view.imageView.image = #imageLiteral(resourceName: "home-slider-printers")//allImageViews.first?.image
							view.qtyLabel.text = prod.quantity
							*/
							/*
							let imageView = UIImageView()
							imageView.image = allImageViews.first?.image//mirror
							imageView.contentMode = .scaleAspectFit
							//imageView.sizeToFit()
							imageView.center.x = self.cartScroll.center.x
							imageView.translatesAutoresizingMaskIntoConstraints = false
							let label = UILabel(frame: CGRect(origin: CGPoint.init(x: 0, y: 0), size: CGSize(width: 0, height: 40)))
							label.backgroundColor = R.color.YumaRed
							label.cornerRadius = 10
							label.textColor = R.color.YumaYel
							label.text = String(qty)
							label.sizeToFit()
							label.center.x = self.cartScroll.center.x
							self.cartScroll.addSubview(label)
							let added = UIView(frame: CGRect(x: 0, y: 0, width: self.cartScroll.frame.width, height: imageView.frame.height))
							added.translatesAutoresizingMaskIntoConstraints = false
							added.backgroundColor = .blue
							added.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
							added.addSubview(imageView)
							NSLayoutConstraint.activate([
							imageView.leftAnchor.constraint(equalTo: added.leftAnchor),
							imageView.topAnchor.constraint(equalTo: added.topAnchor),
							imageView.rightAnchor.constraint(equalTo: added.rightAnchor),
							imageView.bottomAnchor.constraint(equalTo: added.bottomAnchor),
							])
							self.cartScroll.insertSubview(added, at: 0)
							self.cartScroll.contentSize.width = self.cartScroll.frame.width
							self.cartScroll.contentSize.height = imageView.frame.height * CGFloat(self.store.myOrderRows.count)
							*/
							//					self.scrollView.frame = originalFrame
							animateView.center.x = beforeCenterX
							animateView.center.y = beforeCenterY					//revert position
							animateView.transform = beforeAnimation					//revert size
							animateView.alpha = 1									//make vivid
							//					sourceView.alpha = 1
					}
					)
			})
			UIView.animate(withDuration: 0.5, animations:
				{
					animateView.alpha = 1.0							//fade-in
			})
			{
				(completed) in
				
				self.store.flexView(view: animateView)		//shake
				self.putItemInCart()
				//DispatchQueue.main.async { 	self.tableView.reloadData() 	}
			}
		}
		else
		{
			self.putItemInCart()
		}
	}

}
