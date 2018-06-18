//
//  Contents.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-19.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//
///https://github.com/ShengHuaWu/WebserviceInSwift/blob/master/Webservice.playground/Contents.swift

import Foundation

//enum SerializationError: Error
//{
//	case missing(String)
//}

//struct Acronym
//{
//	let id: Int
//	let short: String
//	let long: String
//}
//
//typealias JSONDictionary = [String : Any]
//
//extension Acronym
//{
//	init(json: JSONDictionary) throws
//	{
//		guard let id = json["id"] as? Int else
//		{
//			throw SerializationError.missing("id")
//		}
//
//		guard let short = json["short"] as? String else
//		{
//			throw SerializationError.missing("short")
//		}
//
//		guard let long = json["long"] as? String else
//		{
//			throw SerializationError.missing("long")
//		}
//
//		self.id = id
//		self.short = short
//		self.long = long
//	}
//}

//struct ResourceM<Model>
//{
//	let url: URL
//	let parse: (Data) throws -> Model
//}
//
//extension ResourceM
//{
//	init(url: URL, parseJSON: @escaping (Any) throws -> Model)
//	{
//		self.url = url
//		self.parse = { data in
//			let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//			return try parseJSON(json)
//		}
//	}
//}

//extension Acronym
//{
//	static let all = ResourceM<[Acronym]>(url: URL(string: "http://localhost:8080/acronyms")!, parseJSON:
//	{
//		json in
//		guard let dictionaries = json as? [JSONDictionary] else { throw SerializationError.missing("acronyms") }
//		return try dictionaries.map(Acronym.init)
//	})
//}
//
//enum ResultM<Model>
//{
//	case success(Model)
//	case failure(Error)
//}

//final class Webservice
//{
//	func load<Model>(resource: ResourceM<Model>, completion: @escaping (ResultM<Model>) -> Void)
//	{
//		URLSession.shared.dataTask(with: resource.url)
//		{
//			(data, _, error) in
//			if let error = error
//			{
//				DispatchQueue.main.async
//					{
//					completion(.failure(error))
//				}
//			}
//			else
//			{
//				if let data = data
//				{
//					do
//					{
//						let result = try resource.parse(data)
//						DispatchQueue.main.async
//							{
//							completion(.success(result))
//						}
//					}
//					catch let error
//					{
//						DispatchQueue.main.async
//							{
//							completion(.failure(error))
//						}
//					}
//				}
//			}
//			}.resume()
//	}
//}

//let webservice = Webservice()
//webservice.load(resource: Acronym.all)
//{
//	result in
//	debugPrint(result)
//	PlaygroundPage.current.finishExecution()
//}
//
//PlaygroundPage.current.needsIndefiniteExecution = true

