//
//  CustomProductView.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-12.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


class CustomView: UIView	// product cell view
{
	let prodImage: UIImageView =
	{
		let iv = UIImageView()
		iv.translatesAutoresizingMaskIntoConstraints = false
		iv.contentMode = .scaleAspectFit
		return iv
	}()
	let prodName: UILabel =
	{
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.textAlignment = .center
		lbl.font = UIFont.boldSystemFont(ofSize: 25)
		return lbl
	}()
	let prodPrice: UILabel =
	{
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.font = UIFont.systemFont(ofSize: 21)
		lbl.textAlignment = .center
		return lbl
	}()
	let detailsBtn: UILabel =
	{
		let btn = UILabel()
		btn.translatesAutoresizingMaskIntoConstraints = false
		btn.textColor = .white
		btn.backgroundColor = .red
		btn.textAlignment = .center
		return btn
	}()
	let detailsView: UIView =
	{
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	let imageView: UIView =
	{
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	let imageFrame: UIView =
	{
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	var tags: [String] = []
	let tagsView: UIStackView =
	{
		let sv = UIStackView()
		sv.translatesAutoresizingMaskIntoConstraints = false
		return sv
	}()
	let prodManImage: UIImageView =
	{
		let iv = UIImageView()
		iv.translatesAutoresizingMaskIntoConstraints = false
		iv.contentMode = .scaleAspectFit
		return iv
	}()
	let manufacturerView = UILabel()
	let descLong: UILabel =
	{
		let lab = UILabel()
		lab.translatesAutoresizingMaskIntoConstraints = false
		return lab
	}()
	let descShort: UILabel =
	{
		let lab = UILabel()
		lab.translatesAutoresizingMaskIntoConstraints = false
		return lab
	}()
	var categories: [aCategory] = []
	let categoriesView: UIStackView =
	{
		let sv = UIStackView()
		sv.translatesAutoresizingMaskIntoConstraints = false
		return sv
	}()
	var combinations: [Combination] = []
	let combinationsView = UIStackView()
	let shareView = UIStackView()
	var linkRewrite = ""
	let productOptionValuesView: UIStackView =
	{
		let sv = UIStackView()
		sv.translatesAutoresizingMaskIntoConstraints = false
		return sv
	}()
	let imagesView: UIStackView =
	{
		let sv = UIStackView()
		sv.translatesAutoresizingMaskIntoConstraints = false
		return sv
	}()
	
	
	override init(frame: CGRect)
	{
		super.init(frame: frame)
		
		//		imageFrame.shadowColor = UIColor.gray
		//		imageFrame.shadowOffset = CGSize(width: 1, height: 1)
		//		imageFrame.shadowRadius = 5
		//		imageFrame.shadowOpacity = 1
		imageFrame.addSubview(prodImage)
		NSLayoutConstraint.activate([
			prodImage.topAnchor.constraint(equalTo: imageFrame.topAnchor/*, constant: 5*/),
			prodImage.trailingAnchor.constraint(equalTo: imageFrame.trailingAnchor/*, constant: -5*/),
			prodImage.leadingAnchor.constraint(equalTo: imageFrame.leadingAnchor/*, constant: 5*/),
			prodImage.bottomAnchor.constraint(equalTo: imageFrame.bottomAnchor/*, constant: -5*/),
			])
		
		//		imageView.shadowColor = UIColor.red
		//		imageView.shadowOffset = CGSize(width: 1, height: 1)
		//		imageView.shadowRadius = 5
		//		imageView.shadowOpacity = 1
		imageView.addSubview(imageFrame)
		NSLayoutConstraint.activate([
			imageFrame.topAnchor.constraint(equalTo: imageView.topAnchor/*, constant: 5*/),
			imageFrame.trailingAnchor.constraint(equalTo: imageView.trailingAnchor/*, constant: -5*/),
			imageFrame.leadingAnchor.constraint(equalTo: imageView.leadingAnchor/*, constant: 5*/),
			imageFrame.bottomAnchor.constraint(equalTo: imageView.bottomAnchor/*, constant: -5*/),
//			imageFrame.heightAnchor.constraint(equalToConstant: 200),
			])
		
		let stack1 = UIStackView(arrangedSubviews: [imageView, prodName, prodPrice, /*detailsView*/])
		stack1.axis = .vertical
		stack1.spacing = (self.frame.height > 400) ? (self.frame.height > 800) ? 15 : 10 : 5
		stack1.translatesAutoresizingMaskIntoConstraints = false
		stack1.distribution = UIStackViewDistribution.fill
		//stack1.alignment = UIStackViewAlignment.center
		stack1.backgroundColor = .gray
		
		if detailsBtn.text != nil && detailsBtn.text != ""
		{
			detailsView.addSubview(detailsBtn)
			stack1.addArrangedSubview(detailsView)
			NSLayoutConstraint.activate([
				detailsBtn.topAnchor.constraint(equalTo: detailsView.topAnchor),
				detailsBtn.trailingAnchor.constraint(equalTo: detailsView.trailingAnchor),//, constant: 5),
				detailsBtn.leadingAnchor.constraint(equalTo: detailsView.trailingAnchor, constant: -80),
				detailsBtn.heightAnchor.constraint(equalToConstant: 21),
				])
		}
		//stack2
		let stack2 = UIStackView()
		stack2.axis = .vertical
		stack2.spacing = (self.frame.height > 400) ? (self.frame.height > 800) ? 15 : 10 : 5
		stack2.translatesAutoresizingMaskIntoConstraints = false
		stack2.distribution = UIStackViewDistribution.fill
		stack2.backgroundColor = .gray

		categoriesView.translatesAutoresizingMaskIntoConstraints = false
		//categoriesView.distribution = UIStackViewDistribution.fill
		categoriesView.spacing = 10
//		if categories.count > 0
//		{
//			for co in categories
//			{
//				let lbl = UILabel()
//				lbl.text = String(describing: co)
//				lbl.translatesAutoresizingMaskIntoConstraints = false
//				categoriesView.addArrangedSubview(lbl)
//			}
			stack2.addArrangedSubview(categoriesView)
//		}

//		if tagsView.subviews.count > 0
//		{
			stack2.addArrangedSubview(tagsView)
//		}

		descLong.translatesAutoresizingMaskIntoConstraints = false
//		if descLong.text != ""
//		{
//			stack2.addArrangedSubview(descLong)
//		}

		descShort.translatesAutoresizingMaskIntoConstraints = false
		if descShort.text != ""
		{
			stack2.addArrangedSubview(descShort)
		}

		combinationsView.translatesAutoresizingMaskIntoConstraints = false
		combinationsView.spacing = 10
		if combinations.count > 0
		{
			for co in combinations
			{
				let lbl = UILabel()
				lbl.text = String(describing: co)
				lbl.translatesAutoresizingMaskIntoConstraints = false
				combinationsView.addArrangedSubview(lbl)
			}
			stack2.addArrangedSubview(combinationsView)
		}

		shareView.translatesAutoresizingMaskIntoConstraints = false
		shareView.distribution = UIStackViewDistribution.fill
		shareView.spacing = 5
		if shareView.subviews.count > 0
		{
			stack2.addArrangedSubview(shareView)
		}

		manufacturerView.translatesAutoresizingMaskIntoConstraints = false
		if manufacturerView.subviews.count > 0
		{
			stack2.addArrangedSubview(manufacturerView)
		}
		//stack
		let stack = UIStackView(arrangedSubviews: [stack1, stack2])
		stack.axis = .vertical
		stack.spacing = (self.frame.height > 400) ? (self.frame.height > 800) ? 15 : 10 : 5
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.distribution = UIStackViewDistribution.fill
		//stack1.alignment = UIStackViewAlignment.center
		stack.backgroundColor = .gray
//		stack.addArrangedSubview(stack2)

		NSLayoutConstraint.activate([
//			prodImage.leadingAnchor.constraint(equalTo: stack.leadingAnchor),//, constant: 5),//),//
//			prodImage.topAnchor.constraint(equalTo: stack.topAnchor),
//			prodImage.trailingAnchor.constraint(equalTo: stack.trailingAnchor),//, constant: 5),
//			prodImage.heightAnchor.constraint(equalToConstant: 200),
			imageView.topAnchor.constraint(equalTo: stack1.topAnchor),
			imageView.leadingAnchor.constraint(equalTo: stack1.leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: stack1.trailingAnchor),
			imageView.heightAnchor.constraint(equalToConstant: 200),
			
			prodName.leadingAnchor.constraint(equalTo: stack1.leadingAnchor),//, constant: 5),
			prodName.trailingAnchor.constraint(equalTo: stack1.trailingAnchor),//, constant: 5),
			prodName.heightAnchor.constraint(equalToConstant: 30),
			
			prodPrice.leadingAnchor.constraint(equalTo: stack1.leadingAnchor),//, constant: 5),
			prodPrice.trailingAnchor.constraint(equalTo: stack1.trailingAnchor),//, constant: 5),
			prodPrice.heightAnchor.constraint(equalToConstant: 25),
			
//			detailsView.leadingAnchor.constraint(equalTo: stack1.leadingAnchor),//, constant: 5),
//			detailsView.trailingAnchor.constraint(equalTo: stack1.trailingAnchor),//, constant: 5),
//			detailsView.heightAnchor.constraint(equalToConstant: 20),
			])

		if detailsBtn.text != nil && detailsBtn.text != ""
		{
			NSLayoutConstraint.activate([
				detailsView.leadingAnchor.constraint(equalTo: stack1.leadingAnchor),//, constant: 5),
				detailsView.trailingAnchor.constraint(equalTo: stack1.trailingAnchor),//, constant: 5),
				detailsView.heightAnchor.constraint(equalToConstant: 20),
			])
		}
		
		self.addSubview(stack)
		NSLayoutConstraint.activate([
			stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			stack.topAnchor.constraint(equalTo: self.topAnchor),
//			stack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
			stack.widthAnchor.constraint(equalTo: self.widthAnchor/*, constant: -20*/),
			])
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
/*
	func fillTags(tagNames: [String]) -> UIStackView
	{
		let tagsSV = UIStackView()
		if tagNames.count > 0
		{
			tagsSV.translatesAutoresizingMaskIntoConstraints = false
			tagsSV.distribution = UIStackViewDistribution.fill
			tagsSV.spacing = 10
			for tag in tagNames
			{
				let tagLabel = TagLabel()
				tagLabel.text = tag
				tagsSV.addArrangedSubview(tagLabel)
			}
		}
		return tagsSV
	}
*/
}


/*
class TagLabel: UIView
{
	var text = ""
	var tagBorderColor = R.color.YumaDRed
	var tagShadowColor = UIColor.gray
	var tagShadowOffset = CGSize(width: 3, height: 3)
	var tagShadowRadius: CGFloat = 5
	var tagShadowOpacity: Float = 1
	var tagCornerRadius: CGFloat = 5
	var tagBackgroundColor = R.color.YumaRed
	var minWidth: CGFloat = 20
	var height: CGFloat = 45
	var tagHoleBackgroundColor = UIColor.white
	var tagHoleBorderColor = R.color.YumaDRed
	var textColor = R.color.YumaYel
	var textLeadingMargin: CGFloat = 5
	var textTrailingMargin: CGFloat = 5
	var tagHoleWidth: CGFloat = 10
	var tagHoleHeight: CGFloat = 10

	
	override init(frame: CGRect)
	{
		super.init(frame: frame)

		let tagHolePosition: CGFloat = self.frame.width - 6

		self.backgroundColor = tagBackgroundColor
		self.borderColor = tagBorderColor
		self.shadowColor = tagShadowColor
		self.shadowOffset = tagShadowOffset
		self.shadowRadius = tagShadowRadius
		self.shadowOpacity = tagShadowOpacity
		self.cornerRadius = tagCornerRadius
		self.widthAnchor.constraint(greaterThanOrEqualToConstant: minWidth).isActive = true
		self.heightAnchor.constraint(equalToConstant: height).isActive = true
		let tagInnerCircle = UIView()
		tagInnerCircle.backgroundColor = tagHoleBackgroundColor
		tagInnerCircle.borderColor = tagHoleBorderColor
		tagInnerCircle.shadowColor = tagShadowColor
		tagInnerCircle.shadowOffset = tagShadowOffset
		tagInnerCircle.shadowRadius = tagShadowRadius
		tagInnerCircle.shadowOpacity = tagShadowOpacity
		tagInnerCircle.clipsToBounds = true
		let tagText = UILabel()
		tagText.translatesAutoresizingMaskIntoConstraints = false
		tagText.textColor = textColor
		tagText.text = text
		self.addSubview(tagText)
		tagText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: textLeadingMargin).isActive = true
		tagText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: textTrailingMargin).isActive = true
		tagText.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		self.addSubview(tagInnerCircle)
		tagInnerCircle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		tagInnerCircle.widthAnchor.constraint(equalToConstant: tagHoleWidth).isActive = true
		tagInnerCircle.heightAnchor.constraint(equalToConstant: tagHoleHeight).isActive = true
		tagInnerCircle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: tagHolePosition).isActive = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
*/
