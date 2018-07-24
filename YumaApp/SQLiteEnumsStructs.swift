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
		case notNull 	= "NOT NULL"
		case null 		= "NULL"
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
	enum ColumnExtra: String
	{
		case autoInc = "AUTOINCREMENT"
	}
	
	struct SQLColumn
	{
		let name: String
		var notNull: ColumnNull? = .notNull
		let dataType: ColumnType?
		var key: ColumnKey? = nil
		var extra: ColumnExtra? = nil
//		var isNotNull: Bool? = false
		var defaultValue: String? = nil
		var isPrimaryKey: Bool? = false
	}


	enum SQLComparison: String
	{
		case equals = "="
		case greaterThan = ">"
		case lessThan = "<"
		case like = "%"
		case inside = "IN"
		case notIn = "NOT IN"
		case between = "BETWEEN"
	}
	
	struct SQLWhereHaving
	{
		/// Optionally, function performed on column
		let function: SQLFunc?
		/// String of the column name
		let columnName: String
		/// usually .equals
		let comparison: SQLComparison
		/// Array of a single (or muliple) value(s)
		let values: [Any]
		/// Only if comparisom is .between, inserts (BETWEEN ...) AND xyz
		let betweenAnd: Any?
		/// Optionally, nickname
		let alias: String?
		/// Optionally, whether values are ascending or descending
		let direction: SQLDirection?
	}


	struct SQLDataValue
	{
//		var NULL: String?
		var INTEGER: Int32?
		var TEXT: String?
		var REAL: Double?
		var Bool: Bool?
	}

	enum SQLDirection: String
	{
		case asc = "ASC"
		case desc = "DESC"
	}
//	enum SQLColumn_<T1, T2>
//	{
//		case columnName(T1)
//		case columnPosition(T2)
//	}
	enum SQLColumn_
	{
		case name(String)
		case position(Int)
		var name: String
		{
			switch (self)
			{
			case .name(let str):		return str
			case .position(let pos):	return String(pos)
			}
		}
		var position: Int
		{
			switch (self)
			{
			case .name(let str):		return Int(str) ?? 0
			case .position(let pos):	return pos
			}
		}
	}
	struct SQLColumnOrder
	{
		let column_: SQLColumn_
		let direction: SQLDirection?
	}

	enum SQLFunc: String
	{
		case minimum = "MIN"
		case maximum = "MAX"
		case sumTotal = "SUM"
		case count = "COUNT"
		case average = "AVG"
	}
	struct SQLGroupBy
	{
		let column_: SQLColumn_
		let applyFunc: SQLFunc?
		let direction: SQLDirection?
		let alias: String?
	}

//	struct SQLHaving
//	{
//		let columnName: String
//		let applyFunc: SQLFunc?
//		let direction: SQLDirection?
//		let comparison: SQLComparison
//		let alias: String?
//		let secondary: String?
//	}

	enum SQLJoin: String
	{
		case inner = "INNER JOIN"
		case left
		case right
		case natural = "JOIN"
		case outer
	}
//	enum SQLJoinSecondary
//	{
//		case columnName(String)
//		case value(String)
//	}
	struct SQLJoinOn
	{
		let primaryColumn: String
		let primaryAlias: String?
		let linkedBy: SQLComparison
		let secondary: String//SQLJoinSecondary
		let secondaryAlias: String?
	}
	struct SQLJoinLine
	{
		let joinType: SQLJoin
		let tableName: String
		let ons: [SQLJoinOn]?
	}

	enum SQLAction
	{
		case printOnly
		case printAswell
		case defaultNoPrint
	}
}
