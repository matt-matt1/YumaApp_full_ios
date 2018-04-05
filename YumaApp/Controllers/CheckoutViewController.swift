//
//  CheckoutViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-09.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController, UIScrollViewDelegate
{
	@IBOutlet weak var navBar: UINavigationBar!
	@IBOutlet weak var navTitle: UINavigationItem!
	@IBOutlet weak var navClose: UIBarButtonItem!
	@IBOutlet weak var navHelp: UIBarButtonItem!
	@IBOutlet weak var title1Block: UIView!
	@IBOutlet weak var tick1: UILabel!
	@IBOutlet weak var title1: UILabel!
	@IBOutlet weak var panel1: UIView!
	@IBOutlet weak var panel1Contents: UIView!
	@IBOutlet weak var title2Block: UIView!
	@IBOutlet weak var tick2: UILabel!
	@IBOutlet weak var title2: UILabel!
	@IBOutlet weak var panel2: UIView!
	@IBOutlet weak var panel2Contents: UIView!
	@IBOutlet weak var title3Block: UIView!
	@IBOutlet weak var tick3: UILabel!
	@IBOutlet weak var title3: UILabel!
	@IBOutlet weak var panel3: UIView!
	@IBOutlet weak var panel3Contents: UIView!
	@IBOutlet weak var title4Block: UIView!
	@IBOutlet weak var tick4: UILabel!
	@IBOutlet weak var title4: UILabel!
	@IBOutlet weak var panel4: UIView!
	@IBOutlet weak var panel4Contents: UIView!
	@IBOutlet weak var buttonLeft: GradientButton!
	@IBOutlet weak var buttonRight: GradientButton!
	var panelHeight: CGFloat = 0
	var panelMinHeight: CGFloat = 50
	var panel: [UIView] = []
	var panelOpen = 1
	/////cart table
	@IBOutlet weak var cartPanel: UIView!
	@IBOutlet weak var cartScroll: UIScrollView!
	@IBOutlet weak var totalPcs: UILabel!
	@IBOutlet weak var totalPcsLbl: UILabel!
	@IBOutlet weak var totalWt: UILabel!
	@IBOutlet weak var totalWtLbl: UILabel!
	//@IBOutlet weak var totalAmtLbl: UILabel!
	@IBOutlet weak var totalAmt: UILabel!
	//@IBOutlet weak var tableView: UITableView!
	let store = DataStore.sharedInstance
	let cellID = "cartCell"
	var latestIsUpdate = false
	var latest: OrderRow? = nil
	var cartCellHeight: CGFloat = 100
	var cartCellVSpace: CGFloat = 5
	
	
	override func viewDidLoad()
	{
        super.viewDidLoad()

		cartScroll.delegate = self
		panelHeight = (panel1.superview?.frame.height)!//panelHeight = panel1.frame.height
		print("panelHeight=\(panelHeight)")
		//cartScroll.layoutIfNeeded()
		cartPanel.layoutIfNeeded()
		fillPanelsWithViews()
		preparePanels()
		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
		buttonLeft.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		buttonRight.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		navClose.title = FontAwesome.close.rawValue
		navClose.setTitleTextAttributes([
			NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)
			], for: UIControlState.normal)
		navHelp.title = FontAwesome.questionCircle.rawValue
		navHelp.setTitleTextAttributes([
			NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)
			], for: UIControlState.normal)
		
		/////cart table
		prepareMiniCart()
		/////
//		panel1.superview?.constraints.forEach({ (constraint) in
//			print(constraint)
//		})
//		<NSLayoutConstraint:0x608000298bf0 Title2.height == Title3.height   (active, names: Title2:0x7f8df44d01b0, Title3:0x7f8df44d0a80 )>
//		<NSLayoutConstraint:0x608000298c90 Title3.height == Title4.height   (active, names: Title3:0x7f8df44d0a80, Title4:0x7f8df44d1350 )>
//		<NSLayoutConstraint:0x608000299230 Title3.top == Panel2.top   (active, names: Title3:0x7f8df44d0a80, Panel2:0x7f8df44cc480 )>
//		<NSLayoutConstraint:0x6080002992d0 Panel3.top == Title4.top   (active, names: Panel3:0x7f8df44ccf40, Title4:0x7f8df44d1350 )>
//		<NSLayoutConstraint:0x608000299870 H:|-(0)-[buttons]   (active, names: buttons:0x7f8df44d2b50, '|':UIStackView:0x7f8df44d2940 )>
//		<NSLayoutConstraint:0x608000299910 H:[buttons]-(0)-|   (active, names: buttons:0x7f8df44d2b50, '|':UIStackView:0x7f8df44d2940 )>
//		<NSLayoutConstraint:0x608000299eb0 Panel4.bottom == Title4.bottom   (active, names: Panel4:0x7f8df44cdce0, Title4:0x7f8df44d1350 )>
//		<NSLayoutConstraint:0x6080004834d0 'UISV-alignment' Title1.leading == Panel1.leading   (active, names: Title1:0x7f8df44cf8e0, Panel1:0x7f8df44cb7b0 )>
//		<NSLayoutConstraint:0x608000483520 'UISV-alignment' Title1.leading == Title2.leading   (active, names: Title1:0x7f8df44cf8e0, Title2:0x7f8df44d01b0 )>
//		<NSLayoutConstraint:0x608000483570 'UISV-alignment' Title1.leading == Panel2.leading   (active, names: Title1:0x7f8df44cf8e0, Panel2:0x7f8df44cc480 )>
//		<NSLayoutConstraint:0x6080004835c0 'UISV-alignment' Title1.leading == Title3.leading   (active, names: Title1:0x7f8df44cf8e0, Title3:0x7f8df44d0a80 )>
//		<NSLayoutConstraint:0x608000483610 'UISV-alignment' Title1.leading == Panel3.leading   (active, names: Title1:0x7f8df44cf8e0, Panel3:0x7f8df44ccf40 )>
//		<NSLayoutConstraint:0x608000483660 'UISV-alignment' Title1.leading == Title4.leading   (active, names: Title1:0x7f8df44cf8e0, Title4:0x7f8df44d1350 )>
//		<NSLayoutConstraint:0x6080004836b0 'UISV-alignment' Title1.leading == Panel4.leading   (active, names: Title1:0x7f8df44cf8e0, Panel4:0x7f8df44cdce0 )>
//		<NSLayoutConstraint:0x608000483700 'UISV-alignment' Title1.leading == buttons.leading   (active, names: Title1:0x7f8df44cf8e0, buttons:0x7f8df44d2b50 )>
//		<NSLayoutConstraint:0x6080004837a0 'UISV-alignment' Title1.trailing == Panel1.trailing   (active, names: Title1:0x7f8df44cf8e0, Panel1:0x7f8df44cb7b0 )>
//		<NSLayoutConstraint:0x6080004837f0 'UISV-alignment' Title1.trailing == Title2.trailing   (active, names: Title1:0x7f8df44cf8e0, Title2:0x7f8df44d01b0 )>
//		<NSLayoutConstraint:0x608000483840 'UISV-alignment' Title1.trailing == Panel2.trailing   (active, names: Title1:0x7f8df44cf8e0, Panel2:0x7f8df44cc480 )>
//		<NSLayoutConstraint:0x608000483890 'UISV-alignment' Title1.trailing == Title3.trailing   (active, names: Title1:0x7f8df44cf8e0, Title3:0x7f8df44d0a80 )>
//		<NSLayoutConstraint:0x6080004838e0 'UISV-alignment' Title1.trailing == Panel3.trailing   (active, names: Title1:0x7f8df44cf8e0, Panel3:0x7f8df44ccf40 )>
//		<NSLayoutConstraint:0x608000483930 'UISV-alignment' Title1.trailing == Title4.trailing   (active, names: Title1:0x7f8df44cf8e0, Title4:0x7f8df44d1350 )>
//		<NSLayoutConstraint:0x608000483980 'UISV-alignment' Title1.trailing == Panel4.trailing   (active, names: Title1:0x7f8df44cf8e0, Panel4:0x7f8df44cdce0 )>
//		<NSLayoutConstraint:0x6080004839d0 'UISV-alignment' Title1.trailing == buttons.trailing   (active, names: Title1:0x7f8df44cf8e0, buttons:0x7f8df44d2b50 )>
//		<NSLayoutConstraint:0x6080004830c0 'UISV-canvas-connection' UIStackView:0x7f8df44d2940.top == Title1.top   (active, names: Title1:0x7f8df44cf8e0 )>
//		<NSLayoutConstraint:0x608000483110 'UISV-canvas-connection' V:[buttons]-(0)-|   (active, names: buttons:0x7f8df44d2b50, '|':UIStackView:0x7f8df44d2940 )>
//		<NSLayoutConstraint:0x60800029ad10 'UISV-canvas-connection' UIStackView:0x7f8df44d2940.leading == Title1.leading   (active, names: Title1:0x7f8df44cf8e0 )>
//		<NSLayoutConstraint:0x608000483480 'UISV-canvas-connection' H:[Title1]-(0)-|   (active, names: Title1:0x7f8df44cf8e0, '|':UIStackView:0x7f8df44d2940 )>
//		<NSLayoutConstraint:0x608000483160 'UISV-spacing' V:[Title1]-(0)-[Panel1]   (active, names: Panel1:0x7f8df44cb7b0, Title1:0x7f8df44cf8e0 )>
//		<NSLayoutConstraint:0x6080004831b0 'UISV-spacing' V:[Panel1]-(0)-[Title2]   (active, names: Title2:0x7f8df44d01b0, Panel1:0x7f8df44cb7b0 )>
//		<NSLayoutConstraint:0x608000299f50 'UISV-spacing' V:[Title2]-(0)-[Panel2]   (active, names: Panel2:0x7f8df44cc480, Title2:0x7f8df44d01b0 )>
//		<NSLayoutConstraint:0x608000483200 'UISV-spacing' V:[Panel2]-(0)-[Title3]   (active, names: Title3:0x7f8df44d0a80, Panel2:0x7f8df44cc480 )>
//		<NSLayoutConstraint:0x6080004832a0 'UISV-spacing' V:[Title3]-(0)-[Panel3]   (active, names: Panel3:0x7f8df44ccf40, Title3:0x7f8df44d0a80 )>
//		<NSLayoutConstraint:0x6080004832f0 'UISV-spacing' V:[Panel3]-(0)-[Title4]   (active, names: Title4:0x7f8df44d1350, Panel3:0x7f8df44ccf40 )>
//		<NSLayoutConstraint:0x608000483390 'UISV-spacing' V:[Title4]-(0)-[Panel4]   (active, names: Panel4:0x7f8df44cdce0, Title4:0x7f8df44d1350 )>
//		<NSLayoutConstraint:0x608000483430 'UISV-spacing' V:[Panel4]-(0)-[buttons]   (active, names: buttons:0x7f8df44d2b50, Panel4:0x7f8df44cdce0 )>
		
		//panel1.subviews[0].addSubview(CheckoutStep1ViewController())
//		UIView.animate(withDuration: 60) {
//			self.panel1.heightAnchor.constraint(equalToConstant: 100).isActive = true
//			self.panel1.superview?.heightAnchor.constraint(equalToConstant: 100).isActive = true
				//.frame.height = 100
//		}
//		UIView.animate(withDuration: 60) {
//			self.panel2.heightAnchor.constraint(equalToConstant: 100).isActive = true
//		}
    }
	
	
	func prepareMiniCart()
	{
		//let miniCart = ProductsViewController()
		totalPcsLbl.text = R.string.pieces
		totalWtLbl.text = R.string.kg
		//let (wt, pcs, tot) = populateCartTotal()//miniCart
		totalPcs.text = /* "\(pcs)" */store.myOrder?.totalProducts
		totalWt.text = /* "\(wt)" */store.myOrder?.totalProductsWt
//		totalAmt.text = /* tot */store.myOrder?.totalPaidTaxExcl
		let totalDbl = (store.myOrder?.totalPaidTaxExcl?.toDouble()!)! as NSNumber
		totalAmt.text = store.formatCurrency(amount: totalDbl, iso: store.locale)
		if store.myOrderRows.count > 0
		{
			//for i in (0..<store.myOrderRows.count).reversed()
			for i in 0..<store.myOrderRows.count
			{
				if store.myOrderRows.count > 1 && !latestIsUpdate
				{
					for scr in self.cartScroll.subviews
					{
						if type(of: scr) == CartCell.self
						{
							//							scr.frame.origin.y += miniCart.cartCellHeight + (2*miniCart.cartCellVSpace)//10//104
							scr.frame.origin.y += cartCellHeight + (2*cartCellVSpace)//10//104
						}
					}
					drawCartItem(i)//miniCart.drawCartItem(i)
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
						drawCartItem(i)//miniCart.drawCartItem(i)
					}
				}
			}
			//chkoutBtn.alpha = 1
		}
		//		totalAmtLbl.text = R.string.Total.uppercased()
		//		totalPcsLbl.text = R.string.pieces
		//		tableView.delegate = self
		//		cartPanel.superview?.constraints.forEach({ (constraint) in
		//			if constraint.firstItem === cartPanel && constraint.firstAttribute == .width
		//			{
		//				constraint.constant = self.view.frame.width * 1/3
		//			}
		//		})
		//		fillCart()
	}
	
	
	func preparePanels()
	{
		title1.text = "\(R.string.s1) \(R.string.chk1.uppercased())"
		//		title1Block.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.openPanel1(_:))))
		title1Block.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.openPanel)))
		let _ = title1Block.addBackgroundGradient(colors: [R.color.YumaRed.cgColor, UIColor.gray.cgColor], isVertical: false)
		tick1.font = R.font.FontAwesomeOfSize(pointSize: Int(tick1.frame.height)-1)
		tick1.text = FontAwesome.checkCircleO.rawValue
		title2.text = "\(R.string.s2) \(R.string.chk2.uppercased())"
		//		title2Block.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.openPanel2(_:))))
		title2Block.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.openPanel)))
		let _ = title2Block.addBackgroundGradient(colors: [R.color.YumaRed.cgColor, UIColor.gray.cgColor], isVertical: false)
		tick2.font = R.font.FontAwesomeOfSize(pointSize: Int(tick1.frame.height)-1)
		tick2.text = FontAwesome.checkCircleO.rawValue
		tick2.alpha = 0
		title3.text = "\(R.string.s3) \(R.string.chk3.uppercased())"
		//		title3Block.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.openPanel3(_:))))
		title3Block.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.openPanel)))
		let _ = title3Block.addBackgroundGradient(colors: [R.color.YumaRed.cgColor, UIColor.gray.cgColor], isVertical: false)
		tick3.font = R.font.FontAwesomeOfSize(pointSize: Int(tick1.frame.height)-1)
		tick3.text = FontAwesome.checkCircleO.rawValue
		tick3.alpha = 0
		title4.text = "\(R.string.s4) \(R.string.chk4.uppercased())"
		//		title4Block.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.openPanel4(_:))))
		title4Block.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.openPanel)))
		let _ = title4Block.addBackgroundGradient(colors: [R.color.YumaRed.cgColor, UIColor.gray.cgColor], isVertical: false)
		tick4.font = R.font.FontAwesomeOfSize(pointSize: Int(tick1.frame.height)-1)
		tick4.text = FontAwesome.checkCircleO.rawValue
		tick4.alpha = 0
		
		panel = [panel1, panel2, panel3, panel4]//??????
	}
	
	
	/////cart table
//	func populateCartTotal() -> (Double, Int, String)
//	{
//		var total: Double = 0
//		var pcs: Int = 0
//		var wt: Double = 0
//		var i = 0
//		for row in store.myOrderRows
//		{
//			//print("price=\(row.productPrice ?? ""), convert=\(Double(row.productPrice!)!)")
//			total += (Double(Int(row.productQuantity!)!) * Double(row.productPrice!)!)
//			pcs += Int(row.productQuantity!)!
//			//			let prodWeight = NumberFormatter().number(from: store.products[pageControl.currentPage].weight!)?.doubleValue
//			for p in store.products
//			{
//				if p.id! == Int(row.productId!)!
//				{
//					wt += (p.weight?.toDouble())!
//					break
//				}
//			}
//			let prodWeight = NumberFormatter().number(from: store.products[i].weight!)?.doubleValue
//			if let prodWeight = prodWeight
//			{
//				wt = wt + Double(prodWeight)
//			}
//			i += 1
//		}
//		let totalDbl = total as NSNumber
//		let totalStr = store.formatCurrency(amount: totalDbl, iso: store.locale)
//		//totalAmt.text = totalStr
//		//totalPcs.text = "\(pcs)"
//		return (wt, pcs, totalStr)
//	}

	
	fileprivate func drawCartItem(_ i: Int? = nil)
	{
		//cartScroll.widthAnchor.constraint(equalTo: cartPanel.widthAnchor).isActive = true
		print("CHK cart cell width:\(cartScroll.frame.width), cartPanel width:\(cartPanel.frame.width)")
		let view = CartCell(frame: CGRect(x: 0, y: cartCellVSpace, width: min(300, cartScroll.frame.width, cartPanel.frame.width), height: cartCellHeight))
		cartScroll.contentSize.height += cartCellHeight + (2*cartCellVSpace)
		if i != nil
		{
			latest = store.myOrderRows[i!]
		}
		let name = latest?.productName//thisOrder.productName//prod.name![0].value
		view.prodName.text = name
		view.prodName.lineBreakMode = .byTruncatingHead
		view.tag = Int((latest?.productId)!)!
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
		view.prodQty.text = latest?.productQuantity//thisOrder.productQuantity//prod.quantity
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

//	func fillCart()
//	{
//		var total: Double = 0
//		var pcs: Int = 0
//		var wt: Double = 0
//		for row in store.myOrderRows
//		{
//			//print("price=\(row.productPrice ?? ""), convert=\(Double(row.productPrice!)!)")
//			total = total + (Double(Int(row.productQuantity!)!) * Double(row.productPrice!)!)
//			pcs = pcs + Int(row.productQuantity!)!
//			var prod: aProduct?
//			for p in store.products
//			{
//				if String(p.id!) == row.productId!
//				{
//					prod = p
//					break
//				}
//			}
//			if prod != nil
//			{
//				wt = wt + Double((prod?.weight!)!)!//row.productId
//			}
//		}
//		totalAmt.text = "\(total)"
//		totalPcs.text = "\(pcs) (\(wt)kg)"
//		let date = Date()
//		store.myOrder = Order(id: 0, idAddressDelivery: "", idAddressInvoice: "", idCart: "", idCurrency: "", idLang: store.customer?.id_lang, idCustomer: store.customer?.id_customer, idCarrier: "", currentState: "", module: "", invoiceNumber: "", invoiceDate: "", deliveryNumber: "", deliveryDate: "", valid: "", dateAdd: "\(date)", dateUpd: "\(date)", shippingNumber: "", idShopGroup: "", idShop: "", secureKey: "", payment: "", recyclable: "", gift: "", giftMessage: "", mobileTheme: "", totalDiscounts: "", totalDiscountsTaxIncl: "", totalDiscountsTaxExcl: "", totalPaid: "", totalPaidTaxIncl: "", totalPaidTaxExcl: "", totalPaidReal: "", totalProducts: "\(pcs)", totalProductsWt: "\(wt)", totalShipping: "", totalShippingTaxIncl: "", totalShippingTaxExcl: "", carrierTaxRate: "", totalWrapping: "", totalWrappingTaxIncl: "", totalWrappingTaxExcl: "", roundMode: "", roundType: "", conversionRate: "", reference: "", associations: Associations_OrderRows(order_rows: store.myOrderRows))
//		//print(store.myOrder)
//	}
	/////
	
	
	func fillPanelsWithViews()
	{
		for i in 0..<4
		{
			let stack = UIStackView()
			stack.translatesAutoresizingMaskIntoConstraints = false
			//stack.alignment = UIStackViewAlignment.center
			switch (i)
			{
			case 4:
				let step = CheckoutStep4ViewController()
				stack.addArrangedSubview(step.view)
				panel4Contents.addSubview(stack)
				break
			case 3:
				let step = CheckoutStep3ViewController()
				stack.addArrangedSubview(step.view)
				panel3Contents.addSubview(stack)
				break
			case 2:
				let step = CheckoutStep2ViewController()
				stack.addArrangedSubview(step.view)
				panel2Contents.addSubview(stack)
				break
			//case 1:
			default:
				//let step = CheckoutStep1ViewController()
				panel1Contents.layoutIfNeeded()
				print("x:\(panel1Contents.frame.origin.x), y:\(panel1Contents.frame.origin.y), width:\(panel1Contents.frame.width), height:\(panel1Contents.frame.height)")
				let stack = CheckoutStep1View(frame: CGRect(x: panel1Contents.frame.origin.x, y: panel1Contents.frame.origin.y, width: panel1Contents.frame.width, height: 100/*panel1Contents.frame.height*/))
				//stack.addArrangedSubview(step)
				panel1Contents.addSubview(stack)
			}
		}
	}
	
	
	func is_open(view: UIView) -> Bool
	{
		return view.superview?.frame.height != self.panelMinHeight
	}
	func is_closed(view: UIView) -> Bool
	{
		return view.superview?.frame.height != self.panelHeight
	}
	
	fileprivate func accordian(_ num: Int)
	{
		guard num > 0 && num < 5 else
		{
			print("invalid num call to accordian")
			return
		}
//		print("1:\(self.panel1.superview?.frame.height ?? -1)",
//		"2:\(self.panel2.superview?.frame.height ?? -1)",
//		"3:\(self.panel3.superview?.frame.height ?? -1)",
//		"4:\(self.panel4.superview?.frame.height ?? -1)")
		/*
		var moved = false
		UIView.animate(withDuration: 13, animations: {
			if num != 1
			{
				if self.is_open(view: self.panel1)	//if self.panel1.superview?.frame.height != self.panelMinHeight
				{
					self.panel1.superview?.heightAnchor.constraint(equalToConstant: self.panelMinHeight).isActive = true
					//close 1 open 2
					moved = true
				}
			}
			if num != 2
			{
				if self.is_open(view: self.panel2)	//if self.panel2.superview?.frame.height != self.panelMinHeight
				{
					self.panel2.superview?.heightAnchor.constraint(equalToConstant: self.panelMinHeight).isActive = true
					//close 2 open 3
					//moved = true
					self.panel2.superview?.layoutIfNeeded()
				}
			}
			if num != 3
			{
				if self.is_open(view: self.panel3)	//if self.panel3.superview?.frame.height != self.panelMinHeight
				{
					self.panel3.superview?.heightAnchor.constraint(equalToConstant: self.panelMinHeight).isActive = true
					//close 3 open 4
					moved = true
				}
			}
			if num != 4
			{
				if self.is_open(view: self.panel4)
				{
					self.panel4.superview?.heightAnchor.constraint(equalToConstant: self.panelMinHeight).isActive = true
					//close 4
				}
//				if self.is_open(view: self.panel4)	//if self.panel4.superview?.frame.height != self.panelMinHeight
//				{
//					self.panel4.superview?.heightAnchor.constraint(equalToConstant: self.panelMinHeight).isActive = true
//					//close 4
//					moved = true
//				}
				if self.is_closed(view: self.panel1)
				{
					self.panel1.superview?.heightAnchor.constraint(equalToConstant: self.panelHeight).isActive = true
					//open 1
				}
			}


//						if num != 4
//						{
//						}
//						else if self.is_closed(view: self.panel4)/*self.panel4.superview?.frame.height != self.panelHeight*/ && !moved
//						{
//	//						print("1:\(self.panel1.superview?.frame.height ?? -1)")
//	//						print("2:\(self.panel2.superview?.frame.height ?? -1)")
//	//						print("3:\(self.panel3.superview?.frame.height ?? -1)")
//	//						print("4:\(self.panel4.superview?.frame.height ?? -1)")
//							self.panel4.superview?.heightAnchor.constraint(equalToConstant: self.panelHeight).isActive = true
//						}
//					}
//					else if self.is_closed(view: self.panel3)/*self.panel3.superview?.frame.height != self.panelHeight*/ && !moved
//					{
//	//					print("1:\(self.panel1.superview?.frame.height ?? -1)")
//	//					print("2:\(self.panel2.superview?.frame.height ?? -1)")
//	//					print("3:\(self.panel3.superview?.frame.height ?? -1)")
//	//					print("4:\(self.panel4.superview?.frame.height ?? -1)")
//						self.panel3.superview?.heightAnchor.constraint(equalToConstant: self.panelHeight).isActive = true
//					}
//				}
//				else if self.is_closed(view: self.panel2)/*self.panel2.superview?.frame.height != self.panelHeight*/ && !moved
//				{
//	//				print("1:\(self.panel1.superview?.frame.height ?? -1)")
//	//				print("2:\(self.panel2.superview?.frame.height ?? -1)")
//	//				print("3:\(self.panel3.superview?.frame.height ?? -1)")
//	//				print("4:\(self.panel4.superview?.frame.height ?? -1)")
//					self.panel2.superview?.heightAnchor.constraint(equalToConstant: self.panelHeight).isActive = true
//				}
//				//self.panel[i].layoutIfNeeded()
//			}
//			else//if num == 1
//			{
//				if self.is_closed(view: self.panel1)
//				{
//					self.panel1.superview?.heightAnchor.constraint(equalToConstant: self.panelHeight).isActive = true
//					//open 1
//				}
//			}
		}, completion: {
			(done) in
			print("1:\(self.panel1.superview?.frame.height ?? -1)")
			print("2:\(self.panel2.superview?.frame.height ?? -1)")
			print("3:\(self.panel3.superview?.frame.height ?? -1)")
			print("4:\(self.panel4.superview?.frame.height ?? -1)")
		})
		*/
/**/
		UIView.animate(withDuration: 1.3, animations: {
			for i in 0..<4
			{
				print(i+1)
				self.view.layoutIfNeeded()
				if i != num-1
				{
					print("not num")
					if self.is_open(view: self.panel[i])
					{
						self.panel[i].superview?.heightAnchor.constraint(equalToConstant: self.panelMinHeight).isActive = true
						print("closing panel \(i+1)")
					}
				}
			}
		})
/**/
/*
		//		panel[num-1].heightAnchor.constraint(equalToConstant: panelHeight).constant = panelHeight
		//		panel[num-1].animateConstraintWithDuration()
		//self.view.layoutIfNeeded()
		UIView.animate(withDuration: 1.3, animations: {
			//			self.panel[num-1].heightAnchor.constraint(equalToConstant: self.panelHeight).isActive = true
			self.panel[num-1].superview?.heightAnchor.constraint(equalToConstant: self.panelHeight).isActive = true
			//self.panel[num-1].layoutIfNeeded()
		})
*/
	}
	
	@objc func openPanel(_ sender: UITapGestureRecognizer)
	{
		let str = (sender.view?.subviews[0].subviews[0].subviews[1] as! UILabel).text!
		let cha = str[str.index(str.startIndex, offsetBy: 0)]
		let num = Int(String(cha))!
		panelOpen = num
		accordian(num)
		//self.view.layoutIfNeeded()
	}

//	@objc func openPanel1(_ sender: UITapGestureRecognizer)
//	{
//		if panel1.frame.height == 0
//		{
//			if panel2.frame.height != 0
//			{
//				panel2.heightAnchor.constraint(equalToConstant: 0)
//				panel2.animateConstraintWithDuration()
//			}
//			if panel3.frame.height != 0
//			{
//				panel3.heightAnchor.constraint(equalToConstant: 0)
//				panel3.animateConstraintWithDuration()
//			}
//			if panel4.frame.height != 0
//			{
//				panel4.heightAnchor.constraint(equalToConstant: 0)
//				panel4.animateConstraintWithDuration()
//			}
//			panel1.heightAnchor.constraint(equalToConstant: panelHeight)
//			panel1.animateConstraintWithDuration()
//		}
//	}
//
//	@objc func openPanel2(_ sender: UITapGestureRecognizer)
//	{
//		if panel2.frame.height == 0
//		{
//			if panel1.frame.height != 0
//			{
//				panel1.heightAnchor.constraint(equalToConstant: 0)
//				panel1.animateConstraintWithDuration()
//			}
//			if panel3.frame.height != 0
//			{
//				panel3.heightAnchor.constraint(equalToConstant: 0)
//				panel3.animateConstraintWithDuration()
//			}
//			if panel4.frame.height != 0
//			{
//				panel4.heightAnchor.constraint(equalToConstant: 0)
//				panel4.animateConstraintWithDuration()
//			}
//			panel2.heightAnchor.constraint(equalToConstant: panelHeight)
//			panel2.animateConstraintWithDuration()
//		}
//	}
//
//	@objc func openPanel3(_ sender: UITapGestureRecognizer)
//	{
//		print(sender)
//		if panel3.frame.height == 0
//		{
//			if panel2.frame.height != 0
//			{
//				panel2.heightAnchor.constraint(equalToConstant: 0)
//				panel2.animateConstraintWithDuration()
//			}
//			if panel1.frame.height != 0
//			{
//				panel1.heightAnchor.constraint(equalToConstant: 0)
//				panel1.animateConstraintWithDuration()
//			}
//			if panel4.frame.height != 0
//			{
//				panel4.heightAnchor.constraint(equalToConstant: 0)
//				panel4.animateConstraintWithDuration()
//			}
//			panel3.heightAnchor.constraint(equalToConstant: panelHeight)
//			panel3.animateConstraintWithDuration()
//		}
//	}
//
//	@objc func openPanel4(_ sender: UITapGestureRecognizer)
//	{
//		if panel4.frame.height == 0
//		{
//			if panel2.frame.height != 0
//			{
//				panel2.heightAnchor.constraint(equalToConstant: 0)
//				panel2.animateConstraintWithDuration()
//			}
//			if panel3.frame.height != 0
//			{
//				panel3.heightAnchor.constraint(equalToConstant: 0)
//				panel3.animateConstraintWithDuration()
//			}
//			if panel1.frame.height != 0
//			{
//				panel1.heightAnchor.constraint(equalToConstant: 0)
//				panel1.animateConstraintWithDuration()
//			}
//			panel4.heightAnchor.constraint(equalToConstant: panelHeight)
//			panel4.animateConstraintWithDuration()
//		}
//	}

//	override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    
//	@IBAction func panel1LoginBtnAct(_ sender: Any)
//	{
//	}
//	@IBAction func panel1WithoutSwiAct(_ sender: Any)
//	{
//	}
//	@IBAction func panel1LogoutBtnAct(_ sender: Any)
//	{
//	}
	@IBAction func buttonRightAct(_ sender: Any)
	{
	}
	@IBAction func buttonLeftAct(_ sender: Any)
	{
		panelOpen += 1
		if panelOpen > 4
		{
			panelOpen = 1
		}
		var i = 0
		while (panel[panelOpen].superview?.subviews.first?.subviews.first as! UILabel).textColor == R.color.YumaYel
		{
			panelOpen += 1
			if i > 3
			{
				print("all complete")
				buttonRight.alpha = 1
			}
			i += 1
		}
		accordian(panelOpen)
	}
	@IBAction func navCloseBtnAct(_ sender: Any)
	{
		self.dismiss(animated: false, completion: nil)
	}
	@IBAction func navHelpBtnAct(_ sender: Any)
	{
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


/////cart table
extension CheckoutViewController: UITableViewDataSource, UITableViewDelegate
{
	func numberOfSections(in tableView: UITableView) -> Int
	{
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return store.myOrderRows.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! CartViewCell
		cell.setup(store.myOrderRows[indexPath.row])
		return cell
	}
	
}
/////


class CheckoutStep1View: UIView
{
	let store = DataStore.sharedInstance
	let stack: UIStackView =
	{
		let view = UIStackView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	
	override init(frame: CGRect)
	{
		super.init(frame: frame)
		
		if store.customer?.id == nil && store.customer?.id_customer == nil
		{
			//not logged-in
			let loginBtn = UIButton()
			loginBtn.setTitle(R.string.login, for: .normal)
			loginBtn.translatesAutoresizingMaskIntoConstraints = false
			let orLabel = UILabel()
			orLabel.text = "- or -"//R.string.or
			orLabel.textAlignment = .center
			orLabel.translatesAutoresizingMaskIntoConstraints = false
			let withoutLabel = UILabel()
			withoutLabel.text = R.string.without
			withoutLabel.translatesAutoresizingMaskIntoConstraints = false
			let withoutSwitch = UISwitch()
			withoutSwitch.tintColor = R.color.YumaRed
			withoutSwitch.translatesAutoresizingMaskIntoConstraints = false
			let row = UIStackView(arrangedSubviews: [withoutLabel, withoutSwitch])
			row.translatesAutoresizingMaskIntoConstraints = false
			row.spacing = 5
			
			let stack = UIStackView(arrangedSubviews: [loginBtn, orLabel, row])
			stack.spacing = 20
			stack.axis = UILayoutConstraintAxis.vertical
			stack.translatesAutoresizingMaskIntoConstraints = false
		}
		else
		{
			//logged-in
			let asLabel = UILabel()
			asLabel.text = R.string.logAs
			asLabel.translatesAutoresizingMaskIntoConstraints = false
			let nameLabel = UILabel()
			nameLabel.translatesAutoresizingMaskIntoConstraints = false
			if (store.customer?.lastname != nil && store.customer?.lastname != "" && store.customer?.firstname != nil && store.customer?.firstname != "")
			{
				nameLabel.text = (store.customer?.firstname)! + " " + (store.customer?.lastname)!
			}
			else
			{
				nameLabel.text = store.customer?.email
			}
			let row = UIStackView(arrangedSubviews: [asLabel, nameLabel])
			row.spacing = 10
			row.translatesAutoresizingMaskIntoConstraints = false
			
			let signOutBtn = UIButton()
			signOutBtn.setTitle(R.string.SignOut, for: .normal)
			signOutBtn.target(forAction: #selector(MyAccountViewController.signOutBtnAct(_:)), withSender: nil)
			//signOutBtn.addTarget(self, action: #selector(MyAccountViewController.signOutBtnAct(_:)), for: .action)
			signOutBtn.translatesAutoresizingMaskIntoConstraints = false
			let stack = UIStackView(arrangedSubviews: [row, signOutBtn])
			stack.spacing = 20
			stack.axis = .vertical
			stack.translatesAutoresizingMaskIntoConstraints = false
		}
		self.addSubview(stack)
		NSLayoutConstraint.activate([
			stack.topAnchor.constraint(equalTo: self.topAnchor/*, constant: 5*/),
			stack.leadingAnchor.constraint(equalTo: self.leadingAnchor/*, constant: 5*/),
			stack.bottomAnchor.constraint(equalTo: self.bottomAnchor/*, constant: -5*/),
			stack.trailingAnchor.constraint(equalTo: self.trailingAnchor/*, constant: -5*/),
			])
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
