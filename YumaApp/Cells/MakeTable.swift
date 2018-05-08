//
//  MakeTable.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-05.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


struct MyTable
{
	let caption: 			String?
	let captionGap: 		CGFloat?	//Points
	let captionAttributes: 	[NSAttributedStringKey : Any]?
	let columnSpacing: 		CGFloat?	//Points
	let headerRowGap:		CGFloat?	//Points
	let headerAttributes: 	[NSAttributedStringKey : Any]?	//global for every column
	let dataRowSpacing: 	CGFloat?	//Points
	let dataRowAttributes: 	[NSAttributedStringKey : Any]?	//global for every column
	let columns: 			[MyTableColumn]
}

typealias closureVoid = 	(String) -> Void?
typealias closureString = 	(String) -> String?

struct MyTableColumn
{
	let key: 				String?
	let headerText: 		String?
	let headerAttributes: 	[NSAttributedStringKey : Any]?	//override the MyTable.headerAttributes, if any
	let dataLinkTo: 		Selector?
	let dataReplaceWith: 	String?
	let dataAttributes: 	[NSAttributedStringKey : Any]?	//override the MyTable.dataRowAttributes, if any
	let calculate:			/*(() -> Void)?*/closureString?
}


class MakeTable: UIView
{
	var data: 		[Any]?
	var structure: 	MyTable?
	
	
	override init(frame: CGRect)
	{
		super.init(frame: frame)
		//makeView()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


	func returnTable()
	{
		let table = buildView()
		table.translatesAutoresizingMaskIntoConstraints = false
		addSubview(table)
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
			//print("Label \(cellData.text ?? "")")
		}
		if col.calculate != nil && cellData.text != nil
		{
			cellData.text = col.calculate!(cellData.text!)
		}
		if structure?.dataRowAttributes != nil && (structure?.dataRowAttributes?.count)! > 0
		{
			let attributeStr = NSAttributedString(string: cellData.text!, attributes: structure?.dataRowAttributes)
			cellData.attributedText = attributeStr
		}
		if col.dataAttributes != nil && (col.dataAttributes?.count)! > 0
		{
			let attributeStr = NSAttributedString(string: cellData.text!, attributes: col.dataAttributes)
//			if cellData.attributedText != nil
//			{
				for attr in attributeStr.attributes
				{
					cellData.textAttributes.append(attr)
				}
//			}
//			else
//			{
//				cellData.attributedText = attributeStr
//			}
		}
		else if (structure?.dataRowAttributes == nil || (structure?.dataRowAttributes?.count)! < 1) && cellData.text != nil
		{
			let attrStr = NSAttributedString(string: cellData.text!, attributes: [NSAttributedStringKey.font : UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)])
			cellData.attributedText = attrStr
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
			//print("Label header=\(col?.headerText! ?? "")")
			colTitle.translatesAutoresizingMaskIntoConstraints = false
			if structure?.headerAttributes != nil && (structure?.headerAttributes?.count)! > 0
			{
				let attributeStr = NSAttributedString(string: colTitle.text!, attributes: structure?.headerAttributes)
				colTitle.attributedText = attributeStr
			}
			if col?.headerAttributes != nil && (col?.headerAttributes?.count)! > 0
			{
				let attributeStr = NSAttributedString(string: colTitle.text!, attributes: col?.headerAttributes)
				for attr in attributeStr.attributes
				{
					colTitle.textAttributes.append(attr)
				}
			}
		}
		let colData = UIStackView()
		colData.translatesAutoresizingMaskIntoConstraints = false
		colData.axis = .vertical
		colData.spacing = (structure?.dataRowSpacing)!
		//for cell in DataStore.sharedInstance.orders//ordData
		//for cellNum in 0 ..< DataStore.sharedInstance.orders[colNum].keys!
		//let cell = DataStore.sharedInstance.orders[colNum]
		//		print("Stack key=\(col?.key ?? "")")
		//		if col?.key != nil
		//		{
		for row in data!
		{
			colData.addArrangedSubview(buildCell(row: row, col: col!))//accummulate UILabels
		}
		//		}
		let column = UIStackView(arrangedSubviews: [colTitle, colData])//UILabel + UIStack
		column.spacing = (structure?.headerRowGap)!
		column.translatesAutoresizingMaskIntoConstraints = false
		column.axis = .vertical
		return column
	}
	
	
	func buildView() -> UIView
	{
		let table = UIView()
		table.translatesAutoresizingMaskIntoConstraints = false
		//		let type = String(describing: data.self)
		//		print("type is \(type)|")
		let tblCaption = UILabel()
		tblCaption.translatesAutoresizingMaskIntoConstraints = false
		if structure?.caption != nil
		{
			//print("table caption:\(tblCaption.text)")
			tblCaption.text = structure?.caption
			if structure?.captionAttributes != nil && (structure?.captionAttributes?.count)! > 0
			{
				let attributeStr = NSAttributedString(string: tblCaption.text!, attributes: structure?.captionAttributes)
				tblCaption.attributedText = attributeStr
			}
		}
		let tblColumns = UIStackView()
		tblColumns.translatesAutoresizingMaskIntoConstraints = false
		tblColumns.axis = .horizontal
		tblColumns.spacing = (structure?.columnSpacing)!
		//		let keys = Orders().propertyNames()
		//		print("keys:\(keys)")
		//print("columns-")
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
	
	/*
	func makeView()
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
		//print("columns-")
		for colNum in 0 ..< (structure?.columns.count)!
		{
			tblColumns.addArrangedSubview(buildColumn(colNum))//accumulate columns
		}
		let ordLayout = UIStackView(arrangedSubviews: [tblCaption, tblColumns])
		ordLayout.spacing = (structure?.captionGap)!
		ordLayout.translatesAutoresizingMaskIntoConstraints = false
		ordLayout.axis = .vertical
		table.addSubview(ordLayout)
		self.addSubview(table)
		NSLayoutConstraint.activate([
//			table.topAnchor.constraint(equalTo: ordLayout.topAnchor),
//			table.leadingAnchor.constraint(equalTo: ordLayout.leadingAnchor),
//			table.bottomAnchor.constraint(equalTo: ordLayout.bottomAnchor),
//			table.trailingAnchor.constraint(equalTo: ordLayout.trailingAnchor),

			table.topAnchor.constraint(equalTo: self.topAnchor),
			table.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			table.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			table.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			])
	}
*/
	
	
	func zoomer(min: Float, max: Float) -> UIView
	{
//		if structure?.captionAttributes != nil && (structure?.captionAttributes?.count)! > 0
//		{
//			let attributeStr = NSAttributedString(string: tblCaption.text!, attributes: structure?.captionAttributes)
//			tblCaption.attributedText = attributeStr
//		}
		let smallText = UILabel()
		//smallText.text = "A"
		var attrText = NSAttributedString(string: "A", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 6)])
		smallText.attributedText = attrText
		let bigText = UILabel()
		bigText.text = "A"
		attrText = NSAttributedString(string: "A", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 16)])
		bigText.attributedText = attrText
		let slider = UISlider()
		slider.minimumValue = min
		slider.maximumValue = max
		slider.addTarget(self, action: #selector(self.sliderMoved(sender:)), for: .allEvents)
		let stack = UIStackView(arrangedSubviews: [smallText, slider, bigText])
		stack.axis = UILayoutConstraintAxis.horizontal
		stack.spacing = 10
		return stack
	}
	@objc func sliderMoved(sender: Any?)
	{
		//let value = round((sender as! UISlider).value)
		//UILabel.appearance().fontSize = CGFloat(value * 60)
	}
	
	

}
