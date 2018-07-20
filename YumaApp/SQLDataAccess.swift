//
//  SQLDataAccess.swift
//  SQLiteDemo
//
//  Created by Pat Murphy on 10/14/17.
//  Copyright © 2017 Pat Murphy. All rights reserved.
//

import Foundation

private let SQLITE_DATE = SQLITE_NULL + 1
private let SQLITE_STATIC = unsafeBitCast(0, to:sqlite3_destructor_type.self)
private let SQLITE_TRANSIENT = unsafeBitCast(-1, to:sqlite3_destructor_type.self)

@objc(SQLDataAccess)
class SQLDataAccess: NSObject
{
	static let shared = SQLDataAccess()
	var DB_FILE = "my_db.sqlite"//SQLite.db"
	private var path:String!
	private let DB_Queue = "SQLiteQueue"
	private var queue:DispatchQueue!
	private var sqlite3dbConn:OpaquePointer? = nil
	private let db_format = DateFormatter()
	
	public override init()
	{
		super.init()
		queue = DispatchQueue(label:DB_Queue, attributes:[])
		//for 24-hour format need locale to work, ISO-8601 format
		db_format.locale = Locale(identifier:"en_US_POSIX")
		db_format.timeZone = TimeZone(secondsFromGMT:0)
		db_format.dateFormat = "yyyy-MM-dd HH:mm:ss"
	}
	
	deinit
	{
		closeConnection()
	}
	
	public func setDBName(name:String)
	{
		DB_FILE = name
	}
	
	public func closeConnection()
	{
		var rc = sqlite3_close(sqlite3dbConn)
		if(rc == SQLITE_BUSY)
		{
			let ps:OpaquePointer? = nil
			var stmt = sqlite3_next_stmt(sqlite3dbConn, ps)
			while (stmt != nil)
			{
				stmt = sqlite3_next_stmt(sqlite3dbConn, stmt)
			}
			sqlite3_finalize(stmt);
			rc = sqlite3_close(sqlite3dbConn);
		}
		sqlite3dbConn = nil;
	}
	
	override var description:String
	{
		return "DA : DB path \(path)"
	}
	
	public func dbDateStr(date:Date) -> String
	{
		return db_format.string(from:date)
	}
	
	public func dbStrDate(date:String) -> Date
	{
		return db_format.date(from:date)!
	}
	
	public func openConnection(copyFile:Bool = true) -> Bool
	{
		if sqlite3dbConn != nil
		{
			NDBLog("DA : DB : OPENED")
			return true
		}
		else
		{
			NDBLog("DA : DB : OPENING")
		}
		let fm = FileManager.default
		let docDir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
		let path = (docDir as NSString).appendingPathComponent(DB_FILE)
		// Check if DB is there in Documents directory
		if !(fm.fileExists(atPath:path)) && copyFile {
			// The database does not exist, so copy it
			guard let rp = Bundle.main.resourcePath else 	{ 	return false 	}
			let from = (rp as NSString).appendingPathComponent(DB_FILE)
			do
			{
				try fm.copyItem(atPath:from, toPath:path)
			}
			catch let error
			{
				assert(false, "DA : Failed to copy writable version of \(DB_FILE)! Error - \(error.localizedDescription)")
				return false
			}
		}
		// Open the DB
		let cpath = path.cString(using:String.Encoding.utf8)
		let error = sqlite3_open(cpath!, &sqlite3dbConn)
		if error != SQLITE_OK {
			// Open failed, close DB and fail
			NELog("DA - failed to open \(DB_FILE)!")
			sqlite3_close(sqlite3dbConn)
			return false
		}
		else
		{
			NDBLog("DA : \(DB_FILE) opened")
		}
		
		return true
	}
	
	private func stmt(_ ps: OpaquePointer!, forQuery query: String, withParams parameters: Array<Any>!) -> OpaquePointer!
	{
		if sqlite3dbConn == nil
		{
			return nil
		}
		
		var ps:OpaquePointer? = ps
		
		let cSql = query.cString(using: String.Encoding.utf8)
		
		let code = sqlite3_prepare_v2(sqlite3dbConn, cSql!, CInt(query.lengthOfBytes(using: String.Encoding.utf8)), &ps, nil)
		
		if(code == SQLITE_OK)
		{
			var flag:CInt = 0
			for i in 0 ..< parameters.count
			{
				if let val = parameters![i] as? Double
				{
					flag = sqlite3_bind_double(ps, CInt(i+1), CDouble(val))
				}
				else if let val = parameters![i] as? Float
				{
					flag = sqlite3_bind_double(ps, CInt(i+1), Double(CFloat(val)))
				}
				else if let val = parameters![i] as? Int64
				{
					flag = sqlite3_bind_int64(ps, CInt(i+1), CLongLong(val))
				}
				else if let val = parameters![i] as? Int
				{
					flag = sqlite3_bind_int(ps, CInt(i+1), CInt(val))
				}
				else if let val = parameters![i] as? Bool
				{
					let num = val ? 1 : 0
					flag = sqlite3_bind_int(ps, CInt(i+1), CInt(num))
				}
				else if let txt = parameters![i] as? String
				{
					flag = sqlite3_bind_text(ps, CInt(i+1), txt, -1, SQLITE_TRANSIENT)
				}
				else if let date = parameters![i] as? Date
				{
					let dateStr = self.dbDateStr(date: date)
					flag = sqlite3_bind_text(ps, CInt(i+1), dateStr, -1, SQLITE_TRANSIENT)
				}
				else if let dataValue = parameters![i] as? NSData
				{
					flag = sqlite3_bind_blob(ps, CInt(i+1), dataValue.bytes, CInt(dataValue.length), SQLITE_TRANSIENT)
				}
				else if parameters![i] is NSNull
				{
					flag = sqlite3_bind_null(ps,CInt(i+1));
				}
				else
				{
					NELog("DA : SQL Error Stmt No match found for Data Type")
				}
				
				if flag != SQLITE_OK
				{
					let errMsg = String(validatingUTF8:sqlite3_errmsg(sqlite3dbConn))
					let errCode = Int(sqlite3_errcode(sqlite3dbConn))
					NELog("DA : SQL Error bind Stmt : Err[\(errCode)] = \(String(describing: errMsg!)) : Q = \(query)\n");
				}
			}
		}
		else
		{
			let errMsg = String(validatingUTF8:sqlite3_errmsg(sqlite3dbConn))
			let errCode = Int(sqlite3_errcode(sqlite3dbConn))
			NELog("DA : SQL Error prepared Stmt : Err[\(errCode)] = \(String(describing: errMsg!)) : Q = \(query)\n");
		}
		
		return ps
	}
	
	@discardableResult public func executeStatement(_ query: String!, _ args:Any...) -> Bool
	{
		var status : Bool = false
		if sqlite3dbConn == nil
		{
			return false
		}
		
		status = self.executeStatement(query, withParams: args)
		return status
	}
	
	@discardableResult public func executeStatement(_ query: String, withParams parameters: Array<Any>!) -> Bool {
		
		var status : Bool = false
		
		if(sqlite3dbConn == nil)
		{
			return status
		}
		
		queue.sync {
			//Synchronize all accesses
			let ps:OpaquePointer? = nil
			
			if let ps = self.stmt(ps, forQuery:query, withParams:parameters)
			{
				let code = sqlite3_step(ps)
				if(code == SQLITE_DONE)
				{
					status = true
				}
				else
				{
					status = false
				}
				
				if !status
				{
					let errMsg = String(validatingUTF8:sqlite3_errmsg(sqlite3dbConn))
					let errCode = Int(sqlite3_errcode(sqlite3dbConn))
					NELog("DA : SQL Error during execute : Err[\(errCode)] = \(String(describing: errMsg!)) : Q = \(query)\n");
				}
			}
			sqlite3_finalize(ps)
			sqlite3_exec(sqlite3dbConn, "COMMIT TRANSACTION", nil, nil, nil)
		}
		
		return status
	}
	
	public func getRecordsForQuery(_ query: String!, _ args:Any...) -> Array<Any>
	{
		var results = [Any]()
		if sqlite3dbConn == nil
		{
			return results
		}
		
		results = self.getRecordsForQuery(query, withParams: args)
		return results
	}
	
	private func getColumnType(_ ps:OpaquePointer,_ index:CInt)->CInt
	{
		var type:CInt = 0
		// Column types - http://www.sqlite.org/datatype3.html (section 2.2 table column 1)
		let blobTypes = ["BINARY", "BLOB", "VARBINARY"]
		let charTypes = ["CHAR", "CHARACTER", "CLOB", "NATIONAL VARYING CHARACTER", "NATIVE CHARACTER", "NCHAR", "NVARCHAR", "TEXT", "VARCHAR", "VARIANT", "VARYING CHARACTER"]
		let dateTypes = ["DATE", "DATETIME", "TIME", "TIMESTAMP"]
		let intTypes  = ["BIGINT", "BIT", "BOOL", "BOOLEAN", "INT", "INT2", "INT8", "INTEGER", "MEDIUMINT", "SMALLINT", "TINYINT"]
		let nullTypes = ["NULL"]
		let realTypes = ["DECIMAL", "DOUBLE", "DOUBLE PRECISION", "FLOAT", "NUMERIC", "REAL"]
		// Determine type of column - http://www.sqlite.org/c3ref/c_blob.html
		let buf = sqlite3_column_decltype(ps, index)
		if buf != nil
		{
			var tmp = String(validatingUTF8:buf!)!.uppercased()
			if let pos = tmp.range(of:"(")
			{
				//                tmp = tmp.substring(to:pos.lowerBound)
				tmp = String(tmp[..<pos.lowerBound])
			}
			if intTypes.contains(tmp)
			{
				return SQLITE_INTEGER
			}
			if realTypes.contains(tmp)
			{
				return SQLITE_FLOAT
			}
			if charTypes.contains(tmp)
			{
				return SQLITE_TEXT
			}
			if blobTypes.contains(tmp)
			{
				return SQLITE_BLOB
			}
			if nullTypes.contains(tmp)
			{
				return SQLITE_NULL
			}
			if dateTypes.contains(tmp)
			{
				return SQLITE_DATE
			}
			//If none of the above has to be text
			return SQLITE_TEXT
		}
		else
		{
			// For expressions and sub-queries
			type = sqlite3_column_type(ps, index)
		}
		return type
	}
	
	public func getRecordsForQuery(_ query: String!, withParams parameters: Array<Any>!) -> Array<[String:Any]> {
		//Returns an Array of Dictionaries
		var results = [[String:Any]]()
		
		if(sqlite3dbConn == nil)
		{
			return results
		}
		
		queue.sync {
			//Synchronize all accesses
			let ps:OpaquePointer? = nil
			if let ps = self.stmt(ps, forQuery:query, withParams:parameters)
			{
				let columnCount = sqlite3_column_count(ps)
				var result = Dictionary<String,AnyObject>()
				while sqlite3_step(ps) == SQLITE_ROW
				{
					for i in 0..<columnCount
					{
						let columnType = self.getColumnType(ps,i)
						let name = sqlite3_column_name(ps,i)
						switch columnType
						{
						case SQLITE_INTEGER:
							result[String(validatingUTF8: name!)!] = Int64(sqlite3_column_int64(ps,i)) as AnyObject?
						case SQLITE_FLOAT:
							result[String(validatingUTF8: name!)!] = Double(sqlite3_column_double(ps,i)) as AnyObject?
						case SQLITE_TEXT:
							if let ptr = UnsafeRawPointer.init(sqlite3_column_text(ps,i))
							{
								let uptr = ptr.bindMemory(to:CChar.self, capacity:0)
								result[String(validatingUTF8: name!)!] = String(validatingUTF8:uptr) as AnyObject?
							}
						case SQLITE_BLOB:
							result[String(validatingUTF8: name!)!] = NSData(bytes:sqlite3_column_blob(ps,i), length:Int(sqlite3_column_bytes(ps,i))) as AnyObject?
						case SQLITE_NULL:
							result[String(validatingUTF8: name!)!] = String(validatingUTF8:"") as AnyObject?
						case SQLITE_DATE:
							//Our defined DATE
							if let ptr = UnsafeRawPointer.init(sqlite3_column_text(ps,i))
							{
								let uptr = ptr.bindMemory(to:CChar.self, capacity:0)
								let dateStr = String(validatingUTF8:uptr)
								let set = CharacterSet(charactersIn:"-:")
								if dateStr?.rangeOfCharacter(from:set) != nil
								{
									// Convert to time
									var time:tm = tm(tm_sec: 0, tm_min: 0, tm_hour: 0, tm_mday: 0, tm_mon: 0, tm_year: 0, tm_wday: 0, tm_yday: 0, tm_isdst: 0, tm_gmtoff: 0, tm_zone:nil)
									strptime(dateStr, "%Y-%m-%d %H:%M:%S", &time)
									time.tm_isdst = -1
									let diff = TimeZone.current.secondsFromGMT()
									let t = mktime(&time) + diff
									let ti = TimeInterval(t)
									let date = Date(timeIntervalSince1970:ti)
									result[String(validatingUTF8: name!)!] = date as AnyObject?
								}
							}
						default:
							NELog("DA : SQL Error getRecords Invalid column type")
						}
					}
					results.append(result)
				}
			}
			else
			{
				let errMsg = String(validatingUTF8:sqlite3_errmsg(sqlite3dbConn))
				let errCode = Int(sqlite3_errcode(sqlite3dbConn))
				NELog("DA : SQL Error getRecords : Err[\(errCode)] = \(String(describing: errMsg!)) : Q = \(query)\n");
			}
			sqlite3_finalize(ps)
		}
		return results
	}
	
	@discardableResult public func executeTransaction(_ sqlAndParamsForTransaction: Array<[String:Any]>!) -> Bool
	{
		var status : Bool = true
		
		if sqlite3dbConn == nil
		{
			return status
		}
		
		queue.sync {
			//Synchronize all accesses
			for i in 0..<sqlAndParamsForTransaction.count
			{
				
				let ps:OpaquePointer? = nil
				sqlite3_exec(sqlite3dbConn, "BEGIN EXCLUSIVE TRANSACTION", nil, nil, nil)
				let query = sqlAndParamsForTransaction[i][SQL] as! String
				let parameters = sqlAndParamsForTransaction[i][PARAMS] as! Array<Any>
				
				if let ps = self.stmt(ps, forQuery:query, withParams:parameters)
				{
					let code = sqlite3_step(ps)
					if code == SQLITE_DONE
					{
						status = true
					}
					else
					{
						status = false
					}
					
					if !status
					{
						let errMsg = String(validatingUTF8:sqlite3_errmsg(sqlite3dbConn))
						let errCode = Int(sqlite3_errcode(sqlite3dbConn))
						NELog("DA : SQL Error during executeTransaction : Err[\(errCode)] = \(String(describing: errMsg!)) : Q = \(query)\n");
						sqlite3_exec(sqlite3dbConn, "ROLLBACK", nil, nil, nil)
					}
				}
				sqlite3_finalize(ps)
				sqlite3_exec(sqlite3dbConn, "COMMIT TRANSACTION", nil, nil, nil)
			}
		}
		
		return status
	}
	
}
