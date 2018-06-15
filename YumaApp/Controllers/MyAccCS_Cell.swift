//
//  MyAccCS_Cell.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-06-15.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class MyAccCS_Cell: UICollectionViewCell
{
//struct OrderSlip: Codable
//	{
//	var id: 					Int?
//	var idCustomer: 			Int?
//	var idOrder: 				Int?
//	var conversionRate: 		Float?
//	var totalProductsTaxExcl: 	Float?
//	var totalProductsTaxIncl: 	Float?
//	var totalShippingTaxExcl: 	Float?
//	var totalShippingTaxIncl: 	Float?
//	var amount: 				Float?
//	var shippingCost: 			String?
//	var shippingCostAmount: 	Float?
//	var partial: 				String?
//	var dateAdd: 				Date?
//	var dateUpd: 				Date?
//	var orderSlipType: 			Int?
//	var associations:			OrderSlipAssociations?

	let store = DataStore.sharedInstance
	var wideScreen = false
	let orderNumLbl: UILabel =
	{
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.textColor = UIColor.darkGray
		view.font = UIFont.boldSystemFont(ofSize: 16)
		view.text = R.string.order + ": "
		return view
	}()
	let orderNum: UILabel =
	{
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.textColor = UIColor.darkGray
		view.font = UIFont.boldSystemFont(ofSize: 16)
		return view
	}()
	let dateMade: UILabel =
	{
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.textColor = UIColor.darkGray
		view.font = UIFont.systemFont(ofSize: 14)
		return view
	}()
	let totalPrice: UILabel =
	{
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.textColor = UIColor.darkGray
		view.textAlignment = .right
		view.font = UIFont.boldSystemFont(ofSize: 14)
		return view
	}()
//	let payment: UILabel =
//	{
//		let view = UILabel()
//		view.translatesAutoresizingMaskIntoConstraints = false
//		view.textColor = UIColor.darkGray
//		view.font = UIFont.systemFont(ofSize: 14)
//		view.textAlignment = .center
//		return view
//	}()
//	let status: UILabel =
//	{
//		let view = UILabel()
//		view.translatesAutoresizingMaskIntoConstraints = false
//		view.textColor = UIColor.darkGray
//		view.font = UIFont.systemFont(ofSize: 14)
//		return view
//	}()
//	let invoice: UILabel =
//	{
//		let view = UILabel()
//		view.translatesAutoresizingMaskIntoConstraints = false
//		view.textColor = UIColor.darkGray
//		view.font = UIFont.boldSystemFont(ofSize: 14)
//		return view
//	}()
	let details: UILabel =
	{
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.textColor = R.color.YumaRed
		view.shadowColor = R.color.YumaYel
		view.shadowOffset = CGSize(width: 1, height: 1)
		view.shadowRadius = 3
		view.shadowOpacity = 0.1
		view.textAlignment = .center
		view.text = R.string.details
		view.font = UIFont.systemFont(ofSize: 20)
		return view
	}()
//	let reorder: UILabel =
//	{
//		let view = UILabel()
//		view.translatesAutoresizingMaskIntoConstraints = false
//		view.textColor = R.color.YumaRed
//		view.shadowColor = R.color.YumaYel
//		view.shadowOffset = CGSize(width: 1, height: 1)
//		view.shadowRadius = 3
//		view.shadowOpacity = 0.1
//		view.textAlignment = .center
//		view.text = R.string.reorder
//		view.font = UIFont.systemFont(ofSize: 20)
//		return view
//	}()
	
	
	// MARK: Overrides
	override init(frame: CGRect)
	{
		super.init(frame: frame)
		setupContents()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: Methods
	func setupContents()
	{
		contentView.borderColor = UIColor.lightGray
		contentView.borderWidth = 1
		//		self.layer.shadowColor = UIColor.darkGray.cgColor
		//		self.layer.shadowOffset = CGSize.zero
		//		self.shadowRadius = 5
		//		self.shadowOpacity = 0.7
		//		self.shadowColor = UIColor.darkGray
		//		self.shadowOffset = CGSize.zero
		//		self.shadowRadius = 5
		//		self.shadowOpacity = 0.7
		//		contentView.layer.shadowColor = UIColor.darkGray.cgColor
		//		contentView.layer.shadowOffset = CGSize.zero
		//		contentView.layer.shadowRadius = 5
		//		contentView.layer.shadowOpacity = 0.5
		let stackRow1 = UIStackView(arrangedSubviews: [orderNumLbl, orderNum])
		stackRow1.distribution = .fill
		stackRow1.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(stackRow1)
		NSLayoutConstraint.activate([
			stackRow1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
			stackRow1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
			stackRow1.heightAnchor.constraint(equalToConstant: orderNumLbl.font.pointSize*1.2),
			stackRow1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
			])
//		let stackBottom = UIStackView(arrangedSubviews: [details, reorder])
//		stackBottom.distribution = .equalCentering
//		stackBottom.translatesAutoresizingMaskIntoConstraints = false
		let verticalStack: UIStackView
		//			if wideScreen
		//			{
		//				verticalStack = UIStackView(arrangedSubviews: [stackRow1, totalPrice, payment, status, invoice, details, reorder])
		//			}
		//			else
		//			{
		verticalStack = UIStackView(arrangedSubviews: [stackRow1, dateMade, totalPrice, /*payment, status, invoice,*/ details/*stackBottom, reorder*/])
		//			}
		verticalStack.axis = .vertical
		verticalStack.distribution = .fill
		verticalStack.spacing = 5
		verticalStack.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(verticalStack)
		NSLayoutConstraint.activate([
			verticalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
			verticalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
			verticalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
			verticalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
			])
	}
	
	
	func values(orderSlip: OrderSlip)
	{
		orderNum.text = "\(orderSlip.idOrder!)"
		let df = DateFormatter()
		dateMade.text = df.string(from: orderSlip.dateAdd!)
		let doubleAmt = orderSlip.amount
		totalPrice.text = store.formatCurrency(amount: doubleAmt! as NSNumber) //+ " ex. tax"
//		payment.text = (orderSlip.payment?.count)! > 1 ? order.payment : ""
//		status.text = (orderSlip.current_state?.count)! > 1 ? order.current_state : ""
//		invoice.text = (orderSlip.invoice_number?.count)! > 1 ? order.invoice_number : ""
		contentView.tag = orderSlip.id! + 10
	}
	
}
