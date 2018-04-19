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
	@IBOutlet weak var switch1Group: UIView!
	@IBOutlet weak var switch2Label2: UILabel!
	@IBOutlet weak var switch2Group: UIView!
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
		buttonText.setTitle(R.string.save.uppercased(), for: .normal)
		buttonText.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
	}
	
//	private func getSubviewsOf<T : UIView>(view:UIView) -> [T]
//	{
//		var subviews = [T]()
//
//		for subview in view.subviews
//		{
//			subviews += getSubviewsOf(view: subview) as [T]
//
//			if let subview = subview as? T
//			{
//				subviews.append(subview)
//			}
//		}
//		return subviews
//	}
//
//	func convertEntryToHorizontal(_ width: CGFloat)
//	{
//		let allStacks: [UIStackView] = getSubviewsOf(view: self.view)
//		for myView in allStacks
//		{
//			if !(myView.superview?.isKind(of: UIStackView.self))! && !(myView.superview?.isKind(of: UIScrollView.self))! && myView.arrangedSubviews.count == 3
//			{
//				let eLabel = myView.arrangedSubviews[0]
//				let eView = myView.arrangedSubviews[1]
//				let stack = UIStackView()
//				stack.axis = UILayoutConstraintAxis.horizontal
//				stack.distribution = UIStackViewDistribution.fill
//				stack.spacing = 10
//				stack.bounds = eLabel.bounds
//				eLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
//				//eLabel.aligntextright
//				stack.addArrangedSubview(eLabel)
//				stack.addArrangedSubview(eView)
//				myView.insertArrangedSubview(stack, at: 0)
//			}
//		}
//	}
	
	@objc func alertMe(_ sender: UITapGestureRecognizer)
	{
		let str = (sender.view?.subviews[0].subviews[0] as! UILabel).text!
		var mTitle: String, mMessage: String
		switch (str)
		{
		case switch1Label.text!:
			mTitle = switch1Label.text!
			mMessage = switch1Label2.text!
			break
		case switch2Label.text!:
			mTitle = switch2Label.text!
			mMessage = switch2Label2.text!
			break
		default:
			mTitle = ""
			mMessage = ""
		}
		//let alert = UIAlertController(title: mTitle, message: mMessage, preferredStyle: .alert)
		//alert.addAction(UIAlertAction(title: R.string.dismiss, style: .default, handler: nil))
		//self.present(alert, animated: true, completion: nil)
		store.Alert(fromView: self, title: mTitle, titleColor: R.color.YumaRed, /*titleBackgroundColor: <#T##UIColor?#>, titleFont: <#T##UIFont?#>,*/ message: mMessage, /*messageColor: <#T##UIColor?#>, messageBackgroundColor: <#T##UIColor?#>, messageFont: <#T##UIFont?#>,*/ dialogBackgroundColor: R.color.YumaYel, backgroundBackgroundColor: R.color.YumaRed, /*backgroundBlurStyle: <#T##UIBlurEffectStyle?#>, backgroundBlurFactor: <#T##CGFloat?#>,*/ borderColor: R.color.YumaDRed, borderWidth: 2, /*cornerRadius: <#T##CGFloat?#>,*/ shadowColor: R.color.YumaDRed, /*shadowOffset: <#T##CGSize?#>, shadowOpacity: <#T##Float?#>,*/ shadowRadius: 5, /*alpha: <#T##CGFloat?#>,*/ hasButton1: true, button1Title: R.string.dismiss, /*button1Style: <#T##UIAlertActionStyle?#>, button1Color: <#T##UIColor?#>, button1Font: <#T##UIFont?#>, button1Action: <#T##DataStore.Closure_Void?##DataStore.Closure_Void?##() -> Void#>,*/ hasButton2: false/*, button2Title: <#T##String?#>, button2Style: <#T##UIAlertActionStyle?#>, button2Color: <#T##UIColor?#>, button2Font: <#T##UIFont?#>, button2Action: <#T##DataStore.Closure_Void?##DataStore.Closure_Void?##() -> Void#>*/)
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
			if caStr != nil
			{
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
			}
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
		var edited = customer
//		var edited = Customer(id: store.customer?.id, id_customer: store.customer?.id_customer, id_default_group: store.customer?.id_default_group, id_lang: store.customer?.id_lang, newsletter_date_add: store.customer?.newsletter_date_add, ip_registration_newsletter: store.customer?.ip_registration_newsletter, last_passwd_gen: store.customer?.last_passwd_gen, secure_key: store.customer?.secure_key, deleted: store.customer?.deleted, passwd: (store.customer?.passwd)!, lastname: (store.customer?.lastname)!, firstname: (store.customer?.firstname)!, email: (store.customer?.email)!, id_gender: store.customer?.id_gender, birthday: store.customer?.birthday, newsletter: store.customer?.newsletter, optin: store.customer?.optin, website: store.customer?.website, company: store.customer?.company, siret: store.customer?.siret, ape: store.customer?.ape, outstanding_allow_amount: store.customer?.outstanding_allow_amount, show_public_prices: store.customer?.show_public_prices, id_risk: store.customer?.id_risk, max_payment_days: store.customer?.max_payment_days, active: store.customer?.active, note: store.customer?.note, is_guest: store.customer?.is_guest, id_shop: store.customer?.id_shop, id_shop_group: store.customer?.id_shop_group, date_add: store.customer?.date_add, date_upd: store.customer?.date_upd, reset_password_token: store.customer?.reset_password_token, reset_password_validity: store.customer?.reset_password_validity, associations: store.customer?.associations)
		if true//changed ie. edited
		{
			let now = Date()
			let df = DateFormatter()
			df.dateFormat = "yyyy-MM-dd HH:mm:ss"
			edited?.date_upd = df.string(from: now)
			edited?.firstname = fieldEdit1.text!
			edited?.lastname = field2Edit.text!
			edited?.birthday = field4Edit.text
			edited?.optin = String(switch0.isOn)
			edited?.newsletter = String(switch1.isOn)
			edited?.active = String(switch2.isOn)
		}
		let str = PSWebServices.object2psxml(object: edited!, resource: "customers", resource2: "customer")
		print(str)
//		PSWebServices.postCustomer(XMLStr: str)
//		{
//			(error) in
//			if let error = error
//			{
//				print("fatal error: ", String(error.localizedDescription))
//			}
//		}
	}
	@IBAction func navCloseAct(_ sender: Any)
	{
		self.dismiss(animated: false, completion: nil)
	}
	

	override func viewDidLoad()
	{
        super.viewDidLoad()
		/*
Unable to simultaneously satisfy constraints.
Probably at least one of the constraints in the following list is one you don't want.
Try this:
(1) look at each constraint and try to figure out which you don't expect;
(2) find the code that added the unwanted constraint or constraints and fix it.
(
"<NSLayoutConstraint:0x146256a0 H:[UILabel:0x14632db0'Email Address'(120)]>",
"<NSLayoutConstraint:0x145fa9b0 'UISV-hiding' H:[UILabel:0x14632db0'Email Address'(0)]>"
)

Will attempt to recover by breaking constraint
<NSLayoutConstraint:0x146256a0 H:[UILabel:0x14632db0'Email Address'(120)]>

Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
2018-03-13 09:29:53.420 YumaApp[485:15120] Unable to simultaneously satisfy constraints.
Probably at least one of the constraints in the following list is one you don't want.
Try this:
(1) look at each constraint and try to figure out which you don't expect;
(2) find the code that added the unwanted constraint or constraints and fix it.
(
"<NSLayoutConstraint:0x1461a580 UIStackView:0x1461eda0.top == UIView:0x1461eeb0.topMargin>",
"<NSLayoutConstraint:0x14535960 UINavigationBar:0x14538250.top == UIView:0x1461eeb0.top + 20>",
"<NSLayoutConstraint:0x1451e990 'UISV-canvas-connection' UIStackView:0x1461eda0.top == UINavigationBar:0x14538250.top>"
)

Will attempt to recover by breaking constraint
<NSLayoutConstraint:0x1451e990 'UISV-canvas-connection' UIStackView:0x1461eda0.top == UINavigationBar:0x14538250.top>*/
		getCustomer()
		if #available(iOS 11.0, *)
		{
			navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		}
		else
		{
//			navBar.superview?.constraints.forEach({ (constraint) in
//				if constraint.firstAnchor === navBar && constraint.firstAttribute == .top
//				{
					navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
//				}
//			})
		}
//		if self.view.frame.width > 400
//		{
//			convertEntryToHorizontal(125)
//		}
		navHelp.title = FontAwesome.questionCircle.rawValue
		navHelp.setTitleTextAttributes([NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)], for: .normal)
		switch1Group.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(alertMe(_:))))
		switch2Group.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertMe(_:))))
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
			buttonText.setTitle(R.string.createAcc.uppercased(), for: .normal)
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
