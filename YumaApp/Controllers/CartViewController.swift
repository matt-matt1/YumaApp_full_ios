//
//  CartViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-28.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit
import MGSwipeTableCell


class CartViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource
{
	//MARK: Outlets
	@IBOutlet weak var totalAmt: UILabel!
	@IBOutlet weak var totalLbl: UILabel!
	@IBOutlet weak var totalPcsLbl: UILabel!
	@IBOutlet weak var totalPcs: UILabel!
	@IBOutlet weak var totalWt: UILabel!
	@IBOutlet weak var totalWtLbl: UILabel!
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var navBar: UINavigationBar!
	@IBOutlet weak var navTitle: UINavigationItem!
	@IBOutlet weak var navClose: UIBarButtonItem!
	@IBOutlet weak var navHelp: UIBarButtonItem!
	@IBOutlet weak var chkoutBtn: GradientButton!
	//MARK: Properties
	let store = DataStore.sharedInstance
	let cellID = "cartCell"
	var total: Float = 0
	var pcs: Int = 0
	var wt: Float = 0
	let picker = UIPickerView()
	var pickerData: [String] = [String]()
	static let noteName = Notification.Name("changedCartCellQty")

	
	//MARK: Override Methods
	override func viewDidLoad()
	{
        super.viewDidLoad()

//		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
		chkoutBtn.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
//		navClose.title = FontAwesome.close.rawValue
//		navHelp.title = FontAwesome.questionCircle.rawValue
//		navHelp.setTitleTextAttributes([NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)], for: .normal)
//		if #available (iOS 10.0, *)
//		{
//			navHelp.setTitleTextAttributes([
//				NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)
//				], for: UIControlState.selected)
//		}
//		else
//		{
//			navHelp.setTitleTextAttributes([
//				NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)
//				], for: UIControlState.highlighted)
////		}
//		navigationItem.title = R.string.cart
		NotificationCenter.default.addObserver(self, selector: #selector(calcTotalWrapper), name: CartViewController.noteName, object: nil)
		tableView.layoutIfNeeded()
		totalPcsLbl.text = R.string.pieces
		totalLbl.text = " = "
		totalWtLbl.text = store.weightUnit//R.string.kg
		if store.myOrderRows.count < 1
		{
			alertEmpty()
		}
		else
		{
			calcTotal()
		}
    }

	
	//MARK: UIPickerViewDelegate, UIPickerViewDataSource required
	func numberOfComponents(in pickerView: UIPickerView) -> Int
	{
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
	{
		return self.pickerData.count
	}

	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
	{
		return pickerData[row]
	}

	
	//MARK: Methods
	@objc func calcTotalWrapper(notify: Notification)
	{
		let sender = notify.object as! UIStepper
		let value = sender.value
		var i = 0
		for row in store.myOrderRows
		{
			if row.product_id == String(sender.tag)
			{
				break
			}
			i += 1
		}
		if value < 1
		{
			sender.value = 1
			store.myOrderRows[i].product_quantity = String(1)
			if let prodTitle = (sender.superview?.superview?.subviews[1].subviews[0] as? UILabel)?.text//, let qty = (sender.superview?.subviews.first.subviews.first.subviews.first as? UITextFiled)?.text
			{
				askToDelete(message: "\(R.string.delete) \"\(prodTitle)\"", row: i)
			}
			else
			{
				askToDelete(message: "\(R.string.delete)?", row: i)
			}
		}
		else
		{
			store.myOrderRows[i].product_quantity = String(Int(value))
			calcTotal()
		}
	}

	func calcTotal()
	{
		total = 0
		pcs = 0
		wt = 0
//		if id_product != nil
//		{
//			for p in store.products
//			{
//
//			}
//			total += (Float(Int(row.product_quantity!)!) * Float(row.product_price!)!)
//			pcs += Int(row.product_quantity!)!
//		}
//		else
//		{
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
			}
		if store.displayWeight
		{
			totalWt.text = "\(wt)"
		}
//		}
		if total < 1
		{
			chkoutBtn.alpha = 0.2
		}
		else
		{
			chkoutBtn.alpha = 1
		}
		if pcs < 1
		{
			DispatchQueue.main.async {
				self.alertEmpty()
			}
		}
		else
		{
			let totalDbl = total as NSNumber
			totalAmt.text = "\(store.formatCurrency(amount: totalDbl, iso: store.locale))"
			totalPcs.text = "\(pcs)"
			let date = Date()
			store.myOrder = Order(id: 0, idAddressDelivery: 0, idAddressInvoice: 0, idCart: 0, idCurrency: 0, idLang: (store.customer?.idLang != nil) ? (store.customer?.idLang)! : 0, idCustomer: (store.customer?.idCustomer != nil) ? (store.customer?.idCustomer)! : 0, idCarrier: 0, currentState: 0, module: "", invoiceNumber: "", invoiceDate: nil, deliveryNumber: "", deliveryDate: nil, valid: 0, dateAdd: date, dateUpd: date, shippingNumber: "", idShopGroup: 0, idShop: 0, secureKey: "", payment: "", recyclable: false, gift: false, giftMessage: "", mobileTheme: false, totalDiscounts: 0, totalDiscountsTaxIncl: 0, totalDiscountsTaxExcl: 0, totalPaid: 0, totalPaidTaxIncl: 0, totalPaidTaxExcl: total, totalPaidReal: 0, totalProducts: pcs, totalProductsWt: wt, totalShipping: 0, totalShippingTaxIncl: 0, totalShippingTaxExcl: 0, carrierTaxRate: 0, totalWrapping: 0, totalWrappingTaxIncl: 0, totalWrappingTaxExcl: 0, roundMode: 0, roundType: 0, conversionRate: 0, reference: "", associations: OrdersAssociations(order_rows: store.myOrderRows))
		}
	}

	
	func alertEmpty()
	{
		DispatchQueue.main.async
		{
			if self.store.myOrder != nil
			{
				var str = ""
				let df = DateFormatter()
				df.dateFormat = "yyyy-MM-dd HH:mm:ss"
				if self.store.myOrder?.dateAdd != nil
				{
					str.append(df.string(from: (self.store.myOrder?.dateAdd)!))
					str.append(" ")
				}
				str.append("(")
				if self.store.myOrder?.totalProducts != nil
				{
					str.append("\((self.store.myOrder?.totalProducts)!)\(R.string.pieces)")
					str.append(" ")
				}
				if self.store.myOrder?.totalProductsWt != nil
				{
					str.append("\((self.store.myOrder?.totalProductsWt)!)\(self.store.weightUnit)")//R.string.kg)")
					str.append(" ")
				}
				if self.store.myOrder?.totalPaid != nil && Int((self.store.myOrder?.totalPaid)!) > 0
				{
					let format = NumberFormatter()
					format.locale = Locale(identifier: self.store.locale)
					let num = format.number(from: ("\((self.store.myOrder?.totalPaid)!)"))
					str.append("=\(format.string(from: num!) ?? "0")")
				}
				str.append(")")
				self.pickerData.append(str)
			}
			for oh in self.store.orderHistories
			{
				let df = DateFormatter()
				var str = ""
				if oh.dateAdd != nil
				{
					str += df.string(from: oh.dateAdd!)//String(oh.dateAdd!)
				}
				if oh.id != nil
				{
					str += " ("
					str += String(oh.idOrder!)
					str += ")"
				}
				self.pickerData.append(str)
			}
			print(self.pickerData.joined(separator: ", "))
			myAlertOnlyDismiss(self, title: R.string.err, message: "\(R.string.cart) \(R.string.empty)", dismissTitle: R.string.back.uppercased(), dismissAction: {
//			let alert = 					UIAlertController(title: R.string.err, message: "\(R.string.cart) \(R.string.empty)", preferredStyle: .alert)
//			let coloredBG = 				UIView()
//			let blurFx = 					UIBlurEffect(style: .dark)
//			let blurFxView = 				UIVisualEffectView(effect: blurFx)
//			alert.titleAttributes = 		[NSAttributedString.StringAttribute(key: .foregroundColor, value: R.color.YumaRed)]
//			alert.messageAttributes = 		[NSAttributedString.StringAttribute(key: .foregroundColor, value: UIColor.darkGray)]
//			alert.view.superview?.backgroundColor = R.color.YumaRed
//			alert.view.shadowColor = 		R.color.YumaDRed
//			alert.view.shadowOffset = 		.zero
//			alert.view.shadowRadius = 		5
//			alert.view.shadowOpacity = 		1
//			alert.view.backgroundColor = 	R.color.YumaYel
//			alert.view.cornerRadius = 		15
//			coloredBG.backgroundColor = 	R.color.YumaRed
//			coloredBG.alpha = 				0.4
//			coloredBG.frame = 				self.view.bounds
//			self.view.addSubview(coloredBG)
//			blurFxView.frame = 				self.view.bounds
//			blurFxView.alpha = 				0.5
//			blurFxView.autoresizingMask = 	[.flexibleWidth, .flexibleHeight]
//			self.view.addSubview(blurFxView)
//			alert.addAction(UIAlertAction(title: R.string.back.uppercased(), style: .default, handler:
//			{	(action) in
//				coloredBG.removeFromSuperview()
//				blurFxView.removeFromSuperview()
				self.dismiss(animated: false, completion: nil)
				let sb = UIStoryboard(name: "HelpStoryboard", bundle: nil)
				let vc = sb.instantiateInitialViewController() as? PickerViewController
				if vc != nil
				{
					DispatchQueue.main.async
					{
						self.present(vc!, animated: true, completion: nil)
						//vc?.dialog.layer.cornerRadius = 20
						//vc?.dialog.cornerRadius = 20
						//vc?.titleLbl.text = R.string.select + " " + R.string.order
						//vc?.button.setTitle(R.string.select, for: .normal)
						vc?.view.addSubview(self.picker)
						self.picker.translatesAutoresizingMaskIntoConstraints = false
						NSLayoutConstraint.activate([
							self.picker.centerXAnchor.constraint(equalTo: (vc?.dialog.centerXAnchor)!),
							self.picker.centerYAnchor.constraint(equalTo: (vc?.dialog.centerYAnchor)!),
							])
						//				vc?.pickerView.removeFromSuperview()
						vc?.button.addTarget(self, action: #selector(self.writePickedValue(_:)), for: .touchUpInside)
					}
				}
				else
				{
					print("HelpStoryboard has no initial view controller")
				}
			})
//			self.present(alert, animated: true, completion:
//			{
//			})
		}
	}
	

	@objc func writePickedValue(_ sender: UIButton?)
	{
		//self.addMessageField.text = pickerData[picker.selectedRow(inComponent: 0)]
	}
	
	
	func askToDelete(message: String, row: Int)
	{
		myAlertDialog(self, title: R.string.rusure, message: message, cancelTitle: R.string.cancel.uppercased(), cancelAction: nil, okTitle: R.string.delete.uppercased(), okAction: {
				self.store.myOrderRows.remove(at: row)
				self.tableView.reloadSections([0], with: UITableViewRowAnimation.fade)
				self.calcTotal()
		}) {
		}
//		DispatchQueue.main.async
//		{
//			let alert = UIAlertController(title: R.string.rusure, message: message, preferredStyle: .alert)
//			let coloredBG = 				UIView()
//			let blurFx = 					UIBlurEffect(style: .dark)
//			let blurFxView = 				UIVisualEffectView(effect: blurFx)
//			alert.titleAttributes = [NSAttributedString.StringAttribute(key: .foregroundColor, value: R.color.YumaRed)]
//			alert.messageAttributes = [NSAttributedString.StringAttribute(key: .foregroundColor, value: UIColor.darkGray)]
//			alert.view.superview?.backgroundColor = R.color.YumaRed
//			alert.view.shadowColor = R.color.YumaDRed
//			alert.view.shadowOffset = .zero
//			alert.view.shadowRadius = 5
//			alert.view.shadowOpacity = 1
//			alert.view.backgroundColor = R.color.YumaYel
//			alert.view.cornerRadius = 15
//			coloredBG.backgroundColor = 	R.color.YumaRed
//			coloredBG.alpha = 				0.3
//			coloredBG.frame = 				self.view.bounds
//			self.view.addSubview(coloredBG)
//			blurFxView.frame = 				self.view.bounds
//			blurFxView.alpha = 				0.5
//			blurFxView.autoresizingMask = 	[.flexibleWidth, .flexibleHeight]
//			self.view.addSubview(blurFxView)
//			alert.addAction(UIAlertAction(title: R.string.cancel.uppercased(), style: .default, handler: { (action) in
////				self.store.myOrderRows[row].product_quantity = String(1)
//				coloredBG.removeFromSuperview()
//				blurFxView.removeFromSuperview()
//			}))
//			alert.addAction(UIAlertAction(title: R.string.delete.uppercased(), style: .destructive, handler: { (action) in
//				//print("delete item at position \(row)")
//				coloredBG.removeFromSuperview()
//				blurFxView.removeFromSuperview()
//				self.store.myOrderRows.remove(at: row)
//				self.tableView.reloadSections([0], with: UITableViewRowAnimation.fade)
//				self.calcTotal()
//			}))
//			self.present(alert, animated: true, completion:
//			{
//			})
//		}
	}


	//MARK: Actions
	@IBAction func navCloseAct(_ sender: Any)
	{
		self.dismiss(animated: false, completion: nil)
	}
	@IBAction func navHelpAct(_ sender: Any)
	{
		let viewC = Assistance()
		viewC.array = R.array.help_cart_guide
		viewC.title = "\(R.string.cart.capitalized) \(R.string.help.capitalized)"
		viewC.modalTransitionStyle   = .crossDissolve
		viewC.modalPresentationStyle = .overCurrentContext
		self.present(viewC, animated: true, completion: nil)
	}
	@IBAction func chkoutBtnAct(_ sender: Any)
	{
		store.flexView(view: chkoutBtn)
		store.myOrder?.totalProductsWt = wt
		store.myOrder?.totalPaidTaxExcl = total
		store.myOrder?.totalProducts = pcs
//		let vc = UIStoryboard(name: "Checkout", bundle: nil).instantiateInitialViewController() as! CheckoutViewController
//		let vc = UIStoryboard(name: "CheckoutTabsViewController", bundle: nil).instantiateInitialViewController() as! CheckoutTabsViewController
//		vc.selectedViewController = vc.viewControllers?[2]
		let layout = UICollectionViewFlowLayout()
		//layout.scrollDirection = .horizontal
		let root = CheckoutCollection(collectionViewLayout: layout)
		let vc = UINavigationController(rootViewController: root)
		self.present(vc, animated: false, completion: nil)
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
		return store.myOrderRows.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? CartViewCell else
		{	fatalError("The dequeued cell is not an instance of CartViewCell.") 	}
		cell.setup(store.myOrderRows[indexPath.row])
		cell.rightButtons = [MGSwipeButton(title: R.string.delete, backgroundColor: .red) {
			(sender: MGSwipeTableCell!) -> Bool in
			
			self.askToDelete(message: "\(R.string.delete) \"\(cell.prodQtyEdit.text!)x\(cell.prodTitle.text!)\"", row: indexPath.row)
			return true
			}]
		return cell
	}

}
