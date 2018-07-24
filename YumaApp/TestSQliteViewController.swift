//
//  TestSQliteViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-07-16.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit
//import SQLite
import SQLite3


class TestSQliteViewController: UIViewController
{
//	var db: OpaquePointer?
//	var createStr = "CREATE TABLE IF NOT EXISTS Heroes (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, powerrank INTEGER)"
	var DBFile = "HeroesDatabase"


	/// Open/Connect to SQLite. DBName dosen't include ".sqlite" suffix
//	func Connect(_ DBName: String) -> OpaquePointer
//	{
//		var db: OpaquePointer? = nil
//		let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//			.appendingPathComponent(DBName + ".sqlite")
//		if sqlite3_open(fileURL.path, &db) != SQLITE_OK
//		{
//			print("error opening database")
//		}
//		return db!
//	}

	override func viewDidLoad()
	{
		let sql = MySQLite()
        super.viewDidLoad()

		let table = "Heros"
		if let db = try? sql.Connect(DBFile)
		{
//			let myCreateStr = sql.createTable(db, name: table, notExists: true, columns: [
//				MySQLite.SQLColumn(name: "id", notNull: .null, dataType: .integer, key: .pri, extra: .autoInc, defaultValue: nil, isPrimaryKey: true),
//				MySQLite.SQLColumn(name: "name", notNull: .null, dataType: .text, key: nil, extra: nil, defaultValue: nil, isPrimaryKey: false),
//				MySQLite.SQLColumn(name: "powerrank", notNull: .null, dataType: .integer, key: nil, extra: nil, defaultValue: nil, isPrimaryKey: false)])
//			if myCreateStr != nil
//			{
//				print("error " + myCreateStr!)
//			}
//			else
//			{
//				let cols = sql.columnsIn(db, table)
//				print("columns in \(table):")
//				var num = 0
//				for col in cols!
//				{
//					var output = "|\(num)|\(col.name)|"
//					if col.dataType != nil		{		output += "\(col.dataType!.rawValue)"		}
//					output += "|"
//					if col.notNull != nil		{		output += "\(col.notNull!.rawValue)"		}
//					output += "|"
//					if col.defaultValue != nil	{		output += "\(col.defaultValue!)"			}
//					output += "|"
//					if col.key != nil			{		output += "\(col.key!.rawValue)"			}
//					output += "|"
//					print(output)
//					num += 1
//				}
//				let deleteResults = sql.deleteFrom(db, table, whereClause: MySQLite.Where(columnName: "id", comparison: .lessThan, values: [30]))
//				if deleteResults != nil
//				{
//					print("error " + deleteResults!)
//				}
				let results = sql.selectOrderedFrom(db, table)
				print("data in \(table):")
				if results != nil
				{
					for row in results!
					{								// each row
						var output = "|"			// row beginning
						for value in row
						{							// each field
							output += "\(value)|"	// add an ending pipe
						}
						print(output)				// print the row
					}
				}
				else
				{
					print("no rows in table")
				}
//				let insResult = sql.insertInto(db, table, columns: ["name"], values: ["me", "myself", "I"], debugPrint: .defaultNoPrint)
//				if insResult != nil
//				{
//					print("error " + insResult!)
//				}
			let results2 = sql.selectOrderedFrom(db, table, columns: nil,
												 join: [MySQLite.SQLJoinLine(joinType: .inner, tableName: table, ons: [MySQLite.SQLJoinOn(primaryColumn: "joinPri", primaryAlias: nil, linkedBy: .equals, secondary: "joinSecCol", secondaryAlias: nil), MySQLite.SQLJoinOn(primaryColumn: "priJoinOn2", primaryAlias: "priJoinOnAlias2", linkedBy: .equals, secondary: "secJoinOn2", secondaryAlias: nil)]), MySQLite.SQLJoinLine(joinType: .natural, tableName: table, ons: [MySQLite.SQLJoinOn(primaryColumn: "priJoin2", primaryAlias: "priJoinAlias2", linkedBy: .equals, secondary: "secJoin2", secondaryAlias: "secJoinAlias2")])],
												 whereBy: [MySQLite.SQLWhereHaving(function: MySQLite.SQLFunc.count, columnName: "wheCol", comparison: .between, values: [2], betweenAnd: 4, alias: "whereAlias", direction: nil)],
												 orderBy: [MySQLite.SQLColumnOrder(column_: MySQLite.SQLColumn_/*.position(2)*//**/.name("ordCol")/**/, direction: .asc)],
												 limit: 3, offset: 4,
												 groupBy: [MySQLite.SQLGroupBy(column_: MySQLite.SQLColumn_.name("grpCol"), applyFunc: .average, direction: .asc, alias: nil)],
												 having: [MySQLite.SQLWhereHaving(function: MySQLite.SQLFunc.count, columnName: "havCol", comparison: .greaterThan, values: [3], betweenAnd: nil, alias: nil, direction: nil)],
												 debugPrint: MySQLite.SQLAction.printOnly)
//				print("data in \(table):")
//				if results2 != nil
//				{
//					for row in results2!
//					{
//						var output = "|"
//						for value in row
//						{
//							output += "\(value)|"
//						}
//						print(output)
//					}
//				}
//				else
//				{
//					print("no rows in \(table)")
//				}
//			}
//			let eventModel_longDescription = "AB</p>C"
//			let mutableAttributedString = NSMutableAttributedString(string: eventModel_longDescription)
//			let eventDescription = mutableAttributedString.mutableString
//				.replacingOccurrences(of: "</p>", with: "</p>\n")
//				.replacingOccurrences(of: "<li>", with: "<li>•\t")
//
//			let paragraphStyle = NSMutableParagraphStyle()
//			paragraphStyle.lineSpacing = 0.0
//			paragraphStyle.minimumLineHeight = 22
//			paragraphStyle.maximumLineHeight = 22
//
//			let range = NSMakeRange(0, eventDescription.count)
//
//			mutableAttributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: range)
//			let date = Date()
//			let timeAgo = String(date.secondsAgo)
///////
			try? sql.Disconnect(db)
		}
	}

	//https://stackoverflow.com/questions/24102775/accessing-an-sqlite-database-in-swift
//	func ViewAllData(query: NSString, error: NSError) -> NSArray
//	{
//		var cStatement: OpaquePointer?
//		var result: AnyObject = NSNull()
//		var thisArray: NSMutableArray = NSMutableArray(capacity: 4)
////		cStatement = sqlite3_prepare_v2(db, query, nil, nil, nil)
//		if cStatement != nil
//		{
//			while sqlite3_step(cStatement) == SQLITE_ROW
//			{
//				result = NSNull()
//				var thisDict: NSMutableDictionary = NSMutableDictionary(capacity: 4)
//				for i in 0 ..< Int(sqlite3_column_count(cStatement))
//				{
//					if sqlite3_column_type(cStatement, Int32(i)) == 0
//					{
//						continue
//					}
//					if sqlite3_column_decltype(cStatement, Int32(i)) != nil && strcasecmp(sqlite3_column_decltype(cStatement, Int32(i)), "Boolean") == 0
//					{
//						var temp = sqlite3_column_int(cStatement, Int32(i))
//						if temp == 0
//						{
//							result = NSNumber(value : false)
//						}
//						else
//						{
//							result = NSNumber(value : true)
//						}
//					}
//					else if sqlite3_column_type(cStatement,Int32(i)) == SQLITE_INTEGER
//					{
//						var temp = sqlite3_column_int(cStatement,Int32(i))
//						result = NSNumber(value : temp)
//					}
//					else if sqlite3_column_type(cStatement,Int32(i)) == SQLITE_FLOAT
//					{
//						var temp = sqlite3_column_double(cStatement,Int32(i))
//						result = NSNumber(value: temp)
//					}
//					else
//					{
//						if sqlite3_column_text(cStatement, Int32(i)) != nil
//						{
//							var temp = sqlite3_column_text(cStatement,Int32(i))
//							result = String(cString: temp!) as AnyObject
//
//							var keyString = sqlite3_column_name(cStatement,Int32(i))
//							thisDict.setObject(result, forKey: String(cString: keyString!) as NSCopying)
//						}
//						result = NSNull()
//
//					}
//					if result as! NSObject != NSNull()
//					{
//						var keyString = sqlite3_column_name(cStatement,Int32(i))
//						thisDict.setObject(result, forKey: String(cString: keyString!) as NSCopying)
//					}
//				}
//				thisArray.add(NSMutableDictionary(dictionary: thisDict))
//			}
//			sqlite3_finalize(cStatement)
//		}
//		return thisArray
//	}

	override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
