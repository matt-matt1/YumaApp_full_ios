//
//  ChangePasswordViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-05-03.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


class ChangePasswordViewController: UIView
{
	@IBOutlet var contentView: UIView!
	@IBOutlet weak var exPassEntire: UIView!
	@IBOutlet weak var exPassLabel: UILabel!
	@IBOutlet weak var exPassEdit: UITextField!
	@IBOutlet weak var exPassShow: UILabel!
	@IBOutlet weak var exPassInvalid: UILabel!
	
	@IBOutlet weak var new1Entire: UIView!
	@IBOutlet weak var new1Label: UILabel!
	@IBOutlet weak var new1Edit: UITextField!
	@IBOutlet weak var new1Show: UILabel!
	@IBOutlet weak var new1Invalid: UILabel!

	@IBOutlet weak var new2Entire: UIView!
	@IBOutlet weak var new2Label: UILabel!
	@IBOutlet weak var new2Edit: UITextField!
	@IBOutlet weak var new2Show: UILabel!
	@IBOutlet weak var new2Invalid: UILabel!
	@IBOutlet weak var button: GradientButton!
	let store = DataStore.sharedInstance
	

	override init(frame: CGRect)
	{
		super.init(frame: frame)
		commonInit()
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		super.init(coder: aDecoder)
		commonInit()
	}
	
	func commonInit()
	{
		Bundle.main.loadNibNamed("ChangePasswordViewController", owner: self, options: nil)
		addSubview(contentView)
		contentView.frame = self.bounds
		contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
		clearFields()
		setLabels()
	}
	
	func clearFields()
	{
		exPassEntire.layer.borderColor = UIColor.clear.cgColor
		exPassEntire.layer.borderWidth = 2
		exPassInvalid.text = ""
		new1Entire.layer.borderColor = UIColor.clear.cgColor
		new1Entire.layer.borderWidth = 2
		new1Invalid.text = ""
		new2Entire.layer.borderColor = UIColor.clear.cgColor
		new2Entire.layer.borderWidth = 2
		new2Invalid.text = ""
	}

	func setLabels()
	{
		exPassLabel.text = R.string.exist
		new1Label.text = R.string.newPW
		new2Label.text = R.string.verify
		button.setTitle(R.string.changePass, for: .normal)
	}
	
	func checkFields() -> Bool
	{
		var passed = true
		if exPassEdit == nil || (exPassEdit.text?.isEmpty)!	//existing password incorrect
		{
			exPassInvalid.text = R.string.invalid
			exPassEntire.layer.borderColor = UIColor.red.cgColor
			passed = false
		}
		if new1Edit == nil || (new1Edit.text?.isEmpty)!		//password 1 doesn't meet requirements
		{
			new1Invalid.text = R.string.invalid
			new1Entire.layer.borderColor = UIColor.red.cgColor
			passed = false
		}
		if new2Edit == nil || new1Edit == nil || new2Edit.text != new1Edit.text	//passwords don't match
		{
			new2Invalid.text = R.string.invalid
			new2Entire.layer.borderColor = UIColor.red.cgColor
			passed = false
		}
		return passed
	}

	
	@IBAction func buttonAct(_ sender: Any)
	{
		store.flexView(view: self.button)
		if checkFields()
		{
			//OK
		}
	}

}
