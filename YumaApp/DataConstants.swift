//
//  DataConstants.swift
//  SQLiteDemo
//
//  Created by Pat Murphy on 10/15/17.
//  Copyright © 2017 Pat Murphy. All rights reserved.
//

import UIKit

//Constants
let SQL = "SQL"
let PARAMS = "PARAMS"

func NELog(_ message:String)
{
    #if DEBUGERROR
        NSLog("\(message)")
    #endif
}

func NDBLog(_ message:String)
{
    #if DEBUGDB
        NSLog("\(message)")
    #endif
}
