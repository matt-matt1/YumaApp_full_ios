//
//  Data.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-07-02.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


extension Data
{
	var digestSHA1: Data
	{
		var bytes: [UInt8] = Array(repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
		
		withUnsafeBytes {
			_ = CC_SHA1($0, CC_LONG(count), &bytes)
		}
		
		return Data(bytes: bytes)
	}
	
	var hexString: String {
		return map 	{ 	String(format: "%02x", UInt8($0))	 }.joined()
	}
	
}
