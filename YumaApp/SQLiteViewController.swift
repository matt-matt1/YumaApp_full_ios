//
//  ViewController.swift
//  SQLiteDemo
//
//  Created by Pat Murphy on 10/14/17.
//  Copyright © 2017 Pat Murphy. All rights reserved.
//

import UIKit
//import SQLDataAccess

class SQLiteViewController: UIViewController
{
	override func viewDidLoad()
	{
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		let db = SQLDataAccess.shared
		db.setDBName(name: "my_db.sqlite")//"SQLite.db")
		
		let opened = db.openConnection(copyFile:true)
		if(opened)
		{
			NSLog("Found SQLite DB")
			/*
			let sql : String = "insert into AppInfo (name,value,descrip) values(?,?,?)"
			let params : Array = ["SQLiteDemo","1.0.0","unencrypted"]
			let status = executeStatement(sql, withParams: params)
			*/
			let dict = ["Password":"123456"]
			let blob : NSData = NSKeyedArchiver.archivedData(withRootObject:dict) as NSData
			
			let status = db.executeStatement("insert into AppInfo (name,value,descrip,date,blob) values(?,?,?,?,?)", "SQLiteDemo","1.0.2","unencrypted",Date(),blob)
			
			if(status)
			{
				NSLog("Insert Ok")
				/*
				let sql : String = "select * from AppInfo"
				let param : [String] = []
				let results = db.getRecordsForQuery(sql, withParams: param)
				let results = db.getRecordsForQuery("select * from AppInfo where ID = ? or ID = ?",20,21)
				*/
				let results = db.getRecordsForQuery("select * from AppInfo ")
				NSLog("Results = \(results)")
				
				for dic in results as! [[String:AnyObject]]
				{
					let value = dic["blob"] as? Data
					if (value?.count)! > 0
					{
						let dictionary:NSDictionary? = NSKeyedUnarchiver.unarchiveObject(with: value! )! as? NSDictionary
						NSLog("dictionary[\(value!)] = \(dictionary!)")
					}
				}
			}
			
			//Test Transactions
			var sqlAndParams = [[String:Any]]() //Array of SQL and Params Transactions
			let dict1 = ["Password":"123456"]
			let blob1 : NSData = NSKeyedArchiver.archivedData(withRootObject:dict1) as NSData
			let params1 : Array = ["SQLiteDemo","1.0.0","unencrypted",Date(),blob1] as [Any]
			let sql1 : String = "insert into AppInfo (name,value,descrip,date,blob) values(?,?,?,?,?)"
			let sqlParams1 = [SQL:sql1,PARAMS:params1] as [String : Any]
			sqlAndParams.append(sqlParams1)
			
			let dict2 = ["Password":"789045"]
			let blob2 : NSData = NSKeyedArchiver.archivedData(withRootObject:dict2) as NSData
			let params2 : Array = ["SQLiteDemo","1.0.0","unencrypted",Date(),blob2] as [Any]
			let sql2 : String = "insert into AppInfo (name,value,descrip,date,blob) values(?,?,?,?,?)"
			let sqlParams2 = [SQL:sql2,PARAMS:params2] as [String : Any]
			sqlAndParams.append(sqlParams2)
			
			let dict3 = ["Password":"456782"]
			let blob3 : NSData = NSKeyedArchiver.archivedData(withRootObject:dict3) as NSData
			let params3 : Array = ["SQLiteDemo","1.0.0","unencrypted",Date(),blob3] as [Any]
			let sql3 : String = "insert into AppInfo (name,value,descrip,date,blob) values(?,?,?,?,?)"
			let sqlParams3 = [SQL:sql3,PARAMS:params3] as [String : Any]
			sqlAndParams.append(sqlParams3)
			
			let dict4 = ["Password":"876543"]
			let blob4 : NSData = NSKeyedArchiver.archivedData(withRootObject:dict4) as NSData
			let params4 : Array = ["SQLiteDemo","1.0.0","unencrypted",Date(),blob4] as [Any]
			let sql4 : String = "insert into AppInfo (name,value,descrip,date,blob) values(?,?,?,?,?)"
			let sqlParams4 = [SQL:sql4,PARAMS:params4] as [String : Any]
			sqlAndParams.append(sqlParams4)
			
			let status1 = db.executeTransaction(sqlAndParams)
			if(status1)
			{
				let results2 = db.getRecordsForQuery("select * from AppInfo ")
				for dic in results2 as! [[String:AnyObject]]
				{
					let value = dic["blob"] as? Data
					if (value?.count)! > 0
					{
						let dictionary:NSDictionary? = NSKeyedUnarchiver.unarchiveObject(with: value! )! as? NSDictionary
						NSLog("dictionary[\(value!)] = \(dictionary!)")
					}
				}
			}
		}
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
}

