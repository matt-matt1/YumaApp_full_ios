//
//  ProductsViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-06.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController, UIScrollViewDelegate/*, UIPageViewControllerDelegate*/
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
	/////
	
	
	override func viewDidLoad()
	{
        super.viewDidLoad()

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
		centerLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(refresh)))
//		if self.view.frame.width > 400
//		{
//			stackRight.widthAnchor.constraint(lessThanOrEqualToConstant: 300).isActive = true
//		}
//		else
//		{
//			stackRight.widthAnchor.constraint(lessThanOrEqualToConstant: 200).isActive = true
//		}
		refresh()
/////tableView
		totalLbl.text = R.string.Total.uppercased()
		totalPcsLbl.text = R.string.pieces
		stackRight.widthAnchor.constraint(equalToConstant: self.view.frame.width * 1/4).isActive = true
		//tableView.delegate = self
		putItemInCart()
/////
	}
	
	
	/////tableView
	func putItemInCart()
	{
		var total: Double = 0
		var pcs: Int = 0
		var wt: Double = 0
		for row in store.myOrderRows
		{
			//print("price=\(row.productPrice ?? ""), convert=\(Double(row.productPrice!)!)")
			total = total + (Double(Int(row.productQuantity!)!) * Double(row.productPrice!)!)
			pcs = pcs + Int(row.productQuantity!)!
			//wt = wt + Double(row.productId)
		}
		totalAmt.text = "\(total)"
		totalPcs.text = "\(pcs)"
		if store.products.count > 0
		{
			let date = Date()
			store.myOrder = [Orders(id: 0, idAddressDelivery: "", idAddressInvoice: "", idCart: "", idCurrency: "", idLang: store.customer?.id_lang, idCustomer: store.customer?.id_customer, idCarrier: "", currentState: "", module: "", invoiceNumber: "", invoiceDate: "", deliveryNumber: "", deliveryDate: "", valid: "", dateAdd: "\(date)", dateUpd: "\(date)", shippingNumber: "", idShopGroup: "", idShop: "", secureKey: "", payment: "", recyclable: "", gift: "", giftMessage: "", mobileTheme: "", totalDiscounts: "", totalDiscountsTaxIncl: "", totalDiscountsTaxExcl: "", totalPaid: "", totalPaidTaxIncl: "", totalPaidTaxExcl: "", totalPaidReal: "", totalProducts: "\(pcs)", totalProductsWt: "\(wt)", totalShipping: "", totalShippingTaxIncl: "", totalShippingTaxExcl: "", carrierTaxRate: "", totalWrapping: "", totalWrappingTaxIncl: "", totalWrappingTaxExcl: "", roundMode: "", roundType: "", conversionRate: "", reference: "", associations: Associations_OrderRows(order_rows: store.myOrderRows))]
			//print(store.myOrder)
			if self.cartScroll.contentSize.height > 104
			{
				//animate shift contents down
			}
			let view = CartCell(frame: CGRect(x: 0, y: 10, width: max(300, self.cartScroll.frame.width), height: 84))
			self.cartScroll.contentSize.height += 104	//put next (future) item next
			let prod = store.products[pageControl.currentPage]
			let name = prod.name![0].value
			view.prodName.text = name
	//		if prod.showPrice != "0" && Double(prod.price!)! > 0
	//		{
	//			view.prodPrice.text = prod.price
	//		}
	//		else
	//		{
	//			view.prodPrice.text = R.string.noPrice
	//		}
			view.prodImage.contentMode = UIViewContentMode.scaleAspectFit
			let imgName = prod.associations?.images?[0].id
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
				}
			)
			view.prodQty.text = prod.quantity
			self.cartScroll.addSubview(view)
		}
	}
	/////

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
		pageControl.isHidden = true
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
					df.locale = Locale(identifier: "en_CA")
					df.dateFormat = "dd MMM YYYY  h:mm:ss a"
					self.rightLabel.text = "\(df.string(from: date)) "
					self.pageControl.isHidden = false
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
			print("bad instantantion of products VC")
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
		let vc = UIStoryboard(name: "Checkout", bundle: nil).instantiateInitialViewController() as! CheckoutViewController!
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
	@IBAction func navCloseAct(_ sender: Any)
	{
		self.dismiss(animated: false, completion: nil)
	}
	@IBAction func add2CartBtnAct(_ sender: Any)
	{
		store.flexView(view: self.add2CartBtn)
		var qty = 1
		var count = 0
		var found = false
		//let prod = ((sender as! UIButton).superview as! UIStackView).superview as! UIStackView
		//let num = Int(scrollView.contentOffset.x / self.scrollView.frame.width)
		let prod: aProduct = store.products[pageControl.currentPage]
		count = max(store.myOrderRows.count, 0)
		for i in 0..<store.myOrderRows.count
		{
			//check if product already exists
			if Int(store.myOrderRows[i].productId!) == prod.id
			{
				qty = Int(store.myOrderRows[i].productQuantity!)!
				//print("qty was \(qty)")
				store.myOrderRows[i].productQuantity = "\(qty + 1)"
				found = true
				print("update cart: \(qty) x \(prod.name![0].value ?? "")")
				break
			}
		}
		if found == false
		{
			print("add 2 cart: \(qty) x \(prod.name![0].value ?? "")")
			let row = OrderRow(id: "\(count)", productId: "\(prod.id ?? 0)", productAttributeId: "\(prod.cacheHasAttachments ?? "")", productQuantity: "\(qty)", productName: "\(prod.name![0].value ?? "")", productReference: "\(prod.reference ?? "")", productEan13: "\(prod.ean13 ?? "")", productIsbn: "\(prod.isbn ?? "")", productUpc: "\(prod.upc ?? "")", productPrice: "\(prod.price ?? "")", unitPriceTaxIncl: "\(prod.price ?? "")", unitPriceTaxExcl: "\(prod.price ?? "")")
			//let row2 = CartRow(idProduct: "\(prod.id ?? 0)", idProductAttribute: , idAddressDelivery: <#T##String?#>, quantity: <#T##String?#>)
			store.myOrderRows.append(row)
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
		let beforeAnimation = animateView.transform
//		let originalFrame = self.scrollView.frame
		let beforeCenterX = animateView.center.x
		let beforeCenterY = animateView.center.y
		animateView.alpha = 0.5
		UIView.animate(withDuration: 0.3, animations:
		{
//			copiedView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
			animateView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
		},
					   completion:
		{
			_ in

			UIView.animate(withDuration: 0.65, /*delay: 1.0, usingSpringWithDamping: CGFloat(0), initialSpringVelocity: CGFloat(0), options: [.curveEaseInOut,.allowUserInteraction],*/ animations:
			{
//				copiedView.center.x += self.stackLeft.center.x + 100
//				copiedView.center.y -= self.stackLeft.center.y - 50
				animateView.center.x += self.stackLeft.center.x + 100
				animateView.center.y -= self.stackLeft.center.y - 50
			},
						   completion:
				{
					_ in
					
//					self.scrollView.frame = originalFrame
					animateView.center.x = beforeCenterX
					animateView.center.y = beforeCenterY
					animateView.transform = beforeAnimation
					animateView.alpha = 1
//					sourceView.alpha = 1
				}
			)
		})
		putItemInCart()
		//DispatchQueue.main.async { 	self.tableView.reloadData() 	}
	}

	
	func insertData()
	{
		var i = 0
		for prod in store.products
		{
			let view = CustomView(frame: CGRect(x: 10 + (self.scrollView.frame.width * CGFloat(i)), y: 0, width: self.scrollView.frame.width - 20, height: self.scrollView.frame.height))
			view.prodName.text = prod.name![0].value
			view.prodName.tag = prod.id!
			if prod.showPrice != "0" && Double(prod.price!)! > 0
			{
				view.prodPrice.text = prod.price
			}
			else
			{
				view.prodPrice.text = R.string.noPrice
			}
			view.prodImage.contentMode = UIViewContentMode.scaleAspectFit
			let imgName = prod.associations?.images?[0].id
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
			view.detailsBtn.text = R.string.details
			view.tag = i + 10
			self.scrollView.addSubview(view)
			i += 1
		}
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

