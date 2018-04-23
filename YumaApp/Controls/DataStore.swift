//
//  DataStore.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-14.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation
import UIKit


final class DataStore
{
	static let sharedInstance = DataStore()
//	private let myClient = MyClient()
	fileprivate init() {}

	var customer: 				Customer?
	var addresses: 				[Address] = 			[]
	var products: 				[aProduct] = 			[]
	var printers: 				[aProduct] = 			[]
	var laptops: 				[aProduct] = 			[]
	var toners: 				[aProduct] = 			[]
	var services: 				[aProduct] = 			[]
	var carriers: 				[Carrier] = 			[]
	var states: 				[CountryState] = 		[]
	var countries: 				[Country] = 			[]
	var orderStates: 			[OrderState] = 			[]
	var orders: 				[Order] = 				[]
	var myOrderRows: 			[OrderRow] = 			[]
	var myCartRows: 			[CartRow] = 			[]
	var myOrder: 				Order?
	var myCart: 				[Carts] = 				[]
	var orderDetails: 			[OrderDetail] = 		[]
	var carts: 					[aCart] = 				[]
	var langs: 					[Language] = 			[]
	var manufacturers: 			[Manufacturer] = 		[]
	var categories: 			[aCategory] = 			[]
	var combinations: 			[Combination] = 		[]
	var currencies: 			[Currency] = 			[]
	var locale = 										"en_CA"
	var taxes: 					[Tax] = 				[]
	var tags: 					[myTag] = 				[]
	var shares: 				[ScoialMedia] = 		[]
	var productOptionValues: 	[ProductOptionValue] = 	[]
	var myLang: 				Int = 					0
	var forceRefresh = 									false
	var productOptions: 		[ProductOption] = 		[]
	var orderCarriers: 			[OrderCarrier] = 		[]
	var configurations: 		[Configuration] = 		[]
	var properties: 			[String] = 				[]
	var customerMessages:		[CustomerMessage] = 	[]
	var customerThreads:		[CustomerThread] = 		[]
	var contacts: 				[Contact] = 			[]
	var orderHistories: 		[OrderHistory] = 		[]

	
	/// Sets the parameters for product shares
	func initShares()
	{
		self.shares.append(ScoialMedia(id: 0, name: [IdValue(id: "0", value: "Share")]))
		self.shares.append(ScoialMedia(id: 1, name: [IdValue(id: "0", value: "Facebook")], link: "https://www.facebook.com/sharer.php?u=%prodUrl%", thumb: "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPCEtLSBHZW5lcmF0b3I6IEFkb2JlIElsbHVzdHJhdG9yIDE5LjEuMSwgU1ZHIEV4cG9ydCBQbHVnLUluIC4gU1ZHIFZlcnNpb246IDYuMDAgQnVpbGQgMCkgIC0tPgo8c3ZnIHZlcnNpb249IjEuMSIgaWQ9IkNhbHF1ZV8xIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB4PSIwcHgiIHk9IjBweCIKCSB3aWR0aD0iNDBweCIgaGVpZ2h0PSI0MHB4IiB2aWV3Qm94PSIwIDAgNDAgNDAiIGVuYWJsZS1iYWNrZ3JvdW5kPSJuZXcgMCAwIDQwIDQwIiB4bWw6c3BhY2U9InByZXNlcnZlIj4KPGc+Cgk8aW1hZ2Ugb3ZlcmZsb3c9InZpc2libGUiIG9wYWNpdHk9IjAuMSIgd2lkdGg9IjI2IiBoZWlnaHQ9IjQyIiB4bGluazpocmVmPSJENzk1Q0EyOS5wbmciICB0cmFuc2Zvcm09Im1hdHJpeCgxIDAgMCAxIDggMCkiPgoJPC9pbWFnZT4KCTxnPgoJCTxwYXRoIGZpbGw9IiNhY2FhYTYiIGQ9Ik0yMi4yLDI3LjJ2LTcuMmgyYzEuNSwwLDIsMCwyLTAuMWMwLTAuMSwwLjEtMSwwLjItMi4xYzAuMS0xLjEsMC4yLTIuMiwwLjItMi40bDAtMC40bC0yLjIsMGwtMi4yLDAKCQkJbDAtMS42YzAtMC45LDAuMS0xLjgsMC4yLTEuOWMwLjItMC41LDAuNy0wLjcsMi42LTAuN2gxLjdWOC4zVjUuOEgyNGMtMywwLTMuOCwwLjEtNSwwLjdjLTAuOCwwLjQtMS42LDEuMi0yLDEuOQoJCQljLTAuNSwxLjEtMC43LDEuOC0wLjcsNC4zTDE2LjIsMTVoLTEuNWgtMS41djIuNXYyLjVoMS41aDEuNXY3LjJ2Ny4yaDNoM1YyNy4yeiIvPgoJPC9nPgo8L2c+Cjwvc3ZnPgo="))
		self.shares.append(ScoialMedia(id: 2, name: [IdValue(id: "0", value: "Twitter")], link: "https://twitter.com/intent/tweet?text=%ProdName%2BprodUrl%", thumb: "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPCEtLSBHZW5lcmF0b3I6IEFkb2JlIElsbHVzdHJhdG9yIDE5LjEuMSwgU1ZHIEV4cG9ydCBQbHVnLUluIC4gU1ZHIFZlcnNpb246IDYuMDAgQnVpbGQgMCkgIC0tPgo8c3ZnIHZlcnNpb249IjEuMSIgaWQ9IkNhbHF1ZV8xIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB4PSIwcHgiIHk9IjBweCIKCSB3aWR0aD0iNDBweCIgaGVpZ2h0PSI0MHB4IiB2aWV3Qm94PSIwIDAgNDAgNDAiIGVuYWJsZS1iYWNrZ3JvdW5kPSJuZXcgMCAwIDQwIDQwIiB4bWw6c3BhY2U9InByZXNlcnZlIj4KPGc+Cgk8aW1hZ2Ugb3ZlcmZsb3c9InZpc2libGUiIG9wYWNpdHk9IjAuMSIgd2lkdGg9IjQyIiBoZWlnaHQ9IjM2IiB4bGluazpocmVmPSI0M0Q2OUZCMS5wbmciICB0cmFuc2Zvcm09Im1hdHJpeCgxIDAgMCAxIDEgMykiPgoJPC9pbWFnZT4KCTxnPgoJCTxwYXRoIGZpbGw9IiNhY2FhYTYiIGQ9Ik0yNS43LDhMMjUuNyw4bDAuNywwaDAuN2wwLjUsMC4xYzAuMywwLjEsMC42LDAuMiwwLjksMC4zczAuNSwwLjIsMC44LDAuNEMyOS42LDguOSwyOS44LDksMzAsOS4yCgkJCWMwLjIsMC4xLDAuNCwwLjMsMC42LDAuNWMwLjIsMC4yLDAuNCwwLjIsMC44LDAuMWMwLjMtMC4xLDAuNy0wLjIsMS4xLTAuM2MwLjQtMC4xLDAuOC0wLjMsMS4yLTAuNWMwLjQtMC4yLDAuNi0wLjMsMC43LTAuMwoJCQljMC4xLDAsMC4xLTAuMSwwLjEtMC4xbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwYzAsMCwwLDAuMSwwLDAuMQoJCQlTMzQuNSw5LDM0LjMsOS4zcy0wLjQsMC42LTAuNiwwLjljLTAuMiwwLjMtMC41LDAuNi0wLjYsMC43Yy0wLjIsMC4yLTAuMywwLjMtMC40LDAuM2MtMC4xLDAuMS0wLjEsMC4xLTAuMiwwLjJsLTAuMSwwLjFsMCwwbDAsMAoJCQlsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGgwLjFoMC4xbDAuNy0wLjJjMC41LTAuMSwxLTAuMiwxLjQtMC40YzAuNS0wLjIsMC43LTAuMiwwLjctMC4yCgkJCWMwLDAsMC4xLDAsMC4xLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLjEsMGwwLjEsMHYwdjBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDAKCQkJYzAsMC0wLjEsMC4yLTAuMywwLjVjLTAuMiwwLjMtMC4zLDAuNC0wLjQsMC41YzAsMCwwLDAtMC4xLDAuMWMwLDAtMC4yLDAuMi0wLjYsMC42Yy0wLjMsMC4zLTAuNywwLjctMSwwLjkKCQkJYy0wLjMsMC4zLTAuNSwwLjYtMC41LDFjMCwwLjQsMCwwLjgtMC4xLDEuM2MwLDAuNS0wLjEsMS0wLjIsMS42Yy0wLjEsMC42LTAuMiwxLjItMC41LDJjLTAuMiwwLjctMC41LDEuNC0wLjcsMi4xCgkJCWMtMC4zLDAuNy0wLjYsMS4zLTAuOSwxLjlzLTAuNiwxLTAuOSwxLjRjLTAuMywwLjQtMC41LDAuNy0wLjgsMS4xYy0wLjMsMC4zLTAuNiwwLjctMSwxLjFjLTAuNCwwLjQtMC43LDAuNi0wLjcsMC43CgkJCWMwLDAtMC4yLDAuMi0wLjUsMC40Yy0wLjMsMC4zLTAuNiwwLjUtMSwwLjhjLTAuMywwLjMtMC43LDAuNS0xLDAuNmMtMC4zLDAuMi0wLjYsMC40LTEuMSwwLjZjLTAuNCwwLjItMC45LDAuNC0xLjMsMC42CgkJCWMtMC41LDAuMi0xLDAuNC0xLjUsMC41Yy0wLjUsMC4yLTEsMC4zLTEuNSwwLjRjLTAuNSwwLjEtMS4xLDAuMi0xLjcsMC4ybC0wLjksMC4xdjB2MGgtMC45aC0wLjl2MHYwbC0wLjIsMGMtMC4yLDAtMC4zLDAtMC40LDAKCQkJcy0wLjUtMC4xLTEuMS0wLjFjLTAuNi0wLjEtMS4xLTAuMi0xLjUtMC4zcy0wLjktMC4zLTEuNi0wLjVjLTAuNy0wLjItMS4zLTAuNS0xLjgtMC44Yy0wLjUtMC4zLTAuOC0wLjQtMS0wLjUKCQkJYy0wLjEtMC4xLTAuMy0wLjEtMC40LTAuMmwtMC4yLTAuMWwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGgwaDB2MHYwbDAsMGwwLDBsMC4xLDBjMC4xLDAsMC4zLDAsMC43LDAKCQkJczAuNywwLDEuMSwwczAuOC0wLjEsMS4yLTAuMWMwLjQtMC4xLDAuOS0wLjIsMS41LTAuM2MwLjYtMC4yLDEuMS0wLjMsMS42LTAuNWMwLjUtMC4yLDAuOC0wLjQsMS0wLjVjMC4yLTAuMSwwLjUtMC4zLDAuOS0wLjYKCQkJbDAuNi0wLjRsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwtMC4yLDBjLTAuMSwwLTAuMywwLTAuNCwwcy0wLjMsMC0wLjYtMC4xCgkJCWMtMC4zLTAuMS0wLjYtMC4yLTAuOS0wLjNjLTAuMy0wLjEtMC42LTAuMy0xLTAuNXMtMC41LTAuNC0wLjctMC41Yy0wLjEtMC4xLTAuMy0wLjMtMC41LTAuNWMtMC4yLTAuMi0wLjQtMC41LTAuNi0wLjcKCQkJYy0wLjItMC4yLTAuMy0wLjUtMC41LTAuOWwtMC4yLTAuNWwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLjMsMGMwLjIsMCwwLjUsMCwwLjksMHMwLjcsMCwwLjktMC4xYzAuMiwwLDAuMywwLDAuMy0wLjFsMC4xLDAKCQkJbDAuMSwwbDAuMSwwbDAsMGwwLDBsMCwwbDAsMGwtMC4xLDBsLTAuMSwwbC0wLjEsMGwtMC4xLDBsLTAuMSwwYzAsMC0wLjEsMC0wLjItMC4xcy0wLjMtMC4xLTAuNy0wLjNjLTAuNC0wLjItMC43LTAuMy0wLjktMC41CgkJCWMtMC4yLTAuMi0wLjQtMC4zLTAuNy0wLjVjLTAuMi0wLjItMC40LTAuNC0wLjctMC43Yy0wLjItMC4zLTAuNS0wLjctMC43LTFjLTAuMi0wLjQtMC4zLTAuOC0wLjQtMS4xYy0wLjEtMC40LTAuMi0wLjctMC4yLTEuMQoJCQlsMC0wLjZsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMC40LDAuMmMwLjMsMC4xLDAuNiwwLjIsMSwwLjNzMC43LDAuMSwwLjcsMC4xbDAuMSwwaDAuMWgwLjFsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMAoJCQlsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBjMCwwLTAuMS0wLjEtMC4yLTAuMmMtMC4xLTAuMS0wLjMtMC4zLTAuNS0wLjRjLTAuMi0wLjItMC4zLTAuNC0wLjUtMC42cy0wLjMtMC40LTAuNC0wLjYKCQkJQzgsMTUsNy44LDE0LjcsNy43LDE0LjRjLTAuMS0wLjMtMC4yLTAuNy0wLjMtMWMtMC4xLTAuMy0wLjEtMC43LTAuMS0xYzAtMC4zLDAtMC42LDAtMC45YzAtMC4yLDAuMS0wLjUsMC4yLTAuOHMwLjItMC42LDAuMy0xCgkJCUw4LDkuMmwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLjQsMC40YzAuMiwwLjMsMC41LDAuNiwwLjgsMC45CgkJCUM5LjcsMTAuOCw5LjksMTEsOS45LDExYzAsMCwwLjEsMC4xLDAuMSwwLjFjMC4xLDAuMSwwLjIsMC4yLDAuNSwwLjVjMC4zLDAuMiwwLjcsMC41LDEuMiwwLjlzMSwwLjcsMS42LDEKCQkJYzAuNiwwLjMsMS4yLDAuNiwxLjksMC45YzAuNywwLjMsMS4yLDAuNCwxLjQsMC41YzAuMywwLjEsMC43LDAuMiwxLjQsMC4zYzAuNywwLjEsMS4yLDAuMiwxLjUsMC4yczAuNiwwLjEsMC43LDAuMWwwLjIsMGwwLDAKCQkJbDAsMEwyMC40LDE1YzAtMC4yLTAuMS0wLjUtMC4xLTAuOXMwLTAuOCwwLjEtMS4xYzAuMS0wLjMsMC4yLTAuNywwLjMtMWMwLjEtMC4zLDAuMi0wLjYsMC40LTAuOGMwLjEtMC4yLDAuMy0wLjQsMC41LTAuNwoJCQljMC4yLTAuMywwLjQtMC41LDAuOC0wLjhjMC4zLTAuMywwLjctMC41LDEuMS0wLjhjMC40LTAuMiwwLjgtMC40LDEuMS0wLjVjMC4zLTAuMSwwLjYtMC4yLDAuOC0wLjJTMjUuNyw4LDI1LjcsOHoiLz4KCTwvZz4KPC9nPgo8L3N2Zz4K"))
		self.shares.append(ScoialMedia(id: 3, name: [IdValue(id: "0", value: "Google+")], link: "https://plus.google.com/share?url=%prodUrl%", thumb: "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPCEtLSBHZW5lcmF0b3I6IEFkb2JlIElsbHVzdHJhdG9yIDE5LjEuMSwgU1ZHIEV4cG9ydCBQbHVnLUluIC4gU1ZHIFZlcnNpb246IDYuMDAgQnVpbGQgMCkgIC0tPgo8c3ZnIHZlcnNpb249IjEuMSIgaWQ9IkNhbHF1ZV8xIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB4PSIwcHgiIHk9IjBweCIKCSB3aWR0aD0iNDBweCIgaGVpZ2h0PSI0MHB4IiB2aWV3Qm94PSIwIDAgNDAgNDAiIGVuYWJsZS1iYWNrZ3JvdW5kPSJuZXcgMCAwIDQwIDQwIiB4bWw6c3BhY2U9InByZXNlcnZlIj4KPGc+Cgk8aW1hZ2Ugb3ZlcmZsb3c9InZpc2libGUiIG9wYWNpdHk9IjAuMSIgd2lkdGg9IjQ2IiBoZWlnaHQ9IjM0IiB4bGluazpocmVmPSJDRTYxRDA0Qi5wbmciICB0cmFuc2Zvcm09Im1hdHJpeCgxIDAgMCAxIC0yIDQpIj4KCTwvaW1hZ2U+Cgk8Zz4KCQk8Zz4KCQkJPHBhdGggZmlsbD0iI2FjYWFhNiIgZD0iTTE0LDE4LjF2NC4yYzAsMCw0LDAsNS43LDBjLTAuOSwyLjctMi4zLDQuMi01LjcsNC4yYy0zLjQsMC02LjEtMi44LTYuMS02LjJTMTAuNSwxNCwxNCwxNAoJCQkJYzEuOCwwLDMsMC42LDQuMSwxLjVjMC45LTAuOSwwLjgtMSwzLTMuMWMtMS45LTEuNy00LjMtMi43LTcuMS0yLjdjLTUuOCwwLTEwLjUsNC43LTEwLjUsMTAuNUMzLjUsMjYsOC4yLDMwLjcsMTQsMzAuNwoJCQkJYzguNywwLDEwLjgtNy41LDEwLjEtMTIuNkMyMiwxOC4xLDE0LDE4LjEsMTQsMTguMXogTTMyLjksMTguNHYtMy42aC0yLjZ2My42aC0zLjd2Mi42aDMuN3YzLjdoMi42di0zLjdoMy42di0yLjZIMzIuOXoiLz4KCQk8L2c+Cgk8L2c+CjwvZz4KPC9zdmc+Cg=="))
		self.shares.append(ScoialMedia(id: 4, name: [IdValue(id: "0", value: "Pinerest")], link: "https://www.pinerest.com/pin/create/button/?media=%prodImage%&url=%prodUrl%", thumb: "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPCEtLSBHZW5lcmF0b3I6IEFkb2JlIElsbHVzdHJhdG9yIDE5LjEuMSwgU1ZHIEV4cG9ydCBQbHVnLUluIC4gU1ZHIFZlcnNpb246IDYuMDAgQnVpbGQgMCkgIC0tPgo8c3ZnIHZlcnNpb249IjEuMSIgaWQ9IkNhbHF1ZV8xIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB4PSIwcHgiIHk9IjBweCIKCSB3aWR0aD0iNDBweCIgaGVpZ2h0PSI0MHB4IiB2aWV3Qm94PSIwIDAgNDAgNDAiIGVuYWJsZS1iYWNrZ3JvdW5kPSJuZXcgMCAwIDQwIDQwIiB4bWw6c3BhY2U9InByZXNlcnZlIj4KPGc+Cgk8aW1hZ2Ugb3ZlcmZsb3c9InZpc2libGUiIG9wYWNpdHk9IjAuMSIgd2lkdGg9IjM4IiBoZWlnaHQ9IjQ2IiB4bGluazpocmVmPSI4REY2NkQ0Qi5wbmciICB0cmFuc2Zvcm09Im1hdHJpeCgxIDAgMCAxIDIgLTEpIj4KCTwvaW1hZ2U+Cgk8Zz4KCQk8Zz4KCQkJPHBhdGggZmlsbD0iI2FjYWFhNiIgZD0iTTE4LjcsNS4xQzEzLjQsNS42LDguMSwxMCw3LjgsMTYuMWMtMC4xLDMuOCwwLjksNi42LDQuNSw3LjRjMS42LTIuNy0wLjUtMy4zLTAuOC01LjMKCQkJCWMtMS4zLTguMSw5LjQtMTMuNywxNS04YzMuOSwzLjksMS4zLDE2LTQuOSwxNC44Yy02LTEuMiwyLjktMTAuOC0xLjgtMTIuN2MtMy45LTEuNS01LjksNC43LTQuMSw3LjhjLTEuMSw1LjMtMy40LDEwLjMtMi41LDE3CgkJCQljMy4xLTIuMiw0LjEtNi41LDQuOS0xMC45YzEuNSwwLjksMi40LDEuOSw0LjMsMi4xYzcuMiwwLjYsMTEuMi03LjIsMTAuMy0xNC40QzMxLjgsNy41LDI1LjUsNC4zLDE4LjcsNS4xeiIvPgoJCTwvZz4KCTwvZz4KPC9nPgo8L3N2Zz4K"))
	}
	
	/// Send data via HTTP POST
	func PostHTTP(url: String, parameters: [String : String], completion: @escaping (Any) -> Void)
	{
		if let myUrl = URL(string: url)
		{
			//let bodyStr = "username=username&password=password&grant_type=password"
			//let myURL = NSURL(string: "http://192.168.1.2/rest"
			let request = NSMutableURLRequest(url: myUrl as URL)
			request.httpMethod = "POST"
			request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-type")
			request.setValue("application/json", forHTTPHeaderField: "Accept")
			var bodyStr = ""
			var paramArray: [String] = []
			for param in parameters
			{
				paramArray.append(String(format: "%@=%@", param.key, param.value))
			}
			bodyStr = paramArray.joined(separator: "&")
			request.httpBody = bodyStr.data(using: String.Encoding.utf8)!
			let task = URLSession.shared.dataTask(with: request as URLRequest)
			{	(data, response, error) -> Void in
				completion(false)
//				if let unwrappedData = data
//				{
//					do
//					{
//						let tokenDictionary:NSDictionary = try JSONSerialization.jsonObject(with: unwrappedData, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
//						let token = tokenDictionary["access_token"] as? String
//					}
//					catch
//					{
////						self.emailTextField.text = ""
////						self.passwordTextField.text = ""
//						let alertView = UIAlertController(title: "Login failed",
//														  message: "Wrong username or password." as String, preferredStyle:.alert)
//						let okAction = UIAlertAction(title: "Try Again!", style: .default, handler: nil)
//						alertView.addAction(okAction)
////						self.present(alertView, animated: true, completion: nil)
//						return
//					}
//				}
			}
			task.resume()
		}
	}
	
	/// Use the api to collect details about the logged-in customer, if any
	func callGetCustomerDetails(from: String, completion: @escaping (Any) -> Void)
	{
		PSWebServices.getCustomer(from: from, completionHandler:
			{
				(customer) in
				
				if let _ = customer as? Bool
				{
					completion(false)
				}
				else
				{
					self.customer = customer as? Customer
					completion(customer)
				}
			}
		)
	}
	
	/// Use the api to collect the carriers, if any
	func callGetCarriers(completion: @escaping ([Carrier]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)carriers"
		let myUrl = "\(url)?\(R.string.APIfull)&\(R.string.APIjson)&\(R.string.API_key)"
		PSWebServices.getCarriers(from: myUrl, /*to: CarrierList.self,*/ completionHandler:
			{
				(object, err) in//)(dataStr, object) in
				
				let dataStr = 				UserDefaults.standard.string(forKey: "Carriers")
				let tempCarr: 	String = 	self.trimJSONValueToArray(string: dataStr!)
				let tempObj: 	[Carrier]
				do
				{
					tempObj = try JSONDecoder().decode([Carrier].self, from: tempCarr.data(using: .utf8)!)
					for carr in tempObj
					{
						self.carriers.append(carr)
					}
					completion(tempObj, nil)
				}
				catch let jsonErr
				{
					print(jsonErr)
					completion(nil, err)//"\(err?.localizedDescription) - \(jsonErr)")
				}
			}
		)
	}
	
	/// Use the api to collect the customer's carts, if any
	func callGetCarts(id_customer: Int, completion: @escaping ([aCart]?, Error?) -> Void)
	{
		PSWebServices.getCarts(id_customer: id_customer, completionHandler:
			{
				(object, err) in//)(dataStr, object) in
				
				if err != nil
				{
					let dataStr = 				UserDefaults.standard.string(forKey: "CartsCustomer\(id_customer)")
					let tempCarr: 	String = 	self.trimJSONValueToArray(string: dataStr!)
					let tempObj: 	[aCart]
					do
					{
						tempObj = try JSONDecoder().decode([aCart].self, from: tempCarr.data(using: .utf8)!)
						for carr in tempObj
						{
							self.carts.append(carr)
						}
						completion(tempObj, nil)
					}
					catch let jsonErr
					{
						print(jsonErr)
						completion(nil, err)//"\(err?.localizedDescription) - \(jsonErr)")
					}
				}
				else
				{
					for carr in (object?.carts)!
					{
						self.carts.append(carr)
					}
					completion(object?.carts, nil)
				}
			}
		)
	}
	
	/// Use the api to collect addresses for the logged-in customer, if any
	func callGetAddresses(id_customer: Int, completion: @escaping (Addresses) -> Void)
	{
		PSWebServices.getAddresses(id_customer: id_customer, completionHandler:
			{
				(addresses) in
				
				for addresses in addresses.addresses!
				{
					self.addresses.append(addresses)
				}
				completion(addresses)
			}
		)
	}
	
	/// Try to parse a JSON string and return a string
	func parse(JSON json: String) throws -> [String]?
	{
		guard let data = json.data(using: .utf8) else { 	return nil 	}
		
		guard let rootArray = try JSONSerialization.jsonObject(with: data, options : []) as? [[String: Any]]
			else { return nil }
		
		return rootArray
			.filter{ 	$0["success"] as? Int == 1 		}
			.map{ 		$0["nama_produk"] as! String 	}
	}

	/// Use the api to collect the countries, if any
	func callGetCountries(completion: @escaping (Any?, Error?) -> Void)
	{
		PSWebServices.getCountries(completionHandler:
			{
				(countries, error) in
				
				if error != nil
				{
					completion(nil, error)
				}
				else
				{
					self.countries = countries!
					completion(countries, nil)
				}
			}
		)
	}

	/// Use the api to collect the states, optionally belonging to a certain countryID, if any
	func callGetStates(id_country: Int, completion: @escaping (Any?, Error?) -> Void)
	{
		PSWebServices.getStates(id_country: id_country, completionHandler:
			{
				(states, err) in
				
				if err != nil
				{
					completion(nil, err)
				}
				else
				{
					self.states = states!
					completion(states, nil)
				}
			}
		)
	}

	/// Use the api to collect the orders for the logged-in customer, if any
	func getOrders(id_customer: Int, completion: @escaping (Any?, Error?) -> Void)
	{
		PSWebServices.getOrders(id_customer: id_customer, completionHandler:
			{
				(result, err) in
				
				if err != nil	//if has error
				{
					let dataStr = 				UserDefaults.standard.string(forKey: "OrdersCustomer\(id_customer)")
					let tempCarr: 	String = 	self.trimJSONValueToArray(string: dataStr!)
					let tempObj: 	[Order]
					do
					{
						tempObj = try JSONDecoder().decode([Order].self, from: tempCarr.data(using: .utf8)!)
						for ords in tempObj					{	self.orders.append(ords)	}
						OperationQueue.main.addOperation	{	completion(tempObj, nil)	}
					}
					catch let jsonErr
					{
						print(jsonErr)
						OperationQueue.main.addOperation	{	completion(nil, jsonErr)	}
					}
				}
				else
				{
					for ords in (result?.orders)!			{	self.orders.append(ords)	}
					OperationQueue.main.addOperation		{	completion(result, nil)		}
				}
			}
		)
	}

	/// Use the api to collect details about the orders made by the logged-in customer, if any
	func getOrderDetails(id_order: Int, completion: @escaping (Any?, Error?) -> Void)
	{
		PSWebServices.getOrderDetails(id_order: id_order, completionHandler:
			{
				(result, err) in
				
				if err != nil	//if has error
				{
					let dataStr = 				UserDefaults.standard.string(forKey: "OrderDetailsOrder\(id_order)")
					let tempCarr: 	String = 	self.trimJSONValueToArray(string: dataStr!)
					let tempObj: 	[OrderDetail]
					do
					{
						tempObj = try JSONDecoder().decode([OrderDetail].self, from: tempCarr.data(using: .utf8)!)
						for ords in tempObj					{	self.orderDetails.append(ords)	}
						OperationQueue.main.addOperation	{	completion(tempObj, nil)		}
					}
					catch let jsonErr
					{
						print(jsonErr)
						OperationQueue.main.addOperation	{	completion(nil, jsonErr)		}
					}
				}
				else
				{
					if let result = result
					{
						let array = result.orderDetails
						OperationQueue.main.addOperation	{
//							for carr in result.orderDetails!{	self.orderDetails.append(carr)	}
																completion(array, nil)			}
					}
				}
			}
		)
	}

	/// Use the api to collect a list of the status codes given to the state of each order, if any
	func getOrderStates(completion: @escaping (Any?, Error?) -> Void)
	{
		PSWebServices.getOrderStates(completionHandler:
			{
				(states, err) in
				
				if err != nil	//only if error
				{
					let dataStr = 				UserDefaults.standard.string(forKey: "OrderStates")
					let tempCarr: 	String = 	self.trimJSONValueToArray(string: dataStr!)
					let tempObj: 	[OrderState]	//^remove wrapper - use inner array
					do
					{
						tempObj = try JSONDecoder().decode([OrderState].self, from: tempCarr.data(using: .utf8)!)
//						let array = tempObj.order_states
//						for os in array!
						for os in tempObj					{	self.orderStates.append(os)	}
						OperationQueue.main.addOperation	{	completion(tempObj, nil)	}
					}
					catch let jsonErr
					{
						print(jsonErr)
						OperationQueue.main.addOperation	{	completion(nil, jsonErr)	}
					}
				}
				else
				{
					OperationQueue.main.addOperation		{
//						for carr in states!					{	self.orderCarriers.append(carr)	}
																completion(states, nil)		}
				}
			}
		)
	}

	/// Use the api to collect a list of the order carriers, if any
	func getOrderCarriers(completion: @escaping (Any?, Error?) -> Void)
	{
		PSWebServices.getOrderCarriers(completionHandler:
			{
				(carrs, err) in
				
				if err != nil	//only if error
				{
					let dataStr = 				UserDefaults.standard.string(forKey: "OrderCarriers")
					let tempCarr: 	String = 	self.trimJSONValueToArray(string: dataStr!)
					let tempObj: 	[OrderCarrier]	//^remove wrapper - use inner array
					do
					{
						tempObj = try JSONDecoder().decode([OrderCarrier].self, from: tempCarr.data(using: .utf8)!)
						//						let array = tempObj.order_states
						//						for os in array!
						for carr in tempObj					{	self.orderCarriers.append(carr)	}
						OperationQueue.main.addOperation	{	completion(tempObj, nil)	}
					}
					catch let jsonErr
					{
						print(jsonErr)
						OperationQueue.main.addOperation	{	completion(nil, jsonErr)	}
					}
				}
				else
				{
					OperationQueue.main.addOperation		{
						for carr in carrs!					{	self.orderCarriers.append(carr)	}
																completion(carrs, nil)		}
				}
			}
		)
	}
	
	func getOrderHistories(completion: @escaping (Any?, Error?) -> Void)
	{
		PSWebServices.getOrderHistories(completionHandler:
			{
				(carrs, err) in
				
				if err != nil	//only if error
				{
					let dataStr = 				UserDefaults.standard.string(forKey: "OrderHistories")
					let tempCarr: 	String = 	self.trimJSONValueToArray(string: dataStr!)
					let tempObj: 	[OrderHistory]	//^remove wrapper - use inner array
					do
					{
						tempObj = try JSONDecoder().decode([OrderHistory].self, from: tempCarr.data(using: .utf8)!)
						//						let array = tempObj.order_states
						//						for os in array!
						for carr in tempObj					{	self.orderHistories.append(carr)	}
						OperationQueue.main.addOperation	{	completion(tempObj, nil)	}
					}
					catch let jsonErr
					{
						print(jsonErr)
						OperationQueue.main.addOperation	{	completion(nil, jsonErr)	}
					}
				}
				else
				{
					OperationQueue.main.addOperation		{
						for carr in carrs!					{	self.orderHistories.append(carr)	}
						completion(carrs, nil)		}
				}
		}
		)
	}

	/// Use the api to collect details about the languages, if any
	func callGetLanguages(completion: @escaping (Any?, Error?) -> Void)
	{
		PSWebServices.getLangauages(completionHandler:
			{
				(langs, err) in
				
				if err == nil
				{
					if langs != nil
					{
						for lang in (langs?.languages)!
						{
							self.langs.append(lang)
						}
						completion(self.langs, nil)
					}
				}
				else
				{
					completion(nil, err)
				}
			}
		)
	}
	
	
	/// Use the api to collect the combinations for every product, if any
	func callGetCombinations(completion: @escaping (Any?, Error?) -> Void)
	{
		PSWebServices.getCombinations(completionHandler:
			{
				(combs, err) in
				
				if err == nil
				{
					if combs != nil
					{
						for comb in (combs?.combinations)!
						{
							self.combinations.append(comb)
						}
						completion(self.combinations, nil)
					}
				}
				else
				{
					completion(nil, err)
				}
			}
		)
	}
	
	/// Use the api to collect the options for every product, if any
	func callGetProductOptions(completion: @escaping (Any?, Error?) -> Void)
	{
		PSWebServices.getProductOptions(completionHandler:
			{
				(options, err) in
				
				if err == nil
				{
					if options != nil
					{
						for opt in (options?.product_options)!
						{
							self.productOptions.append(opt)
						}
						completion(self.productOptions, nil)
					}
				}
				else
				{
					completion(nil, err)
				}
			}
		)
	}


	/// Use the api to collect details about the manufacturers, if any
	func callGetManufacturers(completion: @escaping (Any?, Error?) -> Void)
	{
		PSWebServices.getManufacturers(completionHandler:
			{
				(manus, err) in
				
				if err == nil
				{
					if manus != nil
					{
						for man in (manus?.manufacturers)!
						{
							self.manufacturers.append(man)
						}
						completion(self.manufacturers, nil)
					}
				}
				else
				{
					completion(nil, err)
				}
			}
		)
	}

	/// Use the api to collect details about the currencies, if any
	func callGetCurrencies(completion: @escaping (Any?, Error?) -> Void)
	{
		PSWebServices.getCurrencies(completionHandler:
			{
				(currs, err) in
				
				if err == nil
				{
					if currs != nil
					{
						for curr in (currs?.currencies)!
						{
							self.currencies.append(curr)
						}
						completion(self.currencies, nil)
					}
				}
				else
				{
					completion(nil, err)
				}
			}
		)
	}
	
	/// Use the api to collect details about the product categories, if any
	func callGetCategories(completion: @escaping (Any?, Error?) -> Void)
	{
		PSWebServices.getCategories(completionHandler:
			{
				(cats, err) in
				
				if err == nil
				{
					if cats != nil
					{
						for cat in (cats?.categories)!
						{
							self.categories.append(cat)
						}
						completion(self.categories, nil)
					}
				}
				else
				{
					completion(nil, err)
				}
			}
		)
	}
	
	/// Use the api to collect the configurations, if any
	func callGetConfigurations(completion: @escaping ([Configuration]?, Error?) -> Void)
	{
		PSWebServices.getConfigurations(completionHandler:
			{
				(configurations, err) in
				
				if err == nil
				{
					if configurations != nil
					{
						if (configurations?.configurations) != nil
						{
							for tax in (configurations?.configurations!)!
							{
								self.configurations.append(tax)
							}
						}
						completion(self.configurations, nil)
					}
				}
				else
				{
					completion(nil, err)
				}
			}
		)
	}
	
	/// Use the api to collect details about the taxes, if any
	func callGetTaxes(completion: @escaping ([Tax]?, Error?) -> Void)
	{
		PSWebServices.getTaxes(completionHandler:
			{
				(taxes, err) in
				
				if err == nil
				{
					if taxes != nil
					{
						if (taxes?.taxes) != nil
						{
							for tax in (taxes?.taxes!)!
							{
								self.taxes.append(tax)
							}
						}
						completion(self.taxes, nil)
					}
				}
				else
				{
					completion(nil, err)
				}
			}
		)
	}
	
	/// Use the api to collect details about the product tags, if any
	func callGetTags(completion: @escaping ([myTag]?, Error?) -> Void)
	{
		PSWebServices.getTags(completionHandler:
			{
				(tags, err) in
				
				if err == nil
				{
					if tags != nil
					{
						if (tags?.tags) != nil
						{
							for tag in (tags?.tags!)!
							{
								self.tags.append(tag)
							}
						}
						completion(self.tags, nil)
					}
				}
				else
				{
					completion(nil, err)
				}
			}
		)
	}
	
	/// Use the api to collect the values for every product option, if any
	func callGetProductOptionValues(completion: @escaping ([ProductOptionValue]?, Error?) -> Void)
	{
		PSWebServices.getProductOptionValues(completionHandler:
			{
				(productOptionValues, err) in
				
				if err == nil
				{
					if productOptionValues != nil
					{
						if (productOptionValues?.product_option_values) != nil
						{
							for tag in (productOptionValues?.product_option_values)!
							{
								self.productOptionValues.append(tag)
							}
						}
						completion(self.productOptionValues, nil)
					}
				}
				else
				{
					completion(nil, err)
				}
			}
		)
	}

	/// Use the api to collect details about the products in the printers category, if any
	func callGetPrinters(completion: @escaping (Any?) -> Void)
	{
		DispatchQueue.main.async//After(deadline: .now() + 30)
		{
			PSWebServices.getPrinters(completionHandler:
				{
					(printers, error) in
					
					if error != nil
					{
						if printers != nil
						{
							self.printers = printers!
							self.products = printers!
							completion(printers!)
						}
						else
						{
							completion(nil)
						}
					}
				}
			)
		}
	}

	/// Use the api to collect details about the products in the laptops category, if any
	func callGetLaptops(completion: @escaping (Any?) -> Void)
	{
		DispatchQueue.main.async//After(deadline: .now() + 30)
		{
			PSWebServices.getLaptops(completionHandler:
				{
					(laptops, error) in
					
					if error != nil
					{
						if laptops != nil
						{
							self.laptops = laptops!
							self.products = laptops!
							completion(laptops!)
						}
						else
						{
							completion(nil)
						}
					}
				}
			)
		}
	}
	
	/// Use the api to collect details about the products in the services category, if any
	func callGetServices(completion: @escaping (Any?) -> Void)
	{
		DispatchQueue.main.async//After(deadline: .now() + 30)
		{
			PSWebServices.getServices(completionHandler:
				{
					(services, error) in
					
					if error != nil
					{
						if services != nil
						{
							self.services = services!
							self.products = services!
							completion(services!)
						}
						else
						{
							completion(nil)
						}
					}
				}
			)
		}
	}
	
	/// Use the api to collect details about the products in the toners category, if any
	func callGetToners(completion: @escaping (Any?) -> Void)
	{
		DispatchQueue.main.async//After(deadline: .now() + 30)
		{
			PSWebServices.getToners(completionHandler:
				{
					(toners, error) in
					
					if error != nil
					{
						if toners != nil
						{
							self.toners = toners!
							self.products = toners!
							completion(toners!)
						}
						else
						{
							completion(nil)
						}
					}
				}
			)
		}
	}
	
	/// Use the api to collect messages sent by customers, if any
	func callGetCustomerMessages(completion: @escaping (Any?) -> Void)
	{
		DispatchQueue.main.async//After(deadline: .now() + 30)
		{
			PSWebServices.getCustomerMessages(completionHandler:
			{
				(msgs, error) in
				
				if error != nil
				{
					if msgs != nil
					{
						self.customerMessages = msgs!
						completion(msgs!)
					}
					else
					{
						completion(nil)
					}
				}
			})
		}
	}

	/// Use the api to collect customer threads, if any
	func callGetCustomerThreads(completion: @escaping (Any?) -> Void)
	{
		DispatchQueue.main.async//After(deadline: .now() + 30)
		{
			PSWebServices.getCustomerThreads(completionHandler:
				{
					(threads, error) in
					
					if error != nil
					{
						if threads != nil
						{
							self.customerThreads = threads!
							completion(threads!)
						}
						else
						{
							completion(nil)
						}
					}
			})
		}
	}
	
	/// Use the api to collect customer threads, if any
	func callGetContacts(completion: @escaping (Any?, Error?) -> Void)
	{
		//DispatchQueue.main.asyncAfter(deadline: .now() + 30)
		OperationQueue.main.addOperation
		{
			PSWebServices.getContacts(completionHandler:
			{
				(contacts, error) in//array, Error
				
				if error != nil
				{
					completion(nil, error)
				}
				else if contacts != nil
				{
					self.contacts = contacts!
					completion(contacts!, nil)
				}
				else
				{
					completion(nil, nil)
				}
			})
		}
	}

	///try
	func get(fromUrl: String, customHeaders: [String : String]?, sendCookies: [String : String]?, completion: @escaping (Any) -> Void)
	{
		if let myUrl = URL(string: fromUrl)
		{
			var request = URLRequest(url: myUrl)
			request.httpMethod = "GET"
//			let token = UserDefaults.standard.string(forKey: "authToken")!
//			if token != ""
//			{
//				request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//			}
			if customHeaders != nil
			{
				for header in customHeaders!
				{
					request.addValue(header.value, forHTTPHeaderField: header.key)
				}
			}
			if sendCookies != nil
			{
				var cookies = ""
				for cookie in sendCookies!
				{
					cookies.append("\(cookie.key)=\"\(cookie.value)\";")
				}
				request.addValue(cookies, forHTTPHeaderField: "Cookie")
			}
			let task = URLSession.shared.dataTask(with: request)
			{
				(data, response, error) in

				if error != nil
				{
					print("\(R.string.err) \(String(describing: error))")
					completion(false)
				}
				if let httpResponse = response as? HTTPURLResponse
				{
					switch(httpResponse.statusCode)
					{
					case 200:
						guard let data = data else	{	return	}
						completion(data)
						break
					case 401:
						print("401 Refresh token...")
						break
					default:
						print("statusCode: \(httpResponse.statusCode)")
						completion(false)
					}
				}
			}
			task.resume()
		}
	}
	
	/// Displays a simple alert dialog
	func alertMessage(sender: Any, alerttitle: String, _ message: String)
	{
		let alertViewController = 	UIAlertController(title: alerttitle, message: message, preferredStyle: .alert)
		alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		let vc = 					sender as! UIViewController
		vc.present(alertViewController, animated: true, completion: nil)
	}
	
	/// Formats an address into a basic string (converting the countryID and the stateID)
	func formatAddress(_ address: Address) -> String
	{
		var formed = ""
		if address.company != nil && address.company != ""
		{
			formed.append("\(address.company!)\n")
		}
		if address.firstname != ""
		{
			formed.append("\(address.firstname) ")
		}
		if address.lastname != ""
		{
			formed.append(address.lastname)
		}
		if address.firstname != "" || address.lastname != ""
		{
			formed.append("\n")
		}
		if address.address1 != ""
		{
			formed.append("\(address.address1)\n")
		}
		if address.address2 != nil && address.address2 != ""
		{
			formed.append("\(address.address2!)\n")
		}
		if address.city != ""
		{
			formed.append("\(address.city)\n")
		}
		if address.postcode != nil && address.postcode != ""
		{
			formed.append("\(address.postcode!)")
		}
		if address.id_state != nil && address.id_state != ""
		{
			if address.postcode != nil && address.postcode != ""
			{
				formed.append("  ")
			}
			if self.countries.count > 0
			{
				var stateName = ""
				for c in self.states
				{
					if c.id == Int(address.id_state!)
					{
						stateName = c.name!
						break
					}
				}
				formed.append("\(stateName)")
			}
			else
			{
				formed.append(address.id_state!)
			}
		}
		if address.postcode != nil && address.postcode != "" || address.id_state != nil && address.id_state != ""
		{
			formed.append("\n")
		}
		if address.id_country != ""
		{
			if self.countries.count > 0
			{
				var country = ""
				for c in self.countries
				{
					if c.id == Int(address.id_country)
					{
						country = c.name![0].value!
						break
					}
				}
				formed.append("\(country)\n")
			}
			else
			{
				formed.append("\(address.id_country)\n")
			}
		}
		return formed
	}
	
	/// Returns an image from the given URL
	func getImageFromUrl(url: URL, session: URLSession, completion: @escaping (Data?, URLResponse?, Error?) -> ())
	{
		let task = session.dataTask(with: url)
		{
			(data, response, error) in
			
			if let e = error
			{
				print("Error Occurred: \(e)")
			}
			else
			{
				if (response as? HTTPURLResponse) != nil
				{
					if let _ = data
					{
						completion(data, response, error)
					}
					else
					{
						print("Image file is currupted")
					}
				}
				else
				{
					print("No response from server")
				}
			}
		}
		task.resume()
	}
	
	/// Performs a simple animation of the specified view
	func flexView(view: UIView, completionHandler: ((Bool) -> Void)? = nil)
	{
		view.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
		UIView.animate(withDuration: 			1.0,
					   delay: 					0,
					   usingSpringWithDamping: 	CGFloat(0.20),
					   initialSpringVelocity: 	CGFloat(6.0),
					   options: 				UIViewAnimationOptions.allowUserInteraction,
					   animations: {			view.transform = CGAffineTransform.identity	},
					   completion: { 			completionHandler						}()
		)
	}

	/// Trims a JSON string, by removing the wrapper, returns the JSON array as a string
	func trimJSONValueToArray(string: String) -> String
	{
		let pos1 = 	string.indexOf("[")
		let pos2 = 	string.lastIndexOf("]")! + 1
		//print("pos1: \(pos1), pos2: \(pos2)\nin \(string)")
		let start = string.index(string.startIndex, offsetBy: pos1)
		let end = 	string.index(string.startIndex, offsetBy: pos2)
		let sub = 	string[start..<end]
		//print(sub)
		return 		String(sub)
	}
	
	/// Formats a NSNumber to a string using a specific country ISO
	func formatCurrency(amount: NSNumber, iso/*lang_country*/: String? = "en_CA") -> String
	{
		let formatter = 		NumberFormatter()
		formatter.numberStyle = .currency
		formatter.locale = 		Locale(identifier: iso!)
		return 					formatter.string(from: amount)!
	}
	
	typealias Closure_Void = () -> Void

	/// Performs a system alert -shows a modal dialog, with customizations, including blur and colors
	func Alert(fromView: 					UIViewController,
			   title: 						String?,
			   titleColor: 					UIColor? = 				.black,
			   titleBackgroundColor: 		UIColor? = 				.clear,
			   titleFont: 					UIFont? = 				UIFont(name: "AlNile-Bold", size: 16),
			   message: 					String?,
			   messageColor: 				UIColor? = 				.darkGray,
			   messageBackgroundColor: 		UIColor? = 				.clear,
			   messageFont: 				UIFont? = 				UIFont(name: "AvenirNext-Regular", size: 15),
			   dialogBackgroundColor: 		UIColor? = 				.white,
			   backgroundBackgroundColor: 	UIColor? =				.darkGray,
			   backgroundBlurStyle: 		UIBlurEffectStyle? = 	.dark,
			   backgroundBlurFactor:		CGFloat? = 				0.5,
			   borderColor: 				UIColor? = 				.clear,
			   borderWidth: 				CGFloat? = 				0,
//			   buttonsColor: 				UIColor? = 				UIColor(red: 0.1520819664, green: 0.5279997587, blue: 0.985317409, alpha: 1),
			   cornerRadius: 				CGFloat? = 				10,
			   shadowColor: 				UIColor? = 				.black,
			   shadowOffset: 				CGSize? = 				.zero,
			   shadowOpacity: 				Float? = 				1,
			   shadowRadius: 				CGFloat? = 				8,
			   alpha: 						CGFloat? = 				1,
			   hasButton1:	 				Bool = 					true,
			   button1Title: 				String? = 				"OK",
			   button1Style: 				UIAlertActionStyle? = 	.default,
			   button1Color: 				UIColor? = 				R.color.AppleBlue,
			   button1Font: 				UIFont? = 				UIFont(name: "AvenirNext-Regular", size: 16),
			   button1Action: 				Closure_Void? = 		nil,
			   hasButton2: 					Bool = 					false,
			   button2Title: 				String? = 				"Cancel",
			   button2Style: 				UIAlertActionStyle? = 	.default,
			   button2Color: 				UIColor? = 				R.color.AppleBlue,
			   button2Font: 				UIFont? = 				UIFont(name: "AvenirNext-Regular", size: 16),
			   button2Action: 				Closure_Void? = 		nil
			   )
	{
		let coloredBG = 					UIView()
		let blurFx = 						UIBlurEffect(style: backgroundBlurStyle!)
		let blurFxView = 					UIVisualEffectView(effect: blurFx)
//		let alertController = 				UIAlertController(title: title, message: message, preferredStyle: .alert)
		let alertController = 				CustomizableAlertController(title: title, message: message, preferredStyle: .alert)
		//let subView = alertController.view.subviews.first!
		//let alertContentView = subView.subviews.first!
		//alertContentView.backgroundColor = tintBackgroundColor
		//var titleAttr: NSMutableAttributedString
		//alertController.view.subviews.first?.subviews.first?.subviews.last?.backgroundColor = .red
		//alertController.blurStyle = .dark
		if title != nil || title != ""
		{
			var titleAttr: 					[NSAttributedStringKey : Any?]? = [:]
			if titleFont != nil				{	titleAttr?.updateValue(titleFont, forKey: .font)						}
//			if titleFont != nil				{	alertController.titleAttributes += [
//													StringAttribute(key: .font, value: titleFont!)]						}
			if titleColor != nil			{	titleAttr?.updateValue(titleColor, forKey: .foregroundColor)			}
			if titleBackgroundColor != nil	{	alertController.view.superview?.backgroundColor = titleBackgroundColor	}
			let titleString = 				NSAttributedString(string: title!, attributes: titleAttr! as Any as? [NSAttributedStringKey : Any])
			alertController.setValue(titleString, forKey: "attributedTitle")
		}
		if message != nil && message != ""
		{
			var messageAttr: 				[NSAttributedStringKey : Any?]? = [:]
			if messageFont != nil			{	messageAttr?.updateValue(messageFont, forKey: .font)						}
			if messageColor != nil			{	messageAttr?.updateValue(messageColor, forKey: .foregroundColor)			}
			if messageBackgroundColor != nil{	messageAttr?.updateValue(messageBackgroundColor, forKey: .backgroundColor)	}
//			if messageAttr != nil
//			{
				let messageString = 		NSAttributedString(string: message!, attributes: messageAttr! as Any as? [NSAttributedStringKey : Any])
				alertController.setValue(messageString, forKey: "attributedMessage")
//			}
		}
		if hasButton1
		{
//			if button1Color != nil			{	alertController.view.shadowColor = button1Color!					}
			let wholeButton1Action = 		UIAlertAction(title: button1Title ?? "OK", style: button1Style!)
			{
				(action) in
				
//				alertController.dismiss(animated: false, completion: nil)
				if backgroundBackgroundColor != nil								{	coloredBG.removeFromSuperview()		}
				if backgroundBlurFactor != nil || backgroundBlurStyle != nil	{	blurFxView.removeFromSuperview()	}
				if button1Action != nil											{	return _ = button1Action			}
			}
//			var button1Attr: 				[NSAttributedStringKey : Any?]? = [:]
			if button1Font != nil			{	wholeButton1Action.titleAttributes += [
				StringAttribute(key: .font, value: button1Font!)
				]
				/*button1Attr?.updateValue(button1Font, forKey: .font)*/				}
			if button1Color != nil			{	wholeButton1Action.titleAttributes += [
				StringAttribute(key: .foregroundColor, value: button1Color!)
				]
				/*button1Attr?.updateValue(button1Color, forKey: .foregroundColor)*/	}
//			if button1BackgroundColor != nil	{	button1Attr?.updateValue(button1BackgroundColor, forKey: .backgroundColor)	}
//			if button1Attr != nil
//			{
//				let button1String = 		NSAttributedString(string: button1Title ?? "OK", attributes: button1Attr! as Any as? [NSAttributedStringKey : Any])
//				alertController.setValue(button1String, forKey: "attributedButton1")
//				WholeButton1Action.setValue(button1String, forKey: "attributedTitle")
//			}
			alertController.addAction(wholeButton1Action)
		}
		if hasButton2
		{
//			if button2Color != nil			{	alertController.view.shadowColor = button2Color!					}
			let wholeButton2Action = 		UIAlertAction(title: button2Title ?? "Cancel", style: button2Style!)
			{
				(action) in
				
//				alertController.dismiss(animated: false, completion: nil)
				if backgroundBackgroundColor != nil								{	coloredBG.removeFromSuperview()		}
				if backgroundBlurFactor != nil || backgroundBlurStyle != nil	{	blurFxView.removeFromSuperview()	}
				if button2Action != nil											{	return _ = button2Action			}
			}
//			var button2Attr: 				[NSAttributedStringKey : Any?]? = [:]
//			if button2Font != nil			{	button2Attr?.updateValue(button2Font, forKey: .font)				}
//			if button2Color != nil			{	button2Attr?.updateValue(button2Color, forKey: .foregroundColor)	}
			//			if button2BackgroundColor != nil	{	button2Attr?.updateValue(button2BackgroundColor, forKey: .backgroundColor)	}
			if button2Font != nil			{	wholeButton2Action.titleAttributes += [
				StringAttribute(key: .font, value: button2Font!)				]	}
			if button2Color != nil			{	wholeButton2Action.titleAttributes += [
				StringAttribute(key: .foregroundColor, value: button2Color!)	]	}
//			if button2Attr != nil
//			{
//				let button2String = 		NSAttributedString(string: button2Title ?? "Cancel", attributes: button2Attr! as Any as? [NSAttributedStringKey : Any])
//				alertController.setValue(button2String, forKey: "attributedButton2")
//			}
			alertController.addAction(wholeButton2Action)
		}
		if shadowColor != nil				{	alertController.view.shadowColor = shadowColor!					}
		if shadowOffset != nil				{	alertController.view.shadowOffset = shadowOffset!				}
		if shadowOpacity != nil				{	alertController.view.shadowOpacity = shadowOpacity!				}
		if shadowRadius != nil				{	alertController.view.shadowRadius = shadowRadius!				}
		if cornerRadius != nil				{	alertController.view.cornerRadius = cornerRadius!				}
		if dialogBackgroundColor != nil		{	alertController.view.backgroundColor = dialogBackgroundColor	}
		if borderWidth != nil				{	alertController.view.borderWidth = borderWidth!					}
		if borderColor != nil				{	alertController.view.borderColor = borderColor!					}
		if cornerRadius != nil				{	alertController.view.cornerRadius = cornerRadius!				}
		if alpha != nil						{	alertController.view.alpha = alpha!								}
//		if buttonsColor != nil				{	alertController.view.tintColor = buttonsColor!					}
		if backgroundBackgroundColor != nil
		{
			coloredBG.backgroundColor = 	backgroundBackgroundColor
			coloredBG.alpha = 				0.6
			coloredBG.frame = 				fromView.view.bounds
			fromView.view.addSubview(coloredBG)
		}
		if backgroundBlurFactor != nil || backgroundBlurStyle != nil
		{
			blurFxView.frame = 				fromView.view.bounds
			blurFxView.alpha = 				backgroundBlurFactor!
			blurFxView.autoresizingMask = 	[.flexibleWidth, .flexibleHeight]
			fromView.view.addSubview(blurFxView)
		}
		DispatchQueue.main.async {
			fromView.present(alertController, animated: true, completion: {() -> Void in
			})
		}
	}

}
