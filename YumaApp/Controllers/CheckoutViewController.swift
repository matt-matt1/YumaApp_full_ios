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
	var panel: [UIView] = []
	/////cart table
	@IBOutlet weak var cartPanel: UIView!
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
		print("panelHeight=\(panelHeight)")
		title1.text = "\(R.string.s1) \(R.string.chk1.uppercased())"
//		title1Block.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.openPanel1(_:))))
		title1Block.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.openPanel)))
		let _ = title1Block.addBackgroundGradient(colors: [R.color.YumaRed.cgColor, UIColor.gray.cgColor], isVertical: false)
		tick1.font = R.font.FontAwesomeOfSize(pointSize: Int(tick1.frame.height)-1)
		tick1.text = FontAwesome.checkCircleO.rawValue
		title2.text = "\(R.string.s2) \(R.string.chk2.uppercased())"
//		title2Block.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.openPanel2(_:))))
		title2Block.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.openPanel)))
		let _ = title2Block.addBackgroundGradient(colors: [R.color.YumaRed.cgColor, UIColor.gray.cgColor], isVertical: false)
		tick2.font = R.font.FontAwesomeOfSize(pointSize: Int(tick1.frame.height)-1)
		tick2.text = FontAwesome.checkCircleO.rawValue
		tick2.alpha = 0
		title3.text = "\(R.string.s3) \(R.string.chk3.uppercased())"
//		title3Block.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.openPanel3(_:))))
		title3Block.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.openPanel)))
		let _ = title3Block.addBackgroundGradient(colors: [R.color.YumaRed.cgColor, UIColor.gray.cgColor], isVertical: false)
		tick3.font = R.font.FontAwesomeOfSize(pointSize: Int(tick1.frame.height)-1)
		tick3.text = FontAwesome.checkCircleO.rawValue
		tick3.alpha = 0
		title4.text = "\(R.string.s4) \(R.string.chk4.uppercased())"
//		title4Block.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.openPanel4(_:))))
		title4Block.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.openPanel)))
		let _ = title4Block.addBackgroundGradient(colors: [R.color.YumaRed.cgColor, UIColor.gray.cgColor], isVertical: false)
		tick4.font = R.font.FontAwesomeOfSize(pointSize: Int(tick1.frame.height)-1)
		tick4.text = FontAwesome.checkCircleO.rawValue
		tick4.alpha = 0
		panel = [panel1, panel2, panel3, panel4]
		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
		buttonLeft.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		buttonRight.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		navClose.title = FontAwesome.close.rawValue
		navClose.setTitleTextAttributes([
			NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)
			], for: UIControlState.normal)
		navHelp.title = FontAwesome.questionCircle.rawValue
		navHelp.setTitleTextAttributes([
			NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)
			], for: UIControlState.normal)
		/////cart table
//		totalAmtLbl.text = R.string.Total.uppercased()
//		totalPcsLbl.text = R.string.pieces
//		tableView.delegate = self
//		cartPanel.superview?.constraints.forEach({ (constraint) in
//			if constraint.firstItem === cartPanel && constraint.firstAttribute == .width
//			{
//				constraint.constant = self.view.frame.width * 1/3
//			}
//		})
//		fillCart()
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
		//print(store.myOrder)
	}
	/////
	
	
	@objc func openPanel(_ sender: UITapGestureRecognizer)
	{
		let str = (sender.view?.subviews[0].subviews[0].subviews[1] as! UILabel).text!
		let cha = str[str.index(str.startIndex, offsetBy: 0)]
		let num = Int(String(cha))!
		for i in 0..<4
		{
			if i != num-1
			{
				if panel[i].frame.height != 0
				{
//					panel[i].heightAnchor.constraint(equalToConstant: 0)
//					panel[i].heightAnchor.constraint(equalToConstant: 0).constant = 0
//					panel[i].animateConstraintWithDuration()
					UIView.animate(withDuration: 1.3, animations: {
						self.panel[i].heightAnchor.constraint(equalToConstant: 0).isActive = true
						self.panel[i].layoutIfNeeded()
						})
					//self.view.layoutIfNeeded()
				}
			}
		}
//		panel[num-1].heightAnchor.constraint(equalToConstant: panelHeight).constant = panelHeight
//		panel[num-1].animateConstraintWithDuration()
		//self.view.layoutIfNeeded()
		UIView.animate(withDuration: 1.3, animations: {
			self.panel[num-1].heightAnchor.constraint(equalToConstant: self.panelHeight).isActive = true
			self.panel[num-1].layoutIfNeeded()
			})
		//self.view.layoutIfNeeded()
	}

//	@objc func openPanel1(_ sender: UITapGestureRecognizer)
//	{
//		if panel1.frame.height == 0
//		{
//			if panel2.frame.height != 0
//			{
//				panel2.heightAnchor.constraint(equalToConstant: 0)
//				panel2.animateConstraintWithDuration()
//			}
//			if panel3.frame.height != 0
//			{
//				panel3.heightAnchor.constraint(equalToConstant: 0)
//				panel3.animateConstraintWithDuration()
//			}
//			if panel4.frame.height != 0
//			{
//				panel4.heightAnchor.constraint(equalToConstant: 0)
//				panel4.animateConstraintWithDuration()
//			}
//			panel1.heightAnchor.constraint(equalToConstant: panelHeight)
//			panel1.animateConstraintWithDuration()
//		}
//	}
//
//	@objc func openPanel2(_ sender: UITapGestureRecognizer)
//	{
//		if panel2.frame.height == 0
//		{
//			if panel1.frame.height != 0
//			{
//				panel1.heightAnchor.constraint(equalToConstant: 0)
//				panel1.animateConstraintWithDuration()
//			}
//			if panel3.frame.height != 0
//			{
//				panel3.heightAnchor.constraint(equalToConstant: 0)
//				panel3.animateConstraintWithDuration()
//			}
//			if panel4.frame.height != 0
//			{
//				panel4.heightAnchor.constraint(equalToConstant: 0)
//				panel4.animateConstraintWithDuration()
//			}
//			panel2.heightAnchor.constraint(equalToConstant: panelHeight)
//			panel2.animateConstraintWithDuration()
//		}
//	}
//
//	@objc func openPanel3(_ sender: UITapGestureRecognizer)
//	{
//		print(sender)
//		if panel3.frame.height == 0
//		{
//			if panel2.frame.height != 0
//			{
//				panel2.heightAnchor.constraint(equalToConstant: 0)
//				panel2.animateConstraintWithDuration()
//			}
//			if panel1.frame.height != 0
//			{
//				panel1.heightAnchor.constraint(equalToConstant: 0)
//				panel1.animateConstraintWithDuration()
//			}
//			if panel4.frame.height != 0
//			{
//				panel4.heightAnchor.constraint(equalToConstant: 0)
//				panel4.animateConstraintWithDuration()
//			}
//			panel3.heightAnchor.constraint(equalToConstant: panelHeight)
//			panel3.animateConstraintWithDuration()
//		}
//	}
//
//	@objc func openPanel4(_ sender: UITapGestureRecognizer)
//	{
//		if panel4.frame.height == 0
//		{
//			if panel2.frame.height != 0
//			{
//				panel2.heightAnchor.constraint(equalToConstant: 0)
//				panel2.animateConstraintWithDuration()
//			}
//			if panel3.frame.height != 0
//			{
//				panel3.heightAnchor.constraint(equalToConstant: 0)
//				panel3.animateConstraintWithDuration()
//			}
//			if panel1.frame.height != 0
//			{
//				panel1.heightAnchor.constraint(equalToConstant: 0)
//				panel1.animateConstraintWithDuration()
//			}
//			panel4.heightAnchor.constraint(equalToConstant: panelHeight)
//			panel4.animateConstraintWithDuration()
//		}
//	}

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
