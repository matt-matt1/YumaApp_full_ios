//
//  String.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-06-18.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


extension String
{
	/// Returns an HTML string
	//https://stackoverflow.com/questions/37048759/swift-display-html-data-in-a-label-or-textview
	var htmlToAttributedString: NSAttributedString?
	{
		guard let data = data(using: .utf8) 	else 	{ 	return NSAttributedString() 	}
		do
		{
			return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
		}
		catch
		{
			return NSAttributedString()
		}
	}
	var htmlToString: String
	{
		return htmlToAttributedString?.string ?? ""
	}

	//https://medium.com/@valv0/a-swift-extension-for-string-and-html-8cfb7477a510
	var html2Attributed: NSAttributedString?
	{
		do
		{
			guard let data = data(using: String.Encoding.utf8) 	else 	{		return nil			}
			return try NSAttributedString(data: data,
										  options: [.documentType: NSAttributedString.DocumentType.html,
													.characterEncoding: String.Encoding.utf8.rawValue],
										  documentAttributes: nil)
		}
		catch
		{
			print("error: ", error)
			return nil
		}
	}
	var htmlAttributed: (NSAttributedString?, NSDictionary?)
	{
		do
		{
			guard let data = data(using: String.Encoding.utf8) 	else 	{		return (nil, nil)			}
			var dict:NSDictionary?
			dict = NSMutableDictionary()
			return try (NSAttributedString(data: data,
										   options: [.documentType: NSAttributedString.DocumentType.html,
													 .characterEncoding: String.Encoding.utf8.rawValue],
										   documentAttributes: &dict), dict)
		}
		catch
		{
			print("error: ", error)
			return (nil, nil)
		}
	}
	func htmlAttributed(using font: UIFont, color: UIColor) -> NSAttributedString?
	{
		do
		{
			let htmlCSSString = "<style>" +
				"html *" +
				"{" +
				"font-size: \(font.pointSize)pt !important;" +
				"color: #\(color.hexString!) !important;" +
				"font-family: \(font.familyName), Helvetica !important;" +
			"}</style> \(self)"
			guard let data = htmlCSSString.data(using: String.Encoding.utf8) 	else 	{		return nil		}
			return try NSAttributedString(data: data,
										  options: [.documentType: NSAttributedString.DocumentType.html,
													.characterEncoding: String.Encoding.utf8.rawValue],
										  documentAttributes: nil)
		}
		catch
		{
			print("error: ", error)
			return nil
		}
	}
	func htmlAttributed(family: String?, size: CGFloat, color: UIColor) -> NSAttributedString?
	{
		do
		{
			let htmlCSSString = "<style>" +
				"html *" +
				"{" +
				"font-size: \(size)pt !important;" +
				"color: #\(color.hexString!) !important;" +
				"font-family: \(family ?? "Helvetica"), Helvetica !important;" +
			"}</style> \(self)"
			guard let data = htmlCSSString.data(using: String.Encoding.utf8) 	else 	{		return nil		}
			return try NSAttributedString(data: data,
										  options: [.documentType: NSAttributedString.DocumentType.html,
													.characterEncoding: String.Encoding.utf8.rawValue],
										  documentAttributes: nil)
		}
		catch
		{
			print("error: ", error)
			return nil
		}
	}

	/// Reduce array to String
	func implode(_ array: [Int], separater: String=", ") -> String
	{
		var str = ""
		for val in array
		{
			str += "\(val),"
		}
		return String(str.dropLast())
	}
	//https://stackoverflow.com/questions/27880650/swift-extract-regex-matches
	/// eg. "prefix12".matchingStrings("(?:prefix)?([0-9]+)") //[["prefix12", "12"]]
	func matchingStrings(_ regex: String) -> [[String]]
	{
		guard let regex = try? NSRegularExpression(pattern: regex, options: []) else 	{ 	return [] 	}
		let nsString = self as NSString
		let results  = regex.matches(in: self, options: [], range: NSMakeRange(0, nsString.length))
		return results.map
			{
				result in
			(0..<result.numberOfRanges).map
				{
					result.range(at: $0).location != NSNotFound	? nsString.substring(with: result.range(at: $0))
				: ""
			}
		}
	}

	//https://stackoverflow.com/questions/39677330/how-does-string-substring-work-in-swift
	///eg. let s = "hello"; s[0]//h; s[1]//e; s[2]//l ...
	subscript(_ i: Int) -> String
	{
		let idx1 = index(startIndex, offsetBy: i)
		let idx2 = index(idx1, offsetBy: 1)
		return String(self[idx1..<idx2])
	}
//	/// Detect if ESC was pressed
//	var escapePressed: Bool
//	{
//		let char = self.cString(using: String.Encoding.utf8)!
//		return char.elementsEqual([0])
//	}
	//https://stackoverflow.com/questions/25761344/how-to-hash-nsstring-with-sha1-in-swift
//	func sha1() -> String
//	{
//		let data = self.data(using: String.Encoding.utf8)!
//		var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
//		data.withUnsafeBytes {
//			_ = CC_SHA1($0, CC_LONG(data.count), &digest)
//		}
//		let hexBytes = digest.map { String(format: "%02hhx", $0) }
//		return hexBytes.joined()
//	}
	var sha1: String
	{
		guard let data = data(using: .utf8, allowLossyConversion: false) 	else	 { 	fatalError("sha1 error")//
		}
		return data.digestSHA1.hexString
	}

	//https://gist.github.com/bhind/c96ee94b5f6ac2b870f4488619786141
	static private let SNAKECASE_PATTERN:String = "(\\w{0,1})_"
	static private let CAMELCASE_PATTERN:String = "[A-Z][a-z,\\d]*"
	func snake_caseToCamelCase() -> String
	{
		let buf:NSString = self.capitalized.replacingOccurrences(
			of: String.SNAKECASE_PATTERN,
			with: "$1",
			options: .regularExpression,
			range: nil) as NSString
		return buf.replacingCharacters(in: NSMakeRange(0,1), with: buf.substring(to: 1).lowercased()) as String
	}
	func camelCaseTosnake_case() throws -> String
	{
		guard let pattern: NSRegularExpression = try? NSRegularExpression(
			pattern: String.CAMELCASE_PATTERN, options: []) else 	{ 	throw NSError(domain: "NSRegularExpression fatal error occured.", code:-1, userInfo: nil)
		}
		let input:NSString = (self as NSString).replacingCharacters(in: NSMakeRange(0,1), with: (self as NSString).substring(to: 1).capitalized) as NSString
		var array = [String]()
		let matches = pattern.matches(in: input as String, options:[], range: NSRange(location:0, length: input.length))
		for match in matches
		{
			for index in 0..<match.numberOfRanges
			{
				array.append(input.substring(with: match.range(at: index)).lowercased())
			}
		}
		return array.joined(separator: "_")
	}
	//	/// Returns a string coded with MD5 technology
	//	func md5(_ string: String) -> String
	//	{
	//		let context = UnsafeMutablePointer<CC_MD5_CTX>.allocate(capacity: 1)
	//		var digest = Array<UInt8>(repeating:0, count:Int(CC_MD5_DIGEST_LENGTH))
	//		CC_MD5_Init(context)
	//		CC_MD5_Update(context, string, CC_LONG(string.lengthOfBytes(using: String.Encoding.utf8)))
	//		CC_MD5_Final(&digest, context)
	//		context.deallocate()
	//		var hexString = ""
	//		for byte in digest
	//		{
	//			hexString += String(format:"%02x", byte)
	//		}
	//		return hexString
	//	}
	
	//https://stackoverflow.com/questions/29365145/how-can-i-encode-a-string-to-base64-in-swift
	// let testString = "A test string."
	//let encoded = testString.toBase64() // "QSB0ZXN0IHN0cmluZy4="
	//guard let decoded = encoded.fromBase64() // "A test string."
	//else { return }
	/// Returns a String decoded from base64 - eg. guard let decoded = encoded.fromBase64() else { return }
	func fromBase64() -> String?
	{
		guard let data = Data(base64Encoded: self, options: Data.Base64DecodingOptions(rawValue: 0)) else
		{
			return nil
		}
		return String(data: data, encoding: .utf8)
	}
	/// Returns an optional String encoded with base64 - eg. let encoded = testString.toBase64()
	func toBase64() -> String?
	{
		guard let data = self.data(using: String.Encoding.utf8) else
		{
			return nil
		}
		return data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
		//return Data(self.utf8).base64EncodedString()
	}
	
	//	//https://stackoverflow.com/questions/32163848/how-to-convert-string-to-md5-hash-using-ios-swift
	//	var MD5:String {
	//		get{
	//			let messageData = self.data(using:.utf8)!
	//			var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
	//
	//			_ = digestData.withUnsafeMutableBytes {digestBytes in
	//				messageData.withUnsafeBytes {messageBytes in
	//					CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
	//				}
	//			}
	//
	//			return digestData.map { String(format: "%02hhx", $0) }.joined()
	//		}
	//	}
	/// Returns a String of random characters 'length' long, can include symbols
	func generatePassword(_ length: Int = 8, _ incSymbols: Bool = true) -> String
	{
		var pswdChars: Array<Character>
		if incSymbols
		{
			//			let chars = CharacterSet.alphanumerics.intersection(.punctuationCharacters).intersection(.symbols)
			pswdChars = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-!@#$%\\^&*()_")
		}
		else
		{
			//			let chars = CharacterSet.lowercaseLetters.intersection(.uppercaseLetters).intersection(.decimalDigits)
			pswdChars = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890")
		}
		let rndPswd = String((0..<length).map{ _ in pswdChars[Int(arc4random_uniform(UInt32(pswdChars.count)))]})
		return rndPswd
	}
	
	/// Ramdom alphanumberic string
	var randomLetters: String
	{
		get
		{
			let letters: NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
			let len = 20 // length
			let randomString: NSMutableString = NSMutableString(capacity: len)
			
			for _ in 0 ..< len
			{
				let length = UInt32 (letters.length)
				let rand = arc4random_uniform(length)
				randomString.appendFormat("%C", letters.character(at: Int(rand)))
			}
			return randomString as String
		}
	}
	/// Ramdom alphanumberic string
	var randomLettersAndSymbols: String
	{
		get
		{
			let letters: NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()~;,./<>?:-_[]{}=+\\|"
			let len = 20 // length
			let randomString: NSMutableString = NSMutableString(capacity: len)
			
			for _ in 0 ..< len
			{
				let length = UInt32 (letters.length)
				let rand = arc4random_uniform(length)
				randomString.appendFormat("%C", letters.character(at: Int(rand)))
			}
			return randomString as String
		}
	}
	/// Returns the index (Int) of character in a String
	func indexOf(_ character: Character) -> Int
	{
		return (index(of: character)?.encodedOffset)!
	}
	/// Returns the index (Int) of character in a String, reverse order
	func lastIndexOf(_ character: String) -> Int?
	{
		guard let index = range(of: character, options: .backwards) else { 	return nil 	}
		return self.distance(from: self.startIndex, to: index.lowerBound)
	}
	/// Returns the sub-String located between the given characters within a String
	func substringBetween(_ fromCharacter: Character, _ toChartacter: String, exclusive: Bool = false) -> String
	{
		var pos1 = self.indexOf("[")
		var pos2 = self.lastIndexOf("]")!+1
		if exclusive
		{
			pos1 += 1
			pos2 -= 1
		}
		let start = self.index(self.startIndex, offsetBy: pos1)
		let end = self.index(self.startIndex, offsetBy: pos2)
		return String(self[start..<end])
	}
	
	///findArrayPositionOf(findValue: AnyObject, inArray: [AnyObject], searchElements: AnyObject) -> Int
	func findArrayPositionOf(findValue: AnyObject, inArray: [AnyObject], searchElements: AnyObject) -> Int
	{
		var i: Int = 0;
		var found: Int = -1
		for obj in inArray
		{
			//			let pair = obj as! Dictionary
			//			for element in pair
			//			{
			//				if pair.key == findValue
			//			}
			if obj.elementType == searchElements.elementType //&& obj.element(searchElements) == findValue
			{
				found = i//return i
			}
			i+=1
		}
		return found
	}
	
	/// Converts a String to a double value
	func toDouble() -> Double?
	{
		return NumberFormatter().number(from: self)?.doubleValue
	}
}
