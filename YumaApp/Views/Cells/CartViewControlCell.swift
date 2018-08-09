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
		view.contentMode = .scaleAspectFit
		view.frame.size = CGSize(width: 100, height: 100)
		view.clipsToBounds = true
		return view
	}()
	var stepper: UIStepper =
	{
		let view = UIStepper()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.setIncrementImage(Awesome.solid.caretUp.asImage(size: 20), for: .normal)
		view.setDecrementImage(Awesome.solid.caretDown.asImage(size: 20), for: .normal)
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
		view.textAlignment = .center
		view.text = R.string.each
		return view
	}()
	var eachAmt: UILabel =
	{
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.textColor = UIColor.darkGray
		view.textAlignment = .right
		view.text = "eachAmt"
		return view
	}()
	let separator: UIView =
	{
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.lightGray
		return view
	}()
	var prod: OrderRow?


	// MARK: Override Methods

	override func prepareForReuse()
	{
		super.prepareForReuse()
		prodImage.image = nil
	}


	// MARK: Methods

	func setup(_ object: OrderRow)
	{
		self.prod = object
		stepper.setDividerImage(UIImage(color: UIColor(hex: "cfcfcf"), size: CGSize(width: 1, height: stepper.frame.height)), forLeftSegmentState: UIControlState.normal, rightSegmentState: UIControlState.normal)
		stepper.maximumValue = 10
		stepper.minimumValue = 1
		stepper.value = Double(object.productQuantity!)
		stepper.addTarget(self, action: #selector(stepperAct(_:)), for: .valueChanged)
		//		prodTitle.text = object.product_name
		prodTitle.text = object.productName
		//		prodQtyEdit.text = object.product_quantity
		prodQtyEdit.text = "\((object.productQuantity!))"
		prodQtyEdit.keyboardType = .numberPad
		prodQtyEdit.returnKeyType = .done
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
		if object.productId != nil
		{
			stepper.tag = Int(object.productId!)
		}
		searchProducts(object.productId!)
		if found == false
		{
			searchPrinters(object.productId!)
		}
		if found == false
		{
			searchLaptops(object.productId!)
		}
		if found == false
		{
			searchServices(object.productId!)
		}
		if found == false
		{
			searchToners(object.productId!)
		}
		drawView()
	}


	func drawView()
	{
		prodQtyBox.addSubview(prodQtyEdit)
		self.addSubview(prodTitle)
		self.addSubview(prodQtyBox)
		self.addSubview(stepper)
		self.addSubview(prodImage)
		self.addSubview(eachLabel)
		self.addSubview(eachAmt)
		self.addSubview(separator)
		NSLayoutConstraint.activate([
			prodTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
			prodTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
			prodTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
			
			prodQtyEdit.topAnchor.constraint(equalTo: prodQtyBox.topAnchor, constant: 5),
			prodQtyEdit.leadingAnchor.constraint(equalTo: prodQtyBox.leadingAnchor, constant: 15),
			prodQtyEdit.bottomAnchor.constraint(equalTo: prodQtyBox.bottomAnchor, constant: -5),
			prodQtyEdit.trailingAnchor.constraint(equalTo: prodQtyBox.trailingAnchor, constant: -5),
			
			prodQtyBox.topAnchor.constraint(equalTo: prodTitle.bottomAnchor, constant: 25),
			prodQtyBox.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
			prodQtyBox.heightAnchor.constraint(equalToConstant: 50),
			prodQtyBox.widthAnchor.constraint(equalToConstant: 50),
			
			stepper.topAnchor.constraint(equalTo: prodQtyBox.bottomAnchor, constant: 10),
			stepper.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
			
			prodImage.topAnchor.constraint(equalTo: prodTitle.bottomAnchor, constant: 10),
			prodImage.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
			prodImage.heightAnchor.constraint(equalToConstant: 135),
			prodImage.widthAnchor.constraint(equalToConstant: 135),
			
			eachLabel.topAnchor.constraint(equalTo: prodTitle.bottomAnchor, constant: 40),
			eachLabel.centerXAnchor.constraint(equalTo: eachAmt.centerXAnchor, constant: 0),
			
			eachAmt.topAnchor.constraint(equalTo: eachLabel.bottomAnchor, constant: 20),
			eachAmt.leadingAnchor.constraint(equalTo: prodImage.trailingAnchor, constant: 5),
			eachAmt.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
			
			separator.heightAnchor.constraint(equalToConstant: 1),
			separator.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
			separator.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1),
			separator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
			])
	}


	fileprivate func searchProducts(_ id: Int)
	{
		for i in 0..<DataStore.sharedInstance.products.count
		{
			if DataStore.sharedInstance.products[i].id == id
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
	
	fileprivate func searchPrinters(_ id: Int)
	{
		for i in 0..<DataStore.sharedInstance.printers.count
		{
			if DataStore.sharedInstance.printers[i].id == id
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
	
	fileprivate func searchLaptops(_ id: Int)
	{
		for i in 0..<DataStore.sharedInstance.laptops.count
		{
			if DataStore.sharedInstance.laptops[i].id == id
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
	
	fileprivate func searchServices(_ id: Int)
	{
		for i in 0..<DataStore.sharedInstance.services.count
		{
			if DataStore.sharedInstance.services[i].id == id
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
	
	fileprivate func searchToners(_ id: Int)
	{
		for i in 0..<DataStore.sharedInstance.toners.count
		{
			if DataStore.sharedInstance.toners[i].id == id
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


	// MARK: Actions

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
		NotificationCenter.default.post(name: CartViewControl.noteName, object: sender)
	}
}

