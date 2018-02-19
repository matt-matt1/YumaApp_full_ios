//
//  MyAccInfoViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-15.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class MyAccInfoViewController: UIViewController
{
	@IBOutlet weak var navBar: UINavigationBar!
	@IBOutlet weak var navTitle: UINavigationItem!
	@IBOutlet weak var navClose: UIBarButtonItem!
	@IBOutlet weak var navHelp: UIBarButtonItem!
	@IBOutlet weak var genderSwitch: UISegmentedControl!
	@IBOutlet weak var genderBorder: UIView!
	@IBOutlet weak var fieldLabel1: UILabel!
	@IBOutlet weak var fieldEdit1: UITextField!
	@IBOutlet weak var fieldInvalid1: UILabel!
	@IBOutlet weak var fieldBorder1: UIView!
	@IBOutlet weak var field2Label: UILabel!
	@IBOutlet weak var field2Edit: UITextField!
	@IBOutlet weak var field2Invalid: UILabel!
	@IBOutlet weak var field2Border: UIView!
	@IBOutlet weak var field3Label: UILabel!
	@IBOutlet weak var field3Edit: UITextField!
	@IBOutlet weak var field3Invalid: UILabel!
	@IBOutlet weak var field3Border: UIView!
	@IBOutlet weak var buttonText: GradientButton!
	@IBOutlet weak var alreadyLabel: UILabel!
	@IBOutlet weak var loginLabel: UILabel!
	@IBOutlet weak var switch0Label: UILabel!
	@IBOutlet weak var switch1Label: UILabel!
	@IBOutlet weak var switch2Label: UILabel!
	@IBOutlet weak var field4Border: UIView!
	@IBOutlet weak var field4Label: UILabel!
	@IBOutlet weak var field4Edit: UITextField!
	@IBOutlet weak var field4Invalid: UILabel!
	@IBOutlet weak var passwordBorder: UIView!
	@IBOutlet weak var passwordLabel: UILabel!
	@IBOutlet weak var passwordEdit: UITextField!
	@IBOutlet weak var passwordShow: UILabel!
	@IBOutlet weak var passwordInvalid: UILabel!
	@IBOutlet weak var switch0: UISwitch!
	@IBOutlet weak var switch1: UISwitch!
	@IBOutlet weak var switch2: UISwitch!
	@IBOutlet weak var switch1Label2: UILabel!
	@IBOutlet weak var switch2Label2: UILabel!
	
	let store = DataStore.sharedInstance
	
	
	func setLabels()
	{
		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)	//navigation
		genderBorder.layer.borderColor = UIColor.white.cgColor
		fieldInvalid1.text = ""
		fieldLabel1.text = R.string.fName
		fieldEdit1.textColor = R.color.YumaRed
		fieldBorder1.layer.borderColor = UIColor.white.cgColor
		field2Invalid.text = ""
		field2Label.text = R.string.lName
		field2Edit.textColor = R.color.YumaRed
		field2Border.layer.borderColor = UIColor.white.cgColor
		field3Invalid.text = ""
		field3Label.text = R.string.emailAddr
		field3Edit.textColor = R.color.YumaRed
		field3Border.layer.borderColor = UIColor.white.cgColor
		field4Invalid.text = ""
		field4Label.text = R.string.emailAddr
		field4Edit.textColor = R.color.YumaRed
		field4Border.layer.borderColor = UIColor.white.cgColor
		passwordInvalid.text = ""
		passwordLabel.text = R.string.emailAddr
		passwordEdit.textColor = R.color.YumaRed
		passwordBorder.layer.borderColor = UIColor.white.cgColor
		switch0Label.text = R.string.offersFromPartners
		switch1Label.text = R.string.SignUpNewsletter
		switch1Label2.text = R.string.SignUpNewsletterMore
		switch2Label.text = R.string.custDataPriv
		switch2Label2.text = R.string.custDataPrivMore
		alreadyLabel.text = R.string.alreadyAcc
		loginLabel.text = R.string.login
		loginLabel.textColor = R.color.YumaRed
		loginLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(loginButtonAct(_:))))
	}
	
	func setEmailField()
	{
		//field3Edit.superview?.backgroundColor = UIColor.black
		field3Edit.superview?.backgroundColor = UIColor.clear
		field3Edit.backgroundColor = UIColor.clear
		field3Edit.superview?.layer.borderWidth = 2
		field3Edit.superview?.layer.borderColor = UIColor.black.cgColor
		field3Edit.isEnabled = false
	}
	
	func fillFields()
	{
		//var customer: Customer = store.customer[0]
		//let customer: Customer = store.customer[0] as Customer
		//{
		genderSwitch.setEnabled(true, forSegmentAt: Int(store.customer[0].id_gender!)!)
			fieldEdit1.text = store.customer[0].firstname
		field2Edit.text = store.customer[0].lastname
		field3Edit.text = store.customer[0].email
		field3Label.isHidden = true
		field4Edit.text = store.customer[0].birthday
		if store.customer[0].optin != nil
		{
			switch0.setOn((store.customer[0].optin == "1"), animated: false)
		}
		if store.customer[0].newsletter != nil
		{
			switch0.setOn((store.customer[0].newsletter == "1"), animated: false)
		}
		switch0.setOn(false, animated: false)
		//}
	}
	
	@objc func loginButtonAct(_ sender: Any)
	{
		self.present(LoginViewController(), animated: false, completion: nil)
	}
	
	
	override func viewDidLoad()
	{
        super.viewDidLoad()

        setLabels()
		if store.customer.count > 0
		{
			setEmailField()
			fillFields()
		}
    }

    override func didReceiveMemoryWarning()
	{
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
	@IBAction func buttonAct(_ sender: Any)
	{
	}
	@IBAction func navCloseAct(_ sender: Any)
	{
		self.dismiss(animated: false, completion: nil)
	}
	
}
