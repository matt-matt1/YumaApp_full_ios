//
//  CartViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-28.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit
import MGSwipeTableCell


class CartViewController: UIViewController
{
	@IBOutlet weak var totalAmt: UILabel!
	@IBOutlet weak var totalLbl: UILabel!
	@IBOutlet weak var totalPcsLbl: UILabel!
	@IBOutlet weak var totalPcs: UILabel!
	//@IBOutlet weak var cellLabel: UILabel!
	@IBOutlet weak var totalWt: UILabel!
	@IBOutlet weak var totalWtLbl: UILabel!
	@IBOutlet weak var tableView: UITableView!
	//@IBOutlet weak var tableCell: UITableViewCell!
	//@IBOutlet weak var cellLabel: UILabel!
	@IBOutlet weak var navBar: UINavigationBar!
	//@IBOutlet weak var table: UITableView!
	@IBOutlet weak var navTitle: UINavigationItem!
	@IBOutlet weak var navClose: UIBarButtonItem!
	@IBOutlet weak var navHelp: UIBarButtonItem!
	@IBOutlet weak var chkoutBtn: GradientButton!
	//MARK: Properties
	let store = DataStore.sharedInstance
	let cellID = "cartCell"
	var total: Double = 0
	var pcs: Int = 0
	var wt: Double = 0

	
	override func viewDidLoad()
	{
        super.viewDidLoad()

		if #available(iOS 11.0, *)
		{
			navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		}
		else
		{
			navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
		}
		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
		chkoutBtn.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		navClose.title = FontAwesome.close.rawValue
		navHelp.title = FontAwesome.questionCircle.rawValue
		navHelp.setTitleTextAttributes([NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)], for: .normal)
		navigationItem.title = R.string.cart
		tableView.layoutIfNeeded()
		totalPcsLbl.text = R.string.pieces
		totalLbl.text = " = "
		totalWtLbl.text = R.string.kg
		if store.myOrderRows.count < 1
		{
			alertEmpty()
		}
		else
		{
			calcTotal()
		}
    }

	
	fileprivate func calcTotal()
	{
		total = 0
		pcs = 0
		wt = 0
		for row in store.myOrderRows
		{
			//print("price=\(row.productPrice ?? ""), convert=\(Double(row.productPrice!)!)")
			total += (Double(Int(row.product_quantity!)!) * Double(row.product_price!)!)
			pcs += Int(row.product_quantity!)!
			var prod: aProduct?
			for p in store.products
			{
				if String(p.id!) == row.product_id!
				{
					prod = p
				}
			}
			if prod != nil
			{
				wt += Double((prod?.weight!)!)!
			}
			//R.string.Total.uppercased()
			totalWt.text = "\(wt)"
		}
		if total < 1
		{
			DispatchQueue.main.async {
				self.alertEmpty()
			}
		}
		else
		{
			//totalAmt.text = "\(total)"
			let totalDbl = total as NSNumber
			totalAmt.text = "\(store.formatCurrency(amount: totalDbl, iso: store.locale))"
			totalPcs.text = "\(pcs)"
			let date = Date()
			store.myOrder = Order(id: 0, id_address_delivery: "", id_address_invoice: "", id_cart: "", id_currency: "", id_lang: store.customer?.id_lang, id_customer: store.customer?.id_customer, id_carrier: "", current_state: "", module: "", invoice_number: "", invoice_date: "", delivery_number: "", delivery_date: "", valid: "", date_add: "\(date)", date_upd: "\(date)", shipping_number: "", id_shop_group: "", id_shop: "", secure_key: "", payment: "", recyclable: "", gift: "", gift_message: "", mobile_theme: "", total_discounts: "", total_discounts_tax_incl: "", total_discounts_tax_excl: "", total_paid: "", total_paid_tax_incl: "", total_paid_tax_excl: "\(total)", total_paid_real: "", total_products: "\(pcs)", total_products_wt: "\(wt)", total_shipping: "", total_shipping_tax_incl: "", total_shipping_tax_excl: "", carrier_tax_rate: "", total_wrapping: "", total_wrapping_tax_incl: "", total_wrapping_tax_excl: "", round_mode: "", round_type: "", conversion_rate: "", reference: "", associations: Associations_OrderRows(order_rows: store.myOrderRows))
			//				store.myOrder = Order(id: 0, idAddressDelivery: "", idAddressInvoice: "", idCart: "", idCurrency: "", idLang: store.customer?.id_lang, idCustomer: store.customer?.id_customer, idCarrier: "", currentState: "", module: "", invoiceNumber: "", invoiceDate: "", deliveryNumber: "", deliveryDate: "", valid: "", dateAdd: "\(date)", dateUpd: "\(date)", shippingNumber: "", idShopGroup: "", idShop: "", secureKey: "", payment: "", recyclable: "", gift: "", giftMessage: "", mobileTheme: "", totalDiscounts: "", totalDiscountsTaxIncl: "", totalDiscountsTaxExcl: "", totalPaid: "", totalPaidTaxIncl: "", totalPaidTaxExcl: "\(total)", totalPaidReal: "", totalProducts: "\(pcs)", totalProductsWt: "\(wt)", totalShipping: "", totalShippingTaxIncl: "", totalShippingTaxExcl: "", carrierTaxRate: "", totalWrapping: "", totalWrappingTaxIncl: "", totalWrappingTaxExcl: "", roundMode: "", roundType: "", conversionRate: "", reference: "", associations: Associations_OrderRows(order_rows: store.myOrderRows))
			//print(store.myOrder)
		}
	}

	
	func alertEmpty()
	{
		DispatchQueue.main.async
		{
			let alert = UIAlertController(title: R.string.err, message: "\(R.string.cart) \(R.string.empty)", preferredStyle: .alert)
			let coloredBG = 					UIView()
			let blurFx = 						UIBlurEffect(style: .dark)
			let blurFxView = 					UIVisualEffectView(effect: blurFx)
			alert.titleAttributes = [NSAttributedString.StringAttribute(key: .foregroundColor, value: R.color.YumaRed)]
			alert.messageAttributes = [NSAttributedString.StringAttribute(key: .foregroundColor, value: UIColor.darkGray)]
			alert.view.superview?.backgroundColor = R.color.YumaRed
			alert.view.shadowColor = R.color.YumaDRed
			alert.view.shadowOffset = .zero
			alert.view.shadowRadius = 5
			alert.view.shadowOpacity = 1
			alert.view.backgroundColor = R.color.YumaYel
			alert.view.cornerRadius = 15
			coloredBG.backgroundColor = 	R.color.YumaRed
			coloredBG.alpha = 				0.4
			coloredBG.frame = 				self.view.bounds
			self.view.addSubview(coloredBG)
			blurFxView.frame = 				self.view.bounds
			blurFxView.alpha = 				0.5
			blurFxView.autoresizingMask = 	[.flexibleWidth, .flexibleHeight]
			self.view.addSubview(blurFxView)
			alert.addAction(UIAlertAction(title: R.string.back.uppercased(), style: .default, handler: { (action) in
				//				DispatchQueue.main.async
				//					{
				coloredBG.removeFromSuperview()
				blurFxView.removeFromSuperview()
				self.dismiss(animated: false, completion: nil)
				//					}
			}))
			self.present(alert, animated: true, completion:
			{
			})
		}
	}
	

	@IBAction func navCloseAct(_ sender: Any)
	{
		self.dismiss(animated: false, completion: nil)
	}
	@IBAction func navHelpAct(_ sender: Any)
	{
		let vc = HelpVC()// as! helpVC
		vc.backgroundColor = .red
		vc.title.text = "hi"
		self.view.addSubview(vc)
	}
	@IBAction func chkoutBtnAct(_ sender: Any)
	{
		store.flexView(view: chkoutBtn)
		store.myOrder?.total_products_wt = String(wt)
		store.myOrder?.total_paid_tax_excl = String(total)
		store.myOrder?.total_products = String(pcs)
		let vc = UIStoryboard(name: "Checkout", bundle: nil).instantiateInitialViewController() as! CheckoutViewController?
		self.present(vc!, animated: false, completion: nil)
	}
	
}


extension CartViewController: UITableViewDataSource, UITableViewDelegate
{
	func numberOfSections(in tableView: UITableView) -> Int
	{
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return store.myOrderRows.count//contents.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! CartViewCell
		cell.setup(store.myOrderRows[indexPath.row])
		cell.rightButtons = [MGSwipeButton(title: R.string.delete, backgroundColor: .red) {
			(sender: MGSwipeTableCell!) -> Bool in
			
			DispatchQueue.main.async
				{
					let alert = UIAlertController(title: R.string.rusure, message: "\(R.string.delete) \"\(cell.prodTitle.text!)\"", preferredStyle: .alert)
					let coloredBG = 				UIView()
					let blurFx = 					UIBlurEffect(style: .dark)
					let blurFxView = 				UIVisualEffectView(effect: blurFx)
					alert.titleAttributes = [NSAttributedString.StringAttribute(key: .foregroundColor, value: R.color.YumaRed)]
					alert.messageAttributes = [NSAttributedString.StringAttribute(key: .foregroundColor, value: UIColor.darkGray)]
					alert.view.superview?.backgroundColor = R.color.YumaRed
					alert.view.shadowColor = R.color.YumaDRed
					alert.view.shadowOffset = .zero
					alert.view.shadowRadius = 5
					alert.view.shadowOpacity = 1
					alert.view.backgroundColor = R.color.YumaYel
					alert.view.cornerRadius = 15
					coloredBG.backgroundColor = 	R.color.YumaRed
					coloredBG.alpha = 				0.3
					coloredBG.frame = 				self.view.bounds
					self.view.addSubview(coloredBG)
					blurFxView.frame = 				self.view.bounds
					blurFxView.alpha = 				0.5
					blurFxView.autoresizingMask = 	[.flexibleWidth, .flexibleHeight]
					self.view.addSubview(blurFxView)
					alert.addAction(UIAlertAction(title: R.string.cancel.uppercased(), style: .default, handler: { (action) in
							coloredBG.removeFromSuperview()
							blurFxView.removeFromSuperview()
					}))
					alert.addAction(UIAlertAction(title: R.string.delete.uppercased(), style: .destructive, handler: { (action) in
							print("delete item:\(indexPath.row)")
							coloredBG.removeFromSuperview()
							blurFxView.removeFromSuperview()
							self.store.myOrderRows.remove(at: indexPath.row)
							tableView.reloadSections([0], with: UITableViewRowAnimation.fade)
							self.calcTotal()
					}))
					self.present(alert, animated: true, completion:
						{
					})
			}
			return true
			}]
		return cell
	}

}
