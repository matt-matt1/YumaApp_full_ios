//
//  CartViewControl.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-08-05.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit
import MGSwipeTableCell
import AwesomeEnum


class CartViewControl: UIViewController
{
	let cellID = "cartCell"
	var total: Float = 0
	var pcs: Int = 0
	var wt: Float = 0
	let store = DataStore.sharedInstance
	let totalsBar: UIToolbar =
	{
		let view = UIToolbar()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.isTranslucent = false
		view.barTintColor = R.color.YumaRed
		return view
	}()
	let smallFixedSpace: UIBarButtonItem =
	{
		let view = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
		view.width = 8.0
		return view
	}()
	let bigFixedSpace: UIBarButtonItem =
	{
		let view = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
		view.width = 15.0
		return view
	}()
	let flexibleSpace: UIBarButtonItem =
	{
		let view = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
		return view
	}()
	var totalAmt: UILabel =
	{
		let view = UILabel()
		view.textColor = R.color.YumaYel
		view.font = R.font.avenirNextBold21
		return view
	}()
	var totalLbl: UILabel =
	{
		let view = UILabel()
		view.textColor = UIColor.lightGray
		return view
	}()
	var totalPcsLbl: UILabel =
	{
		let view = UILabel()
		view.textColor = UIColor.lightGray
		view.text = R.string.pieces
		return view
	}()
	var totalPcs: UILabel =
	{
		let view = UILabel()
		view.textColor = R.color.YumaYel
		view.font = R.font.avenirNextBold21
		return view
	}()
	var totalWt: UILabel =
	{
		let view = UILabel()
		view.textColor = R.color.YumaYel
		view.font = R.font.avenirNextBold21
		return view
	}()
	var totalWtLbl: UILabel =
	{
		let view = UILabel()
		view.textColor = UIColor.lightGray
		return view
	}()
	var tableView: UITableView =
	{
		let view = UITableView()
		view.backgroundColor = UIColor.white
		view.translatesAutoresizingMaskIntoConstraints = false
//		view.shadowColor = UIColor.darkGray
//		view.shadowOffset = .zero
//		view.shadowRadius = 5
//		view.shadowOpacity = 0.9
		return view
	}()
	var navBar: UINavigationBar =
	{
		let view = UINavigationBar()
		view.backgroundColor = UIColor.lightGray
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
	var chkoutBtn: UIButton =
	{
		let view 					= UIButton()
		view.backgroundColor 		= R.color.YumaYel//UIColor(hex: "f8c03f")
		view.translatesAutoresizingMaskIntoConstraints = false
		let mutableAttributedString = NSMutableAttributedString(attributedString: Awesome.solid.wallet.asAttributedText(fontSize: 26, color: UIColor.white, backgroundColor: UIColor.clear))
		mutableAttributedString.addAttributes([NSAttributedStringKey.shadow : R.shadow.YumaDRed5_downright1()], range: NSRange(location: 0, length: mutableAttributedString.length))
		let str = NSAttributedString(string: "     \(R.string.checkOut.uppercased())", attributes: [
			NSAttributedStringKey.foregroundColor 	: UIColor.white,
			NSAttributedStringKey.font 				: UIFont.boldSystemFont(ofSize: 21),
			NSAttributedStringKey.shadow 			: R.shadow.YumaDRed5_downright1(),
			NSAttributedStringKey.baselineOffset 	: 2])
		mutableAttributedString.append(str)
		view.setAttributedTitle(mutableAttributedString, for: .normal)
		view.borderWidth 			= 1
		view.borderColor 			= R.color.YumaRed
		view.cornerRadius 			= 3
		view.shadowColor 			= UIColor.darkGray
		view.shadowOffset 			= CGSize(width: 1, height: 1)
		view.shadowRadius 			= 5
		view.shadowOpacity 			= 0.9
		view.autoresizingMask 		= [.flexibleWidth]
		return view
	}()
	let picker = UIPickerView()
	var pickerData: [String] = [String]()
	static let noteName = Notification.Name("changedCartCellQty")


	// MARK: Overrides

	override func viewDidLoad()
	{
        super.viewDidLoad()
		view.backgroundColor = UIColor(hex: "e0e0e0")//.lightGray//.white
		NotificationCenter.default.addObserver(self, selector: #selector(calcTotalWrapper), name: 
			CartViewControl.noteName, object: nil)
		totalLbl.text = " = "
		totalWtLbl.text = store.weightUnit//R.string.kg
		drawTable()
		drawTotalsBar()
		drawButton()
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


	override func viewDidLayoutSubviews()
	{
		super.viewDidLayoutSubviews()
		let _ = chkoutBtn.addBackgroundGradient(colors: [R.color.YumaRed.cgColor, R.color.YumaYel.cgColor], isVertical: true)
		chkoutBtn.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 3.6, isVertical: true)
		tableView.reloadData()
//		print("view.frame=\(view.frame)")
//		print(totalsBar.frame)
	}
	
	
	override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


	// MARK: My Methods

	func drawTable()
	{
		view.addSubview(tableView)
		tableView.register(CartViewControlCell.self, forCellReuseIdentifier: cellID)
		tableView.delegate = self
		tableView.dataSource = self
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 0),
			tableView.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: 0),
			tableView.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor, constant: 0),
			])
		if #available(iOS 11, *)
		{
			tableView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: -100).isActive = true
		}
		else
		{
			tableView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: -150).isActive = true
		}
	}


	func drawTotalsBar()
	{
		view.addSubview(totalsBar)
		var items = [
			UIBarButtonItem(customView: totalPcs),
			smallFixedSpace,
			UIBarButtonItem(customView: totalPcsLbl),
			flexibleSpace,
			UIBarButtonItem(customView: totalLbl),
			bigFixedSpace,
			UIBarButtonItem(customView: totalAmt)
			]
		if totalWt.text != nil && !(totalWt.text?.isEmpty)!
		{
			items += [
				flexibleSpace,
				UIBarButtonItem(customView: totalWt),
				UIBarButtonItem(customView: totalWtLbl)
			]
		}
		totalsBar.setItems(items, animated: false)
		NSLayoutConstraint.activate([
			totalsBar.heightAnchor.constraint(equalToConstant: 50),
			totalsBar.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: 0),
			totalsBar.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor, constant: 0),
			])
		if #available(iOS 11, *)
		{
			totalsBar.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: 0).isActive = true
		}
		else
		{
			totalsBar.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: -50).isActive = true
		}
	}


	func drawButton()
	{
		view.addSubview(chkoutBtn)
		NSLayoutConstraint.activate([
			chkoutBtn.heightAnchor.constraint(equalToConstant: 45),
			chkoutBtn.widthAnchor.constraint(equalToConstant: 275),
			chkoutBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			])
		if #available(iOS 11, *)
		{
			chkoutBtn.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: -52).isActive = true
		}
		else
		{
			chkoutBtn.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: -102).isActive = true
		}
		chkoutBtn.alpha = 0.2
		chkoutBtn.addTapGestureRecognizer {
			self.store.flexView(view: self.chkoutBtn)
			if self.chkoutBtn.alpha == 1
			{
//				self.store.flexView(view: self.chkoutBtn)
				self.store.myOrder?.totalProductsWt = self.wt
				self.store.myOrder?.totalPaidTaxExcl = self.total
				self.store.myOrder?.totalProducts = self.pcs
				let layout = UICollectionViewFlowLayout()
				//layout.scrollDirection = .horizontal
				let root = CheckoutCollection(collectionViewLayout: layout)
				let vc = UINavigationController(rootViewController: root)
				self.present(vc, animated: false, completion: nil)
			}
		}
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
//			print(store.myOrder ?? "")
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
				})
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
		totalsBar.subviews.forEach { (sub) in
			sub.layoutIfNeeded()
		}
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
		return self.store.myOrderRows.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? CartViewControlCell else
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
