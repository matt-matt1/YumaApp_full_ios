//
//  KeyedDecodingContainer.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-06-18.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


public extension KeyedDecodingContainer
{
	//http://kean.github.io/post/codable-tips-and-tricks
	//	public func decodeSafely<T: Decodable>(_ key: KeyedDecodingContainer.Key) -> T? {
	//		return self.decodeSafely(T.self, forKey: key)
	//	}
	//
	//	public func decodeSafely<T: Decodable>(_ type: T.Type, forKey key: KeyedDecodingContainer.Key) -> T? {
	//		let decoded = try? decode(FailableDecodable<T>.self, forKey: key)
	//		return decoded?.value
	//	}
	//
	//	public func decodeSafelyIfPresent<T: Decodable>(_ key: KeyedDecodingContainer.Key) -> T? {
	//		return self.decodeSafelyIfPresent(T.self, forKey: key)
	//	}
	//
	//	public func decodeSafelyIfPresent<T: Decodable>(_ type: T.Type, forKey key: KeyedDecodingContainer.Key) -> T? {
	//		let decoded = try? decodeIfPresent(FailableDecodable<T>.self, forKey: key)
	//		return decoded??.value
	//	}
	//	public func decodeSafelyArray<T: Decodable>(of type: T.Type, forKey key: KeyedDecodingContainer.Key) -> [T] {
	//		let array = decodeSafely([FailableDecodable<T>].self, forKey: key)
	//		return array?.flatMap { $0.raw } ?? []
	//	}
	/// Returns an Int
	public func decode(_ type: Int.Type, forKey key: Key) throws -> Int
	{
		let stringValue = try self.decode(String.self, forKey: key)
		guard let floatValue = Int(stringValue) else
		{
			let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Could not parse JSON key \"\(key)\" (value=\(stringValue) to a Int")
			throw DecodingError.dataCorrupted(context)
		}
		return floatValue
	}
}
