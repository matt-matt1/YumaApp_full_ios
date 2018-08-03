//
//  ProductsCollectionCell.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-07-26.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class ProductsPreviewCell: BaseCell//UICollectionViewCell
{
	var btnTapAction: (()->())?
	let store = DataStore.sharedInstance
	let panel: UIView =
	{
		let iv = UIView()
		iv.translatesAutoresizingMaskIntoConstraints = false
		iv.shadowColor = UIColor.darkGray
		iv.shadowOffset = .zero
		iv.shadowRadius = 3
		iv.backgroundColor = UIColor.white
		return iv
	}()
	let prodImage: UIImageView =
	{
		let iv = UIImageView()
		iv.translatesAutoresizingMaskIntoConstraints = false
		iv.contentMode = .scaleAspectFit
		iv.backgroundColor = UIColor.white
		//iv.sizeToFit()
		return iv
	}()
	let prodName: UILabel =
	{
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.isUserInteractionEnabled = false
		lbl.lineBreakMode = NSLineBreakMode.byTruncatingHead
		//lbl.adjustsFontSizeToFitWidth = true
		lbl.textAlignment = .center
		lbl.backgroundColor = UIColor.white
		lbl.font = UIFont.init(name: "AvenirNext-Bold", size: 14)//.boldSystemFont(ofSize: 25)
		lbl.textColor = R.color.YumaRed
		lbl.text = "Product Name"
		lbl.shadowColor = R.color.YumaYel
		lbl.shadowOffset = CGSize(width: 1, height: 1)
		lbl.shadowRadius = 4.0
		//lbl.shadowOpacity = 1
		//lbl.sizeToFit()
		return lbl
	}()
	var showPrice = true
	let prodPrice: UILabel =
	{
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.font = UIFont.systemFont(ofSize: 18)
		lbl.textAlignment = .center
		lbl.text = "$0.00"
		lbl.backgroundColor = UIColor.white
		lbl.textColor = UIColor.darkGray
		return lbl
	}()
	let add2cart: UIButton =
	{
		let view = UIButton()
		view.translatesAutoresizingMaskIntoConstraints = false
		let mutableAttributedString = NSMutableAttributedString(attributedString: Awesome.solid.shoppingCart.asAttributedText(fontSize: 16, color: UIColor.white, backgroundColor: UIColor.clear))
		mutableAttributedString.addAttributes([NSAttributedStringKey.shadow : R.shadow.YumaRed5_downright1()], range: NSRange(location: 0, length: mutableAttributedString.length))
		let str = NSAttributedString(string: "     \(R.string.add2cart)", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white, NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16), NSAttributedStringKey.shadow : R.shadow.YumaRed5_downright1(), NSAttributedStringKey.baselineOffset : 2])
		mutableAttributedString.append(str)
		view.setAttributedTitle(mutableAttributedString, for: .normal)
		view.borderWidth = 2
		view.borderColor = R.color.YumaRed
		view.cornerRadius = 2
		view.backgroundColor = UIColor(hex: "f8c03f")
		view.shadowColor = UIColor.darkGray
		view.shadowOffset = CGSize(width: 1, height: 1)
		view.shadowRadius = 3
		view.shadowOpacity = 0.9
		return view
	}()
	
	
	override func setupViews()
	{
		super.setupViews()
		addSubview(panel)
		NSLayoutConstraint.activate([
			panel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
			panel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
			panel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
			//			panel.heightAnchor.constraint(equalToConstant: self.frame.width),
			])
		backgroundColor = UIColor.white	//not needed - only in-case
		cornerRadius = 4
		shadowColor = UIColor.darkGray
		shadowOffset = .zero
		shadowRadius = 3
		shadowOpacity = 0.8
		panel.addSubview(prodImage)
		panel.addSubview(prodName)
		panel.addSubview(prodPrice)
		//		if showAdd2CartButton
		//		{
		panel.addSubview(add2cart)
		add2cart.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(btnTapped)))
//		add2cart.addTapGestureRecognizer {
//			if self.prodName.text != nil
//			{
//				print("TODO: add \(self.prodName.text!) to cart")
//			}
//		}
		//		add2cart.addTapGestureRecognizer(action: {
		//			print("TODO: Add this item to cart")
		//		})
		//		}
		
		NSLayoutConstraint.activate([
			prodImage.topAnchor.constraint(equalTo: panel.topAnchor, constant: 0),
			prodImage.leadingAnchor.constraint(equalTo: panel.leadingAnchor, constant: 0),
			prodImage.trailingAnchor.constraint(equalTo: panel.trailingAnchor, constant: 0),
			prodImage.heightAnchor.constraint(equalToConstant: self.frame.width-5),
			
			prodName.topAnchor.constraint(equalTo: prodImage.bottomAnchor, constant: 0),
			prodName.leadingAnchor.constraint(equalTo: panel.leadingAnchor, constant: 0),
			prodName.trailingAnchor.constraint(equalTo: panel.trailingAnchor, constant: 0),
			prodName.heightAnchor.constraint(equalToConstant: 20),
			
			prodPrice.topAnchor.constraint(equalTo: prodName.bottomAnchor, constant: 0),
			prodPrice.leadingAnchor.constraint(equalTo: panel.leadingAnchor, constant: 0),
			prodPrice.trailingAnchor.constraint(equalTo: panel.trailingAnchor, constant: 0),
			prodPrice.heightAnchor.constraint(equalToConstant: 20),
			])
		//		if showAdd2CartButton
		//		{
		NSLayoutConstraint.activate([
			add2cart.topAnchor.constraint(equalTo: prodPrice.bottomAnchor, constant: 3),
			add2cart.leadingAnchor.constraint(equalTo: panel.leadingAnchor, constant: 0),
			add2cart.trailingAnchor.constraint(equalTo: panel.trailingAnchor, constant: 0),
			add2cart.heightAnchor.constraint(equalToConstant: 30),
			])
		//		}
	}
	
	@objc func btnTapped()
	{
		print("Tapped!")
		btnTapAction?()
	}

	func fillData(_ prod: aProduct)
	{
		if prod.availableForOrder == nil || !prod.availableForOrder!
		{
			add2cart.removeFromSuperview()
		}
		//		self.prodName.text = self.store.valueById(object: prod.name!, id: self.store.myLang)
		self.prodName.text = prod.name![self.store.myLang].value
		if (prod.showPrice == nil || prod.showPrice!) && prod.price != nil && prod.price! > 0.0
		{
			self.prodPrice.text = self.store.formatCurrency(amount: NSNumber(value: prod.price!))
		}
		else
		{
			self.prodPrice.text = R.string.noPrice
		}
		if prod.associations?.imageData != nil
		{
			self.prodImage.image = UIImage(data: (prod.associations?.imageData)!)
		}
		else
		{
			let imgName = prod.associations?.images![0].id//primary image
			var imageName = "\(R.string.URLbase)img/p"
			for ch in imgName!
			{
				imageName.append("/\(ch)")
			}
			imageName.append("/\(imgName ?? "").jpg")
			//			if let imageFromCache = store.imageDataCache.object(forKey: imageName as AnyObject)
			//			{
			//				self.prodImage.image = UIImage(data: (imageFromCache as? Data)!)
			//			}
			//			else
			//			{
			store.getImageFromUrl(url: URL(string: imageName)!, session: URLSession(configuration: .default), completion:
				{
					(data, response, error) in
					
					guard let data = data, error == nil else { return }
					DispatchQueue.main.async()
						{
							let i = self.tag - 10
							let imageToCache = UIImage(data: data)
							self.store.imageDataCache.setObject(imageToCache!, forKey: imageName as AnyObject)
							self.prodImage.image = imageToCache
							//view.prodImage.image = UIImage(data: data)
							//self.prod_image = data
							if i > 0 && i < self.store.products.count
							{
								self.store.products[i].associations?.imageData = data
							}
					}
			})
			//			}
		}
	}
	
}


class ProductsPreviewHeaderCell: BaseCell
{
	let headerLbl: UILabel =
	{
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.font = UIFont.boldSystemFont(ofSize: 21)
		lbl.textAlignment = .center
		lbl.text = "\(R.string.prod) \(R.string.list)"
		lbl.backgroundColor = UIColor.clear
		return lbl
	}()
	let leftLbl: UILabel =
	{
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.font = UIFont.systemFont(ofSize: 12)
		lbl.textAlignment = .center
		lbl.text = "Left"
		lbl.backgroundColor = UIColor.yellow
		return lbl
	}()
	let centerLbl: UILabel =
	{
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.font = UIFont.systemFont(ofSize: 12)
		lbl.textAlignment = .center
		lbl.text = "C"
		lbl.backgroundColor = UIColor.brown//.clear
		return lbl
	}()
	let rightLbl: UILabel =
	{
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.font = UIFont.systemFont(ofSize: 21)
		lbl.textAlignment = .center
		lbl.text = "R"
		lbl.backgroundColor = UIColor.purple//.clear
		return lbl
	}()
	
	
	override func setupViews()
	{
		super.setupViews()
		addSubview(headerLbl)
		addSubview(leftLbl)
		addSubview(centerLbl)
		addSubview(rightLbl)
		NSLayoutConstraint.activate([
			headerLbl.topAnchor.constraint(equalTo: self.topAnchor, constant: 2),
			headerLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
			headerLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
			headerLbl.heightAnchor.constraint(equalToConstant: headerLbl.font.pointSize+4),//self.frame.height),
			
			leftLbl.topAnchor.constraint(equalTo: headerLbl.bottomAnchor, constant: 0),
			leftLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
			leftLbl.trailingAnchor.constraint(equalTo: centerLbl.leadingAnchor, constant: -1),
			leftLbl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
			
			centerLbl.topAnchor.constraint(equalTo: headerLbl.bottomAnchor, constant: 0),
			centerLbl.leadingAnchor.constraint(equalTo: leftLbl.trailingAnchor, constant: 1),
			centerLbl.trailingAnchor.constraint(equalTo: rightLbl.leadingAnchor, constant: -1),
			centerLbl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
			
			rightLbl.topAnchor.constraint(equalTo: headerLbl.bottomAnchor, constant: 0),
			rightLbl.leadingAnchor.constraint(equalTo: centerLbl.trailingAnchor, constant: 1),
			rightLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2),
			rightLbl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
			])
	}
}


class ProductsPreviewFooterCell: BaseCell
{
	let footerLbl: UILabel =
	{
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.font = UIFont.systemFont(ofSize: 21)
		lbl.textAlignment = .center
		lbl.text = "Tap a product for more details"
		lbl.backgroundColor = UIColor.clear
		return lbl
	}()
	
	
	override func setupViews()
	{
		super.setupViews()
		addSubview(footerLbl)
		NSLayoutConstraint.activate([
			footerLbl.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
			footerLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
			footerLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
			footerLbl.heightAnchor.constraint(equalToConstant: self.frame.height),
			])
	}
}


////
////  ProductsCollectionCell.swift
////  YumaApp
////
////  Created by Yuma Usa on 2018-07-26.
////  Copyright © 2018 Yuma Usa. All rights reserved.
////
//
//import UIKit
//
//class ProductsPreviewCell: BaseCell//UICollectionViewCell
//{
//	let store = DataStore.sharedInstance
//	let panel: UIView =
//	{
//		let iv = UIView()
//		iv.translatesAutoresizingMaskIntoConstraints = false
//		iv.shadowColor = UIColor.darkGray
//		iv.shadowOffset = .zero
//		iv.shadowRadius = 3
////		iv.shadowOpacity = 0.8
//		iv.backgroundColor = UIColor.white
//		return iv
//	}()
//	let prodImage: UIImageView =
//	{
//		let iv = UIImageView()
//		iv.translatesAutoresizingMaskIntoConstraints = false
//		iv.contentMode = .scaleAspectFit
//		iv.backgroundColor = UIColor.white
//		//iv.sizeToFit()
//		return iv
//	}()
//	let prodName: UILabel =
//	{
//		let lbl = UILabel()
//		lbl.translatesAutoresizingMaskIntoConstraints = false
//		lbl.isUserInteractionEnabled = false
//		lbl.lineBreakMode = NSLineBreakMode.byTruncatingHead
//		//lbl.adjustsFontSizeToFitWidth = true
//		lbl.textAlignment = .center
//		lbl.backgroundColor = UIColor.white
//		lbl.font = UIFont.init(name: "AvenirNext-Bold", size: 14)//.boldSystemFont(ofSize: 25)
//		lbl.textColor = R.color.YumaRed
//		lbl.text = "Product Name"
//		lbl.shadowColor = R.color.YumaYel
//		lbl.shadowOffset = CGSize(width: 1, height: 1)
//		lbl.shadowRadius = 4.0
//		//lbl.shadowOpacity = 1
//		//lbl.sizeToFit()
//		return lbl
//	}()
//	var showPrice = true
//	let prodPrice: UILabel =
//	{
//		let lbl = UILabel()
//		lbl.translatesAutoresizingMaskIntoConstraints = false
//		lbl.font = UIFont.systemFont(ofSize: 18)
//		lbl.textAlignment = .center
//		lbl.text = "$0.00"
//		lbl.backgroundColor = UIColor.white
//		lbl.textColor = UIColor.darkGray
//		return lbl
//	}()
//	let add2cart: UIButton =
//	{
//		let view = UIButton()
//		view.translatesAutoresizingMaskIntoConstraints = false
//		let mutableAttributedString = NSMutableAttributedString(attributedString: Awesome.solid.shoppingCart.asAttributedText(fontSize: 16, color: UIColor.white, backgroundColor: UIColor.clear))
//		mutableAttributedString.addAttributes([NSAttributedStringKey.shadow : R.shadow.YumaRed5_downright1()], range: NSRange(location: 0, length: mutableAttributedString.length))
//		let str = NSAttributedString(string: "     \(R.string.add2cart)", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white, NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16), NSAttributedStringKey.shadow : R.shadow.YumaRed5_downright1(), NSAttributedStringKey.baselineOffset : 2])
//		mutableAttributedString.append(str)
//		view.setAttributedTitle(mutableAttributedString, for: .normal)
//		view.borderWidth = 2
//		view.borderColor = R.color.YumaRed
//		view.cornerRadius = 2
//		view.backgroundColor = UIColor(hex: "f8c03f")
//		view.shadowColor = UIColor.darkGray
//		view.shadowOffset = CGSize(width: 1, height: 1)
//		view.shadowRadius = 3
//		view.shadowOpacity = 0.9
//		return view
//	}()
//
//
//	override func setupViews()
//	{
//		super.setupViews()
//		addSubview(panel)
//		NSLayoutConstraint.activate([
//			panel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
//			panel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
//			panel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
////			panel.heightAnchor.constraint(equalToConstant: self.frame.width),
//			])
//		backgroundColor = UIColor.white	//not needed - only in-case
//		cornerRadius = 4
//		shadowColor = UIColor.darkGray
//		shadowOffset = .zero
//		shadowRadius = 3
//		shadowOpacity = 0.8
//		panel.addSubview(prodImage)
//		panel.addSubview(prodName)
//		panel.addSubview(prodPrice)
////		if price is greater than 0 && showPrice
////		{
//		panel.addSubview(add2cart)
////		}
//
//		NSLayoutConstraint.activate([
//			prodImage.topAnchor.constraint(equalTo: panel.topAnchor, constant: 0),
//			prodImage.leadingAnchor.constraint(equalTo: panel.leadingAnchor, constant: 0),
//			prodImage.trailingAnchor.constraint(equalTo: panel.trailingAnchor, constant: 0),
//			prodImage.heightAnchor.constraint(equalToConstant: self.frame.width-5),
//
//			prodName.topAnchor.constraint(equalTo: prodImage.bottomAnchor, constant: 0),
//			prodName.leadingAnchor.constraint(equalTo: panel.leadingAnchor, constant: 0),
//			prodName.trailingAnchor.constraint(equalTo: panel.trailingAnchor, constant: 0),
//			prodName.heightAnchor.constraint(equalToConstant: 20),
//
//			prodPrice.topAnchor.constraint(equalTo: prodName.bottomAnchor, constant: 0),
//			prodPrice.leadingAnchor.constraint(equalTo: panel.leadingAnchor, constant: 0),
//			prodPrice.trailingAnchor.constraint(equalTo: panel.trailingAnchor, constant: 0),
//			prodPrice.heightAnchor.constraint(equalToConstant: 20),
//			])
////		if price is greater than 0 && showPrice
////		{
//		NSLayoutConstraint.activate([
//			add2cart.topAnchor.constraint(equalTo: prodPrice.bottomAnchor, constant: 3),
//			add2cart.leadingAnchor.constraint(equalTo: panel.leadingAnchor, constant: 0),
//			add2cart.trailingAnchor.constraint(equalTo: panel.trailingAnchor, constant: 0),
//			add2cart.heightAnchor.constraint(equalToConstant: 30),
//			])
////		}
//	}
//
//	func fillData(_ prod: aProduct)
//	{
////		self.prodName.text = self.store.valueById(object: prod.name!, id: self.store.myLang)
//		self.prodName.text = prod.name![self.store.myLang].value
//		if (prod.showPrice == nil || prod.showPrice!) && prod.price != nil && prod.price! > 0.0
//		{
//			self.prodPrice.text = self.store.formatCurrency(amount: NSNumber(value: prod.price!))
//		}
//		else
//		{
//			self.prodPrice.text = R.string.noPrice
//		}
//		if prod.associations?.imageData != nil
//		{
//			self.prodImage.image = UIImage(data: (prod.associations?.imageData)!)
//		}
//		else
//		{
//			let imgName = prod.associations?.images![0].id//primary image
//			var imageName = "\(R.string.URLbase)img/p"
//			for ch in imgName!
//			{
//				imageName.append("/\(ch)")
//			}
//			imageName.append("/\(imgName ?? "").jpg")
////			if let imageFromCache = store.imageDataCache.object(forKey: imageName as AnyObject)
////			{
////				self.prodImage.image = UIImage(data: (imageFromCache as? Data)!)
////			}
////			else
////			{
//				store.getImageFromUrl(url: URL(string: imageName)!, session: URLSession(configuration: .default), completion:
//					{
//						(data, response, error) in
//
//						guard let data = data, error == nil else { return }
//						DispatchQueue.main.async()
//							{
//								let i = self.tag - 10
//								let imageToCache = UIImage(data: data)
//								self.store.imageDataCache.setObject(imageToCache!, forKey: imageName as AnyObject)
//								self.prodImage.image = imageToCache
//								//view.prodImage.image = UIImage(data: data)
//								//self.prod_image = data
//								if i > 0 && i < self.store.products.count
//								{
//									self.store.products[i].associations?.imageData = data
//								}
//						}
//				})
////			}
//		}
//	}
//
//}
//
//
//class ProductsPreviewHeaderCell: BaseCell
//{
//	let headerLbl: UILabel =
//	{
//		let lbl = UILabel()
//		lbl.translatesAutoresizingMaskIntoConstraints = false
//		lbl.font = UIFont.boldSystemFont(ofSize: 21)
//		lbl.textAlignment = .center
//		lbl.text = "\(R.string.prod) \(R.string.list)"
//		lbl.backgroundColor = UIColor.clear
//		return lbl
//	}()
//	let leftLbl: UILabel =
//	{
//		let lbl = UILabel()
//		lbl.translatesAutoresizingMaskIntoConstraints = false
//		lbl.font = UIFont.systemFont(ofSize: 12)
//		lbl.textAlignment = .center
//		lbl.text = "Left"
//		lbl.backgroundColor = UIColor.yellow
//		return lbl
//	}()
//	let centerLbl: UILabel =
//	{
//		let lbl = UILabel()
//		lbl.translatesAutoresizingMaskIntoConstraints = false
//		lbl.font = UIFont.systemFont(ofSize: 12)
//		lbl.textAlignment = .center
//		lbl.text = "C"
//		lbl.backgroundColor = UIColor.brown//.clear
//		return lbl
//	}()
//	let rightLbl: UILabel =
//	{
//		let lbl = UILabel()
//		lbl.translatesAutoresizingMaskIntoConstraints = false
//		lbl.font = UIFont.systemFont(ofSize: 21)
//		lbl.textAlignment = .center
//		lbl.text = "R"
//		lbl.backgroundColor = UIColor.purple//.clear
//		return lbl
//	}()
//
//
//	override func setupViews()
//	{
//		super.setupViews()
//		addSubview(headerLbl)
//		addSubview(leftLbl)
//		addSubview(centerLbl)
//		addSubview(rightLbl)
//		NSLayoutConstraint.activate([
//			headerLbl.topAnchor.constraint(equalTo: self.topAnchor, constant: 2),
//			headerLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
//			headerLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
//			headerLbl.heightAnchor.constraint(equalToConstant: headerLbl.font.pointSize+4),//self.frame.height),
//
//			leftLbl.topAnchor.constraint(equalTo: headerLbl.bottomAnchor, constant: 0),
//			leftLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
//			leftLbl.trailingAnchor.constraint(equalTo: centerLbl.leadingAnchor, constant: -1),
//			leftLbl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
//
//			centerLbl.topAnchor.constraint(equalTo: headerLbl.bottomAnchor, constant: 0),
//			centerLbl.leadingAnchor.constraint(equalTo: leftLbl.trailingAnchor, constant: 1),
//			centerLbl.trailingAnchor.constraint(equalTo: rightLbl.leadingAnchor, constant: -1),
//			centerLbl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
//
//			rightLbl.topAnchor.constraint(equalTo: headerLbl.bottomAnchor, constant: 0),
//			rightLbl.leadingAnchor.constraint(equalTo: centerLbl.trailingAnchor, constant: 1),
//			rightLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2),
//			rightLbl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
//		])
//	}
//}
//
//
//class ProductsPreviewFooterCell: BaseCell
//{
//	let footerLbl: UILabel =
//	{
//		let lbl = UILabel()
//		lbl.translatesAutoresizingMaskIntoConstraints = false
//		lbl.font = UIFont.systemFont(ofSize: 21)
//		lbl.textAlignment = .center
//		lbl.text = "Tap a product for more details"
//		lbl.backgroundColor = UIColor.clear
//		return lbl
//	}()
//
//
//	override func setupViews()
//	{
//		super.setupViews()
//		addSubview(footerLbl)
//		NSLayoutConstraint.activate([
//			footerLbl.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
//			footerLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
//			footerLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
//			footerLbl.heightAnchor.constraint(equalToConstant: self.frame.height),
//			])
//	}
//}
