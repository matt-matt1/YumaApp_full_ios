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
	@IBOutlet weak var cartScroll: UIScrollView!
	@IBOutlet weak var stackLeft: UIStackView!
	//@IBOutlet weak var viewCartBtn: GradientButton!
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var navBar: UINavigationBar!
	@IBOutlet weak var navTitle: UINavigationItem!
	@IBOutlet weak var navClose: UIBarButtonItem!
	@IBOutlet weak var navHelp: UIBarButtonItem!
	@IBOutlet weak var leftLabel: UILabel!
	@IBOutlet weak var centerLabel: UILabel!
	@IBOutlet weak var rightLabel: UILabel!
	@IBOutlet weak var pageControl: UIPageControl!
	@IBOutlet weak var add2CartBtn: GradientButton!
	var pageTitle: String = ""
	var pageImage = UIImage()
	let store = DataStore.sharedInstance
	/////tableView
	@IBOutlet weak var stackRight: UIStackView!
	@IBOutlet weak var totalAmt: UILabel!
	@IBOutlet weak var totalLbl: UILabel!
	@IBOutlet weak var totalPcs: UILabel!
	@IBOutlet weak var totalPcsLbl: UILabel!
	//@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var chkoutBtn: GradientButton!
	let cellID = "cartCell"
	var latest: OrderRow?
	var latestIsUpdate = false
	var prod_image: Data?
	var cartCellHeight: CGFloat = 100
	var cartCellVSpace: CGFloat = 5

	
	override func viewDidLoad()
	{
        super.viewDidLoad()

		cartScroll.delegate = self
		scrollView.delegate = self
		scrollView.isPagingEnabled = true
		navTitle.title = pageTitle
		if #available(iOS 11.0, *)
		{
			navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		}
		else
		{
			navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
		}
		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
		add2CartBtn.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		//viewCartBtn.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		chkoutBtn.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		navClose.title = FontAwesome.close.rawValue
		navClose.setTitleTextAttributes([
			NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)
			], for: UIControlState.normal)
		navHelp.title = FontAwesome.questionCircle.rawValue
		navHelp.setTitleTextAttributes([
			NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)
			], for: UIControlState.normal)
		if UIScreen.main.scale < 2
		{
			let spacer = UIBarButtonItem(title: "|", style: .plain, target: self, action: nil)
			spacer.setTitleTextAttributes([
				NSAttributedStringKey.foregroundColor : R.color.YumaRed//UIColor.darkGray,
				], for: UIControlState.normal)
			navTitle.rightBarButtonItems?.append(spacer)
		}
		let cart = UIBarButtonItem(title: FontAwesome.shoppingCart.rawValue, style: .plain, target: self, action: #selector(navCartAct(_:)))
		cart.setTitleTextAttributes([
			NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)
			], for: UIControlState.normal)
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
			store.locale = "\(store.langs[Int((store.customer?.id_lang)!)!].isoCode ?? "")_\(store.countries[Int(store.addresses[0].id_country)!].isoCode ?? "")"//combine lang iso with country iso
		}
//		if store.products.count < 1 || store.forceRefresh
//		{
		//DONT NEED TO REFRESH EVERYTIME!
			store.forceRefresh = false
			refresh()	//load products
//		}
/////tableView
		totalLbl.text = R.string.Total.uppercased()
		totalPcsLbl.text = R.string.pieces
		stackRight.widthAnchor.constraint(equalToConstant: self.view.frame.width * 1/4).isActive = true
		//tableView.delegate = self
		_ = populateCart()
		if store.myOrderRows.count > 0
		{
			for i in (0..<store.myOrderRows.count).reversed()
			{
				if store.myOrderRows.count > 1 && !latestIsUpdate
				{
					for scr in self.cartScroll.subviews
					{
						if type(of: scr) == CartCell.self
						{
							scr.frame.origin.y += self.cartCellHeight + (2*cartCellVSpace)//10//104
						}
					}
					self.drawCartItem(i)
				}
				else
				{
					if latestIsUpdate
					{
						let cell = self.cartScroll.viewWithTag(Int((latest?.productId)!)!) as! CartCell
						cell.prodQty.text = latest?.productQuantity
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
	}
	
	func populateCart() -> (Double, Int)
	{
		var total: Double = 0
		var pcs: Int = 0
		var wt: Double = 0
		for row in store.myOrderRows
		{
			//print("price=\(row.productPrice ?? ""), convert=\(Double(row.productPrice!)!)")
			total = total + (Double(Int(row.productQuantity!)!) * Double(row.productPrice!)!)
			pcs = pcs + Int(row.productQuantity!)!
			let prodWeight = NumberFormatter().number(from: store.products[pageControl.currentPage].weight!)?.doubleValue
			if let prodWeight = prodWeight
			{
				wt = wt + Double(prodWeight)
			}
		}
		let totalDbl = total as NSNumber
		let totalStr = store.formatCurrency(amount: totalDbl, iso: store.locale)
		totalAmt.text = totalStr
		totalPcs.text = "\(pcs)"
		return (wt, pcs)
	}
	
	
	fileprivate func drawCartItem(_ i: Int? = nil)
	{
		let view = CartCell(frame: CGRect(x: 0, y: cartCellVSpace, width: min(300, self.cartScroll.frame.width), height: cartCellHeight))
		self.cartScroll.contentSize.height += cartCellHeight + (2*cartCellVSpace)//104	//put next (future) item next
		//print("cartScroll.contentSize=\(self.cartScroll.contentSize.width)x\(self.cartScroll.contentSize.height)")
		//let thisOrder = store.myOrderRows[store.myOrderRows.count-1]
		if i != nil
		{
			latest = store.myOrderRows[i!]
		}
		let name = self.latest?.productName//thisOrder.productName//prod.name![0].value
		view.prodName.text = name
		view.tag = Int((self.latest?.productId)!)!
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
		if self.prod_image != nil
		{
			view.prodImage.image = UIImage(data: self.prod_image!)
		}
		else if latest?.productImage != nil
		{
			view.prodImage.image = UIImage(data: (latest?.productImage)!)
		}
		//print("prod.quantity=\(prod.quantity)")
		view.prodQty.text = self.latest?.productQuantity//thisOrder.productQuantity//prod.quantity
		self.cartScroll.addSubview(view)
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
		let (wt, pcs) = populateCart()
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
				store.myOrder = Order(id: 0, idAddressDelivery: "", idAddressInvoice: "", idCart: "", idCurrency: "", idLang: store.customer?.id_lang, idCustomer: store.customer?.id_customer, idCarrier: "", currentState: "", module: "", invoiceNumber: "", invoiceDate: "", deliveryNumber: "", deliveryDate: "", valid: "", dateAdd: "\(date)", dateUpd: "\(date)", shippingNumber: "", idShopGroup: "", idShop: "", secureKey: "", payment: "", recyclable: "", gift: "", giftMessage: "", mobileTheme: "", totalDiscounts: "", totalDiscountsTaxIncl: "", totalDiscountsTaxExcl: "", totalPaid: "", totalPaidTaxIncl: "", totalPaidTaxExcl: "", totalPaidReal: "", totalProducts: "\(pcs)", totalProductsWt: "\(wt)", totalShipping: "", totalShippingTaxIncl: "", totalShippingTaxExcl: "", carrierTaxRate: "", totalWrapping: "", totalWrappingTaxIncl: "", totalWrappingTaxExcl: "", roundMode: "", roundType: "", conversionRate: "", reference: "", associations: Associations_OrderRows(order_rows: store.myOrderRows))
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
					let cell = self.cartScroll.viewWithTag(Int((latest?.productId)!)!) as! CartCell
					cell.prodQty.text = latest?.productQuantity
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
		if scrollView == scrollView
		{
			pageControl.currentPage = Int(scrollView.contentOffset.x / self.scrollView.frame.width)
		}
	}
	
	@objc func refresh()//(_ sender: Any)
	{
		let sv = UIViewController.displaySpinner(onView: self.view)
		leftLabel.text = ""
		centerLabel.text = "\(R.string.updating) ..."
		rightLabel.text = ""
		//pageControl.isHidden = true
		pageControl.pageIndicatorTintColor = UIColor.clear
		pageControl.currentPageIndicatorTintColor = .clear
		let completeionFunc: (Any) -> Void =
		{
			(products) in
			
			OperationQueue.main.addOperation
				{
					UIViewController.removeSpinner(spinner: sv)
					self.leftLabel.text = " \(R.string.updated)"
					self.centerLabel.text = FontAwesome.repeat.rawValue
					self.centerLabel.font = R.font.FontAwesomeOfSize(pointSize: 21)
					let date = Date()
					let df = DateFormatter()
					df.locale = Locale(identifier: self.store.locale)
					df.dateFormat = "dd MMM YYYY  h:mm:ss a"
					self.rightLabel.text = "\(df.string(from: date)) "
					//self.pageControl.isHidden = false
					self.pageControl.currentPageIndicatorTintColor = R.color.YumaRed
					self.pageControl.pageIndicatorTintColor = R.color.YumaYel
					self.pageControl.numberOfPages = self.store.products.count
					print("found \(self.store.products.count) products")
					self.scrollView.contentSize.width = self.scrollView.frame.width * CGFloat(self.store.products.count)
					self.insertData()
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
			completeionFunc(store.products)
			//print("bad instantantion of products VC")
		}
	}
	

	/////tableView
	@IBAction func chkoutBtnAct(_ sender: Any)
	{
		//guard viewCartBtn.alpha == 1 else { 	return 	}
//		store.flexView(view: self.viewCartBtn)
		//		sender.view?.backgroundColor = R.color.YumaRed
		//		UIView.animate(withDuration: 1, animations:
		//			{
		//				sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		//			})
		let vc = UIStoryboard(name: "Checkout", bundle: nil).instantiateInitialViewController() as! CheckoutViewController?
		self.present(vc!, animated: false, completion: (() -> Void)?
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
	@IBAction func navCloseAct(_ sender: Any)
	{
		self.dismiss(animated: false, completion: nil)
	}
	@IBAction func add2CartBtnAct(_ sender: Any)
	{
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
		var imageName = "\(R.string.URLbase)img/p"
		for ch in imgName!
		{
			imageName.append("/\(ch)")
		}
		imageName.append("/\(imgName ?? "").jpg")
		store.getImageFromUrl(url: URL(string: imageName)!, session: URLSession(configuration: .default), completion:
			{
				(data, response, error) in
				
				guard let data = data, error == nil else { return }
				DispatchQueue.main.async()
					{
						self.prod_image = data
					}
			}
		)
		if Int((NumberFormatter().number(from: prod.price!)?.doubleValue)!) > 0 && chkoutBtn.alpha != 1
		{
			chkoutBtn.alpha = 1
		}
		count = max(store.myOrderRows.count, 0)
		for i in 0..<store.myOrderRows.count
		{
			//check if product already exists
			if Int(store.myOrderRows[i].productId!) == prod.id
			{
				qty = Int(store.myOrderRows[i].productQuantity!)!
				//print("qty was \(qty)")
				store.myOrderRows[i].productQuantity = "\(qty + 1)"
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
			let row = OrderRow(id: "\(count)", productId: "\(prod.id ?? 0)", productAttributeId: "\(prod.cache_has_attachments ?? "")", productQuantity: "\(qty)", productName: "\(prod.name![0].value ?? "")", productReference: "\(prod.reference ?? "")", productEan13: "\(prod.ean13 ?? "")", productIsbn: "\(prod.isbn ?? "")", productUpc: "\(prod.upc ?? "")", productPrice: "\(prod.price ?? "")", unitPriceTaxIncl: "\(prod.price ?? "")", unitPriceTaxExcl: "\(prod.price ?? "")", productImage: prod_image)
			//let row2 = CartRow(idProduct: "\(prod.id ?? 0)", idProductAttribute: , idAddressDelivery: <#T##String?#>, quantity: <#T##String?#>)
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
		let animateView = self.scrollView.subviews[pageControl.currentPage+2].subviews[0].subviews[0]
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
	
	func insertData()
	{
		var i = 0
		//let id_lang = (store.customer != nil) ? Int((store.customer?.id_lang)!)! : 0
		for prod in store.products
		{
			if prod.active == "1"
			{
				let view = CustomView(frame: CGRect(x: 10 + (self.scrollView.frame.width * CGFloat(i)), y: 0, width: self.scrollView.frame.width - 20, height: self.scrollView.frame.height))
				print("self:\(self.view.frame.width), scroll:\(self.scrollView.frame.width)")
//				print("language id:\(id_lang)")
				view.clipsToBounds = true
				view.sizeToFit()
				view.prodName.text = prod.name![store.myLang].value
				view.prodName.textColor = R.color.YumaRed
				view.prodName.tag = prod.id!
				if prod.showPrice != "0" && Double(prod.price!)! > 0
				{
					let prodPrice = NumberFormatter().number(from: prod.price!)?.doubleValue
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
				let imgName = prod.associations?.images![0].id//primary image
				var imageName = "\(R.string.URLbase)img/p"
				for ch in imgName!
				{
					imageName.append("/\(ch)")
				}
				imageName.append("/\(imgName ?? "").jpg")
				store.getImageFromUrl(url: URL(string: imageName)!, session: URLSession(configuration: .default), completion:
					{
						(data, response, error) in
						
						guard let data = data, error == nil else { return }
						DispatchQueue.main.async()
						{
							view.prodImage.image = UIImage(data: data)
						}
				})
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
				}
				if prod.associations != nil && prod.associations?.tags != nil && (prod.associations?.tags?.count)! > 0
				{
					//view.tagsView.translatesAutoresizingMaskIntoConstraints = false
					view.tagsView.addArrangedSubview(formTagsView(tagIDs: (prod.associations?.tags)!))
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
				if prod.description != nil && prod.description![store.myLang].value != nil
				{
					attrText = try! NSAttributedString(
						data: (prod.description![store.myLang].value?.data(using: String.Encoding.utf8, allowLossyConversion: true)!)!,
						options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
						documentAttributes: nil)
					view.descLong.attributedText = attrText
					view.descLong.textColor = UIColor.gray
					view.descLong.numberOfLines = 0
					view.descLong.lineBreakMode = NSLineBreakMode.byTruncatingTail
					view.descLong.sizeToFit()
				}
				if prod.description_short != nil && prod.description_short![store.myLang].value != nil
				{
					attrText = try! NSAttributedString(
						data: (prod.description_short![store.myLang].value?.data(using: String.Encoding.utf8, allowLossyConversion: true)!)!,
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
				i += 1
			}
		}
	}
	
	fileprivate func formProductOptionValues(ValueIDs: [IdAsString]) -> UIStackView
	{
		let stack = UIStackView()
		//stack.translatesAutoresizingMaskIntoConstraints = false
		for prodOpt in ValueIDs
		{
			let find = Int(prodOpt.id)!
			if find < store.productOptionValues.count
			{
				for co in store.productOptionValues
				{
					if co.id == find
					{
						let lbl = UILabel()
						lbl.translatesAutoresizingMaskIntoConstraints = false
						lbl.text = String(describing: co)
						stack.addArrangedSubview(lbl)
						break
					}
				}
			}
			//view.productOptionValuesView.addArrangedSubview(stack)
		}
		return stack
	}

	fileprivate func formTagsView(tagIDs: [IdAsString]) -> UIStackView
	{
		let stack = UIStackView()
		//stack.translatesAutoresizingMaskIntoConstraints = false
		stack.spacing = 8
		stack.backgroundColor = UIColor.white
		stack.distribution = .fill
		for prodTag in tagIDs
		{
			let find = Int(prodTag.id)!
			if find < store.tags.count
			{
				for storeTag in store.tags
				{
					if storeTag.id == find
					{
						let tagView = makeTag(string: storeTag.name!)
						//tagView.translatesAutoresizingMaskIntoConstraints = false
						stack.addArrangedSubview(tagView)
						break
					}
				}
			}
		}
		return stack
	}

	fileprivate func formImageViews(imageIDs: [IdAsString]) -> UIStackView
	{
		let stack = UIStackView()
		//stack.translatesAutoresizingMaskIntoConstraints = false
//		for prodComb in imageIDs
//		{
//			let find = Int(prodComb.id)!
//			if find < store.images.count
//			{
//				for co in store.images
//				{
//					if co.id == find
//					{
//						view.imagesWidgets.append(co)
//						break
//					}
//				}
//			}
//		}
		return stack
	}
	
	fileprivate func formCombinationView(combinationsIDs: [IdAsString]) -> UIStackView
	{
		let stack = UIStackView()
		//stack.translatesAutoresizingMaskIntoConstraints = false
		for prodComb in combinationsIDs
		{
			let find = Int(prodComb.id)!
			if find < store.combinations.count
			{
				for co in store.combinations
				{
					if co.id == find
					{
						let lbl = UILabel()
						lbl.translatesAutoresizingMaskIntoConstraints = false
						lbl.text = String(describing: co)
						stack.addArrangedSubview(lbl)
						break
					}
				}
			}
		}
		return stack
	}
	
	fileprivate func formCategoriesView(categorieIDs: [IdAsString]) -> UIStackView
	{
		var first = true
		let stack = UIStackView()
		//stack.translatesAutoresizingMaskIntoConstraints = false
		stack.spacing = 2
		for prodCat in categorieIDs
		{
			let find = Int(prodCat.id)!
			if find < store.categories.count
			{
				for cat in store.categories
				{
					if cat.id == find
					{
						if first == false
						{
							first = false
							let sep = UILabel()
							sep.translatesAutoresizingMaskIntoConstraints = false
							sep.text = " > "
							sep.textColor = UIColor.gray
							stack.addArrangedSubview(sep)
						}
						let wrapperLbl = UIView()
						wrapperLbl.translatesAutoresizingMaskIntoConstraints = false
						let lbl = UILabel()
						lbl.translatesAutoresizingMaskIntoConstraints = false
						lbl.text = cat.name![store.myLang].value
						wrapperLbl.addSubview(lbl)
						NSLayoutConstraint.activate([
							wrapperLbl.topAnchor.constraint(equalTo: lbl.topAnchor),
							wrapperLbl.leadingAnchor.constraint(equalTo: lbl.leadingAnchor),
							wrapperLbl.bottomAnchor.constraint(equalTo: lbl.bottomAnchor),
							wrapperLbl.trailingAnchor.constraint(equalTo: lbl.trailingAnchor),
							])
						wrapperLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.displayCat(_:))))
						stack.addArrangedSubview(wrapperLbl)
						first = false
						break
					}
				}
			}
		}
		return stack
	}
	
	@objc private func clickShare(_ sender: UITapGestureRecognizer)
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
	
	@objc private func displayCat(_ sender: UITapGestureRecognizer)
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
	
	func makeTag(string: String) -> UIView
	{
		let tagView = UIView()
		//tagView.translatesAutoresizingMaskIntoConstraints = false
		tagView.backgroundColor = R.color.YumaRed
		tagView.borderColor = R.color.YumaDRed
		//tag.borderWidth = 1
		tagView.cornerRadius = 5
		let tagHole = UIView()
		tagHole.translatesAutoresizingMaskIntoConstraints = false
		tagHole.backgroundColor = UIColor.white
		tagHole.borderColor = R.color.YumaDRed
		//tagHole.borderWidth = 1
		tagHole.shadowColor = UIColor.black
		tagHole.shadowOffset = CGSize(width: -1, height: -1)
		tagHole.shadowRadius = 2
		tagHole.shadowOpacity = 1
		let tagBlock1 = UIView()
		tagBlock1.translatesAutoresizingMaskIntoConstraints = false
		tagBlock1.backgroundColor = UIColor.white
		let tagBlock2 = UIView()
		tagBlock2.translatesAutoresizingMaskIntoConstraints = false
		tagBlock2.backgroundColor = UIColor.white
		let tagLbl = UILabel()
		tagLbl.translatesAutoresizingMaskIntoConstraints = false
		tagLbl.text = "   " + string + " "
		tagLbl.textColor = R.color.YumaYel
		tagLbl.font = UIFont.systemFont(ofSize: 11)
		tagView.addSubview(tagLbl)
		NSLayoutConstraint.activate([
			tagLbl.topAnchor.constraint(equalTo: tagView.topAnchor, constant: 5.5),
			tagLbl.leadingAnchor.constraint(equalTo: tagView.leadingAnchor, constant: 11),
			tagLbl.bottomAnchor.constraint(equalTo: tagView.bottomAnchor, constant: -5.5),
			tagLbl.trailingAnchor.constraint(equalTo: tagView.trailingAnchor, constant: -5),
			])
		tagView.addSubview(tagHole)
		NSLayoutConstraint.activate([
			tagHole.centerYAnchor.constraint(equalTo: tagView.centerYAnchor, constant: 0),
			tagHole.leadingAnchor.constraint(equalTo: tagView.leadingAnchor, constant: 9),
			tagHole.heightAnchor.constraint(equalToConstant: 4),
			tagHole.widthAnchor.constraint(equalToConstant: 4),
			])
		tagHole.cornerRadius = 5 / 2
		tagView.addSubview(tagBlock1)
		tagView.addSubview(tagBlock2)
		NSLayoutConstraint.activate([
			tagBlock1.topAnchor.constraint(equalTo: tagView.topAnchor, constant: -5),
			tagBlock1.leadingAnchor.constraint(equalTo: tagView.leadingAnchor, constant: -2),
			tagBlock1.bottomAnchor.constraint(equalTo: tagView.centerYAnchor, constant: 0),
			tagBlock1.widthAnchor.constraint(equalToConstant: 8),
			
			tagBlock2.topAnchor.constraint(equalTo: tagView.centerYAnchor, constant: 0),
			tagBlock2.leadingAnchor.constraint(equalTo: tagView.leadingAnchor, constant: -2),
			tagBlock2.bottomAnchor.constraint(equalTo: tagView.bottomAnchor, constant: 5),
			tagBlock2.widthAnchor.constraint(equalToConstant: 8),
			])
		tagBlock1.transform = CGAffineTransform(rotationAngle: .pi/180*45)
		tagBlock2.transform = CGAffineTransform(rotationAngle: -.pi/180*45)
		tagView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.displayCat(_:))))
		return tagView
	}
}


/////tableView
//extension ProductsViewController: UITableViewDataSource, UITableViewDelegate
//{
//	func numberOfSections(in tableView: UITableView) -> Int
//	{
//		return 1
//	}
//
//	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
//	{
//		return store.myOrderRows.count//contents.count
//	}
//
//	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
//	{
//		let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! CartViewCell
//		cell.setup(store.myOrderRows[indexPath.row])
//		return cell
//	}
//
//}

extension String
{
	func findArrayPositionOf(findValue: AnyObject, inArray: [AnyObject], searchElements: AnyObject) -> Int
	{
		var i: Int = 0;
		var found: Int = -1
		for obj in inArray
		{
//			let pair = obj as! Dictionary
//			for element in pair
//			{
//				if pair.key == findValue
//			}
			if obj.elementType == searchElements.elementType //&& obj.element(searchElements) == findValue
			{
				found = i//return i
			}
			i+=1
		}
		return found
	}
}
