//
//  MyAccOH_Cell.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-06-14.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


class MyAccOH_Cell: UICollectionViewCell
{
	let store = DataStore.sharedInstance
	var delegate: UIViewController?
	var wideScreen = false
	let reference: UILabel =
	{
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.textColor = UIColor.darkGray
		view.font = UIFont.boldSystemFont(ofSize: 16)
		view.textAlignment = .center
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
	let payment: UILabel =
	{
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.textColor = UIColor.darkGray
		view.font = UIFont.systemFont(ofSize: 14)
		view.textAlignment = .center
		return view
	}()
	let status: UILabel =
	{
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.textColor = UIColor.darkGray
		view.font = UIFont.systemFont(ofSize: 14)
		return view
	}()
	let invoice: UILabel =
	{
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.textColor = UIColor.darkGray
		view.font = UIFont.boldSystemFont(ofSize: 14)
		return view
	}()
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
	let reorder: UILabel =
	{
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.textColor = R.color.YumaRed
		view.shadowColor = R.color.YumaYel
		view.shadowOffset = CGSize(width: 1, height: 1)
		view.shadowRadius = 3
		view.shadowOpacity = 0.1
		view.textAlignment = .center
		view.text = R.string.reorder
		view.font = UIFont.systemFont(ofSize: 20)
		return view
	}()
	let stackBottom: UIStackView =
	{
		let view = UIStackView()
		view.distribution = .equalCentering
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	
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
		if wideScreen
		{
			let stackRow1 = UIStackView(arrangedSubviews: [reference, dateMade])
			stackRow1.distribution = .fill
			stackRow1.translatesAutoresizingMaskIntoConstraints = false
			contentView.addSubview(stackRow1)
			NSLayoutConstraint.activate([
				stackRow1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
				stackRow1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
				stackRow1.heightAnchor.constraint(equalToConstant: reference.font.pointSize*1.2),
				stackRow1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
				])
		}
		else
		{
			contentView.addSubview(reference)
			contentView.addSubview(dateMade)
			NSLayoutConstraint.activate([
				reference.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
				reference.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
				reference.heightAnchor.constraint(equalToConstant: reference.font.pointSize),
				reference.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
				
				dateMade.topAnchor.constraint(equalTo: reference.bottomAnchor, constant: 5),
				dateMade.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
				dateMade.heightAnchor.constraint(equalToConstant: reference.font.pointSize),
				dateMade.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
				])
		}
//		let stackBottom = UIStackView(arrangedSubviews: [details, reorder])
		stackBottom.addArrangedSubview(details)
//		stackBottom.distribution = .equalCentering
//		stackBottom.translatesAutoresizingMaskIntoConstraints = false
		let verticalStack: UIStackView
//			if wideScreen
//			{
//				verticalStack = UIStackView(arrangedSubviews: [stackRow1, totalPrice, payment, status, invoice, details, reorder])
//			}
//			else
//			{
				verticalStack = UIStackView(arrangedSubviews: [reference, dateMade, totalPrice, payment, status, invoice, stackBottom/*details, reorder*/])
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


	func values(order: Order)
	{
		reference.text = order.reference
		dateMade.text = order.date_add
		let doubleAmt = order.total_paid_tax_excl?.toDouble()
		totalPrice.text = store.formatCurrency(amount: doubleAmt! as NSNumber) + " ex. tax"
		payment.text = (order.payment?.count)! > 1 ? order.payment : ""
		status.text = (order.current_state?.count)! > 1 ? order.current_state : ""
		invoice.text = (order.invoice_number?.count)! > 1 ? order.invoice_number : ""
		contentView.tag = order.id! + 10
		if !store.disallowReorder
		{
			reorder.isUserInteractionEnabled = true
			reorder.addTapGestureRecognizer {
				myAlertOKCancel(self.delegate!, title: R.string.reorder, message: "\(self.reference.text ?? "this order") (\(self.totalPrice.text ?? ""))?", okAction: {
					// TBD: reorder this
				}, cancelAction: {
				})
			}
			stackBottom.addArrangedSubview(reorder)
		}
	}

}
