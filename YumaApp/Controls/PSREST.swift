//
//  MovieFeed.swift
//  ProtocolBasedNetworkingTutorialStarter
//
//  Created by Yuma Usa on 2018-03-18.
//  Copyright © 2018 James Rochabrun. All rights reserved.
//

import Foundation


//raw type = String
//enum Airport: String {
//	case munich = "MUC"//"MUC is raw value
//	case sanFrancisco = "SFO"
//	case singapore = "SIN"
//	case london(airportName: LondonAirportName) = "LON"
//}
//enum Airport//: String
//{
//	case munich //= "MUC"//raw values
//	case sanFrancisco //= "SFO"
//	case singapore //= "SIN"
//	case london(airportName: LondonAirportName)
//}
//enum LondonAirportName {
//	case stansted
//	case heathrow
//	case gatwick
//}

//enum Filter
//{
//	case addresses_filter
//}
enum Resource//: String//, CodingKey
{
	//typealias RawValue = String
	
//	case addresses(id, idCustomer, idManufacturer, idSupplier, idWarehouse, idCountry, idState/*...*/)
	case addresses(filters: [Addresses_filter : String]?) //= "addresses"
	case carriers
	case cartRules //= 						"cart_rules"
	case carts(filters: [Carts_filter : String]?)
	case categories
	case combinations
	case configurations
	case contacts
	case contentManagementSystem //= 		"content_management_system"
	case countries
	case currencies
	case customerMessages //= 				"customer_messages"
	case customerThreads //= 				"customer_threads"
	case customers
	case customizations
	case deliveries
	case employees
	case groups
	case guests
	case imageTypes //= 					"image_types"
	case images
	case languages
	case manufacturers
	case messages
	case orderCarriers //= 					"order_carriers"
	case orderDetails //= 					"order_details"
	case orderHistories //= 				"order_histories"
	case orderInvoices //= 					"order_invoices"
	case orderPayments //= 					"order_payments"
	case orderSlip //=						"order_slip"
	case orderStates //= 					"order_states"
	case orders
	case priceRanges //= 					"price_ranges"
	case productCustomizationFields //= 	"product_customization_fields"
	case productFeatureValues //= 			"product_feature_values"
	case productFeatures //= 				"product_features"
	case productOptionValues //= 			"product_option_values"
	case productOptions //= 				"product_options"
	case productSuppliers //=	 			"product_suppliers"
	case products
	case search
	case shopGroups //= 					"shop_groups"
	case shopUrls //= 						"shop_urls"
	case shops
	case specificPriceRules //= 			"specific_price_rules"
	case specificPrices //= 				"specific_prices"
	case states
	case stockAvailables //= 				"stock_availables"
	case stockMovementReasons //= 			"stock_movement_reasons"
	case stockMovements //= 				"stock_movement"
	case stocks
	case stores
	case suppliers
	case supplyOrderDetails //= 			"supply_order_details"
	case supplyOrderHistories //= 			"supply_order_histories"
	case supplyOrderReceiptHistories //= 	"supply_order_receipt_histories"
	case supplyOrderStates //= 				"supply_order_states"
	case supplyOrders //= 					"supply_orders"
	case tags
	case taxRuleGroups //= 					"tax_rule_groups"
	case taxRules //= 						"tax_rules"
	case taxes
	case translatedConfigurations //= 		"translated_configurations"
	case warehouseProductLocations //= 		"warehouse_product_locations"
	case warehouses
	case weightRanges //= 					"weight_ranges"
	case zones

//	var filters: String
//	{
//		switch self
//		{
//		case .addresses: return "addresses"
//		case .carriers: return "carriers"
//		case .cartRules: return "cart_rules"
//		case .carts: return "carts"
//		case .categories: return "categories"
//		case .combinations: return "combinations"
//		case .configurations: return "configurations"
//		case .contacts: return "contacts"
//		case .contentManagementSystem: return "content_management_system"
//		case .countries: return "countries"
//		case .currencies: return "currencies"
//		case .customerMessages: return "customer_messages"
//		case .customerThreads: return "customer_threads"
//		case .customers: return "customers"
//		case .customizations: return "customizations"
//		case .deliveries: return "deliveries"
//		case .employees: return "employees"
//		case .groups: return "groups"
//		case .guests: return "guests"
//		case .imageTypes: return "image_types"
//		case .images: return "images"
//		case .languages: return "languages"
//		case .manufacturers: return "manufacturers"
//		case .messages: return "messages"
//		case .orderCarriers: return "order_carriers"
//		case .orderDetails: return "order_details"
//		case .orderHistories: return "order_histories"
//		case .orderInvoices: return "order_invoices"
//		case .orderPayments: return "order_payments"
//		case .orderSlip: return "order_slip"
//		case .orderStates: return "order_states"
//		case .orders: return "orders"
//		case .priceRanges: return "price_ranges"
//		case .productCustomizationFields: return "product_customization_fields"
//		case .productFeatureValues: return "product_feature_values"
//		case .productFeatures: return "product_features"
//		case .productOptionValues: return "product_option_values"
//		case .productOptions: return "product_options"
//		case .productSuppliers: return "product_suppliers"
//		case .products: return "products"
//		case .search: return "search"
//		case .shopGroups: return "shop_groups"
//		case .shopUrls: return "shop_urls"
//		case .shops: return "shops"
//		case .specificPriceRules: return "specific_price_rules"
//		case .specificPrices: return "specific_prices"
//		case .states: return "states"
//		case .stockAvailables: return "stock_availables"
//		case .stockMovementReasons: return "stock_movement_reasons"
//		case .stockMovements: return "stock_movements"
//		case .stocks: return "stocks"
//		case .stores: return "stores"
//		case .suppliers: return "suppliers"
//		case .supplyOrderDetails: return "supply_order_details"
//		case .supplyOrderHistories: return "supply_order_histories"
//		case .supplyOrderReceiptHistories: return "supply_order_receipt_histories"
//		case .supplyOrderStates: return "supply_order_states"
//		case .supplyOrders: return "supply_orders"
//		case .tags: return "tags"
//		case .taxRuleGroups: return "tax_rule_groups"
//		case .taxRules: return "tax_rules"
//		case .taxes: return "taxes"
//		case .translatedConfigurations: return "translated_configurations"
//		case .warehouseProductLocations: return "warehouse_product_locations"
//		case .warehouses: return "warehouses"
//		case .weightRanges: return "weight_ranges"
//		case .zones: return "zones"
//		}
//	}
}
enum Addresses_filter: String, CodingKey
{
	//typealias RawValue = String:
	
	case id
	case idCustomer = 		"id_customer"
	case idManufacturer = 	"id_manufacturer"
	case idSupplier = 		"id_supplier"
	case idWarehouse = 		"id_warehouse"
	case idCountry = 		"id_country"
	case idState = 			"id_state"
	case alias
	case company
	case lastname
	case firstname
	case vatNumber = 		"vat_number"
	case address1
	case address2
	case postcode
	case city
	case other
	case phone
	case phoneMobile = 		"phone_mobile"
	case dni
	case deleted
	case dateAdd = 			"date_add"
	case dateUpd = 			"date_upd"
}
enum Carts_filter: String, CodingKey
{
	case id
	case idAddressDelivery = 	"id_address_delivery"
	case idAddressInvoice = 	"id_address_invoice"
	//TO BE FINISHED...
}
//extension addresses_filter
//{
//	func buildUrl(resource: String, _ name: String?, _ values: String?) -> String
//	{
//		var output = ""
//		output.append(resource)
//		if name != nil && values != nil
//		{
//			output.append("?filter[\(name)]=[")
//			for value in values!
//			{
//				output.append(value)
//			}
//			output.append("]")
//		}
//		return output
//	}
//	var filter: String
//	{
//		switch self
//		{
//		case .id: return "filter[id]="
//		case .idCustomer: return "filter[id_customer]="
//		default:
//			return ""
//		}
//	}
//}
extension Resource: Endpoint
{
//	var extraParams: String
//	{
//		return "\(R.string.APIjson)&\(R.string.APIfull)"
//	}
//	
//	var filter: String
//	{
//		return ""
//	}
	
	var base: String
	{
		return R.string.WSbase
	}
//	
//	var extraParams: String
//	{
//		//
//	}
	
	var path: String
	{
		switch self
		{
		case .addresses(let array)://[member: String, values: String]):
			var str = "addresses?\(R.string.API_key)&"
			if array != nil
			{
				str.append("filter")
			}
			for member in array!
			{
				str.append("[\(member.key)]=[\(member.value)]&")
			}
			str.append("\(R.string.APIjson)&\(R.string.APIfull)")
			//print(str)
			return str
		case .carriers: return "carriers"
		case .cartRules: return "cart_rules"
		case .carts(let array)://[member: String, values: String]):
			var str = "carts?\(R.string.API_key)&"
			if array != nil
			{
				str.append("filter")
			}
			for member in array!
			{
				str.append("[\(member.key)]=[\(member.value)]&")
			}
			str.append("\(R.string.APIjson)&\(R.string.APIfull)")
			//print(str)
			return str
		case .categories: return "categories"
		case .combinations: return "combinations"
		case .configurations: return "configurations"
		case .contacts: return "contacts"
		case .contentManagementSystem: return "content_management_system"
		case .countries: return "countries"
		case .currencies: return "currencies"
		case .customerMessages: return "customer_messages"
		case .customerThreads: return "customer_threads"
		case .customers: return "customers"
		case .customizations: return "customizations"
		case .deliveries: return "deliveries"
		case .employees: return "employees"
		case .groups: return "groups"
		case .guests: return "guests"
		case .imageTypes: return "image_types"
		case .images: return "images"
		case .languages: return "languages"
		case .manufacturers: return "manufacturers"
		case .messages: return "messages"
		case .orderCarriers: return "order_carriers"
		case .orderDetails: return "order_details"
		case .orderHistories: return "order_histories"
		case .orderInvoices: return "order_invoices"
		case .orderPayments: return "order_payments"
		case .orderSlip: return "order_slip"
		case .orderStates: return "order_states"
		case .orders: return "orders"
		case .priceRanges: return "price_ranges"
		case .productCustomizationFields: return "product_customization_fields"
		case .productFeatureValues: return "product_feature_values"
		case .productFeatures: return "product_features"
		case .productOptionValues: return "product_option_values"
		case .productOptions: return "product_options"
		case .productSuppliers: return "product_suppliers"
		case .products: return "products"
		case .search: return "search"
		case .shopGroups: return "shop_groups"
		case .shopUrls: return "shop_urls"
		case .shops: return "shops"
		case .specificPriceRules: return "specific_price_rules"
		case .specificPrices: return "specific_prices"
		case .states: return "states"
		case .stockAvailables: return "stock_availables"
		case .stockMovementReasons: return "stock_movement_reasons"
		case .stockMovements: return "stock_movements"
		case .stocks: return "stocks"
		case .stores: return "stores"
		case .suppliers: return "suppliers"
		case .supplyOrderDetails: return "supply_order_details"
		case .supplyOrderHistories: return "supply_order_histories"
		case .supplyOrderReceiptHistories: return "supply_order_receipt_histories"
		case .supplyOrderStates: return "supply_order_states"
		case .supplyOrders: return "supply_orders"
		case .tags: return "tags"
		case .taxRuleGroups: return "tax_rule_groups"
		case .taxRules: return "tax_rules"
		case .taxes: return "taxes"
		case .translatedConfigurations: return "translated_configurations"
		case .warehouseProductLocations: return "warehouse_product_locations"
		case .warehouses: return "warehouses"
		case .weightRanges: return "weight_ranges"
		case .zones: return "zones"
		}
	}
}
//var resource: Resource = .addresses(filters: [Addresses_filter.idCustomer: "3"])
extension Dictionary where Key: ExpressibleByStringLiteral {
	subscript<Index: RawRepresentable>(index: Index) -> Value? where Index.RawValue == String {
		get {
			return self[index.rawValue as! Key]
		}
		
		set {
			self[index.rawValue as! Key] = newValue
		}
	}
}
