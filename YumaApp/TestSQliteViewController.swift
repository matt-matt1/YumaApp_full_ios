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

//		let db = Connect(DBFile)
		if let db = try? sql.Connect(DBFile)
		{
			let myCreateStr = sql.createTable(db, name: "Heros", notExists: true, columns: [
				MySQLite.Column(name: "id", notNull: .null, dataType: .integer, key: .pri, extra: .autoInc, defaultValue: nil, isPrimaryKey: true),
				MySQLite.Column(name: "name", notNull: .null, dataType: .text, key: nil, extra: nil, defaultValue: nil, isPrimaryKey: false),
				MySQLite.Column(name: "powerrank", notNull: .null, dataType: .integer, key: nil, extra: nil, defaultValue: nil, isPrimaryKey: false)], printOnly: false)
			if myCreateStr != nil
			{
				print("error " + myCreateStr!)
			}
			else
			{
				print(sql.columnsIn(db, "Heros")!)//sql.columnsIn(db, "Heros")
				let results = sql.selectOrderedFrom(db, "Heros", columns: nil, where: nil, limit: nil)
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
				let insResult = sql.insertInto(db, "Heros", columns: ["name"], values: ["me", "myself", "I"], debugPrint: true)
				if insResult != nil
				{
					print("error " + insResult!)
				}
				let results2 = sql.selectOrderedFrom(db, "Heros", columns: nil, where: nil, limit: nil)
				if results2 != nil
				{
					for row in results2!
					{
						var output = "|"
						for value in row
						{
							output += "\(value)|"
						}
						print(output)
					}
				}
				else
				{
					print("no rows in table")
				}
			}
//			let myColsStr = sql.columnsIn(db, "Heros")
//			if myColsStr != nil
//			{
//				print("error \(myColsStr!)")
//			}
//			try! sql.Disconnect(db)
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
