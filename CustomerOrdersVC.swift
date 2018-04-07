//
//  CustomerOrdersVC.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-13.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit
//import SwiftDataTables


class CustomerOrdersVC: UIViewController
{
	@IBOutlet weak var navBar: UINavigationBar!
	@IBOutlet weak var navTitle: UINavigationItem!
	@IBOutlet weak var navClose: UIBarButtonItem!
	@IBOutlet weak var navHelp: UIBarButtonItem!
	@IBOutlet weak var mainStack: UIStackView!
	@IBOutlet weak var errorView: UIView!
	@IBOutlet weak var errorMessage: UILabel!
	@IBOutlet weak var tableStack: UIStackView!
	//var dataTable: SwiftDataTable! = nil!
	let store = DataStore.sharedInstance
	
	
	override func viewDidLoad()
	{
		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
		navTitle.title = R.string.OrdHist
		getOrderDetails()
		if store.orders.count > 0
		{
//			errorView.isHidden = true
			errorView.removeFromSuperview()
			drawTable()
		}
		else
		{
			errorMessage.text = R.string.noOrderHist
			let alert = UIAlertController(title: R.string.empty, message: R.string.tryAgain, preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: R.string.dismiss, style: .default, handler: { (action) in
				self.dismiss(animated: false, completion: nil)
			}))
			OperationQueue.main.addOperation {
				self.present(alert, animated: false, completion: nil)
			}
		}
	}
	
	
	func drawTable()
	{
		let myTable = MakeTable()//frame: CGRect(x: 5, y: 100, width: 500, height: 200))
		myTable.data = store.orders
		myTable.structure =
			MyTable(caption: R.string.orderHistoryTop,
					captionGap: 		10,
					captionAttributes: 	[NSAttributedStringKey.foregroundColor : UIColor.darkGray,
										NSAttributedStringKey.font : UIFont.systemFont(ofSize: 13)],
					columnSpacing: 		10,
					headerRowGap: 		15,
					headerAttributes: 	[NSAttributedStringKey.foregroundColor : UIColor.black,
										   NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12)],
					dataRowSpacing: 	10,
					dataRowAttributes: 	[NSAttributedStringKey.font : UIFont.systemFont(ofSize: 11)],
					columns: 			[
						MyTableColumn(key: 				"reference",
									  headerText: 		"\(R.string.order) \(R.string.ref)",
									  headerAttributes: nil,
									  dataLinkTo: 		#selector(self.rowDetails(_:)),
									  dataReplaceWith: 	nil,
									  dataAttributes: 	[NSAttributedStringKey.foregroundColor : UIColor.darkGray],
									  calculate: 	{ 	(str) -> String in return str 	}
						),
						MyTableColumn(key: 				"date_add",
									  headerText: 		R.string.date,
									  headerAttributes: nil,
									  dataLinkTo: 		#selector(self.rowDetails(_:)),
									  dataReplaceWith: 	nil,
									  dataAttributes: 	[NSAttributedStringKey.foregroundColor : UIColor.darkGray],
									  calculate:		{ 	(str) in
											let df = DateFormatter()
											df.locale = Locale(identifier: self.store.locale)
											df.dateFormat = "dd MMM YYYY"
											if let date = df.date(from: str)
											{
												return "\(df.string(from: date))"
											}
											return str
										}),
						MyTableColumn(key: 				"total_paid",
									  headerText: 		R.string.tPrice,
									  headerAttributes: nil,
									  dataLinkTo: 		#selector(self.rowDetails(_:)),
									  dataReplaceWith: 	nil,
									  dataAttributes: 	[NSAttributedStringKey.foregroundColor : UIColor.darkGray],
									  calculate:		{ 	(str) in
											if let currency = Double(str)
											{
												return self.store.formatCurrency(amount: NSNumber(value: currency), iso: self.store.locale)
											}
											return str
									}),//total_paid_tax_excl
						MyTableColumn(key: 				"payment",
									  headerText: 		R.string.payment,
									  headerAttributes: nil,
									  dataLinkTo: 		#selector(self.rowDetails(_:)),
									  dataReplaceWith: 	nil,
									  dataAttributes: 	[NSAttributedStringKey.foregroundColor : UIColor.darkGray],
									  calculate: 		{ 	(str) -> String in return str 	}),
						MyTableColumn(key: 				"current_state",
									  headerText: 		R.string.status,
									  headerAttributes: nil,
									  dataLinkTo: 		#selector(self.rowDetails(_:)),
									  dataReplaceWith: 	nil,
									  dataAttributes: 	[NSAttributedStringKey.foregroundColor : UIColor.darkGray],
									  calculate: 		{ 	(str) -> String in return str 	}),
						MyTableColumn(key: 				"invoice_number",
									  headerText: 		R.string.inv,
									  headerAttributes: nil,
									  dataLinkTo: 		#selector(self.rowDetails(_:)),
									  dataReplaceWith: 	nil,
									  dataAttributes: 	[NSAttributedStringKey.foregroundColor : UIColor.darkGray],
									  calculate: 		{ 	(str) -> String in return str 	}),
						MyTableColumn(key: 				nil,
									  headerText: 		nil,
									  headerAttributes: nil,
									  dataLinkTo: 		#selector(self.rowDetails(_:)), dataReplaceWith: R.string.details,
									  dataAttributes: 	[NSAttributedStringKey.foregroundColor : R.color.YumaRed],
									  calculate: 		{ 	(str) -> String in return str 	}),
						MyTableColumn(key: 				nil,
									  headerText: 		nil,
									  headerAttributes: nil,
									  dataLinkTo: 		#selector(self.rowReorder(_:)),
									  dataReplaceWith: 	R.string.reorder,
									  dataAttributes: 	[NSAttributedStringKey.foregroundColor : R.color.YumaRed],
									  calculate: 		{ 	(str) -> String in return str 	}),
				]
		)
		//self.view.addSubview(myTable.buildView())
		let built = myTable.buildView()
		//			let built = myTable
		self.tableStack.addArrangedSubview(built)
		//tableStack.superview?.addSubview(built)
		/*			NSLayoutConstraint.activate([
		//				built.topAnchor.constraint(equalTo: (tableStack.superview?.topAnchor)!),
		//				built.leadingAnchor.constraint(equalTo: (tableStack.superview?.leadingAnchor)!),
		//				built.bottomAnchor.constraint(equalTo: (tableStack.superview?.bottomAnchor)!),
		//				built.trailingAnchor.constraint(equalTo: (tableStack.superview?.trailingAnchor)!),
		
		built.topAnchor.constraint(equalTo: tableStack.topAnchor),
		built.leadingAnchor.constraint(equalTo: tableStack.leadingAnchor),
		built.bottomAnchor.constraint(equalTo: tableStack.bottomAnchor),
		built.trailingAnchor.constraint(equalTo: tableStack.trailingAnchor),
		])*/
	}
	
	
	func getOrderDetails()
	{
		if store.customer != nil && store.orderDetails.count < 1
		{
			var i = 0
			for order in store.orders
			{
				let id_order = Int(order.id!)
				let ord = UserDefaults.standard.string(forKey: "Order\(id_order)Details")
				if ord == nil || ord == ""
					//		if UserDefaults.standard.string(forKey: "OrdersCustomer\(id_customer)") == ""
				{	//perform http get
					store.getOrderDetails(id_order: id_order)
					{
						(orders, err) in
						
						if err != nil
						{
							print(err!)
							return
						}
						if let orders = orders
						{
							let array = (orders as? OrderDetails)?.orderDetails
							for member in array!
							{
								self.store.orderDetails.append(member)
							}
							//let ords = ord?.count
							print("got api details for order \(id_order)")
						}
					}
				}
				else
				{
					//decode json string "ord"
					let tempStr: String = store.trimJSONValueToArray(string: ord!)
					let tempObj: [OrderDetail]
					do
					{
						tempObj = try JSONDecoder().decode([OrderDetail].self, from: tempStr.data(using: .utf8)!)
//						for ords in tempObj
//						{
							store.orderDetails.append(tempObj[0])//ords)
//						}
					}
					catch let jsonErr
					{
						print(jsonErr)
					}
					print("decoding details for order \(id_order)")
				}
				i += 1
			}
			//print("got details for \(i) orders")
		}
	}


	//https://stackoverflow.com/questions/24844681/list-of-classs-properties-in-swift
//	func getKeysAndTypes(forObject:Any?) -> Dictionary<String,String>
//	{
//		var answer:Dictionary<String,String> = [:]
//		var counts = UInt32();
//		let properties = class_copyPropertyList(object_getClass(forObject), &counts);
//		for i in 0..<counts {
//			let property = properties?.advanced(by: Int(i)).pointee;
//
//			let cName = property_getName(property!);
//			let name = String(cString: cName)
//
//			let cAttr = property_getAttributes(property!)!
//			let attr = String(cString:cAttr).components(separatedBy: ",")[0].replacingOccurrences(of: "T", with: "");
//			answer[name] = attr;
//			//print("ID: \(property.unsafelyUnwrapped.debugDescription): Name \(name), Attr: \(attr)")
//		}
//		return answer;
//	}
	
	
	@objc func rowDetails(_ sender: UITapGestureRecognizer)
	{
		print(sender)
		if store.orderDetails.count > 1
		{
			//
		}
		else
		{
			store.Alert(fromView: self, title: R.string.no_data, titleColor: R.color.YumaRed, /*titleBackgroundColor: <#T##UIColor?#>, titleFont: <#T##UIFont?#>,*/ message: nil, /*messageColor: <#T##UIColor?#>, messageBackgroundColor: <#T##UIColor?#>, messageFont: <#T##UIFont?#>,*/ dialogBackgroundColor: R.color.YumaYel, backgroundBackgroundColor: R.color.YumaRed, /*backgroundBlurStyle: <#T##UIBlurEffectStyle?#>, backgroundBlurFactor: <#T##CGFloat?#>,*/ borderColor: R.color.YumaDRed, borderWidth: 1, /*cornerRadius: <#T##CGFloat?#>,*/ shadowColor: R.color.YumaDRed, /*shadowOffset: <#T##CGSize?#>, shadowOpacity: <#T##Float?#>, shadowRadius: <#T##CGFloat?#>, alpha: <#T##CGFloat?#>,*/ hasButton1: true, button1Title: R.string.cancel/*, button1Style: <#T##UIAlertActionStyle?#>, button1Color: <#T##UIColor?#>, button1Font: <#T##UIFont?#>, button1Action: <#T##DataStore.Closure_Void?##DataStore.Closure_Void?##() -> Void#>, hasButton2: <#T##Bool#>, button2Title: <#T##String?#>, button2Style: <#T##UIAlertActionStyle?#>, button2Color: <#T##UIColor?#>, button2Font: <#T##UIFont?#>, button2Action: <#T##DataStore.Closure_Void?##DataStore.Closure_Void?##() -> Void#>*/)
		}
	}
	
	@objc func rowReorder(_ sender: UITapGestureRecognizer)
	{
	}
	

	@IBAction func navCloseAct(_ sender: Any)
	{
		self.dismiss(animated: false, completion: nil)
	}
	@IBAction func navHelpAct(_ sender: Any)
	{
	}
	
}

