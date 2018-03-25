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

	var customer: Customer?
	var addresses: [Address] = []
	var products: [aProduct] = []
	var printers: [aProduct] = []
	var laptops: [aProduct] = []
	var toners: [aProduct] = []
	var services: [aProduct] = []
	var carriers: [Carrier] = []
	var states: [CountryState] = []
	var countries: [Country] = []
	var orderStates: [OrderState] = []
	var orders: [Orders] = []
	var myOrderRows: [OrderRow] = []
	var myCartRows: [CartRow] = []
	var myOrder: [Orders] = []
	var myCart: [Carts] = []
	var orderDetails: [OrderDetail] = []
	var carts: [Carts] = []
	var langs: [Language] = []
	var manufacturers: [Manufacturer] = []
	var categories: [aCategory] = []
	var combinations: [Combination] = []
	var currencies: [Currency] = []
	var locale = "en_CA"
	var taxes: [Tax] = []
	var tags: [myTag] = []
	var shares: [ScoialMedia] = []
	var productOptionValues: [ProductOptionValue] = []
	var myLang: Int = 0
	var forceRefresh = false
	var productOptions: [ProductOption] = []
	
	
	func initShares()
	{
		self.shares.append(ScoialMedia(id: 0, name: [IdValue(id: "0", value: "Share")]))
		self.shares.append(ScoialMedia(id: 1, name: [IdValue(id: "0", value: "Facebook")], link: "https://www.facebook.com/sharer.php?u=%prodUrl%", thumb: "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPCEtLSBHZW5lcmF0b3I6IEFkb2JlIElsbHVzdHJhdG9yIDE5LjEuMSwgU1ZHIEV4cG9ydCBQbHVnLUluIC4gU1ZHIFZlcnNpb246IDYuMDAgQnVpbGQgMCkgIC0tPgo8c3ZnIHZlcnNpb249IjEuMSIgaWQ9IkNhbHF1ZV8xIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB4PSIwcHgiIHk9IjBweCIKCSB3aWR0aD0iNDBweCIgaGVpZ2h0PSI0MHB4IiB2aWV3Qm94PSIwIDAgNDAgNDAiIGVuYWJsZS1iYWNrZ3JvdW5kPSJuZXcgMCAwIDQwIDQwIiB4bWw6c3BhY2U9InByZXNlcnZlIj4KPGc+Cgk8aW1hZ2Ugb3ZlcmZsb3c9InZpc2libGUiIG9wYWNpdHk9IjAuMSIgd2lkdGg9IjI2IiBoZWlnaHQ9IjQyIiB4bGluazpocmVmPSJENzk1Q0EyOS5wbmciICB0cmFuc2Zvcm09Im1hdHJpeCgxIDAgMCAxIDggMCkiPgoJPC9pbWFnZT4KCTxnPgoJCTxwYXRoIGZpbGw9IiNhY2FhYTYiIGQ9Ik0yMi4yLDI3LjJ2LTcuMmgyYzEuNSwwLDIsMCwyLTAuMWMwLTAuMSwwLjEtMSwwLjItMi4xYzAuMS0xLjEsMC4yLTIuMiwwLjItMi40bDAtMC40bC0yLjIsMGwtMi4yLDAKCQkJbDAtMS42YzAtMC45LDAuMS0xLjgsMC4yLTEuOWMwLjItMC41LDAuNy0wLjcsMi42LTAuN2gxLjdWOC4zVjUuOEgyNGMtMywwLTMuOCwwLjEtNSwwLjdjLTAuOCwwLjQtMS42LDEuMi0yLDEuOQoJCQljLTAuNSwxLjEtMC43LDEuOC0wLjcsNC4zTDE2LjIsMTVoLTEuNWgtMS41djIuNXYyLjVoMS41aDEuNXY3LjJ2Ny4yaDNoM1YyNy4yeiIvPgoJPC9nPgo8L2c+Cjwvc3ZnPgo="))
		self.shares.append(ScoialMedia(id: 2, name: [IdValue(id: "0", value: "Twitter")], link: "https://twitter.com/intent/tweet?text=%ProdName%2BprodUrl%", thumb: "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPCEtLSBHZW5lcmF0b3I6IEFkb2JlIElsbHVzdHJhdG9yIDE5LjEuMSwgU1ZHIEV4cG9ydCBQbHVnLUluIC4gU1ZHIFZlcnNpb246IDYuMDAgQnVpbGQgMCkgIC0tPgo8c3ZnIHZlcnNpb249IjEuMSIgaWQ9IkNhbHF1ZV8xIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB4PSIwcHgiIHk9IjBweCIKCSB3aWR0aD0iNDBweCIgaGVpZ2h0PSI0MHB4IiB2aWV3Qm94PSIwIDAgNDAgNDAiIGVuYWJsZS1iYWNrZ3JvdW5kPSJuZXcgMCAwIDQwIDQwIiB4bWw6c3BhY2U9InByZXNlcnZlIj4KPGc+Cgk8aW1hZ2Ugb3ZlcmZsb3c9InZpc2libGUiIG9wYWNpdHk9IjAuMSIgd2lkdGg9IjQyIiBoZWlnaHQ9IjM2IiB4bGluazpocmVmPSI0M0Q2OUZCMS5wbmciICB0cmFuc2Zvcm09Im1hdHJpeCgxIDAgMCAxIDEgMykiPgoJPC9pbWFnZT4KCTxnPgoJCTxwYXRoIGZpbGw9IiNhY2FhYTYiIGQ9Ik0yNS43LDhMMjUuNyw4bDAuNywwaDAuN2wwLjUsMC4xYzAuMywwLjEsMC42LDAuMiwwLjksMC4zczAuNSwwLjIsMC44LDAuNEMyOS42LDguOSwyOS44LDksMzAsOS4yCgkJCWMwLjIsMC4xLDAuNCwwLjMsMC42LDAuNWMwLjIsMC4yLDAuNCwwLjIsMC44LDAuMWMwLjMtMC4xLDAuNy0wLjIsMS4xLTAuM2MwLjQtMC4xLDAuOC0wLjMsMS4yLTAuNWMwLjQtMC4yLDAuNi0wLjMsMC43LTAuMwoJCQljMC4xLDAsMC4xLTAuMSwwLjEtMC4xbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwYzAsMCwwLDAuMSwwLDAuMQoJCQlTMzQuNSw5LDM0LjMsOS4zcy0wLjQsMC42LTAuNiwwLjljLTAuMiwwLjMtMC41LDAuNi0wLjYsMC43Yy0wLjIsMC4yLTAuMywwLjMtMC40LDAuM2MtMC4xLDAuMS0wLjEsMC4xLTAuMiwwLjJsLTAuMSwwLjFsMCwwbDAsMAoJCQlsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGgwLjFoMC4xbDAuNy0wLjJjMC41LTAuMSwxLTAuMiwxLjQtMC40YzAuNS0wLjIsMC43LTAuMiwwLjctMC4yCgkJCWMwLDAsMC4xLDAsMC4xLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLjEsMGwwLjEsMHYwdjBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDAKCQkJYzAsMC0wLjEsMC4yLTAuMywwLjVjLTAuMiwwLjMtMC4zLDAuNC0wLjQsMC41YzAsMCwwLDAtMC4xLDAuMWMwLDAtMC4yLDAuMi0wLjYsMC42Yy0wLjMsMC4zLTAuNywwLjctMSwwLjkKCQkJYy0wLjMsMC4zLTAuNSwwLjYtMC41LDFjMCwwLjQsMCwwLjgtMC4xLDEuM2MwLDAuNS0wLjEsMS0wLjIsMS42Yy0wLjEsMC42LTAuMiwxLjItMC41LDJjLTAuMiwwLjctMC41LDEuNC0wLjcsMi4xCgkJCWMtMC4zLDAuNy0wLjYsMS4zLTAuOSwxLjlzLTAuNiwxLTAuOSwxLjRjLTAuMywwLjQtMC41LDAuNy0wLjgsMS4xYy0wLjMsMC4zLTAuNiwwLjctMSwxLjFjLTAuNCwwLjQtMC43LDAuNi0wLjcsMC43CgkJCWMwLDAtMC4yLDAuMi0wLjUsMC40Yy0wLjMsMC4zLTAuNiwwLjUtMSwwLjhjLTAuMywwLjMtMC43LDAuNS0xLDAuNmMtMC4zLDAuMi0wLjYsMC40LTEuMSwwLjZjLTAuNCwwLjItMC45LDAuNC0xLjMsMC42CgkJCWMtMC41LDAuMi0xLDAuNC0xLjUsMC41Yy0wLjUsMC4yLTEsMC4zLTEuNSwwLjRjLTAuNSwwLjEtMS4xLDAuMi0xLjcsMC4ybC0wLjksMC4xdjB2MGgtMC45aC0wLjl2MHYwbC0wLjIsMGMtMC4yLDAtMC4zLDAtMC40LDAKCQkJcy0wLjUtMC4xLTEuMS0wLjFjLTAuNi0wLjEtMS4xLTAuMi0xLjUtMC4zcy0wLjktMC4zLTEuNi0wLjVjLTAuNy0wLjItMS4zLTAuNS0xLjgtMC44Yy0wLjUtMC4zLTAuOC0wLjQtMS0wLjUKCQkJYy0wLjEtMC4xLTAuMy0wLjEtMC40LTAuMmwtMC4yLTAuMWwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGgwaDB2MHYwbDAsMGwwLDBsMC4xLDBjMC4xLDAsMC4zLDAsMC43LDAKCQkJczAuNywwLDEuMSwwczAuOC0wLjEsMS4yLTAuMWMwLjQtMC4xLDAuOS0wLjIsMS41LTAuM2MwLjYtMC4yLDEuMS0wLjMsMS42LTAuNWMwLjUtMC4yLDAuOC0wLjQsMS0wLjVjMC4yLTAuMSwwLjUtMC4zLDAuOS0wLjYKCQkJbDAuNi0wLjRsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwtMC4yLDBjLTAuMSwwLTAuMywwLTAuNCwwcy0wLjMsMC0wLjYtMC4xCgkJCWMtMC4zLTAuMS0wLjYtMC4yLTAuOS0wLjNjLTAuMy0wLjEtMC42LTAuMy0xLTAuNXMtMC41LTAuNC0wLjctMC41Yy0wLjEtMC4xLTAuMy0wLjMtMC41LTAuNWMtMC4yLTAuMi0wLjQtMC41LTAuNi0wLjcKCQkJYy0wLjItMC4yLTAuMy0wLjUtMC41LTAuOWwtMC4yLTAuNWwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLjMsMGMwLjIsMCwwLjUsMCwwLjksMHMwLjcsMCwwLjktMC4xYzAuMiwwLDAuMywwLDAuMy0wLjFsMC4xLDAKCQkJbDAuMSwwbDAuMSwwbDAsMGwwLDBsMCwwbDAsMGwtMC4xLDBsLTAuMSwwbC0wLjEsMGwtMC4xLDBsLTAuMSwwYzAsMC0wLjEsMC0wLjItMC4xcy0wLjMtMC4xLTAuNy0wLjNjLTAuNC0wLjItMC43LTAuMy0wLjktMC41CgkJCWMtMC4yLTAuMi0wLjQtMC4zLTAuNy0wLjVjLTAuMi0wLjItMC40LTAuNC0wLjctMC43Yy0wLjItMC4zLTAuNS0wLjctMC43LTFjLTAuMi0wLjQtMC4zLTAuOC0wLjQtMS4xYy0wLjEtMC40LTAuMi0wLjctMC4yLTEuMQoJCQlsMC0wLjZsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMC40LDAuMmMwLjMsMC4xLDAuNiwwLjIsMSwwLjNzMC43LDAuMSwwLjcsMC4xbDAuMSwwaDAuMWgwLjFsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMAoJCQlsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBjMCwwLTAuMS0wLjEtMC4yLTAuMmMtMC4xLTAuMS0wLjMtMC4zLTAuNS0wLjRjLTAuMi0wLjItMC4zLTAuNC0wLjUtMC42cy0wLjMtMC40LTAuNC0wLjYKCQkJQzgsMTUsNy44LDE0LjcsNy43LDE0LjRjLTAuMS0wLjMtMC4yLTAuNy0wLjMtMWMtMC4xLTAuMy0wLjEtMC43LTAuMS0xYzAtMC4zLDAtMC42LDAtMC45YzAtMC4yLDAuMS0wLjUsMC4yLTAuOHMwLjItMC42LDAuMy0xCgkJCUw4LDkuMmwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLDBsMCwwbDAsMGwwLjQsMC40YzAuMiwwLjMsMC41LDAuNiwwLjgsMC45CgkJCUM5LjcsMTAuOCw5LjksMTEsOS45LDExYzAsMCwwLjEsMC4xLDAuMSwwLjFjMC4xLDAuMSwwLjIsMC4yLDAuNSwwLjVjMC4zLDAuMiwwLjcsMC41LDEuMiwwLjlzMSwwLjcsMS42LDEKCQkJYzAuNiwwLjMsMS4yLDAuNiwxLjksMC45YzAuNywwLjMsMS4yLDAuNCwxLjQsMC41YzAuMywwLjEsMC43LDAuMiwxLjQsMC4zYzAuNywwLjEsMS4yLDAuMiwxLjUsMC4yczAuNiwwLjEsMC43LDAuMWwwLjIsMGwwLDAKCQkJbDAsMEwyMC40LDE1YzAtMC4yLTAuMS0wLjUtMC4xLTAuOXMwLTAuOCwwLjEtMS4xYzAuMS0wLjMsMC4yLTAuNywwLjMtMWMwLjEtMC4zLDAuMi0wLjYsMC40LTAuOGMwLjEtMC4yLDAuMy0wLjQsMC41LTAuNwoJCQljMC4yLTAuMywwLjQtMC41LDAuOC0wLjhjMC4zLTAuMywwLjctMC41LDEuMS0wLjhjMC40LTAuMiwwLjgtMC40LDEuMS0wLjVjMC4zLTAuMSwwLjYtMC4yLDAuOC0wLjJTMjUuNyw4LDI1LjcsOHoiLz4KCTwvZz4KPC9nPgo8L3N2Zz4K"))
		self.shares.append(ScoialMedia(id: 3, name: [IdValue(id: "0", value: "Google+")], link: "https://plus.google.com/share?url=%prodUrl%", thumb: "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPCEtLSBHZW5lcmF0b3I6IEFkb2JlIElsbHVzdHJhdG9yIDE5LjEuMSwgU1ZHIEV4cG9ydCBQbHVnLUluIC4gU1ZHIFZlcnNpb246IDYuMDAgQnVpbGQgMCkgIC0tPgo8c3ZnIHZlcnNpb249IjEuMSIgaWQ9IkNhbHF1ZV8xIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB4PSIwcHgiIHk9IjBweCIKCSB3aWR0aD0iNDBweCIgaGVpZ2h0PSI0MHB4IiB2aWV3Qm94PSIwIDAgNDAgNDAiIGVuYWJsZS1iYWNrZ3JvdW5kPSJuZXcgMCAwIDQwIDQwIiB4bWw6c3BhY2U9InByZXNlcnZlIj4KPGc+Cgk8aW1hZ2Ugb3ZlcmZsb3c9InZpc2libGUiIG9wYWNpdHk9IjAuMSIgd2lkdGg9IjQ2IiBoZWlnaHQ9IjM0IiB4bGluazpocmVmPSJDRTYxRDA0Qi5wbmciICB0cmFuc2Zvcm09Im1hdHJpeCgxIDAgMCAxIC0yIDQpIj4KCTwvaW1hZ2U+Cgk8Zz4KCQk8Zz4KCQkJPHBhdGggZmlsbD0iI2FjYWFhNiIgZD0iTTE0LDE4LjF2NC4yYzAsMCw0LDAsNS43LDBjLTAuOSwyLjctMi4zLDQuMi01LjcsNC4yYy0zLjQsMC02LjEtMi44LTYuMS02LjJTMTAuNSwxNCwxNCwxNAoJCQkJYzEuOCwwLDMsMC42LDQuMSwxLjVjMC45LTAuOSwwLjgtMSwzLTMuMWMtMS45LTEuNy00LjMtMi43LTcuMS0yLjdjLTUuOCwwLTEwLjUsNC43LTEwLjUsMTAuNUMzLjUsMjYsOC4yLDMwLjcsMTQsMzAuNwoJCQkJYzguNywwLDEwLjgtNy41LDEwLjEtMTIuNkMyMiwxOC4xLDE0LDE4LjEsMTQsMTguMXogTTMyLjksMTguNHYtMy42aC0yLjZ2My42aC0zLjd2Mi42aDMuN3YzLjdoMi42di0zLjdoMy42di0yLjZIMzIuOXoiLz4KCQk8L2c+Cgk8L2c+CjwvZz4KPC9zdmc+Cg=="))
		self.shares.append(ScoialMedia(id: 4, name: [IdValue(id: "0", value: "Pinerest")], link: "https://www.pinerest.com/pin/create/button/?media=%prodImage%&url=%prodUrl%", thumb: "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPCEtLSBHZW5lcmF0b3I6IEFkb2JlIElsbHVzdHJhdG9yIDE5LjEuMSwgU1ZHIEV4cG9ydCBQbHVnLUluIC4gU1ZHIFZlcnNpb246IDYuMDAgQnVpbGQgMCkgIC0tPgo8c3ZnIHZlcnNpb249IjEuMSIgaWQ9IkNhbHF1ZV8xIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB4PSIwcHgiIHk9IjBweCIKCSB3aWR0aD0iNDBweCIgaGVpZ2h0PSI0MHB4IiB2aWV3Qm94PSIwIDAgNDAgNDAiIGVuYWJsZS1iYWNrZ3JvdW5kPSJuZXcgMCAwIDQwIDQwIiB4bWw6c3BhY2U9InByZXNlcnZlIj4KPGc+Cgk8aW1hZ2Ugb3ZlcmZsb3c9InZpc2libGUiIG9wYWNpdHk9IjAuMSIgd2lkdGg9IjM4IiBoZWlnaHQ9IjQ2IiB4bGluazpocmVmPSI4REY2NkQ0Qi5wbmciICB0cmFuc2Zvcm09Im1hdHJpeCgxIDAgMCAxIDIgLTEpIj4KCTwvaW1hZ2U+Cgk8Zz4KCQk8Zz4KCQkJPHBhdGggZmlsbD0iI2FjYWFhNiIgZD0iTTE4LjcsNS4xQzEzLjQsNS42LDguMSwxMCw3LjgsMTYuMWMtMC4xLDMuOCwwLjksNi42LDQuNSw3LjRjMS42LTIuNy0wLjUtMy4zLTAuOC01LjMKCQkJCWMtMS4zLTguMSw5LjQtMTMuNywxNS04YzMuOSwzLjksMS4zLDE2LTQuOSwxNC44Yy02LTEuMiwyLjktMTAuOC0xLjgtMTIuN2MtMy45LTEuNS01LjksNC43LTQuMSw3LjhjLTEuMSw1LjMtMy40LDEwLjMtMi41LDE3CgkJCQljMy4xLTIuMiw0LjEtNi41LDQuOS0xMC45YzEuNSwwLjksMi40LDEuOSw0LjMsMi4xYzcuMiwwLjYsMTEuMi03LjIsMTAuMy0xNC40QzMxLjgsNy41LDI1LjUsNC4zLDE4LjcsNS4xeiIvPgoJCTwvZz4KCTwvZz4KPC9nPgo8L3N2Zz4K"))
	}
	
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
	
	func callGetCarriers(completion: @escaping ([Carrier]?, Error?) -> Void)
	{
		let url = "\(R.string.WSbase)/carriers"
		let myUrl = "\(url)?\(R.string.APIfull)&\(R.string.APIjson)&\(R.string.API_key)"
		PSWebServices.getCarriers(from: myUrl, /*to: CarrierList.self,*/ completionHandler:
			{
				(object, err) in//)(dataStr, object) in
				
				let dataStr = UserDefaults.standard.string(forKey: "Carriers")
				let tempCarr: String = self.trimJSONValueToArray(string: dataStr!)
				let tempObj: [Carrier]
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
	
	func callGetCarts(id_customer: Int, completion: @escaping ([Carts]?, Error?) -> Void)
	{
		PSWebServices.getCarts(id_customer: id_customer, completionHandler:
			{
				(object, err) in//)(dataStr, object) in
				
				let dataStr = UserDefaults.standard.string(forKey: "CartsCustomer\(id_customer)")
				let tempCarr: String = self.trimJSONValueToArray(string: dataStr!)
				let tempObj: [Carts]
				do
				{
					tempObj = try JSONDecoder().decode([Carts].self, from: tempCarr.data(using: .utf8)!)
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
		)
	}

	
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
	
	func parse(JSON json: String) throws -> [String]?
	{
		guard let data = json.data(using: .utf8) else { 	return nil 	}
		
		guard let rootArray = try JSONSerialization.jsonObject(with: data, options : []) as? [[String: Any]]
			else { return nil }
		
		return rootArray
			.filter{ $0["success"] as? Int == 1}
			.map{ $0["nama_produk"] as! String }
	}

	func callGetCountries(completion: @escaping (Any) -> Void)
	{
		PSWebServices.getCountries(completionHandler:
			{
				(countries) in
				
				self.countries = countries
				completion(countries)
			}
		)
	}

	func callGetStates(id_country: Int, completion: @escaping (Any) -> Void)
	{
		PSWebServices.getStates(id_country: id_country, completionHandler:
			{
				(states) in
				
				self.states = states
				completion(states)
			}
		)
	}

	func getOrders(id_customer: Int, completion: @escaping (Any?, Error?) -> Void)
	{
		PSWebServices.getOrders(id_customer: id_customer, completionHandler:
			{
				(result, err) in
				
				if err != nil	//if has error
				{
					let dataStr = UserDefaults.standard.string(forKey: "OrdersCustomer\(id_customer)")
					let tempCarr: String = self.trimJSONValueToArray(string: dataStr!)
					let tempObj: [Orders]
					do
					{
						tempObj = try JSONDecoder().decode([Orders].self, from: tempCarr.data(using: .utf8)!)
						for ords in tempObj
						{
							self.orders.append(ords)
						}
						OperationQueue.main.addOperation
							{
								completion(tempObj, nil)
							}
					}
					catch let jsonErr
					{
						print(jsonErr)
						OperationQueue.main.addOperation
							{
								completion(nil, jsonErr)
							}
					}
				}
				else
				{
					OperationQueue.main.addOperation
						{
							completion(result, nil)
						}
				}
			}
		)
	}

	func getOrderDetails(id_order: Int, completion: @escaping (Any?, Error?) -> Void)
	{
		PSWebServices.getOrderDetails(id_order: id_order, completionHandler:
			{
				(result, err) in
				
				if err != nil	//if has error
				{
					let dataStr = UserDefaults.standard.string(forKey: "OrderDetailsOrder\(id_order)")
					let tempCarr: String = self.trimJSONValueToArray(string: dataStr!)
					let tempObj: [OrderDetail]
					do
					{
						tempObj = try JSONDecoder().decode([OrderDetail].self, from: tempCarr.data(using: .utf8)!)
						for ords in tempObj
						{
							self.orderDetails.append(ords)
						}
						OperationQueue.main.addOperation
							{
								completion(tempObj, nil)
						}
					}
					catch let jsonErr
					{
						print(jsonErr)
						OperationQueue.main.addOperation
							{
								completion(nil, jsonErr)
						}
					}
				}
				else
				{
					if let result = result
					{
//						let dataStr = String(data: result, encoding: .utf8)
//						UserDefaults.standard.set(dataStr, forKey: "Order\(id_order)Details")
						let array = result.orderDetails
						OperationQueue.main.addOperation
							{
								//completion(result, nil)
								completion(array, nil)
							}
					}
				}
			}
		)
	}

	func getOrderStates(completion: @escaping (Any?, Error?) -> Void)
	{
		PSWebServices.getOrderStates(completionHandler:
			{
				(states, err) in
				
				if err != nil	//only if error
				{
					let dataStr = UserDefaults.standard.string(forKey: "OrderStates")
					let tempCarr: String = self.trimJSONValueToArray(string: dataStr!)
					let tempObj: [OrderState]	//^remove wrapper - use inner array
					do
					{
						tempObj = try JSONDecoder().decode([OrderState].self, from: tempCarr.data(using: .utf8)!)
//						let array = tempObj.order_states
//						for os in array!
						for os in tempObj
						{
							self.orderStates.append(os)
						}
						OperationQueue.main.addOperation
							{
								completion(tempObj, nil)
							}
					}
					catch let jsonErr
					{
						print(jsonErr)
						OperationQueue.main.addOperation
							{
								completion(nil, jsonErr)
							}
					}
				}
				else
				{
					OperationQueue.main.addOperation
						{
							completion(states, nil)
						}
				}
			}
		)
	}
	
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

	func callGetPrinters(completion: @escaping (Any) -> Void)
	{
		PSWebServices.getPrinters(completionHandler:
			{
				(printers) in
				
				self.printers = printers
				self.products = printers
				completion(printers)
			}
		)
	}

	func callGetLaptops(completion: @escaping (Any) -> Void)
	{
		PSWebServices.getLaptops(completionHandler:
			{
				(laptops) in
				
				self.laptops = laptops
				self.products = laptops
				completion(laptops)
			}
		)
	}
	
	func callGetServices(completion: @escaping (Any) -> Void)
	{
		PSWebServices.getServices(completionHandler:
			{
				(services) in
				
				self.services = services
				self.products = services
				completion(services)
			}
		)
	}
	
	func callGetToners(completion: @escaping (Any) -> Void)
	{
		PSWebServices.getToners(completionHandler:
			{
				(toners) in
				
				self.toners = toners
				self.products = toners
				completion(toners)
			}
		)
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
					//return
				}
				if let httpResponse = response as? HTTPURLResponse
				{
					switch(httpResponse.statusCode)
					{
					case 200:
						guard let data = data else
						{
							return
						}
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
	
	
	//common methods
	func alertMessage(sender: Any, alerttitle: String, _ message: String)
	{
		let alertViewController = UIAlertController(title: alerttitle, message: message, preferredStyle: .alert)
		alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		let vc = sender as! UIViewController
		vc.present(alertViewController, animated: true, completion: nil)
	}
	
	
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
	
	
	func flexView(view: UIView)
	{
		view.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
		UIView.animate(withDuration: 1.0,
					   delay: 0,
					   usingSpringWithDamping: CGFloat(0.20),
					   initialSpringVelocity: CGFloat(6.0),
					   options: UIViewAnimationOptions.allowUserInteraction,
					   animations: {
							view.transform = CGAffineTransform.identity
		},
					   completion: { Void in()  }
		)
	}

	
	func trimJSONValueToArray(string: String) -> String
	{
		let pos1 = string.indexOf("[")
		let pos2 = string.lastIndexOf("]")!+1
		//print("pos1: \(pos1), pos2: \(pos2)\nin \(string)")
		let start = string.index(string.startIndex, offsetBy: pos1)
		let end = string.index(string.startIndex, offsetBy: pos2)
		let sub = string[start..<end]
		//print(sub)
		return String(sub)
	}
	
//	func getSymbolForCurrencyCode(code: String) -> String?
//	{
//		let locale = NSLocale(localeIdentifier: code)
//		if locale.displayName(forKey: .currencySymbol, value: code) == code
//		{
//			let newlocale = NSLocale(localeIdentifier: code.characters.dropLast() + "_en")
//			return newlocale.displayName(forKey: .currencySymbol, value: code)
//		}
//		return locale.displayName(forKey: .currencySymbol, value: code)
//	}
	
	func formatCurrency(amount: NSNumber, iso/*lang_country*/: String? = "en_CA") -> String
	{
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.locale = Locale(identifier: iso!)
		return formatter.string(from: amount)!
	}

}


extension URLResponse
{
	func getStatusCode() -> Int?
	{
		if let httpResponse = self as? HTTPURLResponse
		{
			return httpResponse.statusCode
		}
		return nil
	}
}
