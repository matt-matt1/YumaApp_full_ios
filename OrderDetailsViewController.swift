//
//  OrderDetailsViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-06.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class OrderDetailsViewController: UIViewController {

	@IBOutlet weak var orderRef: UILabel!
	@IBOutlet weak var reorderBtn: UIButton!
	@IBOutlet weak var carrierLabel: UILabel!
	@IBOutlet weak var paymentLabel: UILabel!
	@IBOutlet weak var followSteps: UILabel!
	@IBOutlet weak var statusDate: UILabel!
	@IBOutlet weak var statusStatus: UILabel!
	@IBOutlet weak var statusEntry0Date: UILabel!
	@IBOutlet weak var statusEntry0Status: UILabel!
	@IBOutlet weak var deliveryAddr: UILabel!
	@IBOutlet weak var deliveryAddrField: UITextView!
	@IBOutlet weak var invoiceAddr: UILabel!
	@IBOutlet weak var invoiceAddrField: UITextView!
	@IBOutlet weak var orderProduct: UILabel!
	@IBOutlet weak var orderQuantity: UILabel!
	@IBOutlet weak var orderUnitPrice: UILabel!
	@IBOutlet weak var orderTotalPrice: UILabel!
	@IBOutlet weak var order0Product: UILabel!
	@IBOutlet weak var order0Quantity: UILabel!
	@IBOutlet weak var order0UnitPrice: UILabel!
	@IBOutlet weak var orderSubtotalProduct: UILabel!
	@IBOutlet weak var order0TotalPrice: UILabel!
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
	let store = DataStore.sharedInstance
	let order: Order? = nil
	let details: OrderDetail? = nil
	var products = [String : Int]()

	
	override func viewDidLoad()
	{
        super.viewDidLoad()

		prepareLabels()
		fillData()
		addMessageList.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dropdownList(_:))))
    }
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	
	func prepareLabels()
	{
		orderRef.text = R.string.ordRef
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
		self.products.updateValue(0, forKey: R.string.plsChoose)
		for i in 0..<(self.order?.associations?.order_rows?.count)!
		{
			let item = self.order?.associations?.order_rows![i]
			products.updateValue(i+1, forKey: (item?.productName)!)
		}
		addMessageArrow.text = FontAwesome.angleDown.rawValue
		button.setTitle(R.string.send, for: .normal)
	}
	
	
	func fillData()
	{
		//guard order != nil && details != nil else { 	return 	}
		var text = orderRef.text! + " " + (self.order?.reference!)!
		if self.order?.dateAdd != nil && self.order?.dateAdd != ""
		{
			text += " - " + R.string.placed + " " + (self.order?.dateAdd!)!
		}
		orderRef.text = text
	}
	
	
	@objc func dropdownList(_ sender: UITapGestureRecognizer)
	{
		//
	}
	
	
	@IBAction func buttonAct(_ sender: Any)
	{
	}

}
