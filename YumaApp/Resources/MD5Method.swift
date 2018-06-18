//
//  MD5Method.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-06-18.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


/// Returns a string coded with MD5 technology
func md5(_ string: String) -> String
{
	let context = UnsafeMutablePointer<CC_MD5_CTX>.allocate(capacity: 1)
	var digest = Array<UInt8>(repeating:0, count:Int(CC_MD5_DIGEST_LENGTH))
	CC_MD5_Init(context)
	CC_MD5_Update(context, string, CC_LONG(string.lengthOfBytes(using: String.Encoding.utf8)))
	CC_MD5_Final(&digest, context)
	context.deallocate()
	var hexString = ""
	for byte in digest
	{
		hexString += String(format:"%02x", byte)
	}
	return hexString
}
