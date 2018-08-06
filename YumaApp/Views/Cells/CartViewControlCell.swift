//
//  CartViewControlCell.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-08-06.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit
import MGSwipeTableCell


class CartViewControlCell: /*UITableViewCell*/MGSwipeTableCell
{
	let prodQtyBox: UIView =
	{
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.white
		//		view.shadowColor = UIColor.darkGray
		//		view.shadowOffset = .zero
		//		view.shadowRadius = 2
		//		view.shadowOpacity = 0.8
		view.borderColor = UIColor.lightGray
		view.borderWidth = 1
		return view
	}()
	var prodQtyEdit: UITextField =
	{
		let view = UITextField()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.font = UIFont.systemFont(ofSize: 17)
		view.text = "1"
		view.backgroundColor = UIColor.white
		view.textColor = UIColor.darkGray
		view.borderStyle = UITextBorderStyle.none
		return view
	}()
	var prodTitle: UILabel =
	{
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.textColor = UIColor.darkGray
		view.textAlignment = .center
//		view.backgroundColor = UIColor.white
		view.font = R.font.avenirNextBold16//.boldSystemFont(ofSize: 25)
		view.textColor = R.color.YumaRed
		view.text = R.string.prodName
		view.shadowColor = R.color.YumaYel
		view.shadowOffset = CGSize(width: 1, height: 1)
		view.shadowRadius = 4.0
		return view
	}()
	var prodImage: UIImageView =
	{
		let view = UIImageView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	var stepper: UIStepper =
	{
		let view = UIStepper()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.tintColor = UIColor.lightGray
		return view
	}()
	var found = false
	let store = DataStore.sharedInstance
	
	var eachLabel: UILabel =
	{
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.textColor = UIColor.darkGray
		view.font = UIFont.systemFont(ofSize: 12)
		view.text = R.string.each
		return view
	}()
	var eachAmt: UILabel =
	{
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.textColor = UIColor.darkGray
		view.text = "eachAmt"
		return view
	}()

	
	override func prepareForReuse()
	{
		super.prepareForReuse()
		prodImage.image = nil
	}
	
	func setup(_ object: OrderRow)
	{
		stepper.setDividerImage(UIImage(color: UIColor(hex: "cfcfcf"), size: CGSize(width: 1, height: stepper.frame.height)), forLeftSegmentState: UIControlState.normal, rightSegmentState: UIControlState.normal)
		stepper.maximumValue = 10
		stepper.minimumValue = 1
		stepper.addTarget(self, action: #selector(stepperAct(_:)), for: .valueChanged)
		//		prodTitle.text = object.product_name
		prodTitle.text = object.productName
		//		prodQtyEdit.text = object.product_quantity
		prodQtyEdit.text = "\((object.productQuantity!))"
		prodQtyEdit.keyboardType = .numberPad
		prodQtyEdit.returnKeyType = .done
		//		let asDbl = object.product_price?.toDouble()!
		let asDbl = Double(object.productPrice!)
		if /*asDbl != nil &&*/ asDbl > 0
		{
			eachLabel.text = R.string.each
			eachAmt.text = store.formatCurrency(amount: asDbl as NSNumber, iso: store.locale)
		}
		else
		{
			eachLabel.text = ""
			eachAmt.text = ""
		}
		stepper.autorepeat = true
		//		if object.product_id != nil
		if object.productId != nil
		{
			//			stepper.tag = Int(object.product_id!)!
			stepper.tag = Int(object.productId!)
		}
		//		searchProducts(object.product_id!)
		//		searchProducts(object.productId!)
		//		if found == false
		//		{
		////			searchPrinters(object.product_id!)
		//			searchPrinters(object.productId!)
		//		}
		//		if found == false
		//		{
		////			searchLaptops(object.product_id!)
		//			searchLaptops(object.productId!)
		//		}
		//		if found == false
		//		{
		////			searchServices(object.product_id!)
		//			searchServices(object.productId!)
		//		}
		//		if found == false
		//		{
		////			searchToners(object.product_id!)
		//			searchToners(object.productId!)
		//		}
		drawView()
	}

	func drawView()
	{
		self.separatorInset = UIEdgeInsets(top: 2, left: 10, bottom: 2, right: 10)
		prodQtyBox.addSubview(prodQtyEdit)
		NSLayoutConstraint.activate([
			prodQtyEdit.topAnchor.constraint(equalTo: prodQtyBox.topAnchor, constant: 5),
			prodQtyEdit.leadingAnchor.constraint(equalTo: prodQtyBox.leadingAnchor, constant: 20),
			prodQtyEdit.bottomAnchor.constraint(equalTo: prodQtyBox.bottomAnchor, constant: -5),
			prodQtyEdit.trailingAnchor.constraint(equalTo: prodQtyBox.trailingAnchor, constant: -5),
			])
		let falseEnd = UIView(frame: .zero)
		falseEnd.translatesAutoresizingMaskIntoConstraints = false
		let leftSection = UIStackView(arrangedSubviews: [prodQtyBox, stepper])
		prodQtyBox.heightAnchor.constraint(equalToConstant: 50).isActive = true
		prodQtyBox.widthAnchor.constraint(equalToConstant: 50).isActive = true
		leftSection.translatesAutoresizingMaskIntoConstraints = false
		leftSection.axis = .vertical
		leftSection.alignment = .center
		leftSection.spacing = 10
		let midSection = UIStackView(arrangedSubviews: [prodTitle, prodImage])
		midSection.translatesAutoresizingMaskIntoConstraints = false
		midSection.axis = .vertical
		midSection.spacing = 10
		let together = UIStackView(arrangedSubviews: [leftSection, midSection])
		together.translatesAutoresizingMaskIntoConstraints = false
		if eachAmt.text != nil && !(eachAmt.text?.isEmpty)!
		{
			let rightSection = UIStackView(arrangedSubviews: [eachLabel, eachAmt])
			rightSection.translatesAutoresizingMaskIntoConstraints = false
			rightSection.axis = .vertical
			together.addArrangedSubview(rightSection)
		}
		together.spacing = 10
		self.addSubview(together)
		NSLayoutConstraint.activate([
			together.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
			together.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
			together.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
			together.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
			])
	}

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

	@objc func stepperAct(_ sender: UIStepper)
	{
		let value = Int(sender.value)
		if value > 0
		{
			prodQtyEdit.text = Int(sender.value).description
		}
		//		else
		//		{
		//			stepper.value = 1
		//		}
		NotificationCenter.default.post(name: CartViewController.noteName, object: sender)
	}
}

