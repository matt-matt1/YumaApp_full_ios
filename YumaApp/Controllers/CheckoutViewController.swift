//
//  CheckoutViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-09.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController
{
	@IBOutlet weak var navBar: UINavigationBar!
	@IBOutlet weak var navTitle: UINavigationItem!
	@IBOutlet weak var navClose: UIBarButtonItem!
	@IBOutlet weak var navHelp: UIBarButtonItem!
	@IBOutlet weak var title1Block: UIView!
	@IBOutlet weak var tick1: UILabel!
	@IBOutlet weak var title1: UILabel!
	@IBOutlet weak var panel1: UIView!
	@IBOutlet weak var panel1LoginBtn: UIButton!
	@IBOutlet weak var panel1orLbl: UILabel!
	@IBOutlet weak var panel1WithoutLbl: UILabel!
	@IBOutlet weak var panel1LoggedAs: UILabel!
	@IBOutlet weak var panel1LogoutBtn: UIButton!
	@IBOutlet weak var title2Block: UIView!
	@IBOutlet weak var tick2: UILabel!
	@IBOutlet weak var title2: UILabel!
	@IBOutlet weak var panel2: UIView!
	@IBOutlet weak var title3Block: UIView!
	@IBOutlet weak var tick3: UILabel!
	@IBOutlet weak var title3: UILabel!
	@IBOutlet weak var panel3: UIView!
	@IBOutlet weak var title4Block: UIView!
	@IBOutlet weak var tick4: UILabel!
	@IBOutlet weak var title4: UILabel!
	@IBOutlet weak var panel4: UIView!
	@IBOutlet weak var buttonLeft: GradientButton!
	@IBOutlet weak var buttonRight: GradientButton!
	var panelHeight: CGFloat = 0
	/////cart table
	@IBOutlet weak var totalPcs: UILabel!
	@IBOutlet weak var totalPcsLbl: UILabel!
	@IBOutlet weak var totalAmtLbl: UILabel!
	@IBOutlet weak var totalAmt: UILabel!
	@IBOutlet weak var tableView: UITableView!
	let store = DataStore.sharedInstance
	let cellID = "cartCell"
	/////
	
	
	override func viewDidLoad()
	{
        super.viewDidLoad()

		panelHeight = panel1.frame.height
		title1Block.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.openPanel1(_:))))
		title2Block.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.openPanel2(_:))))
		title3Block.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.openPanel3(_:))))
		title4Block.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.openPanel4(_:))))
		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
		buttonLeft.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		buttonRight.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		/////cart table
		totalAmtLbl.text = R.string.Total.uppercased()
		totalPcsLbl.text = R.string.pieces
		fillCart()
		/////
    }
	
	
	/////cart table
	func fillCart()
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
		totalAmt.text = "\(total)"
		totalPcs.text = "\(pcs)"
		let date = Date()
		store.myOrder = [Orders(id: 0, idAddressDelivery: "", idAddressInvoice: "", idCart: "", idCurrency: "", idLang: store.customer?.id_lang, idCustomer: store.customer?.id_customer, idCarrier: "", currentState: "", module: "", invoiceNumber: "", invoiceDate: "", deliveryNumber: "", deliveryDate: "", valid: "", dateAdd: "\(date)", dateUpd: "\(date)", shippingNumber: "", idShopGroup: "", idShop: "", secureKey: "", payment: "", recyclable: "", gift: "", giftMessage: "", mobileTheme: "", totalDiscounts: "", totalDiscountsTaxIncl: "", totalDiscountsTaxExcl: "", totalPaid: "", totalPaidTaxIncl: "", totalPaidTaxExcl: "", totalPaidReal: "", totalProducts: "\(pcs)", totalProductsWt: "\(wt)", totalShipping: "", totalShippingTaxIncl: "", totalShippingTaxExcl: "", carrierTaxRate: "", totalWrapping: "", totalWrappingTaxIncl: "", totalWrappingTaxExcl: "", roundMode: "", roundType: "", conversionRate: "", reference: "", associations: Associations_OrderRows(order_rows: store.myOrderRows))]
		print(store.myOrder)
	}
	/////
	
	
	@objc func openPanel1(_ sender: UITapGestureRecognizer/*_ panel: Int*/)
	{
		if panel1.frame.height != 0
		{
			if panel2.frame.height != 0
			{
				panel2.heightAnchor.constraint(equalToConstant: 0)
				panel2.animateConstraintWithDuration()
			}
			if panel3.frame.height != 0
			{
				panel3.heightAnchor.constraint(equalToConstant: 0)
				panel3.animateConstraintWithDuration()
			}
			if panel4.frame.height != 0
			{
				panel4.heightAnchor.constraint(equalToConstant: 0)
				panel4.animateConstraintWithDuration()
			}
			panel1.heightAnchor.constraint(equalToConstant: panelHeight)
			panel1.animateConstraintWithDuration()
		}
	}
	
	@objc func openPanel2(_ sender: UITapGestureRecognizer)
	{
		if panel2.frame.height != 0
		{
			if panel1.frame.height != 0
			{
				panel1.heightAnchor.constraint(equalToConstant: 0)
				panel1.animateConstraintWithDuration()
			}
			if panel3.frame.height != 0
			{
				panel3.heightAnchor.constraint(equalToConstant: 0)
				panel3.animateConstraintWithDuration()
			}
			if panel4.frame.height != 0
			{
				panel4.heightAnchor.constraint(equalToConstant: 0)
				panel4.animateConstraintWithDuration()
			}
			panel2.heightAnchor.constraint(equalToConstant: panelHeight)
			panel2.animateConstraintWithDuration()
		}
	}
	
	@objc func openPanel3(_ sender: UITapGestureRecognizer)
	{
		if panel3.frame.height != 0
		{
			if panel2.frame.height != 0
			{
				panel2.heightAnchor.constraint(equalToConstant: 0)
				panel2.animateConstraintWithDuration()
			}
			if panel1.frame.height != 0
			{
				panel1.heightAnchor.constraint(equalToConstant: 0)
				panel1.animateConstraintWithDuration()
			}
			if panel4.frame.height != 0
			{
				panel4.heightAnchor.constraint(equalToConstant: 0)
				panel4.animateConstraintWithDuration()
			}
			panel3.heightAnchor.constraint(equalToConstant: panelHeight)
			panel3.animateConstraintWithDuration()
		}
	}
	
	@objc func openPanel4(_ sender: UITapGestureRecognizer)
	{
		if panel4.frame.height != 0
		{
			if panel2.frame.height != 0
			{
				panel2.heightAnchor.constraint(equalToConstant: 0)
				panel2.animateConstraintWithDuration()
			}
			if panel3.frame.height != 0
			{
				panel3.heightAnchor.constraint(equalToConstant: 0)
				panel3.animateConstraintWithDuration()
			}
			if panel1.frame.height != 0
			{
				panel1.heightAnchor.constraint(equalToConstant: 0)
				panel1.animateConstraintWithDuration()
			}
			panel4.heightAnchor.constraint(equalToConstant: panelHeight)
			panel4.animateConstraintWithDuration()
		}
	}

//	override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    
	@IBAction func panel1LoginBtnAct(_ sender: Any)
	{
	}
	@IBAction func panel1WithoutSwiAct(_ sender: Any)
	{
	}
	@IBAction func panel1LogoutBtnAct(_ sender: Any)
	{
	}
	@IBAction func buttonRightAct(_ sender: Any)
	{
	}
	@IBAction func buttonLeftAct(_ sender: Any)
	{
	}
	@IBAction func navCloseBtnAct(_ sender: Any)
	{
		self.dismiss(animated: false, completion: nil)
	}
	@IBAction func navHelpBtnAct(_ sender: Any)
	{
	}
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


/////cart table
extension CheckoutViewController: UITableViewDataSource, UITableViewDelegate
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
		let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! CartViewCell
		cell.setup(store.myOrderRows[indexPath.row])
		return cell
	}
	
}
/////
