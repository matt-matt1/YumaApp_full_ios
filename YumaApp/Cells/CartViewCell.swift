//
//  CartViewCell.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-02.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class CartViewCell: UITableViewCell
{
	@IBOutlet weak var prodQtyBorder: UIView!
	@IBOutlet weak var prodQtyEdit: UITextField!
	@IBOutlet weak var prodTitle: UILabel!
	@IBOutlet weak var prodImage: UIImageView!
	var found = false

	
	func setup(_ object: OrderRow)
	{
		prodTitle.text = object.productName
		prodQtyEdit.text = object.productQuantity
		prodQtyEdit.keyboardType = .numberPad
		prodQtyEdit.returnKeyType = .done
		for i in 0..<DataStore.sharedInstance.products.count
		{
			if "\(DataStore.sharedInstance.products[i].id ?? 0)" == object.productId
			{
				let prod = DataStore.sharedInstance.products[i]
				let imgName = prod.associations?.images?[0].id
				var imageName = "\(R.string.URLbase)img/p"
				for ch in imgName!
				{
					imageName.append("/\(ch)")
				}
				imageName.append("/\(imgName ?? "").jpg")
				DataStore.sharedInstance.getImageFromUrl(url: URL(string: imageName)!, session: URLSession(configuration: .default), completion:
					{
						(data, response, error) in
						
						guard let data = data, error == nil else { return }
						DispatchQueue.main.async()
							{
								self.prodImage.image = UIImage(data: data)
							}
					}
				)
				found = true
				break
			}
		}
		if found == false
		{
			for i in 0..<DataStore.sharedInstance.printers.count
			{
				if "\(DataStore.sharedInstance.printers[i].id ?? 0)" == object.productId
				{
					let prod = DataStore.sharedInstance.printers[i]
					let imgName = prod.associations?.images?[0].id
					var imageName = "\(R.string.URLbase)img/p"
					for ch in imgName!
					{
						imageName.append("/\(ch)")
					}
					imageName.append("/\(imgName ?? "").jpg")
					DataStore.sharedInstance.getImageFromUrl(url: URL(string: imageName)!, session: URLSession(configuration: .default), completion:
						{
							(data, response, error) in
							
							guard let data = data, error == nil else { return }
							DispatchQueue.main.async()
								{
									self.prodImage.image = UIImage(data: data)
							}
						}
					)
					found = true
					break
				}
			}
		}
		if found == false
		{
			for i in 0..<DataStore.sharedInstance.laptops.count
			{
				if "\(DataStore.sharedInstance.laptops[i].id ?? 0)" == object.productId
				{
					let prod = DataStore.sharedInstance.laptops[i]
					let imgName = prod.associations?.images?[0].id
					var imageName = "\(R.string.URLbase)img/p"
					for ch in imgName!
					{
						imageName.append("/\(ch)")
					}
					imageName.append("/\(imgName ?? "").jpg")
					DataStore.sharedInstance.getImageFromUrl(url: URL(string: imageName)!, session: URLSession(configuration: .default), completion:
						{
							(data, response, error) in
							
							guard let data = data, error == nil else { return }
							DispatchQueue.main.async()
								{
									self.prodImage.image = UIImage(data: data)
							}
					}
					)
					found = true
					break
				}
			}
		}
		if found == false
		{
			for i in 0..<DataStore.sharedInstance.services.count
			{
				if "\(DataStore.sharedInstance.services[i].id ?? 0)" == object.productId
				{
					let prod = DataStore.sharedInstance.services[i]
					let imgName = prod.associations?.images?[0].id
					var imageName = "\(R.string.URLbase)img/p"
					for ch in imgName!
					{
						imageName.append("/\(ch)")
					}
					imageName.append("/\(imgName ?? "").jpg")
					DataStore.sharedInstance.getImageFromUrl(url: URL(string: imageName)!, session: URLSession(configuration: .default), completion:
						{
							(data, response, error) in
							
							guard let data = data, error == nil else { return }
							DispatchQueue.main.async()
								{
									self.prodImage.image = UIImage(data: data)
							}
					}
					)
					found = true
					break
				}
			}
		}
		if found == false
		{
			for i in 0..<DataStore.sharedInstance.toners.count
			{
				if "\(DataStore.sharedInstance.toners[i].id ?? 0)" == object.productId
				{
					let prod = DataStore.sharedInstance.toners[i]
					let imgName = prod.associations?.images?[0].id
					var imageName = "\(R.string.URLbase)img/p"
					for ch in imgName!
					{
						imageName.append("/\(ch)")
					}
					imageName.append("/\(imgName ?? "").jpg")
					DataStore.sharedInstance.getImageFromUrl(url: URL(string: imageName)!, session: URLSession(configuration: .default), completion:
						{
							(data, response, error) in
							
							guard let data = data, error == nil else { return }
							DispatchQueue.main.async()
								{
									self.prodImage.image = UIImage(data: data)
							}
					}
					)
					found = true
					break
				}
			}
		}
	}
}
