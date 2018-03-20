//
//  ServicesCell.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-06.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class ServicesCell: UICollectionViewCell
{
	@IBOutlet weak var prodImage: UIImageView!
	@IBOutlet weak var prodPrice: UILabel!
	@IBOutlet weak var prodName: UILabel!
	@IBOutlet weak var detailBtn: UIButton!
	
	@IBOutlet weak var prodImage2: UIImageView!
	@IBOutlet weak var prodName2: UILabel!
	@IBOutlet weak var prodPrice2: UILabel!
	@IBOutlet weak var prodDesc: UILabel!
	@IBOutlet weak var prodNotes: UILabel!
	@IBOutlet weak var prodCats: UIView!
	@IBOutlet weak var prodShare: UIView!
	@IBOutlet weak var mainBtn: UIButton!
	var id_lang = 0
	var page: aProduct?
	{
		didSet
		{
			//print(page?.name ?? "getting page")
			guard let unwrap = page else
			{
				return
			}
			prodName.text = unwrap.name![id_lang].value
			prodName2.text = unwrap.name![id_lang].value
			//			prodImage.image = UIImage(named: unwrap.imageName)//id_default_image
			if unwrap.showPrice == "1"
			{
				prodPrice.text = unwrap.price
				prodPrice2.text = unwrap.price
			}
			prodDesc.text = "\(unwrap.description![id_lang].value ?? "") \n\(unwrap.description_short![id_lang].value ?? "")"
			if unwrap.id_manufacturer != ""
			{
				//
			}
			if unwrap.id_supplier != ""
			{
				//
			}
			var cats: String = ""
			for cat in (unwrap.associations?.categories)!
			{
				cats += cat.id!
			}
			let _ = unwrap.id
		}
	}
	
	override init(frame: CGRect)
	{
		super.init(frame: frame)
		//backgroundColor = .green
		prodImage = UIImageView(image: R.image.homeSliderCartridges)
		//		addSubview(prodImage)
		//		prodName.text = "Product Name"
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
	
	
	@IBAction func detailsBtnAct(_ sender: Any)
	{
		//show details page
	}
	
	@IBAction func mainBtnAct(_ sender: Any)
	{
		//show main page
	}
}
