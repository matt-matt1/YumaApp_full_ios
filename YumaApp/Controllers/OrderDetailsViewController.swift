//
//  OrderDetailsViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-06.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class OrderDetailsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource
{
	@IBOutlet weak var navBar: UINavigationBar!
	@IBOutlet weak var navTitle: UINavigationItem!
	@IBOutlet weak var navClose: UIBarButtonItem!
	@IBOutlet weak var navHelp: UIBarButtonItem!
	@IBOutlet weak var orderRef: UILabel!
	@IBOutlet weak var orderRefValue: UILabel!
	@IBOutlet weak var reorderBtn: UIButton!
	@IBOutlet weak var placedOn: UILabel!
	@IBOutlet weak var placedOnValue: UILabel!
	@IBOutlet weak var carrierLabel: UILabel!
	@IBOutlet weak var carrier: UILabel!
	@IBOutlet weak var paymentLabel: UILabel!
	@IBOutlet weak var payment: UILabel!
	@IBOutlet weak var followSteps: UILabel!
	@IBOutlet weak var statusDate: UILabel!
	@IBOutlet weak var statusStatus: UILabel!
	@IBOutlet weak var statusAddHere: UIStackView!
	@IBOutlet weak var deliveryAddr: UILabel!
	@IBOutlet weak var deliveryAddrField: UITextView!
	@IBOutlet weak var invoiceAddr: UILabel!
	@IBOutlet weak var invoiceAddrField: UITextView!
	@IBOutlet weak var orderProduct: UILabel!
	@IBOutlet weak var orderQuantity: UILabel!
	@IBOutlet weak var orderUnitPrice: UILabel!
	@IBOutlet weak var orderTotalPrice: UILabel!
	@IBOutlet weak var orderListAdd2: UIStackView!
	@IBOutlet weak var orderWrapRow: UIStackView!
	@IBOutlet weak var orderWrapProd: UILabel!
	@IBOutlet weak var orderWrapTotal: UILabel!
	@IBOutlet weak var orderWrapQty: UILabel!
	@IBOutlet weak var orderWrapUI: UILabel!
	@IBOutlet weak var orderDiscRow: UIStackView!
	@IBOutlet weak var orderDiscProd: UILabel!
	@IBOutlet weak var orderDiscQty: UILabel!
	@IBOutlet weak var orderDiscUnit: UILabel!
	@IBOutlet weak var orderDiscTotal: UILabel!
	@IBOutlet weak var orderSubtotalProduct: UILabel!
	@IBOutlet weak var orderSubtotalQuantity: UILabel!
	@IBOutlet weak var orderSubtotalLabel: UILabel!
	@IBOutlet weak var orderSubtotalAmt: UILabel!
	@IBOutlet weak var orderShipProd: UILabel!
	@IBOutlet weak var orderShipQty: UILabel!
	@IBOutlet weak var orderShipLabel: UILabel!
	@IBOutlet weak var orderShipAmt: UILabel!
	@IBOutlet weak var orderTaxProd: UILabel!
	@IBOutlet weak var orderTaxQty: UILabel!
	@IBOutlet weak var orderTaxLabel: UILabel!
	@IBOutlet weak var orderTaxAmt: UILabel!
	@IBOutlet weak var orderTotalProd: UILabel!
	@IBOutlet weak var orderTotalQty: UILabel!
	@IBOutlet weak var orderTotalLabel: UILabel!
	@IBOutlet weak var orderTotalAmt: UILabel!
	@IBOutlet weak var messagesLabel: UILabel!
	@IBOutlet weak var addMessageLabel: UILabel!
	@IBOutlet weak var addMessageCaption: UILabel!
	@IBOutlet weak var addMessageProd: UILabel!
	@IBOutlet weak var addMessageList: UIView!
	@IBOutlet weak var addMessageField: UITextField!
	@IBOutlet weak var addMessageArrow: UILabel!
	@IBOutlet weak var addMessageMessageLabel: UILabel!
	@IBOutlet weak var button: GradientButton!
	@IBOutlet weak var addMessageSelect: UIStackView!
	@IBOutlet weak var addMessageMessageField: UITextField!
	let store = DataStore.sharedInstance
	var order: Order? = nil
	var details: OrderDetail? = nil
	let picker = UIPickerView()
	var pickerData: [String] = [String]()
//	var observer: NSObjectProtocol?

	@IBOutlet weak var scrollForm: UIScrollView!


	// MARK: Overrides
	override func viewDidLoad()
	{
        super.viewDidLoad()

		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
		button.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		navTitle.title = R.string.order + " " + R.string.details
		prepareLabels()
		fillData()
		picker.dataSource = self
		picker.delegate = self
		addMessageList.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dropdownList(_:))))
		let notificationCenter = NotificationCenter.default
		notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillHide, object: nil)
		notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
    }

	
//	override func viewDidAppear(_ animated: Bool)
//	{
//		super.viewDidAppear(animated)
	
//		if #available(iOS 11.0, *)
//		{
//			navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//		}
//		else
//		{
//			navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
//		}
//		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
//		button.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
//		navTitle.title = R.string.order + " " + R.string.details
//		prepareLabels()
//		fillData()
//		observer = NotificationCenter.default.addObserver(forName: .gotNameFromPopup, object: nil, queue: OperationQueue.main) { (notification) in
//			let data = notification.object as! PickerViewController
//			//self.addMessageField.text = String(data.pickerView.selectedRow(inComponent: 0))
//			var pickedStr = ""
//			if let picked = data.dialog.subviews[1] as? UIPickerView
//			{
//				pickedStr = String(picked.selectedRow(inComponent: 0))
//			}
//			self.addMessageField.text = pickedStr
//		}
//		addMessageList.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dropdownList(_:))))
//	}
	
//	override func viewDidDisappear(_ animated: Bool)
//	{
//		super.viewDidDisappear(animated)
//		if let observer = observer
//		{
//			NotificationCenter.default.removeObserver(observer)
//		}
//	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


	// MARK: Methods
	func prepareLabels()
	{
		navClose.title = FontAwesome.times.rawValue
		navHelp.title = FontAwesome.questionCircle.rawValue
		navHelp.setTitleTextAttributes([NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)], for: .normal)
		navHelp.setTitleTextAttributes([
			NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)
			], for: UIControlState.highlighted)
		if !store.disallowReorder
		{
			reorderBtn.setTitle(R.string.reorder, for: .normal)
		}
		orderRef.text = R.string.ordRef
		placedOn.text = R.string.placed.capitalized
		carrierLabel.text = R.string.carr
		paymentLabel.text = R.string.payment
		followSteps.text = R.string.ordFoll
		statusDate.text = R.string.date
		statusStatus.text = R.string.status
		deliveryAddr.text = R.string.delAddr
		invoiceAddr.text = R.string.invAddr
		orderProduct.text = R.string.prod
		orderQuantity.text = R.string.Quant
		orderUnitPrice.text = R.string.unitP
		orderTotalPrice.text = R.string.tPrice
		orderSubtotalProduct.text = ""
		orderSubtotalQuantity.text = R.string.subT
		orderSubtotalLabel.text = ""
		orderShipProd.text = ""
		orderShipQty.text = R.string.shipAnd
		orderTaxProd.text = ""
		orderTaxQty.text = R.string.tax
		orderTaxLabel.text = ""
		orderTotalProd.text = ""
		orderTotalQty.text = R.string.Total
		//orderTotalLabel.text =
		if order?.totalWrapping != nil && Double((order?.totalWrapping)!) > 0
		{
			orderWrapRow.isHidden = false
			orderWrapProd.text = ""
			orderWrapQty.text = R.string.wrap
		}
		else
		{
			orderWrapRow.isHidden = true
		}
		if order?.totalDiscounts != nil && Double((order?.totalDiscounts)!) > 0
		{
			orderDiscRow.isHidden = false
			orderDiscProd.text = ""
			orderDiscQty.text = R.string.disc
		}
		else
		{
			orderDiscRow.isHidden = true
		}
		messagesLabel.text = R.string.msgs
		addMessageLabel.text = R.string.addMsg
		addMessageCaption.text = R.string.msgTop
		addMessageProd.text = R.string.prod
		addMessageArrow.text = FontAwesome.caretDown.rawValue
		addMessageArrow.font = R.font.FontAwesomeOfSize(pointSize: 21)
		addMessageArrow.textAlignment = .center
		addMessageArrow.center.y = (addMessageArrow.superview?.center.y)!
		addMessageMessageLabel.text = R.string.msg
		button.setTitle(R.string.addMsg.uppercased(), for: .normal)
	}
	
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int
	{
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
	{
		return pickerData.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
	{
		return pickerData[row]
	}
	

	func fillData()
	{
		if order != nil && order?.reference != nil
		{
			//guard order != nil && order?.reference != nil && order?.reference != "" else { 	return 	}
			var sub: Double = 0, total: Double = 0, tax: Double = 0, unit: Double = 0, handling: Double = 0, handlingIncTax: Double = 0
			if order?.reference != nil
			{
				orderRefValue.text = order?.reference
				// http get order_payments find reference, if found add status paid ...
			}
			placedOnValue.text = ""
			if self.order?.dateAdd != nil
			{
				let df = DateFormatter()
				df.locale = Locale(identifier: self.store.locale)
//				df.dateFormat = "yyyy-MM-dd HH:mm:ss"
//				if let date = df.date(from: (order?.dateAdd)!)
//				{
					df.dateFormat = "dd MMM yyyy"
//					df.string(from: date)
//					placedOnValue.text = df.string(from: date)
				placedOnValue.text = df.string(from: (order?.dateAdd)!)
//				}
			}
			if order?.idCarrier != nil
			{
				var found = false
				for carr in store.carriers
				{
					if carr.idReference != nil
					{
						if Int((carr.idReference)!) == Int((order?.idCarrier)!)
						{
							found = true
							if carr.deleted != nil && carr.deleted!
							{
								carrier.setStrikethrough(text: carr.name!)//, color: R.color.YumaRed)
							}
							else
							{
								carrier.text = carr.name!
							}
							break
//					if carr.shippingHandling != nil && (carr.isFree == nil || carr.isFree != "")
//					{
//						handling = Double(carr.shippingHandling!)!
//					}
//					total += handling
//					orderShipAmt.text = self.store.formatCurrency(amount: NSNumber(value: handling), iso: self.store.locale)
						}
					}
				}
				if !found
				{
					carrier.text = "DELETED (was #" + "\((order?.idCarrier)!)" + ")"
				}
			}
			if store.orderCarriers.count > 0
			{
				for carr in store.orderCarriers
				{
					if (order?.id!)! == Int(carr.id_order!)!
					{
						handling = Double(carr.shipping_cost_tax_excl!)!
						handlingIncTax = Double(carr.shipping_cost_tax_incl!)!
					}
					total += handlingIncTax
				}
				orderShipLabel.text = self.store.formatCurrency(amount: NSNumber(value: handling), iso: self.store.locale)
				orderShipAmt.text = self.store.formatCurrency(amount: NSNumber(value: handlingIncTax), iso: self.store.locale)
			}
			payment.text = order?.payment
			if order?.deliveryDate != nil
			{
				let dateField = UILabel()
				let df = DateFormatter()
				df.locale = Locale(identifier: self.store.locale)
				df.dateFormat = "dd MMM YYYY"
//				if let date = df.date(from: (order?.deliveryDate)!)
//				{
				dateField.text = df.string(from: (order?.deliveryDate)!)
					let status = UILabel()
					status.text = R.string.delivered
					let stack = UIStackView(arrangedSubviews: [dateField, status])
					stack.distribution = .fillEqually
					statusAddHere.addArrangedSubview(stack)
//				}
			}
			// order?.currentState
			if order?.idAddressDelivery != nil
			{
				for del in store.addresses
				{
					if del.id! == Int((order?.idAddressDelivery)!)
					{
						deliveryAddrField.text = store.formatAddress(del, phoneNums: .full)
						break
					}
				}
				deliveryAddrField.isScrollEnabled = false
//				self.automaticallyAdjustsScrollViewInsets = false
//				deliveryAddrField.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
//				deliveryAddrField.contentOffset = CGPoint(x: 0, y: 0)
			}
			if order?.idAddressInvoice != nil
			{
				for inva in store.addresses
				{
					if order?.idAddressInvoice != nil && inva.id! == Int((order?.idAddressInvoice)!)
					{
						invoiceAddrField.text = store.formatAddress(inva, phoneNums: .full)
						break
					}
				}
				invoiceAddrField.isScrollEnabled = false
//				invoiceAddrField.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
			}
			if order?.associations?.order_rows != nil && (order?.associations?.order_rows?.count)! > 0
			{
				var pos = 1
				addMessageField.text = (order?.associations?.order_rows![0].productName)	//insert first product
				for row in (order?.associations?.order_rows)!
				{
					let prod = UILabel()
					prod.text = row.productName
					prod.textColor = R.color.YumaRed
					prod.adjustsFontSizeToFitWidth = true
					let qty = UILabel()
					qty.textAlignment = .center
					qty.textColor = R.color.YumaRed
					qty.text = "\((row.productQuantity)!)"
					let up = UILabel()
					up.textColor = R.color.YumaRed
					up.textAlignment = .right
					/*if*/ let currency = Double(row.unitPriceTaxExcl!)
//					{
						up.text = self.store.formatCurrency(amount: NSNumber(value: currency), iso: self.store.locale)
						unit = currency
//					}
					let tp = UILabel()
					tp.textAlignment = .right
					tp.textColor = R.color.YumaRed
					/*if*/ let currency2 = Double(row.productPrice!)
//					{
						tp.text = self.store.formatCurrency(amount: NSNumber(value: currency2), iso: self.store.locale)
						sub += currency2
						total += sub
						tax += Double(row.unitPriceTaxIncl!) - unit
//					}
					let stack = UIStackView(arrangedSubviews: [prod, qty, up, tp])
					stack.distribution = .fillEqually
					orderListAdd2.insertArrangedSubview(stack, at: pos)
					pickerData.append(row.productName!)
//				var msgs: [String] = [String]()
//				if row.productReference != nil
//				{
//					msgs.append(row.productReference!)
//				}
//				if msgs.count > 0
//				{
//					messagesLabel.text = msgs.joined()
//				}
					pos += 1
				}
				if order?.totalWrapping != nil && Double((order?.totalWrapping)!) > 0
				{
					orderWrapRow.isHidden = false
					/*if*/ let exTax = Double((order?.totalWrappingTaxExcl)!)
//					{
						orderWrapUI.text = self.store.formatCurrency(amount: NSNumber(value: exTax), iso: self.store.locale)
//					}
					/*if*/ let incTax = Double((order?.totalWrappingTaxIncl)!)
//					{
						orderWrapTotal.text = self.store.formatCurrency(amount: NSNumber(value: incTax), iso: self.store.locale)
//					}
				}
				else
				{
					orderWrapRow.isHidden = true
				}
				if order?.totalDiscounts != nil && Double((order?.totalDiscounts)!) > 0
				{
					orderDiscRow.isHidden = false
					/*if*/ let exTax = Double((order?.totalDiscountsTaxExcl)!)
//					{
						orderDiscProd.text = self.store.formatCurrency(amount: NSNumber(value: exTax), iso: self.store.locale)
//					}
					/*if*/ let incTax = Double((order?.totalDiscountsTaxIncl)!)
//					{
						orderDiscQty.text = self.store.formatCurrency(amount: NSNumber(value: incTax), iso: self.store.locale)
//					}
				}
				else
				{
					orderDiscRow.isHidden = true
				}
			}
			if let currency = Double(String(sub))
			{
				orderSubtotalAmt.text = self.store.formatCurrency(amount: NSNumber(value: currency), iso: self.store.locale)
			}
			total += tax
			orderTaxAmt.text = self.store.formatCurrency(amount: NSNumber(value: tax), iso: self.store.locale)
			/*if*/ let exTax = Double((order?.totalPaidTaxExcl)!)
//			{
				orderTotalLabel.text = self.store.formatCurrency(amount: NSNumber(value: exTax), iso: self.store.locale)
//			}
			/*if*/ let incTax = Double((order?.totalPaidTaxIncl)!)
//			{
				orderTotalAmt.text = self.store.formatCurrency(amount: NSNumber(value: incTax), iso: self.store.locale)
//			}
//			/*else if*/ let incTax = Double((order?.totalPaid)!)
//			{
//				orderTotalAmt.text = self.store.formatCurrency(amount: NSNumber(value: incTax), iso: self.store.locale)
//			}
			if order?.gift != nil && (order?.gift)!
			{
				messagesLabel.text = order?.giftMessage
			}
//			if order?.associations != nil
//			{
//				for msg in order?.associations.messages
//				{
//					let myMsg = mess as! Message
//					let df = DateFormatter()
//					df.locale = Locale(identifier: self.store.locale)
//					df.dateFormat = "yyyy-MM-dd HH:mm:ss"
//					if let date = df.date(from: (myMsg.date_add)!)
//					{
//						df.dateFormat = "dd MMM yyyy"
////						df.string(from: date)
//						let dateLbl = UILabel()
//						dateLbl.text = df.string(from: date)
//						let messLbl = UILabel()
//						messLbl.text = myMsg.message
//					}
//				}
//			}
		}
	}


	// MARK: Actions
	@objc func adjustForKeyboard(notification: Notification)
	{
		let userInfo = notification.userInfo!
		let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
		let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

		if notification.name == Notification.Name.UIKeyboardWillHide
		{
			self.scrollForm.contentInset = UIEdgeInsets.zero
		}
		else
		{
			self.scrollForm.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
		}
		self.scrollForm.scrollIndicatorInsets = self.scrollForm.contentInset
		//let selectedRange = self.scrollForm.selectedRange
		//self.scrollForm.scrollRangeToVisible(selectedRange)
	}


	@objc func dropdownList(_ sender: UITapGestureRecognizer)
	{
		let sb = UIStoryboard(name: "HelpStoryboard", bundle: nil)
		let vc = sb.instantiateInitialViewController() as? PickerViewController
		if vc != nil
		{
			self.present(vc!, animated: true, completion: nil)
//			let blurFxView = 					UIVisualEffectView(effect: UIBlurEffect(style: .dark))
//			blurFxView.frame = 					self.view.bounds
//			blurFxView.alpha = 					0.5
//			blurFxView.autoresizingMask = 		[.flexibleWidth, .flexibleHeight]
//			vc?.backgroundView.addSubview(blurFxView)
			vc?.dialog.shadowColor = 			R.color.YumaDRed
			vc?.dialog.shadowOffset = 			.zero
			vc?.dialog.shadowRadius = 			5
			vc?.dialog.shadowOpacity = 			1
			vc?.dialog.layer.cornerRadius = 	20
			vc?.dialog.cornerRadius = 			20
			vc?.titleLbl.text = 				R.string.select.uppercased() + " " + R.string.prod.uppercased()
			vc?.button.setTitle(R.string.select.uppercased(), for: .normal)
			vc?.view.addSubview(picker)
			picker.translatesAutoresizingMaskIntoConstraints = false
			NSLayoutConstraint.activate([
				picker.centerXAnchor.constraint(equalTo: (vc?.dialog.centerXAnchor)!),
				picker.centerYAnchor.constraint(equalTo: (vc?.dialog.centerYAnchor)!),
				])
			vc?.button.addTarget(self, action: #selector(writePickedValue(_:)), for: .touchUpInside)
		}
		else
		{
			print("HelpStoryboard has no initial view controller")
		}
	}
	
	
	@objc func writePickedValue(_ sender: UIButton?)
	{
		self.addMessageField.text = pickerData[picker.selectedRow(inComponent: 0)]
	}
	
	
	@IBAction func navCloseAct(_ sender: Any)
	{
		self.dismiss(animated: false, completion: nil)
	}
	@IBAction func navHelpAct(_ sender: Any)
	{
		let viewC = Assistance()
		viewC.array = R.array.help_order_details_guide
		viewC.title = "\(R.string.order.capitalized) \(R.string.details.capitalized) \(R.string.help.capitalized)"
		viewC.modalTransitionStyle = .crossDissolve
		viewC.modalPresentationStyle = .overCurrentContext
		self.present(viewC, animated: true, completion: nil)
	}
	@IBAction func buttonAct(_ sender: Any)
	{
		if addMessageField.text != "" && addMessageMessageField.text != ""
		{
			let df = DateFormatter()
			df.dateFormat = "yyyy-MM-dd HH:mm:ss"
			let myMsg = Message(id: "", id_cart: "", id_order: String((order?.id)!), id_customer: String((store.customer?.idCustomer)!), id_employee: "", message: addMessageMessageField.text, isprivate: "", date_add: df.string(from: Date()))
			print(myMsg)
		}
	}

}



extension String
{
	static func makeSlashText(_ text:String) -> NSAttributedString
	{
		let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: text)
		attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: NSUnderlineStyle.styleSingle, range: NSMakeRange(0, attributeString.length))
		return attributeString
	}

}
