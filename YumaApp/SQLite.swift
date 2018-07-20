//
//  SQLite.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-07-17.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit
import SQLite3


class MySQLite
{
	internal let SQLITE_STATIC = unsafeBitCast(0, to: sqlite3_destructor_type.self)
	internal let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
	
	/// Open/Connect to SQLite. DBName dosen't include ".sqlite" suffix
	func Connect(_ DBName: String) throws -> OpaquePointer
	{
		var db: OpaquePointer? = nil
		let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(DBName + ".sqlite")
		if sqlite3_open(fileURL.path, &db) != SQLITE_OK
		{
			throw SQLiteError.message(error: "cannot open database")
		}
		return db!
	}
	
	/// End a connection to a SQLite database
	func Disconnect(_ db: OpaquePointer) throws
	{
		if sqlite3_close(db) != SQLITE_OK
		{
			throw SQLiteError.message(error: "cannot close database")
		}
	}

	/// Create a database(db) table(table), optionally if it exists, containing Columns, returns nil on success or if error a error message(String)
	func createTable(_ db: OpaquePointer, name: String, notExists: Bool = true, columns: [Column], printOnly: Bool?) -> String?
	{
		var createStr = "CREATE TABLE "
		var i = 0
		
		if notExists					{		createStr += "IF NOT EXISTS "		}
		createStr += "\(name) (\n"
		var primaries = 0
		for col in columns
		{
			createStr += "\t\(col.name) \(col.dataType!.rawValue)"
			if col.key != nil			{		createStr += " \(col.key!.rawValue)"				}
			if col.extra != nil			{		createStr += " \(col.extra!.rawValue)"				}
			if col.isPrimaryKey!		{		primaries += 1										}
			if i < columns.count-1		{		createStr += ",\n"									}
			i += 1
		}
		if primaries > 1
		{
			createStr += ",\n\tPRIMARY KEY("
			for col in columns
			{
				createStr += "\(col.name),"
			}
			createStr = String(createStr.dropLast()) + ")\n"
		}
		createStr += ")"
		if printOnly != nil && printOnly!
		{
			return createStr
		}
		if sqlite3_exec(db, createStr, nil, nil, nil) != SQLITE_OK
		{
			let errMsg = String(cString: sqlite3_errmsg(db)!)
			return "error creating table: \(errMsg)"
		}
		return nil
	}
	
	/// Returns an array of columns([Column]) in database(db) table(table)
	func columnsIn(_ db: OpaquePointer, _ table: String) -> [Column]?
	{
		let queryString = "PRAGMA table_info(\(table))"
//		let queryString = "SELECT sql FROM sqlite_master WHERE name = \(table)"
		var stmt: OpaquePointer?
		var results: [Column] = []
		
		if sqlite3_prepare_v2(db, queryString, -1, &stmt, nil) != SQLITE_OK
		{
			return nil//String(cString: sqlite3_errmsg(db)!)
		}
		else
		{
			var row = 0
			while(sqlite3_step(stmt) == SQLITE_ROW)
			{
				var cid: SQLDataValue?
				var name: SQLDataValue?
				var type: SQLDataValue?
				var notNull: SQLDataValue?
				var dfltValue: SQLDataValue?
				var PK: SQLDataValue?
				if sqlite3_column_type(stmt, 0) == SQLITE_INTEGER
				{
					cid = SQLDataValue(INTEGER: sqlite3_column_int(stmt, Int32(0)), TEXT: nil, REAL: nil, Bool: nil)
				}
				if sqlite3_column_type(stmt, 1) == SQLITE_TEXT
				{
					name = SQLDataValue(INTEGER: nil, TEXT: String(cString: sqlite3_column_text(stmt, Int32(1))), REAL: nil, Bool: nil)
				}
				if sqlite3_column_type(stmt, 2) == SQLITE_TEXT
				{
					type = SQLDataValue(INTEGER: nil, TEXT: String(cString: sqlite3_column_text(stmt, Int32(2))), REAL: nil, Bool: nil)
				}
				if sqlite3_column_type(stmt, 3) == SQLITE_INTEGER
				{
					notNull = SQLDataValue(INTEGER: nil, TEXT: nil, REAL: nil, Bool: sqlite3_column_int(stmt, Int32(3)) == 1 ? true : false)
				}
				if sqlite3_column_type(stmt, 4) == SQLITE_TEXT
				{
					dfltValue = SQLDataValue(INTEGER: nil, TEXT: String(cString: sqlite3_column_text(stmt, Int32(4))), REAL: nil, Bool: nil)
				}
				if sqlite3_column_type(stmt, 5) == SQLITE_INTEGER
				{
					PK = SQLDataValue(INTEGER: nil, TEXT: nil, REAL: nil, Bool: sqlite3_column_int(stmt, Int32(5)) == 1 ? true : false)
				}
				var output = "row \(row):"
				var id = 0
				var nm = ""
				var ty: ColumnType!
				var nn: ColumnNull!
				var dv = ""
				var pk: ColumnKey!
				if cid?.INTEGER != nil
				{
					id = Int(cid!.INTEGER!)
//					output += "\(cid!.INTEGER!)"
					output += "\(id)"
				}
				output += "|"
				if name?.TEXT != nil
				{
					nm = name!.TEXT!
//					output += "\(name!.TEXT!)"
					output += "\(nm)"
				}
				output += "|"
				if type?.TEXT != nil
				{
					output += "\(type!.TEXT!)"
					switch (type!.TEXT!)
					{
					case "BLOB":
						ty = ColumnType.blob
						break
					case "INTEGER":
						ty = ColumnType.integer
						break
					case "NULL":
						ty = ColumnType.null
						break
					case "REAL":
						ty = ColumnType.real
						break
					case "TEXT":
						ty = ColumnType.text
						break
					default:
						ty = ColumnType.text
					}
				}
				output += "|"
				if notNull?.Bool != nil
				{
					output += "\(notNull!.Bool!)"
					if notNull!.Bool!
					{
						nn = ColumnNull.notNull
					}
					else
					{
						nn = ColumnNull.null
					}
				}
				output += "|"
				if dfltValue?.TEXT != nil
				{
					dv = dfltValue!.TEXT!
//					output += "\(dfltValue!.TEXT!)"
					output += "\(dv)"
				}
				output += "|"
				if PK?.Bool != nil
				{
					output += "\(PK!.Bool!)"
					if PK!.Bool!
					{
						pk = ColumnKey.pri
					}
				}
				results.append(MySQLite.Column(name: nm, notNull: nn, dataType: ty, key: pk, extra: nil, defaultValue: dv, isPrimaryKey: nil))
//				print(output)
				row += 1
			}
		}
		return results
	}
	
	/// Select rows (with specific columns-or nil for all) for a database(db) table(table), optionally where a condition is met, optionally limit the results(limit-starting from row, number of rows) and return results as an array of dictionaries(the row number(Int) and value as a string)
	func selectOrderedFrom(_ db: OpaquePointer, _ table: String, columns: [Column]?, where: [String : Any]?, limit: [Int]?) -> [[String]]?
	{
		var queryString = "SELECT "
		var list: [[String]] = []
		var stmt: OpaquePointer?
//		var mycolumns: [Column]? = nil
		
		if columns == nil
		{
			queryString += "* "
//			mycolumns = columnsIn(db, table)
		}
		queryString += "FROM \(table)"
		if sqlite3_prepare_v2(db, queryString, -1, &stmt, nil) != SQLITE_OK
		{
			let errmsg = String(cString: sqlite3_errmsg(db)!)
			list[0].append(errmsg)
			return list
		}
		while (sqlite3_step(stmt) == SQLITE_ROW)
		{
			var resultRow: [String] = []
			let to = (columns != nil) ? columns?.count : Int(sqlite3_column_count(stmt))//mycolumns?.count
			for i in 0 ..< to!
			{
				if sqlite3_column_type(stmt, Int32(i)) != SQLITE_NULL
				{
					resultRow.append(String(cString: sqlite3_column_text(stmt, Int32(i))))
				}
			}
			list.append(resultRow)
		}
		sqlite3_finalize(stmt)
		return list
	}
	
	/// Select rows (with specific columns-or nil for all) for a database(db) table(table), optionally where a condition is met, optionally limit the results(limit-starting from row, number of rows) and return results as an array of dictionaries(the column name(String) and value as a String)
	func selectAsArrayFrom(_ db: OpaquePointer, _ table: String, columns: [Column]?, where: [String : Any]?, limit: [Int]?) -> [[String : String]]?
	{
		var queryString = "SELECT "
		var list: [[String]] = []
		var stmt: OpaquePointer?
		//		var mycolumns: [Column]? = nil
		
		if columns == nil
		{
			queryString += "* "
			//			mycolumns = columnsIn(db, table)
		}
		queryString += "FROM \(table)"
		if sqlite3_prepare_v2(db, queryString, -1, &stmt, nil) != SQLITE_OK
		{
			let errmsg = String(cString: sqlite3_errmsg(db)!)
			list[0].append(errmsg)
			return nil//list
		}
		while (sqlite3_step(stmt) == SQLITE_ROW)
		{
			var resultRow: [String] = []
			let to = (columns != nil) ? columns?.count : Int(sqlite3_column_count(stmt))//mycolumns?.count
			for i in 0 ..< to!
			{
				if sqlite3_column_type(stmt, Int32(i)) != SQLITE_NULL
				{
					resultRow.append(String(cString: sqlite3_column_text(stmt, Int32(i))))
				}
			}
			list.append(resultRow)
		}
		sqlite3_finalize(stmt)
		return nil//list
	}

	/// Inserts rows, (optionally)columns and related values for a database(db) table(table), optionally where a condition is met and returns nil on success otherwise returns an error message(String) (can accept multiple values per columns ie. insert... columns: ["name"], values: ["a", "b", "c"] ...)
	func insertInto(_ db: OpaquePointer, _ table: String, columns: [String]?, values: [Any], debugPrint: Bool=false) -> String?
	{
		var stmt: OpaquePointer?
		var c = 0
		let totalCycles = (columns != nil) ? columns!.count : values.count

		if values.count < totalCycles
		{
			return "Error: too many columns for number of values"
		}
		var queryString = "INSERT INTO \(table) "
		if columns != nil
		{
			queryString += "("
			for col in columns!
			{
				queryString += col + ", "
				c += 1
			}
			queryString = String(queryString.dropLast().dropLast())
			queryString += ") "
		}
		queryString += "VALUES ("
		if columns != nil
		{
			for _ in 0 ..< c
			{
				queryString += "?, "
			}
		}
		else
		{
			for _ in 0 ..< values.count
			{
				queryString += "?, "
			}
		}
		queryString = String(queryString.dropLast().dropLast())
		queryString += ")"
		if debugPrint
		{
			print(queryString)
		}
		if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK
		{
			return (false) ? nil : "prepare statement \"\(queryString)\" - \(String(cString: sqlite3_errmsg(db)!))"
		}
		for cycle in 0 ..< values.count//(values.count - totalCycles + 1)
		{
			for k in cycle ..< cycle + c
			{
				if debugPrint
				{
					print("\(k):\(values[k]), ")
				}
				if sqlite3_bind_text(stmt, 1, values[k] as! String, -1, SQLITE_TRANSIENT) != SQLITE_OK
				{
					return (false) ? nil : "binding error on row \(cycle) - trying \(queryString) - \(String(cString: sqlite3_errmsg(db)!))"
				}
			}
			if sqlite3_step(stmt) != SQLITE_DONE
			{
				return (false) ? nil : "insert error on row \(cycle) - trying \(queryString) - \(String(cString: sqlite3_errmsg(db)!))"
			}
		}
		if sqlite3_finalize(stmt) != SQLITE_OK
		{
			return (false) ? nil : "finalize statement \"\(queryString)\" - \(String(cString: sqlite3_errmsg(db)!))"
		}
		return (false) ? nil : "error - \(String(cString: sqlite3_errmsg(db)!))"
	}
	
	/// Inserts rows DIRECTLY, (optionally)columns and related values for a database(db) table(table), optionally where a condition is met and returns nil on success otherwise returns an error message(String)
	func insertDirectInto(_ db: OpaquePointer, _ table: String, columns: [String], values: [Any]) -> String?
	{
		var queryString = "INSERT INTO \(table) ("
//		var stmt: OpaquePointer?
		var i = 0
		for col in columns
		{
			queryString += col
			if i < columns.count-1
			{
				queryString += ", "
			}
			i += 1
		}
		queryString += ") VALUES ("
		var j = 0
		for col in values
		{
			queryString += col as! String
			if j < columns.count-1
			{
				queryString += ", "
			}
			j += 1
		}
		queryString += ")"
		if sqlite3_exec(db, queryString, nil, nil, nil) != SQLITE_OK
		{
			return (false) ? nil : String(cString: sqlite3_errmsg(db)!)
		}
		return (false) ? nil : String(cString: sqlite3_errmsg(db)!)
	}

	/// Remove a table(table) AND ALL CONTAINING DATA from the database(db)
	func dropTable(_ db: OpaquePointer, _ table: String) -> String?
	{
		if sqlite3_exec(db, "DROP TABLE \(table)", nil, nil, nil) != SQLITE_OK
		{
			return (false) ? nil : String(cString: sqlite3_errmsg(db)!)
		}
		return nil
	}

	/// Preforms BEGIN TRANSACTION, then operations, then COMMIT
	func performTransaction(_ db: OpaquePointer, completion: (String) -> String?) -> String?
	{
		if sqlite3_exec(db, "BEGIN TRANSACTION", nil, nil, nil) != SQLITE_OK
		{
			return (false) ? nil : String(cString: sqlite3_errmsg(db)!)
		}
		else
		{
			_ = completion("abc")
		}
		if sqlite3_exec(db, "COMMIT", nil, nil, nil) != SQLITE_OK
		{
			return (false) ? nil : String(cString: sqlite3_errmsg(db)!)
		}
		return nil
	}

	/// Adds (a) primary key(s) to an existing table
	func addPrimary(_ db: OpaquePointer, _ table: String, primaryKey: [Column]) -> String?
	{
		if sqlite3_exec(db, "PRAGMA foreign_keys=off", nil, nil, nil) != SQLITE_OK
		{
			return (false) ? nil : String(cString: sqlite3_errmsg(db)!)
		}
		else
		{
//			if sqlite3_exec(db, "BEGIN TRANSACTION", nil, nil, nil) != SQLITE_OK
//			{
//				return (false) ? nil : String(cString: sqlite3_errmsg(db)!)
//			}
//			else
			let transResult = performTransaction(db) { (result) in
				if sqlite3_exec(db, "ALTER TABLE \(table) RENAME TO \(table)_copy", nil, nil, nil) != SQLITE_OK
				{
					return (false) ? nil : String(cString: sqlite3_errmsg(db)!)
				}
				else
				{
					var cols = columnsIn(db, table)
					var i = 0
					for col in cols!
					{
						for pri in primaryKey
						{
							if col.name == pri.name
							{
								cols![i].isPrimaryKey = true
								break
							}
						}
						i += 1
					}
					let createResult = createTable(db, name: table, notExists: false, columns: cols!, printOnly: false)	//create table with primaries
					if createResult != nil
					{
						return (false) ? nil : String(cString: sqlite3_errmsg(db)!)
					}
					if sqlite3_exec(db, "INSERT INTO \(table) SELECT * FROM \(table)_copy", nil, nil, nil) != SQLITE_OK
					{
						return (false) ? nil : String(cString: sqlite3_errmsg(db)!)
					}
					else
					{
						let dropResult = dropTable(db, "\(table)_copy")
						if dropResult != nil
						{
							return (false) ? nil : String(cString: sqlite3_errmsg(db)!)
						}
//						if sqlite3_exec(db, "COMMIT", nil, nil, nil) != SQLITE_OK
//						{
//							return (false) ? nil : String(cString: sqlite3_errmsg(db)!)
//						}
					}}
				return result//nil
			}
			if transResult != nil
			{
				return nil
			}
						else
						{
							if sqlite3_exec(db, "PRAGMA foreign_keys=on", nil, nil, nil) != SQLITE_OK
							{
								return (false) ? nil : String(cString: sqlite3_errmsg(db)!)
							}
//						}
//					}
//				}
			}
		}
		return nil
	}

}
