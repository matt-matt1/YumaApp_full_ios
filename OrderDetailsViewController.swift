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
	@IBOutlet weak var paymentLabel: UILabel!
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
	@IBOutlet weak var orderSubtotalProduct: UILabel!
	@IBOutlet weak var orderSubtotalQuantity: UILabel!
	@IBOutlet weak var orderSubtotalLabel: UILabel!
	@IBOutlet weak var orderSubtotalAmt: UILabel!
	@IBOutlet weak var orderShipProd: UILabel!
	@IBOutlet weak var orderShipQty: UILabel!
	@IBOutlet weak var orderShipLabel: UILabel!
	@IBOutlet weak var orderTaxProd: UILabel!
	@IBOutlet weak var orderTaxQty: UILabel!
	@IBOutlet weak var orderTaxLabel: UILabel!
	@IBOutlet weak var orderTaxAmt: UILabel!
	@IBOutlet weak var orderTotalProd: UILabel!
	@IBOutlet weak var payment: UILabel!
	@IBOutlet weak var orderTotalQty: UILabel!
	@IBOutlet weak var orderTotalLabel: UILabel!
	@IBOutlet weak var orderTotalAmt: UILabel!
	@IBOutlet weak var carrier: UILabel!
	@IBOutlet weak var messagesLabel: UILabel!
	@IBOutlet weak var addMessageLabel: UILabel!
	@IBOutlet weak var addMessageCaption: UILabel!
	@IBOutlet weak var addMessageProd: UILabel!
	@IBOutlet weak var addMessageList: UIView!
	@IBOutlet weak var addMessageField: UITextField!
	@IBOutlet weak var addMessageArrow: UILabel!
	@IBOutlet weak var button: GradientButton!
	@IBOutlet weak var orderShipAmt: UILabel!
	@IBOutlet weak var addMessageSelect: UIStackView!
	let store = DataStore.sharedInstance
	var order: Order? = nil
	var details: OrderDetail? = nil
	let picker = UIPickerView()
	var pickerData: [String] = [String]()

	
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
		button.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		navTitle.title = R.string.order + " " + R.string.details
		prepareLabels()
		fillData()
		picker.dataSource = self
		picker.delegate = self
		addMessageList.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dropdownList(_:))))
    }
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	
	func prepareLabels()
	{
		navClose.title = FontAwesome.times.rawValue
		navHelp.title = FontAwesome.questionCircle.rawValue
		navHelp.setTitleTextAttributes([NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)], for: .normal)
		orderRef.text = R.string.ordRef
		placedOn.text = R.string.placed
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
		orderSubtotalLabel.text = R.string.subT
		orderShipLabel.text = R.string.shipAnd
		orderTaxLabel.text = R.string.tax
		orderTotalLabel.text = R.string.Total
		messagesLabel.text = R.string.msgs
		addMessageLabel.text = R.string.addMsg
		addMessageCaption.text = R.string.msgTop
		addMessageProd.text = R.string.prod
//		if self.order != nil && self.order?.associations != nil && self.order?.associations?.order_rows != nil
//		{
//			for i in 0..<(self.order?.associations?.order_rows?.count)!
//			{
//				let item = self.order?.associations?.order_rows![i]
//				//products.updateValue(i+1, forKey: (item?.productName)!)
//				//^Fatal error: Unexpectedly found nil while unwrapping an Optional value
//			}
//		}
		addMessageArrow.text = FontAwesome.caretDown.rawValue
		addMessageArrow.font = R.font.FontAwesomeOfSize(pointSize: 21)
		addMessageArrow.textAlignment = .center
		addMessageArrow.center.y = (addMessageArrow.superview?.center.y)!
		button.setTitle(R.string.send, for: .normal)
	}
	
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int
	{
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
	{
		return pickerData.count
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
	{
		addMessageField.text = pickerData[row]
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
	{
		return R.string.prod
	}
	

	func fillData()
	{
		guard order != nil else { 	return 	}
		placedOnValue.text = ""
		if order?.reference != nil
		{
			orderRefValue.text = order?.reference
		}
		if self.order?.date_add != nil && self.order?.date_add != ""
		{
			let df = DateFormatter()
			df.locale = Locale(identifier: self.store.locale)
			df.dateFormat = "dd MMM YYYY"
//			if let date = df.date(from: (order?.date_add)!)
//			{
//				placedOnValue.text = " \(df.string(from: date))"
//			}
			placedOnValue.text = df.string(from: try! Date(from: order?.date_add as! Decoder))
		}
		if order?.id_carrier != nil
		{
			for carr in store.carriers
			{
				if order?.id_carrier != nil && carr.id! == Int((order?.id_carrier)!)!
				{
					carrier.text = carr.name!
				}
			}
		}
		payment.text = order?.payment
		if order?.delivery_date != nil
		{
			let dateField = UILabel()
			let df = DateFormatter()
			df.locale = Locale(identifier: self.store.locale)
			df.dateFormat = "dd MMM YYYY"
			if let date = df.date(from: (order?.delivery_date)!)
			{
				dateField.text = "\(df.string(from: date))"
				let status = UILabel()
				status.text = R.string.delivered
				let stack = UIStackView(arrangedSubviews: [dateField, status])
				stack.distribution = .fillEqually
				statusAddHere.addArrangedSubview(stack)
			}
		}
		// order?.currentState
		for del in store.addresses
		{
			if order?.id_address_delivery != nil && del.id! == Int((order?.id_address_delivery)!)!
			{
				deliveryAddrField.text = store.formatAddress(del)
			}
			self.automaticallyAdjustsScrollViewInsets = false
			deliveryAddrField.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
			deliveryAddrField.contentOffset = CGPoint(x: 0, y: 0)
		}
		for inva in store.addresses
		{
			if order?.id_address_invoice != nil && inva.id! == Int((order?.id_address_invoice)!)!
			{
				invoiceAddrField.text = store.formatAddress(inva)
			}
			invoiceAddrField.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
		}
		var sub: Double = 0
		if order?.associations?.order_rows != nil && (order?.associations?.order_rows?.count)! > 0
		{
			var pos = 1
			for row in (order?.associations?.order_rows)!
			{
				let prod = UILabel()
				prod.text = row.product_name
				prod.textColor = R.color.YumaRed
				prod.adjustsFontSizeToFitWidth = true
				let qty = UILabel()
				qty.textAlignment = .center
				qty.text = row.product_quantity
				let up = UILabel()
				up.textColor = R.color.YumaRed
				up.textAlignment = .right
				if let currency = Double(((row.unit_price_tax_incl != nil) ? row.unit_price_tax_incl : row.unit_price_tax_excl)!)
				{
					up.text = self.store.formatCurrency(amount: NSNumber(value: currency), iso: self.store.locale)
				}
				let tp = UILabel()
				tp.textAlignment = .right
				if let currency = Double(row.product_price!)
				{
					tp.text = self.store.formatCurrency(amount: NSNumber(value: currency), iso: self.store.locale)
				}
				let stack = UIStackView(arrangedSubviews: [prod, qty, up, tp])
				stack.distribution = .fillEqually
				orderListAdd2.insertArrangedSubview(stack, at: pos)
				//sub += (tp.text?.toDouble())!
				pickerData.append(row.product_name!)
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
		}
		if let currency = Double(String(sub))
		{
			orderSubtotalAmt.text = self.store.formatCurrency(amount: NSNumber(value: currency), iso: self.store.locale)
		}
		if let currency = Double(String(0))
		{
			orderShipAmt.text = self.store.formatCurrency(amount: NSNumber(value: currency), iso: self.store.locale)
		}
		if let currency = Double(String(sub * 13 / 100))
		{
			orderTaxAmt.text = self.store.formatCurrency(amount: NSNumber(value: currency), iso: self.store.locale)
		}
		if let currency = Double(String(sub + 0 + (sub * 13 / 100)))
		{
			orderTotalAmt.text = self.store.formatCurrency(amount: NSNumber(value: currency), iso: self.store.locale)
		}
		if order?.associations != nil
		{
//			for msg in order?.associations.messages
//			{
				//
//			}
		}
	}
	
	
	@objc func dropdownList(_ sender: UITapGestureRecognizer)
	{
		//picker.
	}
	
	
	@IBAction func navCloseAct(_ sender: Any) {
	}
	@IBAction func navHelpAct(_ sender: Any) {
	}
	@IBAction func buttonAct(_ sender: Any)
	{
	}

}
