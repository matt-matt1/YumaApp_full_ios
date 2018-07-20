//
//  SQLiteEnumsStructs.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-07-17.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


extension MySQLite
{
	enum SQLiteError: Error
	{
		case generalFailure
		case message(error: String)
	}

	enum ColumnNull: String
	{
		case null 		= "NULL"
		case notNull 	= "NOT NULL"
	}
	enum ColumnType: String
	{
		case integer 	= "INTEGER"
		case text 		= "TEXT"
		case real 		= "REAL"
		case blob 		= "BLOB"
		case null 		= "NULL"
	}
	enum ColumnKey: String
	{
		case pri = "PRIMARY KEY"
	}
	enum ColumnCount: String
	{
		case autoInc = "AUTOINCREMENT"
	}
	
	struct Column
	{
		let name: String
		var null: ColumnNull? = .notNull
		let dataType: ColumnType?
		var key: ColumnKey? = nil
		var operation: ColumnCount? = nil
		var isNotNull: Bool? = false
		var defaultValue: String? = nil
		var isPrimaryKey: Bool? = false
	}


	enum WhereComparison: String
	{
		case equals = "="
		case greaterThan = ">"
		case lessThan = "<"
		case like = "%"
	}
	
	struct Where
	{
		let columnName: String
		let comparison: WhereComparison
		let value: Any
	}


	struct SQLDataValue
	{
		var INTEGER: Int32?
		var TEXT: String?
		var REAL: Double?
		var Bool: Bool?
	}

}
