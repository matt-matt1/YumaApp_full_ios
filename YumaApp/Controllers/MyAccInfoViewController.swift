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
	@IBOutlet weak var alreadyLabel: UILabel!
	@IBOutlet weak var loginLabel: UILabel!
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
	@IBOutlet weak var switch0Label: UILabel!
	@IBOutlet weak var switch1Label: UILabel!
	@IBOutlet weak var switch2Label: UILabel!
	@IBOutlet weak var switch1Label2: UILabel!
	@IBOutlet weak var switch2Label2: UILabel!
	@IBOutlet weak var buttonText: GradientButton!

	let store = DataStore.sharedInstance
	var customer: Customer?
	
	
	func setLabels()
	{
		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)	//navigation
		//let segmentedItem = [R.string.mr, R.string.mrs]
		genderSwitch.removeAllSegments()
		genderSwitch.insertSegment(withTitle: R.string.mr, at: 0, animated: false)
		genderSwitch.insertSegment(withTitle: R.string.mrs, at: 1, animated: false)
		genderSwitch.selectedSegmentIndex = 0
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
		field4Label.text = R.string.bDate
		field4Edit.textColor = R.color.YumaRed
		field4Border.layer.borderColor = UIColor.white.cgColor
		passwordInvalid.text = ""
		passwordLabel.text = R.string.txtPass
		passwordEdit.textColor = R.color.YumaRed
		passwordBorder.layer.borderColor = UIColor.white.cgColor
		switch0Label.text = R.string.offersFromPartners
		switch1Label.text = R.string.SignUpNewsletter
		switch1Label2.text = R.string.SignUpNewsletterMore
		switch2Label.text = R.string.custDataPriv
		switch2Label2.text = R.string.custDataPrivMore
		alreadyLabel.text = R.string.alreadyAcc
		loginLabel.text = R.string.loginInstead
		loginLabel.textColor = R.color.YumaRed
		loginLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(loginButtonAct(_:))))
		buttonText.setTitle(R.string.save, for: .normal)
	}
	
	private func getSubviewsOf<T : UIView>(view:UIView) -> [T]
	{
		var subviews = [T]()
		
		for subview in view.subviews
		{
			subviews += getSubviewsOf(view: subview) as [T]
			
			if let subview = subview as? T
			{
				subviews.append(subview)
			}
		}
		return subviews
	}
	
	func convertEntryToHorizontal(_ width: CGFloat)
	{
		let allStacks: [UIStackView] = getSubviewsOf(view: self.view)
		for myView in allStacks
		{
			if !(myView.superview?.isKind(of: UIStackView.self))! && !(myView.superview?.isKind(of: UIScrollView.self))! && myView.arrangedSubviews.count == 3
			{
				let eLabel = myView.arrangedSubviews[0]
				let eView = myView.arrangedSubviews[1]
				let stack = UIStackView()
				stack.axis = UILayoutConstraintAxis.horizontal
				stack.distribution = UIStackViewDistribution.fill
				stack.spacing = 10
				stack.bounds = eLabel.bounds
				eLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
				//eLabel.aligntextright
				stack.addArrangedSubview(eLabel)
				stack.addArrangedSubview(eView)
				myView.insertArrangedSubview(stack, at: 0)
			}
		}
	}
	
	@objc func alertMe(_ sender : Any)
	{
		print(sender)
		var mTitle: String, mMessage: String
		switch (sender)
		{
		case nil:
			mTitle = ""
			mMessage = ""
			break
		default:
			mTitle = ""
			mMessage = ""
		}
		let _ = UIAlertController(title: mTitle, message: mMessage, preferredStyle: .alert)
	}
	
	func setEmailField()
	{
		field3Edit.superview?.backgroundColor = UIColor.clear
		field3Edit.backgroundColor = UIColor.clear
		field3Edit.superview?.layer.borderWidth = 2
		field3Edit.superview?.layer.borderColor = UIColor.black.cgColor
		field3Edit.isEnabled = false
	}
	
	func getCustomer()
	{
		if store.customer == nil || store.customer?.lastname == ""
		{
			//			if store.customer.count > 0
			//			{
			//				//id_customer = Int(store.customer[0].id_customer!) ?? 3
			//				id_customer = Int(store.customer[0].id_customer!)!
			//			}
			//			else
			//			{
			//				id_customer = 3
			//			}
			let caStr = UserDefaults.standard.string(forKey: "Customer")
			//			let caStr = UserDefaults.standard.string(forKey: "CustomerAddresses")
//			if caStr == ""
//			{
//				let loading = UIViewController.displaySpinner(onView: self.view)
//				//if store.addresses.count == 0
//				store.
//			}
//			else
//			{
				var decoded: Customer
				do
				{
					decoded = try JSONDecoder().decode(Customer.self, from: (caStr?.data(using: .utf8))!)
					self.customer = decoded
					store.customer = decoded
				}
				catch let jsonErr
				{
					print(jsonErr)
				}
//			}
		}
		else
		{
			self.customer = store.customer
		}
	}

	
	func fillFields()
	{
		genderSwitch.setEnabled(true, forSegmentAt: Int((self.customer?.id_gender!)!)!)
		fieldEdit1.text = self.customer?.firstname
		field2Edit.text = self.customer?.lastname
		field3Edit.text = self.customer?.email
		field3Label.isHidden = true
		field4Edit.text = self.customer?.birthday
		if self.customer?.optin != nil
		{
			switch0.setOn((self.customer?.optin == "1"), animated: false)
		}
		if self.customer?.newsletter != nil
		{
			switch0.setOn((self.customer?.newsletter == "1"), animated: false)
		}
		switch0.setOn(false, animated: false)
	}
	
	@objc func loginButtonAct(_ sender: Any)
	{
		self.dismiss(animated: false, completion: nil)
	}
	
	@IBAction func buttonAct(_ sender: Any)
	{
	}
	@IBAction func navCloseAct(_ sender: Any)
	{
		self.dismiss(animated: false, completion: nil)
	}
	

	override func viewDidLoad()
	{
        super.viewDidLoad()
		getCustomer()
		if #available(iOS 11.0, *)
		{
			navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		}
		else
		{
			navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
		}
//		if self.view.frame.width > 400
//		{
//			convertEntryToHorizontal(125)
//		}
		switch0Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertMe(_:))))
		switch1Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertMe(_:))))
		switch2Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertMe(_:))))
        setLabels()
		if store.customer != nil && store.customer?.lastname != ""
		{
			setEmailField()
			buttonText.setTitle(R.string.upd.uppercased(), for: .normal)
			fillFields()
		}
		else
		{
			navTitle.title = R.string.createAcc
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
}
