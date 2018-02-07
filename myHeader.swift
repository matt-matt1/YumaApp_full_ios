//
//  myHeader.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-06.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class MyHeader: UITableViewHeaderFooterView {

	@IBOutlet var whole: XibView!
	let headerNib = UINib.init(nibName: "MyHeader", bundle: Bundle.main)
	//tblItems.register(headerNib, forHeaderFooterViewReuseIdentifier: "MyHeader")
	weak var delegate: CustomHeaderDelegate?
	@IBOutlet weak var label: UILabel!
	
	var sectionNumber: Int!
	var showBack: Bool!
	
	@IBAction func backBtn(_ sender: Any) {
		delegate?.didTapButton(in: sectionNumber)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		Bundle.main.loadNibNamed("MyHeader", owner: self, options: nil)
		//self.addSubview(self.view)
	}
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

// if you want your header to be able to inform view controller of key events, create protocol

protocol CustomHeaderDelegate: class {
	func didTapButton(in section: Int)
}

