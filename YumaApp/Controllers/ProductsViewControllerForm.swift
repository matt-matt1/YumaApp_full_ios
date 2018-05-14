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
						//tagView.translatesAutoresizingMaskIntoConstraints = false
						stack.addArrangedSubview(tagView)
						break
					}
				}
			}
		}
		return stack
	}
	
	func formImageViews(imageIDs: [IdAsString]) -> UIStackView
	{
		let stack = UIStackView()
		//stack.translatesAutoresizingMaskIntoConstraints = false
		//		for prodComb in imageIDs
		//		{
		//			let find = Int(prodComb.id)!
		//			if find < store.images.count
		//			{
		//				for co in store.images
		//				{
		//					if co.id == find
		//					{
		//						view.imagesWidgets.append(co)
		//						break
		//					}
		//				}
		//			}
		//		}
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
							first = false
							let sep = UILabel()
							sep.translatesAutoresizingMaskIntoConstraints = false
							sep.text = " > "
							sep.textColor = UIColor.gray
							stack.addArrangedSubview(sep)
							//stack.addSubview(sep)
							//stack.contentSize.width += 53
							//print("stack contentSize w:\(stack.contentSize.width), h:\(stack.contentSize.height)")
						}
						let wrapperLbl = UIView()
						wrapperLbl.translatesAutoresizingMaskIntoConstraints = false
						let lbl = UILabel()
						lbl.translatesAutoresizingMaskIntoConstraints = false
						lbl.text = cat.name![store.myLang].value
						wrapperLbl.addSubview(lbl)
						NSLayoutConstraint.activate([
							wrapperLbl.topAnchor.constraint(equalTo: lbl.topAnchor),
							wrapperLbl.leadingAnchor.constraint(equalTo: lbl.leadingAnchor),
							wrapperLbl.bottomAnchor.constraint(equalTo: lbl.bottomAnchor),
							wrapperLbl.trailingAnchor.constraint(equalTo: lbl.trailingAnchor),
							])
						wrapperLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(displayCat(_:))))
						stack.addArrangedSubview(wrapperLbl)
						//stack.addSubview(wrapperLbl)
						//stack.contentSize.width += CGFloat(((lbl.text?.count)! * 17) + 2)
						//print("stack contentSize w:\(stack.contentSize.width), h:\(stack.contentSize.height)")
						first = false
						break
					}
				}
			}
		}
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
