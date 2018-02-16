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
	fileprivate init() {}

	var customer: [Customer] = []
	var addresses: [Addresses] = []
	
	
	func getCustomerDetails(from: String, completion: @escaping (Customer) -> Void)
	{
		PSWebServices.getCustomer(from: from, completionHandler:
			{
				(customer) in
				
				self.customer.append(customer)
				completion(customer)
			}
		)
	}
	
	func callGetCustomerDetails(from: String, completion: @escaping (Customer) -> Void)
	{
		self.getCustomerDetails(from: from, completion:
			{
				(customer) in
				
				self.customer.append(customer)
				OperationQueue.main.addOperation
					{
						completion(customer)
					}
			}
		)
	}
	
	func getAddressesDetails(id_customer: Int, completion: @escaping (Addresses) -> Void)
	{
		PSWebServices.getAddresses(id_customer: id_customer, completionHandler:
			{
				(addresses) in
				
				self.addresses.append(addresses)
				completion(addresses)
			}
		)
	}
	
	func callGetAddressesDetails(id_customer: Int, completion: @escaping (Addresses) -> Void)
	{
		PSWebServices.getAddresses(id_customer: id_customer, completionHandler:
			{
				(addresses) in
				
				self.addresses.append(addresses)
				OperationQueue.main.addOperation
					{
						completion(addresses)
					}
			}
		)
	}
	

	func get(from: String, completion: @escaping (Customer) -> Void)
	{
		getCustomerDetails(from: from, completion:
			{cust in
				OperationQueue.main.addOperation {
					completion(cust)
				}
		})
	}
	

	func formatAddress(_ address: Address) -> String
	{
		var formed = ""
		if address.company != nil && address.company != ""
		{
			formed.append("\(address.company!)\n")
		}
		if address.firstname != nil && address.firstname != ""
		{
			formed.append("\(address.firstname!) ")
		}
		if address.lastname != nil && address.lastname != ""
		{
			formed.append(address.lastname!)
		}
		if address.firstname != nil && address.firstname != "" || address.lastname != nil && address.lastname != ""
		{
			formed.append("\n")
		}
		if address.address1 != nil && address.address1 != ""
		{
			formed.append("\(address.address1!)\n")
		}
		if address.address2 != nil && address.address2 != ""
		{
			formed.append("\(address.address2!)\n")
		}
		if address.city != nil && address.city != ""
		{
			formed.append("\(address.city!)\n")
		}
		if address.postcode != nil && address.postcode != ""
		{
			formed.append(address.postcode!)
		}
		if address.id_state != nil && address.id_state != ""
		{
			formed.append(address.id_state!)
		}
		if address.postcode != nil && address.postcode != "" || address.id_state != nil && address.id_state != ""
		{
			formed.append("\n")
		}
		if address.id_country != nil && address.id_country != ""
		{
			formed.append("\(address.id_country!)\n")
		}
		return formed
	}
	
}
