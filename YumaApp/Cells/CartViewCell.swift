//
//  CartViewCell.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-02.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit
import MGSwipeTableCell


class CartViewCell: /*UITableViewCell*/MGSwipeTableCell
{
	@IBOutlet weak var prodQtyEdit: UITextField!
	@IBOutlet weak var prodTitle: UILabel!
	@IBOutlet weak var prodImage: UIImageView!
	@IBOutlet weak var stepper: UIStepper!
	var found = false
	let store = DataStore.sharedInstance

	
	fileprivate func searchProducts(_ id: String)
	{
		for i in 0..<DataStore.sharedInstance.products.count
		{
			if "\(DataStore.sharedInstance.products[i].id)" == id
			{
				let prod = DataStore.sharedInstance.products[i]
				let imgName = prod.associations?.images![0].id
				var imageName = "\(R.string.URLbase)img/p"
				for ch in imgName!
				{
					imageName.append("/\(ch)")
				}
				imageName.append("/\(imgName ?? "").jpg")
				//				if let imageFromCache = store.imageDataCache.object(forKey: imageName as AnyObject)
				//				{
				//					//self.prodImage.image = UIImage(data: (imageFromCache as? Data)!)
				//					self.prodImage.image = UIImage(data: imageFromCache as! Data)
				//				}
				//				else
				//				{
				DataStore.sharedInstance.getImageFromUrl(url: URL(string: imageName)!, session: URLSession(configuration: .default), completion:
					{
						(data, response, error) in
						
						guard let data = data, error == nil else { return }
						DispatchQueue.main.async()
							{
								let imageToCache = UIImage(data: data)
								self.store.imageDataCache.setObject(imageToCache!, forKey: imageName as AnyObject)
								self.prodImage.image = imageToCache
								//self.prodImage.image = UIImage(data: data)
						}
					})
				//				}
				found = true
				break
			}
		}
	}
	
	fileprivate func searchPrinters(_ id: String)
	{
		for i in 0..<DataStore.sharedInstance.printers.count
		{
			if "\(DataStore.sharedInstance.printers[i].id)" == id
			{
				let prod = DataStore.sharedInstance.printers[i]
				let imgName = prod.associations?.images![0].id
				var imageName = "\(R.string.URLbase)img/p"
				for ch in imgName!
				{
					imageName.append("/\(ch)")
				}
				imageName.append("/\(imgName ?? "").jpg")
				if let imageFromCache = store.imageDataCache.object(forKey: imageName as AnyObject)
				{
					self.prodImage.image = UIImage(data: (imageFromCache as? Data)!)
				}
				else
				{
					DataStore.sharedInstance.getImageFromUrl(url: URL(string: imageName)!, session: URLSession(configuration: .default), completion:
						{
							(data, response, error) in
							
							guard let data = data, error == nil else { return }
							DispatchQueue.main.async()
								{
									let imageToCache = UIImage(data: data)
									self.store.imageDataCache.setObject(imageToCache!, forKey: imageName as AnyObject)
									self.prodImage.image = imageToCache
									//self.prodImage.image = UIImage(data: data)
							}
					})
				}
				found = true
				break
			}
		}
	}
	
	fileprivate func searchLaptops(_ id: String)
	{
		for i in 0..<DataStore.sharedInstance.laptops.count
		{
			if "\(DataStore.sharedInstance.laptops[i].id)" == id
			{
				let prod = DataStore.sharedInstance.laptops[i]
				let imgName = prod.associations?.images![0].id
				var imageName = "\(R.string.URLbase)img/p"
				for ch in imgName!
				{
					imageName.append("/\(ch)")
				}
				imageName.append("/\(imgName ?? "").jpg")
				if let imageFromCache = store.imageDataCache.object(forKey: imageName as AnyObject)
				{
					self.prodImage.image = UIImage(data: (imageFromCache as? Data)!)
				}
				else
				{
					DataStore.sharedInstance.getImageFromUrl(url: URL(string: imageName)!, session: URLSession(configuration: .default), completion:
						{
							(data, response, error) in
							
							guard let data = data, error == nil else { return }
							DispatchQueue.main.async()
								{
									let imageToCache = UIImage(data: data)
									self.store.imageDataCache.setObject(imageToCache!, forKey: imageName as AnyObject)
									self.prodImage.image = imageToCache
									//self.prodImage.image = UIImage(data: data)
							}
						})
				}
				found = true
				break
			}
		}
	}
	
	fileprivate func searchServices(_ id: String)
	{
		for i in 0..<DataStore.sharedInstance.services.count
		{
			if "\(DataStore.sharedInstance.services[i].id)" == id
			{
				let prod = DataStore.sharedInstance.services[i]
				let imgName = prod.associations?.images![0].id
				var imageName = "\(R.string.URLbase)img/p"
				for ch in imgName!
				{
					imageName.append("/\(ch)")
				}
				imageName.append("/\(imgName ?? "").jpg")
				if let imageFromCache = store.imageDataCache.object(forKey: imageName as AnyObject)
				{
					self.prodImage.image = UIImage(data: (imageFromCache as? Data)!)
				}
				else
				{
					DataStore.sharedInstance.getImageFromUrl(url: URL(string: imageName)!, session: URLSession(configuration: .default), completion:
						{
							(data, response, error) in
							
							guard let data = data, error == nil else { return }
							DispatchQueue.main.async()
								{
									let imageToCache = UIImage(data: data)
									self.store.imageDataCache.setObject(imageToCache!, forKey: imageName as AnyObject)
									self.prodImage.image = imageToCache
									//self.prodImage.image = UIImage(data: data)
							}
						})
				}
				found = true
				break
			}
		}
	}
	
	fileprivate func searchToners(_ id: String)
	{
		for i in 0..<DataStore.sharedInstance.toners.count
		{
			if "\(DataStore.sharedInstance.toners[i].id )" == id
			{
				let prod = DataStore.sharedInstance.toners[i]
				let imgName = prod.associations?.images![0].id
				var imageName = "\(R.string.URLbase)img/p"
				for ch in imgName!
				{
					imageName.append("/\(ch)")
				}
				imageName.append("/\(imgName ?? "").jpg")
				if let imageFromCache = store.imageDataCache.object(forKey: imageName as AnyObject)
				{
					self.prodImage.image = UIImage(data: (imageFromCache as? Data)!)
				}
				else
				{
					DataStore.sharedInstance.getImageFromUrl(url: URL(string: imageName)!, session: URLSession(configuration: .default), completion:
						{
							(data, response, error) in
							
							guard let data = data, error == nil else { return }
							DispatchQueue.main.async()
								{
									let imageToCache = UIImage(data: data)
									self.store.imageDataCache.setObject(imageToCache!, forKey: imageName as AnyObject)
									self.prodImage.image = imageToCache
									//self.prodImage.image = UIImage(data: data)
							}
						})
				}
				found = true
				break
			}
		}
	}
	
	func setup(_ object: OrderRow)
	{
		prodTitle.text = object.product_name
		prodQtyEdit.text = object.product_quantity
		prodQtyEdit.keyboardType = .numberPad
		prodQtyEdit.returnKeyType = .done
		if object.product_id != nil
		{
			stepper.tag = Int(object.product_id!)!
		}
		searchProducts(object.product_id!)
		if found == false
		{
			searchPrinters(object.product_id!)
		}
		if found == false
		{
			searchLaptops(object.product_id!)
		}
		if found == false
		{
			searchServices(object.product_id!)
		}
		if found == false
		{
			searchToners(object.product_id!)
		}
	}
	@IBAction func stepperAct(_ sender: UIStepper)
	{
		//let value = Int(sender.value)
		prodQtyEdit.text = Int(sender.value).description
		//let prod = sender.superview
		//let row_qty = value
		NotificationCenter.default.post(name: CartViewController.noteName, object: sender/*, userInfo: ["sender": sender]*/)
		//NotificationCenter.default.post(name: CartViewController.noteName, object: nil)
	}
}
