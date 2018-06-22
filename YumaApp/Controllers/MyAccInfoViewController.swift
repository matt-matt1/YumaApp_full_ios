//
//  MyAccInfoViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-15.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import SWXMLHash
import UIKit


class MyAccInfoViewController: UIViewController, UITextFieldDelegate
{
	@IBOutlet weak var stackElements: UIStackView!
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
	@IBOutlet weak var passwordInvalid: UILabel!
	@IBOutlet weak var passwordShow: UIView!
	@IBOutlet weak var showPass: UILabel!
	@IBOutlet weak var passwordGenerateLabel: UILabel!
	@IBOutlet weak var passwordGenerateDo: UIView!
	@IBOutlet weak var field5Border: UIView!
	@IBOutlet weak var field5Label: UILabel!
	@IBOutlet weak var field5Edit: UITextField!
	@IBOutlet weak var field5Invalid: UILabel!
	@IBOutlet weak var field6Border: UIView!
	@IBOutlet weak var field6Label: UILabel!
	@IBOutlet weak var field6Edit: UITextField!
	@IBOutlet weak var field7Border: UIView!
	@IBOutlet weak var field6Invalid: UILabel!
	@IBOutlet weak var field7Label: UILabel!
	@IBOutlet weak var field7Edit: UITextField!
	@IBOutlet weak var field7Invalid: UILabel!
	@IBOutlet weak var field8Border: UIView!
	@IBOutlet weak var field8Label: UILabel!
	@IBOutlet weak var field8Edit: UITextField!
	@IBOutlet weak var field8Invalid: UILabel!
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
	let helpPageControl = UIPageControl()
	let helpScrollView = UIScrollView()
	let store = DataStore.sharedInstance
	var customer: Customer?
	var addNew = false
	var passwordVisible = false
	static let selectBDate = Notification.Name("selectBDate")

	@IBOutlet weak var scrollForm: UIScrollView!
	
	// MARK: Overrides
	override func viewDidLoad()
	{
		super.viewDidLoad()
		getCustomer()
//		if #available(iOS 11.0, *)
//		{
//			navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//		}
//		else
//		{
//			//			navBar.superview?.constraints.forEach({ (constraint) in
//			//				if constraint.firstAnchor === navBar && constraint.firstAttribute == .top
//			//				{
//			navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
//			//				}
//			//			})
//		}
		//		if self.view.frame.width > 400
		//		{
		//			convertEntryToHorizontal(125)
		//		}
		navHelp.title = FontAwesome.questionCircle.rawValue
		navHelp.setTitleTextAttributes([NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)], for: .normal)
		navHelp.setTitleTextAttributes([
			NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)
			], for: UIControlState.highlighted)
		switch1Group.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(alertMe(_:))))
		switch2Group.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertMe(_:))))
		clearErrors()
		setLabels()
		passwordShow.isUserInteractionEnabled = true
		passwordShow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showPassAct(_:))))
		if store.customer != nil && store.customer?.lastname != ""
		{
			navTitle.title = R.string.my_account + " " + R.string.Info
			setEmailField()
			buttonText.setTitle(R.string.upd.uppercased(), for: .normal)
			passwordGenerateDo.subviews.first?.isHidden = true
			//showPass.isHidden = true//passwordShow.subviews.first?.isHidden = true
			passwordLabel.isUserInteractionEnabled = true
			passwordBorder.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changePasswd(_:))))
			fillFields()
		}
		else
		{
			addNew = true
			navTitle.title = R.string.createAcc
			buttonText.setTitle(R.string.createAcc.uppercased(), for: .normal)
			passwordGenerateDo.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(makePassword(_:))))
			passwordLabel.isUserInteractionEnabled = true
			passwordLabel.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(setPW(_:))))
		}
		let notificationCenter = NotificationCenter.default
		notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillHide, object: nil)
		notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
		notificationCenter.addObserver(self, selector: #selector(selectedADate(_:)), name: MyAccInfoViewController.selectBDate, object: nil)
	}


	override func didReceiveMemoryWarning()
	{
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


	// MARK: Methods
	func clearErrors()
	{
		genderBorder.layer.borderColor = UIColor.clear.cgColor
		fieldInvalid1.text = ""
		fieldBorder1.layer.borderColor = UIColor.clear.cgColor
		field2Invalid.text = ""
		field2Border.layer.borderColor = UIColor.clear.cgColor
		field3Invalid.text = ""
		field3Border.layer.borderColor = UIColor.clear.cgColor
		passwordInvalid.text = ""
		passwordBorder.layer.borderColor = UIColor.clear.cgColor
		field4Invalid.text = ""
		field4Border.layer.borderColor = UIColor.clear.cgColor
		field5Invalid.text = ""
		field5Border.layer.borderColor = UIColor.clear.cgColor
		field6Invalid.text = ""
		field6Border.layer.borderColor = UIColor.clear.cgColor
		field7Invalid.text = ""
		field7Border.layer.borderColor = UIColor.clear.cgColor
		field8Invalid.text = ""
		field8Border.layer.borderColor = UIColor.clear.cgColor
	}


	func textFieldShouldReturn(_ textField: UITextField) -> Bool
	{
		textField.resignFirstResponder()
		return true
	}


	@objc func getBDate(_ sender: UITapGestureRecognizer)
	{
		let vc = SelectDateVC()
		vc.modalTransitionStyle = .crossDissolve
		vc.modalPresentationStyle = .overCurrentContext
		vc.noteName = MyAccInfoViewController.selectBDate
//		print("notify: MyAccInfoViewController.\(MyAccInfoViewController.selectBDate.rawValue)")
		vc.datePicker.maximumDate = Date()
//		vc.datePicker.locale = Locale(identifier: "en_US_POSIX")
//		vc.datePicker.locale = Locale(identifier: "en_au")//ddMMMyyyy
//		vc.datePicker.locale = Locale(identifier: "en_uk")//ddMMMyyyy
//		vc.datePicker.locale = Locale(identifier: "en_ca")//MMMddyyyy
//		vc.datePicker.locale = Locale(identifier: "en_us")//MMMddyyyy
		if field4Edit.text != nil && !(field4Edit.text?.contains("-00"))!
		{
			vc.selectedDate = field4Edit.text!
		}
		else
		{
			vc.selectedDate = "2000-06-15"
		}
		self.present(vc, animated: false) {
			//
		}
	}


	func setLabels()
	{
		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
		//let segmentedItem = [R.string.mr, R.string.mrs]
		genderSwitch.removeAllSegments()
		genderSwitch.insertSegment(withTitle: R.string.mr, at: 0, animated: false)
		genderSwitch.insertSegment(withTitle: R.string.mrs, at: 1, animated: false)
		genderSwitch.selectedSegmentIndex = 0
		fieldLabel1.text = R.string.fName
		fieldEdit1.textColor = R.color.YumaRed
		fieldEdit1.returnKeyType = UIReturnKeyType.next
		field2Label.text = R.string.lName
		field2Edit.textColor = R.color.YumaRed
		field2Edit.returnKeyType = UIReturnKeyType.next
		field3Label.text = R.string.emailAddr
		field3Edit.textColor = R.color.YumaRed
		field3Edit.returnKeyType = UIReturnKeyType.next
		if store.custBDate == 1
		{
			field4Label.text = R.string.bDate
			field4Label.textAlignment = .center
			field4Label.backgroundColor = R.color.YumaYel.withAlphaComponent(0.5)
			field4Label.borderWidth = 1
			field4Label.borderColor = R.color.YumaRed
			field4Label.cornerRadius = 4
			field4Label.isUserInteractionEnabled = true
			field4Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(getBDate(_:))))
			field4Edit.placeholder = "YYYY-MM-DD"
			field4Edit.textColor = R.color.YumaRed
			field4Edit.returnKeyType = UIReturnKeyType.next
		}
		else
		{
			field4Border.removeFromSuperview()
		}
		passwordLabel.text = R.string.txtPass
		passwordLabel.textAlignment = .center
		passwordLabel.backgroundColor = R.color.YumaYel.withAlphaComponent(0.5)
		passwordLabel.borderWidth = 1
		passwordLabel.borderColor = R.color.YumaRed
		passwordLabel.cornerRadius = 4
		passwordEdit.textColor = R.color.YumaRed
		passwordEdit.placeholder = R.string.same
		passwordEdit.returnKeyType = UIReturnKeyType.next
		passwordGenerateLabel.text = ""
		(passwordGenerateDo.subviews.first as! UILabel).text = R.string.generate
		field5Label.text = R.string.co
		field5Edit.textColor = R.color.YumaRed
		field5Edit.placeholder = R.string.optional
		field5Edit.returnKeyType = UIReturnKeyType.next
		field6Label.text = R.string.website
		field6Edit.textColor = R.color.YumaRed
		field6Edit.placeholder = R.string.optional
		field6Edit.returnKeyType = UIReturnKeyType.next
		field7Label.text = R.string.siret
		field7Edit.placeholder = R.string.optional
		field7Edit.textColor = R.color.YumaRed
		field7Edit.returnKeyType = UIReturnKeyType.next
		field8Label.text = R.string.ape
		field8Edit.textColor = R.color.YumaRed
		field8Edit.placeholder = R.string.optional
		field8Edit.returnKeyType = UIReturnKeyType.next
		switch0Label.text = R.string.offersFromPartners
		switch1Label.text = R.string.SignUpNewsletter
		switch1Label2.text = R.string.SignUpNewsletterMore
		switch1.isOn = store.custOptin==1 ? true : false
		switch2Label.text = R.string.custDataPriv
		switch2Label2.text = R.string.custDataPrivMore
		buttonText.setTitle(R.string.save.uppercased(), for: .normal)
		buttonText.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
	}


	func setEmailField()
	{
		field3Border.backgroundColor = UIColor.clear
		field3Edit.backgroundColor = UIColor.clear
//		field3Edit.superview?.backgroundColor = UIColor.clear			//red border
//		field3Edit.backgroundColor = UIColor.clear						//field bg
//		field3Edit.superview?.layer.borderWidth = 2						//border
//		field3Edit.superview?.layer.borderColor = UIColor.black.cgColor
		field3Edit.isEnabled = false									//prevent editing
	}


	func getCustomer()
	{
		if store.customer == nil || store.customer?.lastname == ""
		{
			let caStr = UserDefaults.standard.string(forKey: "Customer")
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
		genderSwitch.setEnabled(true, forSegmentAt: Int((self.customer?.idGender!)!))
		fieldEdit1.text = self.customer?.firstname
		field2Edit.text = self.customer?.lastname
		field3Edit.text = self.customer?.email
		//field3Label.alpha = 0//.isHidden = true
		field3Edit.textColor = UIColor.darkGray
		let df = DateFormatter()
		df.dateFormat = "yyyy-MM-dd"
		if self.customer?.birthday != nil
		{
			field4Edit.text = df.string(from: (self.customer?.birthday)!)
		}
		field5Edit.text = self.customer?.company
		field6Edit.text = self.customer?.website
		field7Edit.text = self.customer?.siret
		field8Edit.text = self.customer?.ape
		if self.customer?.optin != nil
		{
//			switch0.setOn((self.customer?.optin == "1"), animated: false)
			switch0.setOn((self.customer?.optin)!, animated: false)
		}
		if self.customer?.newsletter != nil
		{
//			switch0.setOn((self.customer?.newsletter == "1"), animated: false)
			switch0.setOn((self.customer?.newsletter)!, animated: false)
		}
		switch0.setOn(false, animated: false)
	}


	func areFieldsValid() -> Bool
	{
		clearErrors()
		var passed = true
		if fieldEdit1.text != nil && (fieldEdit1.text?.isEmpty)!
		{
			fieldInvalid1.text = "\(R.string.invalid) \(R.string.fName)"
			fieldBorder1.layer.borderColor = UIColor.red.cgColor
			passed = false
		}
		if field2Edit.text != nil && (field2Edit.text?.isEmpty)!
		{
			field2Invalid.text = "\(R.string.invalid) \(R.string.lName)"
			field2Border.layer.borderColor = UIColor.red.cgColor
			passed = false
		}
		if field3Edit.text != nil && (field3Edit.text?.isEmpty)!
		{
			field3Invalid.text = "\(R.string.invalid) \(R.string.emailAddr)"
			field3Border.layer.borderColor = UIColor.red.cgColor
			passed = false
		}
//		if passwordEdit.text != nil && (passwordEdit.text?.isEmpty)!
//		{
//			passwordInvalid.text = "\(R.string.invalid) \(R.string.txtPass)"
//			passwordBorder.layer.borderColor = UIColor.red.cgColor
//			passed = false
//		}
		return passed
	}


//	func loadEnteredValues() -> Bool, Customer
//	{
//		var changed = false
//		let date = Date()
//		let df = DateFormatter()
//		df.dateFormat = "yyyy-MM-dd HH:mm:ss"
////		let today = df.string(from: date)
//		let ipAddr: String = store.getIPAddress()!
//		let newRow = Customer(id: (store.customer?.id)!, id_customer: (store.customer?.idCustomer)!, id_default_group: (store.idDefaultGroup), id_lang: (store.myLang), newsletter_date_add: switch1.isOn ? date : (store.customer?.newsletterDateAdd != nil) ? store.customer?.newsletterDateAdd!) : nil, ip_registration_newsletter: switch1.isOn ? ipAddr : (store.customer?.ipRegistrationNewsletter)!, last_passwd_gen: date, secure_key: "", deleted: false, passwd: passwordEdit.text != nil ? md5(passwordEdit.text!) : "", lastname: field2Edit.text != nil ? field2Edit.text! : "", firstname: fieldEdit1.text != nil ? fieldEdit1.text! : "", email: field3Edit.text != nil ? field3Edit.text! : "", id_gender: (genderSwitch.selectedSegmentIndex), birthday: df.date(from: field4Edit.text!)!, newsletter: switch1.isOn, optin: switch0.isOn, website: (field6Edit.text != nil && (field6Edit.text?.isEmpty)! ? nil : field6Edit.text)!, company: (field5Edit.text != nil && (field5Edit.text?.isEmpty)! ? nil : field5Edit.text)!, siret: (field7Edit.text != nil && (field7Edit.text?.isEmpty)! ? nil : field7Edit.text)!, ape: (field8Edit.text != nil && (field8Edit.text?.isEmpty)! ? nil : field8Edit.text)!, outstanding_allow_amount: 0, show_public_prices: true, id_risk: 0, max_payment_days: 0, active: true, note: "", is_guest: false, id_shop: store.idShop, id_shop_group: store.idShopGroup, date_add: date, date_upd: date, reset_password_token: "", reset_password_validity: date, associations: CustomerAssociations(groups: nil))//associations: CustomerAssociations(groups: [CustomerGroup(group: nil)])
////		let encode = try? JSONEncoder().encode(newRow)
////		UserDefaults.standard.set(encode, forKey: "updateCustomer.\(df.string(from: date))")
//		return changed, newRow
//	}


	@objc func adjustForKeyboard(notification: Notification)
	{
		let userInfo = notification.userInfo!
		let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
		let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
		
		if notification.name == Notification.Name.UIKeyboardWillHide
		{
			self.scrollForm.contentInset = UIEdgeInsets.zero
		}
		else
		{
			self.scrollForm.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
		}
		self.scrollForm.scrollIndicatorInsets = self.scrollForm.contentInset
		//let selectedRange = self.scrollForm.selectedRange
		//self.scrollForm.scrollRangeToVisible(selectedRange)
	}


	// MARK: Actions
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
		OperationQueue.main.addOperation
			{
				let alert = 					UIAlertController(title: mTitle, message: mMessage, preferredStyle: .alert)
				let coloredBG = 				UIView()
				let blurFx = 					UIBlurEffect(style: .dark)
				let blurFxView = 				UIVisualEffectView(effect: blurFx)
				alert.titleAttributes = 		[NSAttributedString.StringAttribute(key: .foregroundColor, value: R.color.YumaRed)]
				alert.messageAttributes = 		[NSAttributedString.StringAttribute(key: .foregroundColor, value: UIColor.darkGray)]
				alert.view.superview?.backgroundColor = R.color.YumaRed
				alert.view.shadowColor = 		R.color.YumaDRed
				alert.view.shadowOffset = 		.zero
				alert.view.shadowRadius = 		5
				alert.view.shadowOpacity = 		1
				alert.view.backgroundColor = 	R.color.YumaYel
				alert.view.cornerRadius = 		15
				coloredBG.backgroundColor = 	R.color.YumaRed
				coloredBG.alpha = 				0.4
				coloredBG.frame = 				self.view.bounds
				self.view.addSubview(coloredBG)
				blurFxView.frame = 				self.view.bounds
				blurFxView.alpha = 				0.5
				blurFxView.autoresizingMask = 	[.flexibleWidth, .flexibleHeight]
				self.view.addSubview(blurFxView)
				alert.addAction(UIAlertAction(title: R.string.dismiss.uppercased(), style: .default, handler: { (action) in
					coloredBG.removeFromSuperview()
					blurFxView.removeFromSuperview()
				}))
				self.present(alert, animated: true, completion:
					{
				})
		}
		//		store.Alert(fromView: self, title: mTitle, titleColor: R.color.YumaRed, /*titleBackgroundColor: <#T##UIColor?#>, titleFont: <#T##UIFont?#>,*/ message: mMessage, /*messageColor: <#T##UIColor?#>, messageBackgroundColor: <#T##UIColor?#>, messageFont: <#T##UIFont?#>,*/ dialogBackgroundColor: R.color.YumaYel, backgroundBackgroundColor: R.color.YumaRed, /*backgroundBlurStyle: <#T##UIBlurEffectStyle?#>, backgroundBlurFactor: <#T##CGFloat?#>,*/ borderColor: R.color.YumaDRed, borderWidth: 2, /*cornerRadius: <#T##CGFloat?#>,*/ shadowColor: R.color.YumaDRed, /*shadowOffset: <#T##CGSize?#>, shadowOpacity: <#T##Float?#>,*/ shadowRadius: 5, /*alpha: <#T##CGFloat?#>,*/ hasButton1: true, button1Title: R.string.dismiss, /*button1Style: <#T##UIAlertActionStyle?#>, button1Color: <#T##UIColor?#>, button1Font: <#T##UIFont?#>, button1Action: <#T##DataStore.Closure_Void?##DataStore.Closure_Void?##() -> Void#>,*/ hasButton2: false/*, button2Title: <#T##String?#>, button2Style: <#T##UIAlertActionStyle?#>, button2Color: <#T##UIColor?#>, button2Font: <#T##UIFont?#>, button2Action: <#T##DataStore.Closure_Void?##DataStore.Closure_Void?##() -> Void#>*/)
	}
	@objc func selectedADate(_ sender: Notification)
	{
		field4Edit.text = (sender.object as! String)
	}
	@objc func setPW(_ sender: UITapGestureRecognizer)
	{
		let vc = SetPW()
		vc.modalTransitionStyle = .crossDissolve
		vc.modalPresentationStyle = .overCurrentContext
		vc.delegate = self
		self.present(vc, animated: true, completion: nil)
	}
	@objc func makePassword(_ sender: UITapGestureRecognizer)
	{
		let (passwd, formatted) = store.makePassword()
		passwordEdit.text = passwd
		store.myAlert(title: R.string.txtPass, message: "", attributedMessage: formatted, viewController: self)
	}
	@objc func changePasswd(_ sender: AnyObject?)
	{
		if self.store.debug > 0
		{
			print("changePW")
		}
		let vc = ChangePW()
		vc.modalTransitionStyle = .crossDissolve
		vc.modalPresentationStyle = .overCurrentContext
		vc.delegate = self
		self.present(vc, animated: true, completion: nil)
	}
	@objc func showPassAct(_ sender: Any)
	{
		if (passwordEdit.text?.count)! < 1
		{
			changePasswd(nil)
			return
		}
		//passwordTextField.updateFocusIfNeeded()
		if passwordVisible
		{
			passwordEdit.isSecureTextEntry = true
			showPass.text = FontAwesome.eye.rawValue
		}
		else
		{
			passwordEdit.isSecureTextEntry = false
			showPass.text = FontAwesome.eyeSlash.rawValue
		}
		passwordEdit.becomeFirstResponder()
		passwordVisible = !passwordVisible
	}
	@IBAction func buttonAct(_ sender: Any)
	{
		store.flexView(view: buttonText)
		if areFieldsValid()
		{
			let spinner = UIViewController.displaySpinner(onView: self.view)
			var ws = WebService()
			ws.startURL = R.string.WSbase
			ws.resource = APIResource.customers
			ws.keyAPI = R.string.APIkey
			if addNew
			{
				//GET the XML blank data for the resource (/api/customer?schema=blank), fill it with your changes, and POST the whole XML file to the /api/customers/ URL again and will return an XML file indicating that the operation has been successful, along with the ID of the newly created customer
				//var paramsDict = [String : String]()
				//paramsDict["id_default_group"] = String(store.idDefaultGroup)
	//			ws.schema = Schema.blank
	//			ws.get { (result) in
	//			}
//				let newRow = loadEnteredValues()
//				var newRow = store.customer?.copy() as! Customer
//				var changed = false
//				if genderSwitch.selectedSegmentIndex != store.customer?.idGender
//				{
//					newRow.idGender = genderSwitch.selectedSegmentIndex
//					changed = true
//				}
//				if !(fieldEdit1.text?.isEmpty)! && fieldEdit1.text != store.customer?.firstname
//				{
//					newRow.firstname = fieldEdit1.text
//					changed = true
//				}
//				if !(field2Edit.text?.isEmpty)! && field2Edit.text != store.customer?.lastname
//				{
//					newRow.lastname = field2Edit.text
//					changed = true
//				}
//				let bdate = DateFormatter()
//				bdate.dateFormat = "yyyy-MM-dd"
//				if !(field4Edit.text?.isEmpty)! && field4Edit.text != bdate.string(from: (store.customer?.birthday)!)
//				{
//					newRow.birthday = bdate.date(from: field4Edit.text!)
//					changed = true
//				}
//				if !(field5Edit.text?.isEmpty)! && field5Edit.text != store.customer?.company
//				{
//					newRow.company = field5Edit.text
//					changed = true
//				}
//				if !(field6Edit.text?.isEmpty)! && field6Edit.text != store.customer?.website
//				{
//					newRow.website = field6Edit.text
//					changed = true
//				}
//				if !(field7Edit.text?.isEmpty)! && field7Edit.text != store.customer?.siret
//				{
//					newRow.siret = field7Edit.text
//					changed = true
//				}
//				if !(field8Edit.text?.isEmpty)! && field8Edit.text != store.customer?.ape
//				{
//					newRow.ape = field8Edit.text
//					changed = true
//				}
//				if !(passwordEdit.text?.isEmpty)! && passwordEdit.text != store.customer?.passwd
//				{
//					newRow.passwd = passwordEdit.text
//					changed = true
//				}
//				if switch0.isOn != store.customer?.optin
//				{
//					newRow.optin = switch0.isOn
//					changed = true
//				}
//				if switch1.isOn != store.customer?.newsletter
//				{
//					newRow.newsletter = switch1.isOn
//					changed = true
//				}
//				newRow.associations = CustomerAssociations(groups: [CustomerGroup(id: IdAsString(id: String((customer?.idCustomer)!)))])//groups: [CustomerGroup(id: IdAsString(id: (customer?.id_customer)!))]
//				for sub in stackElements.subviews
//				{
//					print(sub.superview)
//					if let field = sub.superview as? InputField
//					{
//						print("yes")
//						if !field.textEdit.text?.isEmpty && field.textEdit.text? != store.
//					}
//				}
//				let newRow = Customer(id: (store.customer?.id)!, id_customer: (store.customer?.idCustomer)!, id_default_group: (store.idDefaultGroup), id_lang: (store.myLang), newsletter_date_add: switch1.isOn ? date : (store.customer?.newsletterDateAdd != nil) ? store.customer?.newsletterDateAdd!) : nil, ip_registration_newsletter: switch1.isOn ? ipAddr : (store.customer?.ipRegistrationNewsletter)!, last_passwd_gen: date, secure_key: "", deleted: false, passwd: passwordEdit.text != nil ? md5(passwordEdit.text!) : "", lastname: field2Edit.text != nil ? field2Edit.text! : "", firstname: fieldEdit1.text != nil ? fieldEdit1.text! : "", email: field3Edit.text != nil ? field3Edit.text! : "", id_gender: (genderSwitch.selectedSegmentIndex), birthday: df.date(from: field4Edit.text!)!, newsletter: switch1.isOn, optin: switch0.isOn, website: (field6Edit.text != nil && (field6Edit.text?.isEmpty)! ? nil : field6Edit.text)!, company: (field5Edit.text != nil && (field5Edit.text?.isEmpty)! ? nil : field5Edit.text)!, siret: (field7Edit.text != nil && (field7Edit.text?.isEmpty)! ? nil : field7Edit.text)!, ape: (field8Edit.text != nil && (field8Edit.text?.isEmpty)! ? nil : field8Edit.text)!, outstanding_allow_amount: 0, show_public_prices: true, id_risk: 0, max_payment_days: 0, active: true, note: "", is_guest: false, id_shop: store.idShop, id_shop_group: store.idShopGroup, date_add: date, date_upd: date, reset_password_token: "", reset_password_validity: date, associations: CustomerAssociations(groups: nil))//associations: CustomerAssociations(groups: [CustomerGroup(group: nil)])

				//print(newRow)
				// Add a row
				//ws.schema = nil
//				ws.xml = PSWebServices.object2psxml(object: newRow, resource: "\(ws.resource!)", resource2: ws.resource2(resource: "\(ws.resource!)"), omit: [])
				print(ws.xml!)
				ws.printURL()
				store.PostHTTP(url: "\(R.string.WSbase)\(APIResource.customers)?\(R.string.API_key)", parameters: nil, headers: ["Content-Type": "text/xml; charset=utf-8", "Accept": "text/xml"], body: "\(ws.xml!)", save: nil, asJSON: false) 	{ 	(cust) in
					//print("return: \(cust)")
					var title = R.string.customer
					if !((cust as? Bool)!)
					{
						title = R.string.err
					}
					UIViewController.removeSpinner(spinner: spinner)
					OperationQueue.main.addOperation
					{
						let alert = 					UIAlertController(title: title, message: cust as? String, preferredStyle: .alert)
						let coloredBG = 				UIView()
						let blurFx = 					UIBlurEffect(style: .dark)
						let blurFxView = 				UIVisualEffectView(effect: blurFx)
						alert.titleAttributes = 		[NSAttributedString.StringAttribute(key: .foregroundColor, value: R.color.YumaRed)]
						alert.messageAttributes = 		[NSAttributedString.StringAttribute(key: .foregroundColor, value: UIColor.darkGray)]
						alert.view.superview?.backgroundColor = R.color.YumaRed
						alert.view.shadowColor = 		R.color.YumaDRed
						alert.view.shadowOffset = 		.zero
						alert.view.shadowRadius = 		5
						alert.view.shadowOpacity = 		1
						alert.view.backgroundColor = 	R.color.YumaYel
						alert.view.cornerRadius = 		15
						coloredBG.backgroundColor = 	R.color.YumaRed
						coloredBG.alpha = 				0.4
						coloredBG.frame = 				self.view.bounds
						self.view.addSubview(coloredBG)
						blurFxView.frame = 				self.view.bounds
						blurFxView.alpha = 				0.5
						blurFxView.autoresizingMask = 	[.flexibleWidth, .flexibleHeight]
						self.view.addSubview(blurFxView)
						alert.addAction(UIAlertAction(title: R.string.dismiss.uppercased(), style: .default, handler:
							{ 	(action) in
								coloredBG.removeFromSuperview()
								blurFxView.removeFromSuperview()
//								self.dismiss(animated: false, completion: nil)
						}))
						self.present(alert, animated: true, completion:
						{
						})
					}
				}
//				ws.add() 	{ 	(result) in
//					if result.data != nil
//					{
//						let data = String(data: result.data! as Data, encoding: .utf8)
//						print(data!)
//						print("----add^")
//					}
//				}
			}
			else	//update information
			{
				//GET the full XML file for the resource you want to change (/api/customers/7), edit its content as needed, then PUT the whole XML file back to the same URL again
				ws.filter = ["id" : [customer?.idCustomer! as Any]]
//				if true//changed ie. edited
//				{
//					let now = Date()
//					let df = DateFormatter()
//					df.dateFormat = "yyyy-MM-dd HH:mm:ss"
//					edited?.date_upd = df.string(from: now)
//					edited?.firstname = fieldEdit1.text!
//					edited?.lastname = field2Edit.text!
//					edited?.birthday = field4Edit.text
//					edited?.optin = String(switch0.isOn)
//					edited?.newsletter = String(switch1.isOn)
//					edited?.active = String(switch2.isOn)
//					edited?.passwd = passwordEdit.text!
//				}
//				var edited = store.customer?.copy() as! Customer
//				var changed = false
//				if genderSwitch.selectedSegmentIndex != store.customer?.idGender
//				{
//					edited.idGender = genderSwitch.selectedSegmentIndex
//					changed = true
//				}
//				if !(fieldEdit1.text?.isEmpty)! && fieldEdit1.text != store.customer?.firstname
//				{
//					edited.firstname = fieldEdit1.text
//					changed = true
//				}
//				if !(field2Edit.text?.isEmpty)! && field2Edit.text != store.customer?.lastname
//				{
//					edited.lastname = field2Edit.text
//					changed = true
//				}
//				let bdate = DateFormatter()
//				bdate.dateFormat = "yyyy-MM-dd"
//				if !(field4Edit.text?.isEmpty)! && field4Edit.text != bdate.string(from: (store.customer?.birthday)!)
//				{
//					edited.birthday = bdate.date(from: field4Edit.text!)
//					changed = true
//				}
//				if !(field5Edit.text?.isEmpty)! && field5Edit.text != store.customer?.company
//				{
//					edited.company = field5Edit.text
//					changed = true
//				}
//				if !(field6Edit.text?.isEmpty)! && field6Edit.text != store.customer?.website
//				{
//					edited.website = field6Edit.text
//					changed = true
//				}
//				if !(field7Edit.text?.isEmpty)! && field7Edit.text != store.customer?.siret
//				{
//					edited.siret = field7Edit.text
//					changed = true
//				}
//				if !(field8Edit.text?.isEmpty)! && field8Edit.text != store.customer?.ape
//				{
//					edited.ape = field8Edit.text
//					changed = true
//				}
//				if !(passwordEdit.text?.isEmpty)! && passwordEdit.text != store.customer?.passwd
//				{
//					edited.passwd = passwordEdit.text
//					changed = true
//				}
//				if switch0.isOn != store.customer?.optin
//				{
//					edited.optin = switch0.isOn
//					changed = true
//				}
//				if switch1.isOn != store.customer?.newsletter
//				{
//					edited.newsletter = switch1.isOn
//					changed = true
//				}
//				var edited = loadEnteredValues()
//				edited.id = Int((customer?.id_customer)!)
//				edited.associations = CustomerAssociations(groups: [CustomerGroup(id: IdAsString(id: String((customer?.idCustomer)!)))])//groups: [CustomerGroup(id: IdAsString(id: (customer?.id_customer)!))]
//				edited.secureKey = customer?.secureKey
//				edited.lastPasswdGen = customer?.lastPasswdGen
//				edited.ipRegistrationNewsletter = nil
//				if passwordEdit.text != nil && !(passwordEdit.text?.isEmpty)!
//				{
//					edited.passwd = md5(passwordEdit.text!)
//				}
//				else
//				{
//					edited.passwd = customer?.passwd
//				}
				var omit: [String] = []
				omit.append("id_customer")
//				omit.append("some")
//				omit.append("associations")
//				let str = PSWebServices.object2psxml(object: edited, resource: "customers", resource2: "customer", omit: omit)
				let str = ""
//				print(str)
				//var params = [String : String]()
				//params["ws_key"] = R.string.APIkey
				//params["xml"] = str
				var allowed = CharacterSet.alphanumerics
				allowed.insert(charactersIn: ".-_~/?")
				store.PutHTTP(url: "\(R.string.WSbase)\(APIResource.customers)?\(R.string.API_key)", parameters: nil, headers: ["Content-Type": /*"application/xml; charset=utf-8"*/"text/xml; charset=utf-8"/*"application/x-www-form-urlencoded"*/, "Accept": "*/*"/*"text/xml"*/, "Accept-Language": "en-US,en", /*"Referer": "",*/ /*"cache-control": "no-cache",*/ /*"X-Requested-With": "XMLHttpRequest"*/], body: "\(str/*.addingPercentEncoding(withAllowedCharacters: allowed) ?? ""*/)", save: nil)//, "Accept": "application/json, text/javascript, */*; q=0.01"
				{ 	(cust) in
//					print("return: \(cust)")
					var title = R.string.customer
					if cust is Bool && !((cust as? Bool)!)
					{
						title = R.string.err
					}
					UIViewController.removeSpinner(spinner: spinner)
//					if let xml = cust as? SWXMLHash.XMLIndexer
//					{
						self.store.enumerate(cust as! XMLIndexer)
//					}
					OperationQueue.main.addOperation
					{
						let alert = 					UIAlertController(title: title, message: self.store.XMLstr /*cust as? String*/, preferredStyle: .alert)
						let coloredBG = 				UIView()
						let blurFx = 					UIBlurEffect(style: .dark)
						let blurFxView = 				UIVisualEffectView(effect: blurFx)
						alert.titleAttributes = 		[NSAttributedString.StringAttribute(key: .foregroundColor, value: R.color.YumaRed)]
						alert.messageAttributes = 		[NSAttributedString.StringAttribute(key: .foregroundColor, value: UIColor.darkGray)]
						alert.view.superview?.backgroundColor = R.color.YumaRed
						alert.view.shadowColor = 		R.color.YumaDRed
						alert.view.shadowOffset = 		.zero
						alert.view.shadowRadius = 		5
						alert.view.shadowOpacity = 		1
						alert.view.backgroundColor = 	R.color.YumaYel
						alert.view.cornerRadius = 		15
						coloredBG.backgroundColor = 	R.color.YumaRed
						coloredBG.alpha = 				0.4
						coloredBG.frame = 				self.view.bounds
						self.view.addSubview(coloredBG)
						blurFxView.frame = 				self.view.bounds
						blurFxView.alpha = 				0.5
						blurFxView.autoresizingMask = 	[.flexibleWidth, .flexibleHeight]
						self.view.addSubview(blurFxView)
						alert.addAction(UIAlertAction(title: R.string.dismiss.uppercased(), style: .default, handler:
							{ 	(action) in
								coloredBG.removeFromSuperview()
								blurFxView.removeFromSuperview()
								//self.dismiss(animated: false, completion: nil)
						}))
						self.present(alert, animated: true, completion:
						{
							self.store.XMLstr = ""
						})
					}
				}
		//		PSWebServices.postCustomer(XMLStr: str)
		//		{
		//			(error) in
		//			if let error = error
		//			{
		//				print("fatal error: ", String(error.localizedDescription))
		//			}
		//		}
			}
		}
	}
	@IBAction func navCloseAct(_ sender: Any)
	{
		self.dismiss(animated: false, completion: nil)
	}
	@IBAction func navHelpAct(_ sender: Any)
	{
		let viewC = Assistance()
		if store.customer != nil && !(store.customer?.lastname?.isEmpty)!
		{
			viewC.array = R.array.help_my_account_information_guide.loggedIn
		}
		else
		{
			viewC.array = R.array.help_my_account_information_guide.newUser
		}
		viewC.title = "\(R.string.my_account.capitalized) \(R.string.Info.capitalized) \(R.string.help.capitalized)"
		viewC.modalTransitionStyle = .crossDissolve
		viewC.modalPresentationStyle = .overCurrentContext
		self.present(viewC, animated: true, completion: nil)
	}

}



extension MyAccInfoViewController: UIScrollViewDelegate
{
	func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView)
	{
		if scrollView == self.helpScrollView
		{
			self.helpPageControl.currentPage = Int(round(scrollView.contentOffset.x / scrollView.frame.width))
		}
	}
}



extension MyAccInfoViewController: PopupDelegate
{
	func popupValueSelected(value: String)
	{
		passwordEdit.text = value
	}
}



extension MyAccInfoViewController: SetPWDelegate
{
	func SetPWValue(value: String)
	{
		passwordEdit.text = value
	}
}
