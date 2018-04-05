//
//  CustomerOrdersVC.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-13.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit
//import SwiftDataTables


struct MyTable
{
	let caption: 		String?
	let captionGap: 	CGFloat?
	let columnSpacing: 	CGFloat?
	let headerRowGap:	CGFloat?	//Points
	let dataRowSpacing: CGFloat?
	let columns: 		[MyTableColumn]
}

typealias closureVoid = (Any) -> Void

struct MyTableColumn
{
	let key: 				String?
	let headerText: 		String?
	let headerAttributes: 	[NSAttributedStringKey : Any]?
	let dataLinkTo: 		Selector?
	let dataReplaceWith: 	String?
	let dataAttributes: 	[NSAttributedStringKey : Any]?
	let calculate:			/*(() -> Void)?*/closureVoid?
}


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
		if store.orders.count > 0
		{
//			errorView.isHidden = true
			errorView.removeFromSuperview()
			let myTable = MakeTable()//frame: CGRect(x: 5, y: 100, width: 500, height: 200))
			myTable.data = store.orders
			myTable.structure =
				MyTable(caption: R.string.orderHistoryTop, captionGap: 10, columnSpacing: 5, headerRowGap: 15, dataRowSpacing: 5, columns: [
					MyTableColumn(key: "reference", headerText: "\(R.string.order) \(R.string.ref)", headerAttributes: nil, dataLinkTo: nil, dataReplaceWith: nil, dataAttributes: nil, calculate: { (data) in }),
					MyTableColumn(key: "date_add", headerText: R.string.date, headerAttributes: nil, dataLinkTo: nil, dataReplaceWith: nil, dataAttributes: [:], calculate: { (data) in
						let df = DateFormatter()
						df.locale = Locale(identifier: self.store.locale)
						df.dateFormat = "dd MMM YYYY"
					}),
					MyTableColumn(key: "total_paid", headerText: R.string.tPrice, headerAttributes: nil, dataLinkTo: nil, dataReplaceWith: nil, dataAttributes: [:], calculate: { (data) in
						let currency = data as! NSNumber
						let _ = self.store.formatCurrency(amount: currency, iso: self.store.locale)
					}),//total_paid_tax_excl
					MyTableColumn(key: "payment", headerText: R.string.payment, headerAttributes: nil, dataLinkTo: nil, dataReplaceWith: nil, dataAttributes: [:], calculate: { (data) in }),
					MyTableColumn(key: "current_state", headerText: R.string.status, headerAttributes: nil, dataLinkTo: nil, dataReplaceWith: nil, dataAttributes: [:], calculate: { (data) in }),
					MyTableColumn(key: "invoice_number", headerText: R.string.inv, headerAttributes: nil, dataLinkTo: nil, dataReplaceWith: nil, dataAttributes: [:], calculate: { (data) in }),
					MyTableColumn(key: nil, headerText: nil, headerAttributes: nil, dataLinkTo: #selector(self.rowDetails(_:)), dataReplaceWith: R.string.details, dataAttributes: [NSAttributedStringKey.foregroundColor: R.color.YumaRed], calculate: { (data) in }),
					MyTableColumn(key: nil, headerText: nil, headerAttributes: nil, dataLinkTo: #selector(self.rowReorder(_:)), dataReplaceWith: R.string.reorder, dataAttributes: [NSAttributedStringKey.foregroundColor: R.color.YumaRed], calculate: { (data) in }),
					]
			)
			navTitle.title = R.string.OrdHist
/*
			let testLabel = UILabel()
			testLabel.text = "store=\(store.orders[0].id ?? 0)|"
			tableStack.addArrangedSubview(testLabel)
			let ordTable = myTable.buildView()
			ordTable.translatesAutoresizingMaskIntoConstraints = false
			tableStack.addArrangedSubview(ordTable)
			let testLabel1 = UILabel()
			testLabel1.text = "data=\(myTable.data![0])|"
			tableStack.addArrangedSubview(testLabel1)
*/
			//self.view.addSubview(myTable.buildView())
			let built = myTable.buildView()
			tableStack.addArrangedSubview(built)
			NSLayoutConstraint.activate([
				built.topAnchor.constraint(equalTo: tableStack.topAnchor),
				built.leadingAnchor.constraint(equalTo: tableStack.leadingAnchor),
//				built.bottomAnchor.constraint(equalTo: tableStack.bottomAnchor),
//				built.trailingAnchor.constraint(equalTo: tableStack.trailingAnchor),
				])
		}
		else
		{
			errorMessage.text = R.string.noOrderHist
		}
	}


	//https://stackoverflow.com/questions/24844681/list-of-classs-properties-in-swift
	func getKeysAndTypes(forObject:Any?) -> Dictionary<String,String>
	{
		var answer:Dictionary<String,String> = [:]
		var counts = UInt32();
		let properties = class_copyPropertyList(object_getClass(forObject), &counts);
		for i in 0..<counts {
			let property = properties?.advanced(by: Int(i)).pointee;
			
			let cName = property_getName(property!);
			let name = String(cString: cName)
			
			let cAttr = property_getAttributes(property!)!
			let attr = String(cString:cAttr).components(separatedBy: ",")[0].replacingOccurrences(of: "T", with: "");
			answer[name] = attr;
			//print("ID: \(property.unsafelyUnwrapped.debugDescription): Name \(name), Attr: \(attr)")
		}
		return answer;
	}
	
	
	@objc func rowDetails(_ sender: UITapGestureRecognizer)
	{
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


class MakeTable: UIView
{
	var data: [Any]?
	var structure: MyTable?
	
	
	override init(frame: CGRect)
	{
		super.init(frame: frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	fileprivate func buildCell(row: Any, col: MyTableColumn) -> UILabel
	{
		let cellData = UILabel()
		cellData.translatesAutoresizingMaskIntoConstraints = false
		if col.dataReplaceWith != nil
		{
			cellData.text = col.dataReplaceWith
		}
		else
		{
			let rowStr = String(describing: row)
			let findThis = "\(col.key ?? ""): Optional"// + "\\"// + "\""
			var foundFirst = ""
			let pos = rowStr.range(of: findThis, options: .literal, range: rowStr.startIndex..<rowStr.endIndex, locale: nil)
			var foundFinal = R.string.no_data
			if let range1 = pos
			{
				let start = range1.upperBound
				foundFirst = String(rowStr[start..<rowStr.endIndex])
				let result = foundFirst.range(of: ",", options: .literal, range: foundFirst.startIndex..<foundFirst.endIndex, locale: nil)
				if let range2 = result
				{
					let start = range2.lowerBound
					foundFinal = String(foundFirst[foundFirst.startIndex..<start])
				}
			}
			foundFinal = foundFinal.replacingOccurrences(of: "(\"", with: "")
			foundFinal = foundFinal.replacingOccurrences(of: "\")", with: "")
			foundFinal = foundFinal.replacingOccurrences(of: "Data unavailable", with: "-")
			cellData.text = foundFinal
		//cellData.text = "get \(col.key)"//" in \(row)"//**TODO**
		//print("get \(col.key) in \(row)")
		//	cellData.text = (row as AnyObject).value(forKey: col.key!) as? String//[<_SwiftValue 0x7feb6307fa00> valueForUndefinedKey:]: this class is not key value coding-compliant for the key reference
		//	print((row as AnyObject).value(forKey: col.key) as? String as Any)
			print("Label \(cellData.text ?? "")")
		}
		if col.dataAttributes != nil && (col.dataAttributes?.count)! > 0
		{
			let attributeStr = NSAttributedString(string: cellData.text!, attributes: col.dataAttributes)
			cellData.attributedText = attributeStr
		}
		if col.dataLinkTo != nil
		{
			cellData.addGestureRecognizer(UITapGestureRecognizer(target: self, action: col.dataLinkTo))
		}
		return cellData
		//colData.addArrangedSubview(cellData)
	}

	
	fileprivate func buildColumn(_ colNum: Int) -> UIStackView
	{
		let col = structure?.columns[colNum]
		let colTitle = UILabel()
		if col?.headerText != nil
		{
			colTitle.text = col?.headerText
			print("Label header=\(col?.headerText! ?? "")")
			//colTitle.translatesAutoresizingMaskIntoConstraints = false
			if col?.headerAttributes != nil && (col?.headerAttributes?.count)! > 0
			{
				let attributeStr = NSAttributedString(string: colTitle.text!, attributes: col?.headerAttributes)
				colTitle.attributedText = attributeStr
			}
		}
		let colData = UIStackView()
		//colData.translatesAutoresizingMaskIntoConstraints = false
		colData.axis = .vertical
		colData.spacing = (structure?.dataRowSpacing)!
		//for cell in DataStore.sharedInstance.orders//ordData
		//for cellNum in 0 ..< DataStore.sharedInstance.orders[colNum].keys!
		//let cell = DataStore.sharedInstance.orders[colNum]
		print("Stack key=\(col?.key ?? "")")
//		if col?.key != nil
//		{
			for row in data!
			{
				colData.addArrangedSubview(buildCell(row: row, col: col!))//accummulate UILabels
			}
//		}
		let column = UIStackView(arrangedSubviews: [colTitle, colData])//UILabel + UIStack
		column.spacing = (structure?.headerRowGap)!
		//column.translatesAutoresizingMaskIntoConstraints = false
		column.axis = .vertical
		return column
	}
	
	
	func buildView() -> UIView
	{
		let table = UIView()
		//table.translatesAutoresizingMaskIntoConstraints = false
//		let type = String(describing: data.self)
//		print("type is \(type)|")
		let tblCaption = UILabel()
		//tblCaption.translatesAutoresizingMaskIntoConstraints = false
		if structure?.caption != nil
		{
			//print("table caption:\(tblCaption.text)")
			tblCaption.text = structure?.caption
		}
		let tblColumns = UIStackView()
		//tblColumns.translatesAutoresizingMaskIntoConstraints = false
		tblColumns.axis = .horizontal
		tblColumns.spacing = (structure?.columnSpacing)!
//		let keys = Orders().propertyNames()
//		print("keys:\(keys)")
		print("columns-")
		for colNum in 0 ..< (structure?.columns.count)!
		{
			tblColumns.addArrangedSubview(buildColumn(colNum))//accumulate columns
		}
		let ordLayout = UIStackView(arrangedSubviews: [tblCaption, tblColumns])
		ordLayout.spacing = (structure?.captionGap)!
		ordLayout.translatesAutoresizingMaskIntoConstraints = false
		ordLayout.axis = .vertical
		table.addSubview(ordLayout)
		//self.addSubview(table)
//		NSLayoutConstraint.activate([
//			table.topAnchor.constraint(equalTo: ordLayout.topAnchor),
//			table.leadingAnchor.constraint(equalTo: ordLayout.leadingAnchor),
//			table.bottomAnchor.constraint(equalTo: ordLayout.bottomAnchor),
//			table.trailingAnchor.constraint(equalTo: ordLayout.trailingAnchor),
//			])
		return table
	}

}
