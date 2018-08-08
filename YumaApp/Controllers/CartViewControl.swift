//
//  CartViewControl.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-08-05.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit
import MGSwipeTableCell


class CartViewControl: UIViewController
{
	let cellID = "cartCell"
	var total: Float = 0
	var pcs: Int = 0
	var wt: Float = 0
	let store = DataStore.sharedInstance
	var totalAmt: UILabel =
	{
		let view = UILabel()
		view.backgroundColor = UIColor.gray
		return view
	}()
	var totalLbl: UILabel =
	{
		let view = UILabel()
		view.backgroundColor = UIColor.gray
		return view
	}()
	var totalPcsLbl: UILabel =
	{
		let view = UILabel()
		view.backgroundColor = UIColor.gray
		return view
	}()
	var totalPcs: UILabel =
	{
		let view = UILabel()
		view.backgroundColor = UIColor.gray
		return view
	}()
	var totalWt: UILabel =
	{
		let view = UILabel()
		view.backgroundColor = UIColor.gray
		return view
	}()
	var totalWtLbl: UILabel =
	{
		let view = UILabel()
		view.backgroundColor = UIColor.gray
		return view
	}()
	var tableView: UITableView =
	{
		let view = UITableView()
		view.backgroundColor = UIColor.white
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	var navBar: UINavigationBar =
	{
		let view = UINavigationBar()
		view.backgroundColor = UIColor.gray
		view.frame = UIApplication.shared.statusBarFrame
		return view
	}()
	var navTitle: UINavigationItem =
	{
		let view = UINavigationItem()
		return view
	}()
	var navClose: UIBarButtonItem =
	{
		let view = UIBarButtonItem()
		return view
	}()
	var navHelp: UIBarButtonItem =
	{
		let view = UIBarButtonItem()
		return view
	}()
	var chkoutBtn: GradientButton =
	{
		let view = GradientButton()
		return view
	}()
	let picker = UIPickerView()
	var pickerData: [String] = [String]()
	static let noteName = Notification.Name("changedCartCellQty")


	// MARK: Overrides

	override func viewDidLoad()
	{
        super.viewDidLoad()

		NotificationCenter.default.addObserver(self, selector: #selector(calcTotalWrapper), name: 
			CartViewController.noteName, object: nil)
		totalLbl.text = " = "
		totalWtLbl.text = store.weightUnit//R.string.kg
		drawTable()
		if store.myOrderRows.count < 1
		{
			alertEmpty()
		}
		else
		{
			calcTotal()
		}
//		tableView.contentInset = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5)
		tableView.rowHeight = 180
//		tableView.rowHeight = UITableViewAutomaticDimension
//		tableView.estimatedRowHeight = 150
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


	// MARK: Methods

	func drawTable()
	{
		view.addSubview(tableView)
		tableView.register(CartViewControlCell.self, forCellReuseIdentifier: cellID)
		tableView.delegate = self
		tableView.dataSource = self
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 0),
			tableView.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: 0),
			tableView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: 0),
			tableView.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor, constant: 0),
			])
	}


	func calcTotal()
	{
		total = 0
		pcs = 0
		wt = 0
		for row in store.myOrderRows
		{
			total += Float(Int(row.productQuantity!)) * Float(row.productPrice!)
			pcs += Int(row.productQuantity!)
			for p in store.products
			{
				if p.id == row.productId! && p.weight != nil
				{
					wt += p.weight!
					break
				}
			}
		}
		if store.displayWeight
		{
			totalWt.text = "\(wt)"
		}
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
			print(store.myOrder ?? "")
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
					self.tabBarController?.selectedIndex = 0
//					self.dismiss(animated: false, completion: nil)
//					let sb = UIStoryboard(name: "HelpStoryboard", bundle: nil)
//					let vc = sb.instantiateInitialViewController() as? PickerViewController
//					if vc != nil
//					{
//						DispatchQueue.main.async
//							{
//								self.present(vc!, animated: true, completion: nil)
//								vc?.view.addSubview(self.picker)
//								self.picker.translatesAutoresizingMaskIntoConstraints = false
//								NSLayoutConstraint.activate([
//									self.picker.centerXAnchor.constraint(equalTo: (vc?.dialog.centerXAnchor)!),
//									self.picker.centerYAnchor.constraint(equalTo: (vc?.dialog.centerYAnchor)!),
//									])
//								//				vc?.pickerView.removeFromSuperview()
//								vc?.button.addTarget(self, action: #selector(self.writePickedValue(_:)), for: .touchUpInside)
//						}
//					}
//					else
//					{
//						print("HelpStoryboard has no initial view controller")
//					}
				})
				//			self.present(alert, animated: true, completion:
				//			{
				//			})
		}
	}


	func askToDelete(message: String, row: Int)
	{
		myAlertDialog(self, title: R.string.rusure, message: message, cancelTitle: R.string.cancel.uppercased(), cancelAction: nil, okTitle: R.string.delete.uppercased(), okAction:
			{
				self.store.myOrderRows.remove(at: row)
				self.tableView.reloadSections([0], with: UITableViewRowAnimation.fade)
				self.calcTotal()
			}) {
		}
	}


	// MARK: Actions

	@objc func writePickedValue(_ sender: UIButton?)
	{
		//self.addMessageField.text = pickerData[picker.selectedRow(inComponent: 0)]
	}

	@objc func calcTotalWrapper(notify: Notification)
	{
		let sender = notify.object as! UIStepper
		let value = sender.value
		var i = 0
		for row in store.myOrderRows
		{
			if row.productId == sender.tag
			{
				break
			}
			i += 1
		}
		if value < 1
		{
			sender.value = 1
			store.myOrderRows[i].productQuantity = 1
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
			store.myOrderRows[i].productQuantity = Int(value)
			calcTotal()
		}
	}
	
}



extension CartViewControl: UIPickerViewDelegate, UIPickerViewDataSource
{
	func numberOfComponents(in pickerView: UIPickerView) -> Int
	{
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
	{
		return 1
	}
	
	
}



extension CartViewControl: UITableViewDelegate, UITableViewDataSource
{
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
//		print(self.store.myOrderRows.count)
		return self.store.myOrderRows.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? CartViewControlCell else
		{	fatalError("The dequeued cell is not an instance of CartViewCell.") 	}
		cell.setup(store.myOrderRows[indexPath.row])
		cell.rightButtons = [MGSwipeButton(title: R.string.delete, backgroundColor: .red) {
			(sender: MGSwipeTableCell!) -> Bool in
			
//			self.askToDelete(message: "\(R.string.delete) \"\(cell.prodQtyEdit.text!)x\(cell.prodTitle.text!)\"", row: indexPath.row)
			return true
			}]
		return cell
	}

}
