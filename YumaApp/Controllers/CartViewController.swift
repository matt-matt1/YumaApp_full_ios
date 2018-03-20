//
//  CartViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-28.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class CartViewController: UIViewController
{
	@IBOutlet weak var totalAmt: UILabel!
	@IBOutlet weak var totalLbl: UILabel!
	@IBOutlet weak var totalPcsLbl: UILabel!
	@IBOutlet weak var totalPcs: UILabel!
	//	@IBOutlet weak var cellLabel: UILabel!
	//MARK: Properties
	@IBOutlet weak var tableView: UITableView!
	//@IBOutlet weak var tableCell: UITableViewCell!
//	@IBOutlet weak var cellLabel: UILabel!
	@IBOutlet weak var navBar: UINavigationBar!
//	@IBOutlet weak var table: UITableView!
	@IBOutlet weak var navTitle: UINavigationItem!
	@IBOutlet weak var navClose: UIBarButtonItem!
	@IBOutlet weak var navHelp: UIBarButtonItem!
	@IBOutlet weak var chkoutBtn: GradientButton!
	let store = DataStore.sharedInstance
	let cellID = "cartCell"
//	private var contents = ["Apple", "Apricot", "Banana", "Blueberry", "Cantaloupe", "Cherry",
//				  "Clementine", "Coconut", "Cranberry", "Fig", "Grape", "Grapefruit",
//				  "Kiwi fruit", "Lemon", "Lime", "Lychee", "Mandarine", "Mango",
//				  "Melon", "Nectarine", "Olive", "Orange", "Papaya", "Peach",
//				  "Pear", "Pineapple", "Raspberry", "Strawberry"]
	
	
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
		navigationItem.title = R.string.cart

		totalLbl.text = R.string.Total.uppercased()
		totalPcsLbl.text = R.string.pieces
		if store.myOrderRows.count < 1
		{
			alertEmpty()
		}
		else
		{
			var total: Double = 0
			var pcs: Int = 0
			var wt: Double = 0
			for row in store.myOrderRows
			{
				//print("price=\(row.productPrice ?? ""), convert=\(Double(row.productPrice!)!)")
				total = total + (Double(Int(row.productQuantity!)!) * Double(row.productPrice!)!)
				pcs = pcs + Int(row.productQuantity!)!
				//wt = wt + Double(row.productId)
			}
			if total < 1
			{
				DispatchQueue.main.async {
					self.alertEmpty()
				}
			}
			else
			{
				totalAmt.text = "\(total)"
				totalPcs.text = "\(pcs)"
				let date = Date()
				store.myOrder = [Orders(id: 0, idAddressDelivery: "", idAddressInvoice: "", idCart: "", idCurrency: "", idLang: store.customer?.id_lang, idCustomer: store.customer?.id_customer, idCarrier: "", currentState: "", module: "", invoiceNumber: "", invoiceDate: "", deliveryNumber: "", deliveryDate: "", valid: "", dateAdd: "\(date)", dateUpd: "\(date)", shippingNumber: "", idShopGroup: "", idShop: "", secureKey: "", payment: "", recyclable: "", gift: "", giftMessage: "", mobileTheme: "", totalDiscounts: "", totalDiscountsTaxIncl: "", totalDiscountsTaxExcl: "", totalPaid: "", totalPaidTaxIncl: "", totalPaidTaxExcl: "", totalPaidReal: "", totalProducts: "\(pcs)", totalProductsWt: "\(wt)", totalShipping: "", totalShippingTaxIncl: "", totalShippingTaxExcl: "", carrierTaxRate: "", totalWrapping: "", totalWrappingTaxIncl: "", totalWrappingTaxExcl: "", roundMode: "", roundType: "", conversionRate: "", reference: "", associations: Associations_OrderRows(order_rows: store.myOrderRows))]
				print(store.myOrder)
			}
		}
    }
	
	
	func alertEmpty()
	{
		let alert = UIAlertController(title: R.string.err, message: "\(R.string.cart) \(R.string.empty)", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: R.string.back, style: .default, handler: nil))
		self.present(alert, animated: true, completion:
			{
				DispatchQueue.main.async
					{
						self.dismiss(animated: false, completion: nil)
					}
			}
		)
	}
	

	@IBAction func navCloseAct(_ sender: Any)
	{
		self.dismiss(animated: false, completion: nil)
	}
	@IBAction func navHelpAct(_ sender: Any)
	{
	}
	@IBAction func chkoutBtnAct(_ sender: Any)
	{
		store.flexView(view: chkoutBtn)
		let vc = UIStoryboard(name: "Checkout", bundle: nil).instantiateInitialViewController() as! CheckoutViewController!
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
		//		guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? TableViewCell else
		//		{
		//			fatalError("table dequeue error")
		//		}
		let cell = tableView.dequeueReusableCell(withIdentifier: cellID/*, for: indexPath*/) as! CartViewCell
		//let text = contents[indexPath.row]
		cell.setup(store.myOrderRows[indexPath.row])//cell.setup(string: text)
		//cell.cellLabel.text = text
		//cell.textLabel?.text = text//.cellLabel?.text = text
		return cell
	}

}
