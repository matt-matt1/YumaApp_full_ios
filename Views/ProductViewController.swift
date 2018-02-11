//
//  ProductViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-08.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController
{
	@IBOutlet weak var prodImage: UIImageView!
	@IBOutlet weak var prodPrice: UILabel!
	@IBOutlet weak var prodName: UILabel!
	@IBOutlet weak var detailBtn: UIButton!
	
	@IBOutlet weak var prodName2: UILabel!
	@IBOutlet weak var prodPrice2: UILabel!
	@IBOutlet weak var prodDesc: UILabel!
	@IBOutlet weak var prodNotes: UILabel!
	@IBOutlet weak var prodCats: UIView!
	@IBOutlet weak var prodShare: UIView!
	@IBOutlet weak var mainBtn: UIButton!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		//load current item details into fields
		//prodName = "\()"
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
