//
//  ProductsViewControllerForm.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-05-09.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


extension ProductsViewController
{

	func formProductOptionValues(ValueIDs: [IdAsString]) -> UIStackView
	{
		let stack = UIStackView()
		//stack.translatesAutoresizingMaskIntoConstraints = false
		for prodOpt in ValueIDs
		{
			let find = Int(prodOpt.id)!
			if find < store.productOptionValues.count
			{
				for co in store.productOptionValues
				{
					if co.id == find
					{
						let lbl = UILabel()
						lbl.translatesAutoresizingMaskIntoConstraints = false
						lbl.text = String(describing: co)
						stack.addArrangedSubview(lbl)
						break
					}
				}
			}
			//view.productOptionValuesView.addArrangedSubview(stack)
		}
		return stack
	}

	func formTagsView(tagIDs: [IdAsString], maxWidth: CGFloat, maxHeight: CGFloat) -> UIStackView
	{
		let stack = UIStackView()
		//stack.translatesAutoresizingMaskIntoConstraints = false
		stack.spacing = 8
		stack.backgroundColor = UIColor.white
		stack.distribution = .fill
		stack.alignment = .top
		stack.setContentHuggingPriority(UILayoutPriority(rawValue: 760), for: .horizontal)
		stack.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 749), for: .horizontal)
		for prodTag in tagIDs
		{
			let find = Int(prodTag.id)!
			if find < store.tags.count
			{
				for storeTag in store.tags
				{
					if storeTag.id == find
					{
						let tagView = makeTag(string: storeTag.name!)
//						tagView.translatesAutoresizingMaskIntoConstraints = false
//						print("tagView frame:\(tagView.bounds), stack frame:\(stack.bounds)")
						stack.addArrangedSubview(tagView)
						break
					}
				}
			}
		}
		let falseBottom = UIView(frame: .zero)
		stack.addArrangedSubview(falseBottom)
		return stack
	}

	func numberOfSections(in collectionView: UICollectionView) -> Int
	{
		return 1
	}

	func formTagsView2(tagIDs: [IdAsString]/*, maxWidth: CGFloat, maxHeight: CGFloat*/) //-> UICollectionView
	{
		var array: [String] = []
		for prodTag in tagIDs
		{
			let find = Int(prodTag.id)!
			if find < store.tags.count
			{
				for storeTag in store.tags
				{
					if storeTag.id == find
					{
						array.append(storeTag.name!)
						break
					}
				}
			}
		}
		collectionTags.register(ProductLabelCell.self, forCellWithReuseIdentifier: "prodTags")
		collectionTags.delegate = self
		collectionTags.dataSource = self
		let stack = ProductTagsCollection.init(/*numberOfCells: tagIDs.count,*/ arrayOfStrings: array)
		//stack.translatesAutoresizingMaskIntoConstraints = false
		//stack.spacing = 8
		//stack.distribution = .fill
		stack.backgroundColor = UIColor.white
		//let falseBottom = UIView(frame: .zero)
		//stack.addArrangedSubview(falseBottom)
//		return stack
	}

	func formImageViews(imageIDs: [IdAsString], imageChar: String="p") -> UIStackView
	{
		let stack = UIStackView()
		stack.spacing = 5
//		stack.axis = .horizontal
//		stack.alignment = .center
//		stack.translatesAutoresizingMaskIntoConstraints = false
		for img in imageIDs
		{
			var imageName = "\(R.string.URLbase)img/\(imageChar)"
			for ch in img.id
			{
				imageName.append("/\(ch)")
			}
			imageName.append("/\(img.id).jpg")
			store.getImageFromUrl(url: URL(string: imageName)!, session: URLSession(configuration: .default), completion:
				{
					(data, response, error) in
					
					guard let data = data, error == nil else { return }
					DispatchQueue.main.async()
						{
							//							let i = self.view.tag - 10
							let imageToCache = UIImage(data: data)
							self.store.imageDataCache.setObject(imageToCache!, forKey: "\(imageChar)\(img.id)" as AnyObject)
							let imageInFrame = UIImageView(image: imageToCache)
							imageInFrame.contentMode = .scaleAspectFit
							imageInFrame.borderColor = UIColor.lightGray
							imageInFrame.borderWidth = 3
							imageInFrame.tag = Int(img.id)!
							imageInFrame.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.expandPicture(_:))))
							imageInFrame.translatesAutoresizingMaskIntoConstraints = false
							stack.addArrangedSubview(imageInFrame)
							NSLayoutConstraint.activate([
								imageInFrame.topAnchor.constraint(equalTo: stack.topAnchor, constant: 0),
								imageInFrame.heightAnchor.constraint(equalToConstant: 100),
//								imageInFrame.leadingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 0),
								imageInFrame.widthAnchor.constraint(equalToConstant: 100),
								])
//							stack.addConstraintsWithFormat(format: "H:[v0(100)]", views: imageInFrame)
//							stack.addConstraintsWithFormat(format: "V:[v0(100)]", views: imageInFrame)
							//							if i > 0 && i < self.store.products.count
							//							{
							//								self.store.products[i].associations?.imageData = data
							//							}
					}
			})
		}
		stack.addArrangedSubview(UIView(frame: .zero))
		return stack
	}
	
	func formCombinationView(combinationsIDs: [IdAsString]) -> UIStackView
	{
		let stack = UIStackView()
		//stack.translatesAutoresizingMaskIntoConstraints = false
		for prodComb in combinationsIDs
		{
			let find = Int(prodComb.id)!
			if find < store.combinations.count
			{
				for co in store.combinations
				{
					if co.id == find
					{
						let lbl = UILabel()
						lbl.translatesAutoresizingMaskIntoConstraints = false
						lbl.text = String(describing: co)
						stack.addArrangedSubview(lbl)
						break
					}
				}
			}
		}
		return stack
	}
	
	func formCategoriesView(categorieIDs: [IdAsString]) -> UIStackView
	//func formCategoriesView(categorieIDs: [IdAsString]) -> UIScrollView
	{
		var first = true
		let stack = UIStackView()
		//let stack = UIScrollView(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
		//stack.contentSize.height = 30
//		print("stack frame x:\(stack.frame.origin.x), y:\(stack.frame.origin.y), w:\(stack.frame.width), h:\(stack.frame.height)")
		//stack.heightAnchor.constraint(equalToConstant: 30).isActive = true
		//stack.translatesAutoresizingMaskIntoConstraints = false
		stack.spacing = 2
		for prodCat in categorieIDs
		{
			let find = Int(prodCat.id)!
			if find < store.categories.count
			{
				for cat in store.categories
				{
					if cat.id == find
					{
						if first == false
						{
//							first = false
							let sep = UILabel()
//							sep.translatesAutoresizingMaskIntoConstraints = false
							sep.text = " > "
							sep.textColor = UIColor.gray
							stack.addArrangedSubview(sep)
							//stack.addSubview(sep)
							//stack.contentSize.width += 53
//							print("stack contentSize w:\(stack.contentSize.width), h:\(stack.contentSize.height)")
						}
						let wrapperLbl = UIView()
//						wrapperLbl.translatesAutoresizingMaskIntoConstraints = false
						let lbl = UILabel()
						lbl.translatesAutoresizingMaskIntoConstraints = false
						lbl.text = cat.name![self.store.myLang].value//store.valueById(object: cat.name!, id: store.myLang)//cat.name![store.myLang].value
						wrapperLbl.addSubview(lbl)
//						wrapperLbl.addConstraintsWithFormat(format: "H:|[v0]|", views: lbl)
//						wrapperLbl.addConstraintsWithFormat(format: "V:|[v0]|", views: lbl)
						NSLayoutConstraint.activate([
							lbl.topAnchor.constraint(equalTo: wrapperLbl.topAnchor),
							lbl.leadingAnchor.constraint(equalTo: wrapperLbl.leadingAnchor),
							lbl.bottomAnchor.constraint(equalTo: wrapperLbl.bottomAnchor),
							lbl.trailingAnchor.constraint(equalTo: wrapperLbl.trailingAnchor),
							])
//						wrapperLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(displayCat(_:))))
						stack.addArrangedSubview(wrapperLbl)
						//stack.addSubview(wrapperLbl)
						//stack.contentSize.width += CGFloat(((lbl.text?.count)! * 17) + 2)
//						print("stack contentSize w:\(stack.contentSize.width), h:\(stack.contentSize.height)")
						first = false
						break
					}
				}
			}
		}
		let falseBottom = UIView(frame: .zero)
		stack.addArrangedSubview(falseBottom)
		return stack
	}
	
	func makeTag(string: String) -> UIView
	{
		let tagView = UIView()
		//tagView.translatesAutoresizingMaskIntoConstraints = false
		tagView.backgroundColor = R.color.YumaRed
		tagView.borderColor = R.color.YumaDRed
		//tag.borderWidth = 1
		tagView.cornerRadius = 5
		let tagHole = UIView()
		tagHole.translatesAutoresizingMaskIntoConstraints = false
		tagHole.backgroundColor = UIColor.white
		tagHole.borderColor = R.color.YumaDRed
		//tagHole.borderWidth = 1
		tagHole.shadowColor = UIColor.black
		tagHole.shadowOffset = CGSize(width: -1, height: -1)
		tagHole.shadowRadius = 2
		tagHole.shadowOpacity = 1
		let tagBlock1 = UIView()
		tagBlock1.translatesAutoresizingMaskIntoConstraints = false
		tagBlock1.backgroundColor = UIColor.white
		let tagBlock2 = UIView()
		tagBlock2.translatesAutoresizingMaskIntoConstraints = false
		tagBlock2.backgroundColor = UIColor.white
		let tagLbl = UILabel()
		tagLbl.translatesAutoresizingMaskIntoConstraints = false
		tagLbl.text = "   " + string + " "
		tagLbl.textColor = R.color.YumaYel
		tagLbl.font = UIFont.systemFont(ofSize: 11)
		tagView.addSubview(tagLbl)
		NSLayoutConstraint.activate([
			tagLbl.topAnchor.constraint(equalTo: tagView.topAnchor, constant: 5.5),
			tagLbl.leadingAnchor.constraint(equalTo: tagView.leadingAnchor, constant: 11),
			tagLbl.bottomAnchor.constraint(equalTo: tagView.bottomAnchor, constant: -5.5),
			tagLbl.trailingAnchor.constraint(equalTo: tagView.trailingAnchor, constant: -5),
			])
		tagView.addSubview(tagHole)
		NSLayoutConstraint.activate([
			tagHole.centerYAnchor.constraint(equalTo: tagView.centerYAnchor, constant: 0),
			tagHole.leadingAnchor.constraint(equalTo: tagView.leadingAnchor, constant: 9),
			tagHole.heightAnchor.constraint(equalToConstant: 4),
			tagHole.widthAnchor.constraint(equalToConstant: 4),
			])
		tagHole.cornerRadius = 5 / 2
		tagView.addSubview(tagBlock1)
		tagView.addSubview(tagBlock2)
		NSLayoutConstraint.activate([
			tagBlock1.topAnchor.constraint(equalTo: tagView.topAnchor, constant: -5),
			tagBlock1.leadingAnchor.constraint(equalTo: tagView.leadingAnchor, constant: -2),
			tagBlock1.bottomAnchor.constraint(equalTo: tagView.centerYAnchor, constant: 0),
			tagBlock1.widthAnchor.constraint(equalToConstant: 8),
			
			tagBlock2.topAnchor.constraint(equalTo: tagView.centerYAnchor, constant: 0),
			tagBlock2.leadingAnchor.constraint(equalTo: tagView.leadingAnchor, constant: -2),
			tagBlock2.bottomAnchor.constraint(equalTo: tagView.bottomAnchor, constant: 5),
			tagBlock2.widthAnchor.constraint(equalToConstant: 8),
			])
		tagBlock1.transform = CGAffineTransform(rotationAngle: .pi/180*45)
		tagBlock2.transform = CGAffineTransform(rotationAngle: -.pi/180*45)
		tagView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.displayCat(_:))))
		return tagView
	}
	
}
