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
		fieldEdit1.autocapitalizationType = .words
		fieldEdit1.returnKeyType = UIReturnKeyType.next
		field2Label.text = R.string.lName
		field2Edit.textColor = R.color.YumaRed
		field2Edit.autocapitalizationType = .words
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
		if store.customer != nil && store.customer?.lastname != ""
		{
			passwordEdit.placeholder = R.string.same
		}
		else
		{
			passwordEdit.placeholder = R.string.minPass
		}
		passwordEdit.returnKeyType = UIReturnKeyType.next
		passwordGenerateLabel.text = ""
		(passwordGenerateDo.subviews.first as! UILabel).text = R.string.generate
		field5Label.text = R.string.co
		field5Edit.textColor = R.color.YumaRed
		field5Edit.placeholder = R.string.optional
		field5Edit.autocapitalizationType = .words
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
//		let df = DateFormatter()
//		df.dateFormat = "yyyy-MM-dd"
		if self.customer?.birthday != nil
		{
			field4Edit.text = (self.customer?.birthday)!
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

	func wrapInCdata(_ str: String) -> String
	{
//		return "<![CDATA[" + str + "]]>"
		return str
	}

	func insertValuesInBlank(_ str: String) -> String
	{
		var arrayXML = str.replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "\t", with: "").trimmingCharacters(in: .whitespaces).components(separatedBy: ">")
		var i = 0
		for line in arrayXML
		{
			arrayXML[i] = "\(line)>"
			let df = DateFormatter()
			df.dateFormat = "yyyy-MM-dd HH:mm:ss"
			switch(line)
			{
			case "<id_shop":
				arrayXML[i] = "\n\t" + arrayXML[i] + "\(store.idShop)"
				break
			case "<id_shop_group":
				arrayXML[i] = "\n\t" + arrayXML[i] + "\(store.idShopGroup)"
				break
			case "<id_lang":
				arrayXML[i] = "\n\t" + arrayXML[i] + "\(store.myLang)"
				break
			case "<secure_key":
				let pswdChars = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890~!@#$%^&*()_+{}|:<>?-=[]\\;,./")
				let rndPswd = String((0..<32).map{ _ in pswdChars[Int(arc4random_uniform(UInt32(pswdChars.count)))]
				})
//				let (passwd, formatted) = self.store.makePassword(length: 20, formattedFontSize: 20, formattedTextColor: .black, formattedBackgroundColor: .white, formattedKern: 20, normalTextColor: .blue, normalBackgroundColor: .clear, normalFontSize: 20)
				arrayXML[i] = "\n\t" + arrayXML[i] + md5(rndPswd)
				break
			case "<last_passwd_gen":
//				if self.switch1.isOn//store.customer?.newsletter != nil && (store.customer?.newsletter)!
//				{
//					let df = DateFormatter()
//					df.dateFormat = "yyyy-MM-dd HH:mm:ss"
					let after = Date().addingTimeInterval(TimeInterval(-self.store.passwdTimeFront*60))
					arrayXML[i] = "\n\t" + arrayXML[i] + df.string(from: after)
//				}
				break
			case "<newsletter_date_add":
				if self.switch1.isOn//store.customer?.newsletter != nil && (store.customer?.newsletter)!
				{
//					let df = DateFormatter()
//					df.dateFormat = "yyyy-MM-dd HH:mm:ss"
					arrayXML[i] = "\n\t" + arrayXML[i] + df.string(from: Date())
				}
				else
				{
					arrayXML[i] = "\n\t" + arrayXML[i]
				}
				break
			case "<ip_registration_newsletter":
				if self.switch1.isOn//store.customer?.newsletter != nil && (store.customer?.newsletter)!
				{
					arrayXML[i] = "\n\t" + arrayXML[i] + store.getIPAddress()!
				}
				else
				{
					arrayXML[i] = "\n\t" + arrayXML[i]
				}
				break
			case "<id_default_group":
//				if self.store.customer?.isGuest//store.customer?.newsletter != nil && (store.customer?.newsletter)!
//				{
					arrayXML[i] = "\n\t" + arrayXML[i] + "3"//"\(store.idDefaultGroup)"
//				}
				break
			case "<active":
				arrayXML[i] = "\n\t" + arrayXML[i] + "\((store.customer?.active)! ? "1" : "0")"
				break
			case "<id_gender":
				arrayXML[i] = "\n\t" + arrayXML[i] + "\(self.genderSwitch.selectedSegmentIndex)"
				break
			case "<firstname":
				arrayXML[i] = "\n\t" + arrayXML[i] + "\(self.fieldEdit1.text!)"
				break
			case "<lastname":
				arrayXML[i] = "\n\t" + arrayXML[i] + "\(self.field2Edit.text!)"
				break
			case "<email":
				arrayXML[i] = "\n\t" + arrayXML[i] + "\(self.field3Edit.text!)"
				break
			case "<birthday":
				if self.field4Edit.text != nil && !(self.field4Edit.text?.isEmpty)!
				{
//					let bdate = DateFormatter()
//					bdate.dateFormat = "yyyy-MM-dd"
//					arrayXML[i] = "\n\t" + arrayXML[i] + "\(bdate.date(from: self.field4Edit.text!)!)"
					arrayXML[i] = "\n\t" + arrayXML[i] + "\(self.field4Edit.text!)"
				}
				else
				{
					arrayXML[i] = "\n\t" + arrayXML[i]
				}
				break
			case "<company":
				if self.field5Edit.text != nil && !self.field5Edit.text!.isEmpty
				{
					arrayXML[i] = "\n\t" + arrayXML[i] + "\(self.field5Edit.text!)"
				}
				else
				{
					arrayXML[i] = "\n\t" + arrayXML[i]
				}
				break
			case "<website":
				if self.field6Edit.text != nil && !self.field6Edit.text!.isEmpty
				{
					arrayXML[i] = "\n\t" + arrayXML[i] + "\(self.field6Edit.text!)"
				}
				else
				{
					arrayXML[i] = "\n\t" + arrayXML[i]
				}
				break
			case "<siret":
				if self.field7Edit.text != nil && !self.field7Edit.text!.isEmpty
				{
					arrayXML[i] = "\n\t" + arrayXML[i] + "\(self.field7Edit.text!)"
				}
				else
				{
					arrayXML[i] = "\n\t" + arrayXML[i]
				}
				break
			case "<ape":
				if self.field8Edit.text != nil && !self.field8Edit.text!.isEmpty
				{
					arrayXML[i] = "\n\t" + arrayXML[i] + "\(self.field8Edit.text!)"
				}
				else
				{
					arrayXML[i] = "\n\t" + arrayXML[i]
				}
				break
			case "<passwd":
				if self.passwordEdit.text != nil && !self.passwordEdit.text!.isEmpty
				{
					arrayXML[i] = "\n\t" + arrayXML[i] + "\(self.passwordEdit.text!)"
				}
				break
			case "<optin":
				arrayXML[i] = "\n\t" + arrayXML[i] + "\(self.switch0.isOn ? "1" : "0")"
				break
			case "<newsletter":
				arrayXML[i] = "\n\t" + arrayXML[i] + "\(self.switch1.isOn ? "1" : "0")"
				break
			case "<deleted":
				arrayXML[i] = "\n\t" + arrayXML[i] + "\((store.customer?.deleted)! ? "1" : "0")"
				break
			case "<associations":
				arrayXML[i] = "\n\t" + arrayXML[i]
				break
			default:
				if i > 2 && !line.contains("</") && !line.contains("/>") && !line.contains("<![CDATA[")
				{
					arrayXML[i] = "\n\t" + arrayXML[i]
				}
				else if (i > 0 && i < 3) || (i > (arrayXML.count-4) && i < (arrayXML.count-1))
				{
					arrayXML[i] = "\n" + arrayXML[i]
				}
				break
			}
			i += 1
		}
		let str = arrayXML.joined()
		return String(str.dropLast())
	}

	/// Update XML by reading the customer record and inserting the (updated) values in another XML
	func insertValues(_ str: String, isFresh: Bool = true) -> String
	{
//		OperationQueue.main.addOperation
//		DispatchQueue.main.async
//		{
			var arrayXML = str.replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "\t", with: "")/*replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression)*/.trimmingCharacters(in: .whitespaces).components(separatedBy: ">")
			var changed = false
			var i = 0
			for line in arrayXML
			{
				arrayXML[i] = "\(line)>"
				switch(line)
				{
				case "<is_guest":
					arrayXML[i] = "\n\t" + arrayXML[i] + "\((store.customer?.isGuest)! ? "1" : "0")"
					break
				case "<deleted":
					arrayXML[i] = "\n\t" + arrayXML[i] + "\((store.customer?.deleted)! ? "1" : "0")"
					break
				case "<active":
					arrayXML[i] = "\n\t" + arrayXML[i] + "\((store.customer?.active)! ? "1" : "0")"
					break
				case "<id_shop":
					arrayXML[i] = "\n\t" + arrayXML[i] + "\(store.idShop)"
					break
				case "<id_shop_group":
					arrayXML[i] = "\n\t" + arrayXML[i] + "\(store.idShopGroup)"
					break
				case "<id_lang":
					arrayXML[i] = "\n\t" + arrayXML[i] + "\(store.myLang)"
					break
				case "<id_default_group":
					arrayXML[i] = "\n\t" + arrayXML[i] + "3"//"\(store.idDefaultGroup)"
					break
				case "<id_gender":
					var data = ""
					if isFresh
					{
						data = "\(self.genderSwitch.selectedSegmentIndex)"
					}
					else if self.store.customer != nil && self.genderSwitch.selectedSegmentIndex != self.store.customer?.idGender
					{
						data = "\(self.genderSwitch.selectedSegmentIndex)"
						changed = true
					}
					arrayXML[i] = "\n\t" + arrayXML[i] + data
					break
				case "<firstname":
					if self.store.customer != nil && self.fieldEdit1.text != self.store.customer?.firstname
					{
						changed = true
					}
					arrayXML[i] = "\n\t" + arrayXML[i] + "\(self.fieldEdit1.text!)"
					break
				case "<lastname":
					if self.store.customer != nil && self.field2Edit.text != self.store.customer?.lastname
					{
						changed = true
					}
					arrayXML[i] = "\n\t" + arrayXML[i] + "\(self.field2Edit.text!)"
					break
				case "<email":
					if self.store.customer != nil && self.fieldEdit1.text != self.store.customer?.firstname
					{
						changed = true
					}
					arrayXML[i] = "\n\t" + arrayXML[i] + "\(self.field3Edit.text!)"
					break
				case "<birthday":
					if self.field4Edit.text != nil && !(self.field4Edit.text?.isEmpty)!
					{
//						let bdate = DateFormatter()
//						bdate.dateFormat = "yyyy-MM-dd"
						if !(self.field4Edit.text?.isEmpty)! && self.field4Edit.text != (self.store.customer?.birthday)!
						{
							changed = true
						}
						arrayXML[i] = "\n\t" + arrayXML[i] + "\(self.field4Edit.text!)"
					}
					break
				case "<id":
					if self.customer?.idCustomer != nil && (self.customer?.idCustomer)! > 0
					{
						arrayXML[i] = "\n\t" + arrayXML[i] + "\((self.customer?.idCustomer)!)"
//						changed = true
					}
					else
					{
						arrayXML[i] = "\n\t" + arrayXML[i]
					}
					break
				case "<company":
					if self.field5Edit.text != nil && !self.field5Edit.text!.isEmpty
					{
						arrayXML[i] = "\n\t" + arrayXML[i] + "\(self.field5Edit.text!)"
					}
					else
					{
						arrayXML[i] = "\n\t" + arrayXML[i]
					}
					if !(self.field5Edit.text?.isEmpty)! && self.field5Edit.text != self.store.customer?.company
					{
						changed = true
					}
					break
				case "<website":
					if self.field6Edit.text != nil && !self.field6Edit.text!.isEmpty
					{
						arrayXML[i] = "\n\t" + arrayXML[i] + "\(self.field6Edit.text!)"
					}
					else
					{
						arrayXML[i] = "\n\t" + arrayXML[i]
					}
					if !(self.field6Edit.text?.isEmpty)! && self.field6Edit.text != self.store.customer?.website
					{
						changed = true
					}
					break
				case "<siret":
					if self.field7Edit.text != nil && !self.field7Edit.text!.isEmpty
					{
						arrayXML[i] = "\n\t" + arrayXML[i] + "\(self.field7Edit.text!)"
					}
					else
					{
						arrayXML[i] = "\n\t" + arrayXML[i]
					}
					if !(self.field7Edit.text?.isEmpty)! && self.field7Edit.text != self.store.customer?.siret
					{
						changed = true
					}
					break
				case "<ape":
					if self.field8Edit.text != nil && !self.field8Edit.text!.isEmpty
					{
						arrayXML[i] = "\n\t" + arrayXML[i] + "\(self.field8Edit.text!)"
					}
					else
					{
						arrayXML[i] = "\n\t" + arrayXML[i]
					}
					if !(self.field8Edit.text?.isEmpty)! && self.field8Edit.text != self.store.customer?.ape
					{
						changed = true
					}
					break
				case "<passwd":
					if self.passwordEdit.text != nil && !self.passwordEdit.text!.isEmpty
					{
						arrayXML[i] = "\n\t" + arrayXML[i] + "\(self.passwordEdit.text!)"
					}
					else
					{
						arrayXML[i] = "\n\t" + arrayXML[i]
					}
					if !(self.passwordEdit.text?.isEmpty)! && self.passwordEdit.text != self.store.customer?.passwd
					{
						changed = true
					}
					break
				case "<optin":
					arrayXML[i] = "\n\t" + arrayXML[i] + "\(self.switch0.isOn ? "1" : "0")"
					break
				case "<newsletter":
					arrayXML[i] = "\n\t" + arrayXML[i] + "\(self.switch1.isOn ? "1" : "0")"
					break
				case "<associations":
					arrayXML[i] = "\n\t" + arrayXML[i]// + "<groups nodeType=\"groups\" api=\"group\" /></associations>"//<groups><group><id></id></group></groups></associations>
					break
				default:
					if i > 2 && !line.contains("</") && !line.contains("/>") && !line.contains("<![CDATA[")
					{
						arrayXML[i] = "\n\t" + arrayXML[i]
					}
					else if (i > 0 && i < 3) || (i > (arrayXML.count-4) && i < (arrayXML.count-1))
					{
						arrayXML[i] = "\n" + arrayXML[i]
					}
//					print("error while inserting values.")
					break
				}
				i += 1
			}
//		}
//		OperationQueue.main.addOperation {
//			if self.genderSwitch.selectedSegmentIndex != self.store.customer?.idGender
//			{
//				var i = 0
//				for line in arrayXML
//				{
//					if line == "<id_gender>"
//					{
//						let str = "\(line)\(self.genderSwitch.selectedSegmentIndex)"
//						arrayXML[i] = str
//						break
//					}
//					i += 1
//				}
//	//			newRow.idGender = genderSwitch.selectedSegmentIndex
//				changed = true
//			}
//			if !(self.fieldEdit1.text?.isEmpty)! && self.fieldEdit1.text != self.store.customer?.firstname
//			{
//				var i = 0
//				for line in arrayXML
//				{
//					if line == "<firstname>"
//					{
//						let str = "\(line)\(self.fieldEdit1.text!)"
//						arrayXML[i] = str
//						break
//					}
//					i += 1
//				}
//	//			newRow.firstname = fieldEdit1.text
//				changed = true
//			}
//			if !(self.field2Edit.text?.isEmpty)! && self.field2Edit.text != self.store.customer?.lastname
//			{
//				var i = 0
//				for line in arrayXML
//				{
//					if line == "<lastname>"
//					{
//						let str = "\(line)\(self.field2Edit.text!)"
//						arrayXML[i] = str
//						break
//					}
//					i += 1
//				}
//	//			newRow.lastname = field2Edit.text
//				changed = true
//			}
//			let bdate = DateFormatter()
//			bdate.dateFormat = "yyyy-MM-dd"
//			if !(self.field4Edit.text?.isEmpty)! && self.field4Edit.text != bdate.string(from: (self.store.customer?.birthday)!)
//			{
//				var i = 0
//				for line in arrayXML
//				{
//					if line == "<birthday>"
//					{
//						let str = "\(line)\(bdate.date(from: self.field4Edit.text!)!)"
//						arrayXML[i] = str
//						break
//					}
//					i += 1
//				}
//	//			newRow.birthday = bdate.date(from: field4Edit.text!)
//				changed = true
//			}
//			if !(self.field5Edit.text?.isEmpty)! && self.field5Edit.text != self.store.customer?.company
//			{
//				var i = 0
//				for line in arrayXML
//				{
//					if line == "<company>"
//					{
//						let str = "\(line)\(self.field5Edit.text!)"
//						arrayXML[i] = str
//						break
//					}
//					i += 1
//				}
//	//			newRow.company = field5Edit.text
//				changed = true
//			}
//			if !(self.field6Edit.text?.isEmpty)! && self.field6Edit.text != self.store.customer?.website
//			{
//				var i = 0
//				for line in arrayXML
//				{
//					if line == "<website>"
//					{
//						let str = "\(line)\(self.field6Edit.text!)"
//						arrayXML[i] = str
//						break
//					}
//					i += 1
//				}
//	//			newRow.website = field6Edit.text
//				changed = true
//			}
//			if !(self.field7Edit.text?.isEmpty)! && self.field7Edit.text != self.store.customer?.siret
//			{
//				var i = 0
//				for line in arrayXML
//				{
//					if line == "<siret>"
//					{
//						let str = "\(line)\(self.field7Edit.text!)"
//						arrayXML[i] = str
//						break
//					}
//					i += 1
//				}
//	//			newRow.siret = field7Edit.text
//				changed = true
//			}
//			if !(self.field8Edit.text?.isEmpty)! && self.field8Edit.text != self.store.customer?.ape
//			{
//				var i = 0
//				for line in arrayXML
//				{
//					if line == "<ape>"
//					{
//						let str = "\(line)\(self.field8Edit.text!)"
//						arrayXML[i] = str
//						break
//					}
//					i += 1
//				}
//	//			newRow.ape = field8Edit.text
//				changed = true
//			}
//			if !(self.passwordEdit.text?.isEmpty)! && self.passwordEdit.text != self.store.customer?.passwd
//			{
//				var i = 0
//				for line in arrayXML
//				{
//					if line == "<passwd>"
//					{
//						let str = "\(line)\(self.passwordEdit.text!)"
//						arrayXML[i] = str
//						break
//					}
//					i += 1
//				}
//	//			newRow.passwd = passwordEdit.text
//				changed = true
//			}
//			if self.switch0.isOn != self.store.customer?.optin
//			{
//				var i = 0
//				for line in arrayXML
//				{
//					if line == "<optin>"
//					{
//						let str = "\(line)\(self.switch0.isOn)"
//						arrayXML[i] = str
//						break
//					}
//					i += 1
//				}
//	//			newRow.optin = switch0.isOn
//				changed = true
//			}
//			if self.switch1.isOn != self.store.customer?.newsletter
//			{
//				var i = 0
//				for line in arrayXML
//				{
////					var breakNext = false
//					if line == "<newsletter>"
//					{
//						let str = "\(line)\(self.switch1.isOn ? "1" : "0")"
//						arrayXML[i] = str
////						if breakNext
////						{
//							break
////						}
////						breakNext = true
//					}
////					else if self.switch1.isOn && line == "<ip_registration_newsletter>"
////					{
////						let str = "\(line)\(self.store.getIPAddress())"
////						arrayXML[i] = str
////						if breakNext
////						{
////							break
////						}
////						breakNext = true
////					}
//					i += 1
//				}
	//			newRow.newsletter = switch1.isOn
//				changed = true
//			}
//			var i = 0
//			for line in arrayXML
//			{
//				if line == "<associations>"
//				{
//					let str = "\(line)<groups><group><id></id></group></groups></associations>"
////					let str = "\(line)\(CustomerAssociations(groups: [CustomerGroup(id: IdAsString(id: String((self.customer?.idCustomer)!)))]))"
//					arrayXML[i] = str
//					break
//				}
//				i += 1
//			}
	//		newRow.associations = CustomerAssociations(groups: [CustomerGroup(id: IdAsString(id: String((customer?.idCustomer)!)))])//groups: [CustomerGroup(id: IdAsString(id: (customer?.id_customer)!))]
	//		for sub in stackElements.subviews
	//		{
	//			print(sub.superview)
	//			if let field = sub.superview as? InputField
	//			{
	//				print("yes")
	//				if !field.textEdit.text?.isEmpty && field.textEdit.text? != store.
	//			}
	//		}
//		}
		let str = arrayXML.joined()
		return changed ? String(str.dropLast()) : ""
//		return String(str.dropLast())
	}

	fileprivate func addResource(_ ws: WebService, _ spinner: UIView)
	{
		ws.add { (httpResult) in
			let cust = String(data: httpResult.data! as Data, encoding: .utf8)
			UIViewController.removeSpinner(spinner: spinner)
			if self.store.debug > 4
			{
				print("PUT response: \(cust!)")
			}
			if httpResult.success
			{
				myAlertOnlyDismiss(self, title: R.string.success, message: "\(R.string.login): \(self.field3Edit.text!)"/*cust!*/, dismissAction: {
					self.dismiss(animated: false, completion: {
						OperationQueue.main.addOperation {
							let vc = FloatingAlertViewController()
							vc.modalTransitionStyle = .crossDissolve
							vc.modalPresentationStyle = .overCurrentContext
							vc.floatingMessage.text = "\(R.string.login): \(self.field3Edit.text!)"
							self.present(vc, animated: true) {
								self.dismiss(animated: false, completion: {
								})
							}
						}
					})
				}, completion: {
				})
			}
			else if (cust?.contains("<error"))!
			{
				print("PUT response: \(cust!)")
				let parser = XMLParser(data: (cust?.data(using: .utf8))!)
				let ps = PrestashopXMLroot()
				parser.delegate = ps
				parser.parse()
				var errors = ""
				for err in ps.errors
				{
					errors.append("\(err.message) (\(err.code))")
				}
				myAlertOnlyDismiss(self, title: R.string.err, message: errors, dismissAction: {
					self.dismiss(animated: false, completion: {
					})
				})
			}
		}
	}

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
				myAlertOnlyDismiss(self, title: mTitle, message: mMessage)
		}
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
		buttonText.becomeFirstResponder()
		buttonText.resignFirstResponder()
		if areFieldsValid()
		{
			let spinner = UIViewController.displaySpinner(onView: self.view)
			var ws = WebService()
			ws.startURL = R.string.WSbase
			ws.resource = APIResource.customers
			ws.keyAPI = R.string.APIkey
			if addNew
			{
				let blank = UserDefaults.standard.string(forKey: "BlankSchemaXMLCustomer")//store.blankSchemaXML["Customer"]
				if blank != nil && !(blank?.isEmpty)!
				{
					ws.xml = insertValuesInBlank(blank!)
					store.customer?.active = true
					store.customer?.deleted = false
					if ws.xml != nil && !(ws.xml?.isEmpty)!
					{
						addResource(ws, spinner)
					}
				}
				else	// blank schema not saved - retrieve it
				{
					ws.schema = Schema.blank
					ws.get { (httpResult) in
						if let data = httpResult.data
						{
							let str = String(data: data as Data, encoding: .utf8)
							self.store.blankSchemaXML["Customer"] = str
							UserDefaults.standard.set(str, forKey: "BlankSchemaXMLCustomer")
							self.store.customer?.active = true
							self.store.customer?.deleted = false
							ws.xml = self.insertValuesInBlank(str!)
							if ws.xml != nil && !(ws.xml?.isEmpty)!
							{
								self.addResource(ws, spinner)
//								ws.add { (httpResult) in
//									let cust = String(data: httpResult.data! as Data, encoding: .utf8)
//									UIViewController.removeSpinner(spinner: spinner)
//									if self.store.debug > 4
//									{
//										print("PUT response: \(cust!)")
//									}
//									if httpResult.success
//									{
//										myAlertOnlyDismiss(self, title: R.string.success, message: "\(R.string.login): \(self.field3Edit.text!)"/*cust!*/, dismissAction: {
//											self.dismiss(animated: false, completion: {
//											})
//										}, completion: {
//										})
//									}
//									else if (cust?.contains("<error"))!
//									{
//										let parser = XMLParser(data: (cust?.data(using: .utf8))!)
//										let ps = PrestashopXMLroot()
//										parser.delegate = ps
//										parser.parse()
//										var errors = ""
//										for err in ps.errors
//										{
//											errors.append("\(err.message) (\(err.code))")
//										}
//										myAlertOnlyDismiss(self, title: R.string.err, message: errors, dismissAction: {
//											self.dismiss(animated: false, completion: {
//											})
//										})
//									}
//								}
							}
						}
					}
				}
			}
			else	//update information
			{
//				<?xml version="1.0" encoding="UTF-8"?>
//				<prestashop xmlns:xlink="http://www.w3.org/1999/xlink">
//				<customer>
//				<id>3</id>
//				<id_default_group xlink:href="http://yumatechnical.com/api/groups/3">3</id_default_group>
//				<id_lang xlink:href="http://yumatechnical.com/api/languages/1">1</id_lang>
//				<newsletter_date_add>0000-00-00 00:00:00</newsletter_date_add>
//				<ip_registration_newsletter></ip_registration_newsletter>
//				<last_passwd_gen>2018-05-11 13:55:02</last_passwd_gen>
//				<secure_key>baef23c3484858f93935c13fcebd891f</secure_key>
//				<deleted>0</deleted>
//				<passwd>kB670xK3sO</passwd>
//				<lastname>Manager</lastname>
//				<firstname>Yuma</firstname>
//				<email>sales@yumatechnical.com</email>
//				<id_gender>0</id_gender>
//				<birthday>0000-00-00</birthday>
//				<newsletter>0</newsletter>
//				<optin>0</optin>
//				<website></website>
//				<company>red</company>
//				<siret></siret>
//				<ape></ape>
//				<outstanding_allow_amount>0.000000</outstanding_allow_amount>
//				<show_public_prices>0</show_public_prices>
//				<id_risk>0</id_risk>
//				<max_payment_days>0</max_payment_days>
//				<active>1</active>
//				<note></note>
//				<is_guest>0</is_guest>
//				<id_shop>1</id_shop>
//				<id_shop_group>1</id_shop_group>
//				<date_add>2016-12-29 15:15:08</date_add>
//				<date_upd>2018-05-22 16:18:32</date_upd>
//				<reset_password_token></reset_password_token>
//				<reset_password_validity>0000-00-00 00:00:00</reset_password_validity>
//				<associations></associations>
//				</customer>
//				</prestashop>

//				print(PrestaShop(xmlns: "http://www.w3.org/1999/xlink", customers: Customers(customer: [store.customer!]), customer: nil).toXML()!)//<?xml version=\"1.0\"?>\n<customer>\n    <outstanding_allow_amount>0</outstanding_allow_amount>\n    <firstname>Yuma</firstname>\n    <lastname>Technical</lastname>\n    <id_shop_group>1</id_shop_group>\n    <max_payment_days>0</max_payment_days>\n    <optin>0</optin>\n    <last_passwd_gen>2018-05-11</last_passwd_gen>\n    <active>1</active>\n    <passwd>$2y$10$CDgHOnQRTaVadMaCSKt.MOC9dvImGPmaxdBhTNOVOAZ.ojKlTKSyG</passwd>\n    <id_customer>3</id_customer>\n    <id_shop>1</id_shop>\n    <id_lang>1</id_lang>\n    <newsletter>0</newsletter>\n    <date_add>2016-12-29</date_add>\n    <id_default_group>3</id_default_group>\n    <id>0</id>\n    <company></company>\n    <note></note>\n    <date_upd>2018-05-22</date_upd>\n    <deleted>0</deleted>\n    <email>yumatechnical@gmail.com</email>\n    <website></website>\n    <show_public_prices>0</show_public_prices>\n    <secure_key>baef23c3484858f93935c13fcebd891f</secure_key>\n    <siret></siret>\n    <ip_registration_newsletter></ip_registration_newsletter>\n    <ape></ape>\n    <id_gender>0</id_gender>\n    <is_guest>0</is_guest>\n    <reset_password_token></reset_password_token>\n    <id_risk>0</id_risk>\n</customer>
//				print(PrestaShop(xmlns: "http://www.w3.org/1999/xlink", customers: nil, customer: [store.customer!]).toXML()!)////				ws.filter = ["id" : [customer?.idCustomer! as Any]]
				let thisCustomer = UserDefaults.standard.string(forKey: "Customer\((customer?.id)!)")
				if thisCustomer != nil && !(thisCustomer?.isEmpty)!
				{
//					let parser = XMLParser(data: (thisCustomer?.data(using: .utf8))!)
//					let ps = PrestashopXMLroot()
//					parser.delegate = ps
//					parser.parse()
//					var custs = ""
//					for c in ps.customers
//					{
//						custs.append("\(c.active!) \(c.company!) \(c.firstname!) \(c.lastname!) \(c.email!) (\(c.ape!))")
//					}

					DispatchQueue.main.async
					{
						ws.xml = self.insertValues(thisCustomer!, isFresh: false)
//						self.store.customer?.active = true
//						self.store.customer?.deleted = false
						if ws.xml != nil && !(ws.xml?.isEmpty)!
						{
							ws.edit { (httpResult) in
								let cust = String(data: httpResult.data! as Data, encoding: .utf8)
								UIViewController.removeSpinner(spinner: spinner)
								if self.store.debug > 4
								{
									print("PUT response: \(cust!)")
								}
								if httpResult.success
								{
									myAlertOnlyDismiss(self, title: R.string.success, message: "\(R.string.login): \(self.field3Edit.text!)"/*cust!*/, dismissAction: {
										self.dismiss(animated: false, completion: {
										})
									}, completion: {
									})
								}
								else if (cust?.contains("<error"))!
								{
									let parser = XMLParser(data: (cust?.data(using: .utf8))!)
									let ps = PrestashopXMLroot()
									parser.delegate = ps
									parser.parse()
									var errors = ""
									for err in ps.errors
									{
										errors.append("\(err.message) (\(err.code))")
									}
									myAlertOnlyDismiss(self, title: R.string.err, message: errors, dismissAction: {
										self.dismiss(animated: false, completion: {
										})
									})
								}
							}
						}
					}
				}
				else
				{
//					ws.id = (customer?.id)!
//					if ws.id == 0
//					{
//						ws.id = (customer?.idCustomer)!
//					}
					ws.schema = Schema.blank
					ws.get { (httpResult) in
						if let data = httpResult.data
						{
							let str = String(data: data as Data, encoding: .utf8)
							DispatchQueue.main.async
							{
								ws.schema = nil
								ws.id = (self.customer?.idCustomer)!
								ws.get(completionHandler: { (httpResult) in
									if let data2 = httpResult.data
									{
										let cust = String(data: data2 as Data, encoding: .utf8)
										let arrayXML = cust?.split(separator: ">")
										print(arrayXML?.joined() as Any)
										let parser = XMLParser(data: (cust?.data(using: .utf8))!)
										let ps = PrestashopXMLroot()
										parser.delegate = ps
										parser.parse()
										for node in ps.customers
										{
											print(node.firstname!)
										}
									}
								})
//								self.store.customer?.active = true
//								self.store.customer?.deleted = false
								self.store.customer?.idCustomer = self.customer?.idCustomer
								self.store.customer?.id = self.customer?.idCustomer
								ws.xml = self.insertValues(str!, isFresh: false)
								if !(ws.xml?.isEmpty)!
								{
									ws.id = (self.customer?.idCustomer)!
									ws.edit { (httpResult) in
										let cust = String(data: httpResult.data! as Data, encoding: .utf8)
										UIViewController.removeSpinner(spinner: spinner)
										if self.store.debug > 4
										{
											print("PUT response: \(cust!)")
										}
										if httpResult.success
										{
											myAlertOnlyDismiss(self, title: R.string.success, message: "\(R.string.login): \(self.field3Edit.text!)"/*cust!*/, dismissAction: {
												self.dismiss(animated: false, completion: {
												})
											}, completion: {
											})
										}
										else if (cust?.contains("<error"))!
										{
											let parser = XMLParser(data: (cust?.data(using: .utf8))!)
											let ps = PrestashopXMLroot()
											parser.delegate = ps
											parser.parse()
											var errors = ""
											for err in ps.errors
											{
												errors.append("\(err.message) (\(err.code))")
											}
											myAlertOnlyDismiss(self, title: R.string.err, message: errors, dismissAction: {
												self.dismiss(animated: false, completion: {
												})
											})
										}
									}
								}
								else
								{
									UIViewController.removeSpinner(spinner: spinner)
									myAlertOnlyDismiss(self, title: R.string.err, message: R.string.noChange)
								}
							}
						}
					}
				}
//				UIViewController.removeSpinner(spinner: spinner)
//				myAlertOnlyDismiss(self, title: title, message: self.store.XMLstr /*cust as? String*/)
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
