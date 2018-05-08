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
	
	
	// MARK: Overrides
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
		switch1Group.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(alertMe(_:))))
		switch2Group.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertMe(_:))))
		clearErrors()
		setLabels()
		if store.customer != nil && store.customer?.lastname != ""
		{
			navTitle.title = R.string.my_account + " " + R.string.Info
			setEmailField()
			buttonText.setTitle(R.string.upd.uppercased(), for: .normal)
			//passwordGenerateDo.subviews.first?.isHidden = true
			showPass.isHidden = true//passwordShow.subviews.first?.isHidden = true
			passwordEdit.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changePasswd(_:))))
			fillFields()
		}
		else
		{
			addNew = true
			navTitle.title = R.string.createAcc
			buttonText.setTitle(R.string.createAcc.uppercased(), for: .normal)
			passwordShow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showPassAct(_:))))
			passwordGenerateDo.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(makePassword(_:))))
		}
	}
	
	override func didReceiveMemoryWarning()
	{
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


	// MARK: My methods
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
		field2Label.text = R.string.lName
		field2Edit.textColor = R.color.YumaRed
		field3Label.text = R.string.emailAddr
		field3Edit.textColor = R.color.YumaRed
		field4Label.text = R.string.bDate
		field4Edit.textColor = R.color.YumaRed
		passwordLabel.text = R.string.txtPass
		passwordEdit.textColor = R.color.YumaRed
		passwordGenerateLabel.text = ""
		(passwordGenerateDo.subviews.first as! UILabel).text = R.string.generate
		field5Label.text = R.string.co
		field5Edit.textColor = R.color.YumaRed
		field5Edit.placeholder = R.string.optional
		field6Label.text = R.string.website
		field6Edit.textColor = R.color.YumaRed
		field6Edit.placeholder = R.string.optional
		field7Label.text = R.string.siret
		field7Edit.placeholder = R.string.optional
		field7Edit.textColor = R.color.YumaRed
		field8Label.text = R.string.ape
		field8Edit.textColor = R.color.YumaRed
		field8Edit.placeholder = R.string.optional
		switch0Label.text = R.string.offersFromPartners
		switch1Label.text = R.string.SignUpNewsletter
		switch1Label2.text = R.string.SignUpNewsletterMore
		switch2Label.text = R.string.custDataPriv
		switch2Label2.text = R.string.custDataPrivMore
		buttonText.setTitle(R.string.save.uppercased(), for: .normal)
		buttonText.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
	}
	
	@objc func changePasswd(_ sender: UITapGestureRecognizer)
	{
		let sb = UIStoryboard(name: "HelpStoryboard", bundle: nil)
		let vc = sb.instantiateInitialViewController() as? PickerViewController
		if vc != nil
		{
			self.present(vc!, animated: true, completion: nil)
			vc?.titleLbl.text = R.string.changePass
			vc?.button.setTitle(R.string.dismiss.uppercased(), for: .normal)
			let existing = InputField(frame: CGRect(x: 0, y: (vc?.titleLbl.frame.height)!, width: (vc?.dialog.frame.width)!, height: 110))
			//existing.translatesAutoresizingMaskIntoConstraints = false
			existing.label.text = R.string.exist
			let newpw = InputField(frame: CGRect(x: 0, y: 120, width: (vc?.dialog.frame.width)!, height: 110))
			//newpw.translatesAutoresizingMaskIntoConstraints = false
			newpw.label.text = R.string.newPW
			let verify = InputField(frame: CGRect(x: 0, y: 240, width: (vc?.dialog.frame.width)!, height: 110))
			//verify.translatesAutoresizingMaskIntoConstraints = false
			verify.label.text = R.string.verify
			let stack = UIStackView(arrangedSubviews: [existing, newpw, verify])
			//stack.translatesAutoresizingMaskIntoConstraints = false
			stack.spacing = 5
			vc?.dialog.addSubview(stack)
//			vc?.dialog.addConstraintsWithFormat(format: "H:|-5-[v0]-5-|", views: stack)
//			vc?.dialog.addConstraintsWithFormat(format: "V:|-5-[v0]-5-|", views: stack)
//			NSLayoutConstraint.activate([
//				stack.topAnchor.constraint(equalTo: (vc?.titleLbl.bottomAnchor)!, constant: 5),
//				stack.bottomAnchor.constraint(equalTo: (vc?.button.topAnchor)!, constant: 5),
//				stack.leadingAnchor.constraint(equalTo: (vc?.dialog.leadingAnchor)!, constant: 5),
//				stack.trailingAnchor.constraint(equalTo: (vc?.dialog.trailingAnchor)!, constant: 5),
//				])
			//			Bundle.main.loadNibNamed("ChangePasswordViewController", owner: vc, options: nil)
			//let changePasswordVC = ChangePasswordViewController()
//			vc?.dialog.addSubview(changePasswordVC.contentView)
//			chanePasswordVC.contentView.frame = (vc?.dialog.bounds)!
//			chanePasswordVC.contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
		}
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
	
	@objc func makePassword(_ sender: UITapGestureRecognizer)
	{
		let len = 6
		let pswdChars = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890~!@#$%^&*()_+{}|:<>?-=[]\\;,./")
		let rndPswd = String((0..<len).map{ _ in pswdChars[Int(arc4random_uniform(UInt32(pswdChars.count)))]})
		let mMessage: String = rndPswd
		passwordEdit.text = mMessage
		//let mMessage: String = String.generatePassword(length: 6)
		let attrNormal = [
			NSAttributedStringKey.font : UIFont.systemFont(ofSize: 16),
			NSAttributedStringKey.foregroundColor : UIColor.darkGray,
			NSAttributedStringKey.backgroundColor : UIColor.clear,
		]
		let wholeMsg = NSMutableAttributedString(string: R.string.genInstr, attributes: attrNormal)
		let attrPassword = [
			NSAttributedStringKey.font : UIFont.monospacedDigitSystemFont(ofSize: 20, weight: UIFont.Weight.medium),
			NSAttributedStringKey.foregroundColor : UIColor.black,
			NSAttributedStringKey.backgroundColor : UIColor.white,
//			NSAttributedStringKey.expansion : NSNumber(value: 1.2),
			NSAttributedStringKey.kern : NSNumber(value: 4.5)
			]
		let passwordWithAttributes = NSMutableAttributedString(string: mMessage, attributes: attrPassword)
		wholeMsg.append(passwordWithAttributes)
		OperationQueue.main.addOperation
		{
			let alert = 					UIAlertController(title: R.string.txtPass, message: "\(R.string.genInstr) \n \n \(mMessage) ", preferredStyle: .alert)
			alert.setValue(wholeMsg, forKey: "attributedMessage")
			let coloredBG = 				UIView()
			let blurFx = 					UIBlurEffect(style: .dark)
			let blurFxView = 				UIVisualEffectView(effect: blurFx)
			alert.titleAttributes = 		[NSAttributedString.StringAttribute(key: .foregroundColor, value: R.color.YumaRed)]
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
			alert.addAction(UIAlertAction(title: R.string.ok.uppercased(), style: .default, handler: 	{ 	(action) in
				coloredBG.removeFromSuperview()
				blurFxView.removeFromSuperview()
			}))
			self.present(alert, animated: true, completion:
				{
			})
		}
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
		//field3Label.alpha = 0//.isHidden = true
		field3Edit.textColor = UIColor.darkGray
		field4Edit.text = self.customer?.birthday
		field5Edit.text = self.customer?.company
		field6Edit.text = self.customer?.website
		field7Edit.text = self.customer?.siret
		field8Edit.text = self.customer?.ape
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
		if passwordEdit.text != nil && (passwordEdit.text?.isEmpty)!
		{
			passwordInvalid.text = "\(R.string.invalid) \(R.string.txtPass)"
			passwordBorder.layer.borderColor = UIColor.red.cgColor
			passed = false
		}
//		if field4Edit.text != nil && (field4Edit.text?.isEmpty)!
//		{
//			fieldInvalid1.text = "\(R.string.invalid) \(R.string.bDate)"
//			field4Border.layer.borderColor = UIColor.red.cgColor
//			passed = false
//		}
//		if field5Edit.text != nil && (field5Edit.text?.isEmpty)!
//		{
//			field5Invalid.text = "\(R.string.invalid) \(R.string.co)"
//			field5Border.layer.borderColor = UIColor.red.cgColor
//			passed = false
//		}
//		if field6Edit.text != nil && (field6Edit.text?.isEmpty)!
//		{
//			field6Invalid.text = "\(R.string.invalid) \(R.string.website)"
//			field6Border.layer.borderColor = UIColor.red.cgColor
//			passed = false
//		}
//		if field7Edit.text != nil && (field7Edit.text?.isEmpty)!
//		{
//			field7Invalid.text = "\(R.string.invalid) \(R.string.siret)"
//			field7Border.layer.borderColor = UIColor.red.cgColor
//			passed = false
//		}
//		if field8Edit.text != nil && (field8Edit.text?.isEmpty)!
//		{
//			field8Invalid.text = "\(R.string.invalid) \(R.string.ape)"
//			field8Border.layer.borderColor = UIColor.red.cgColor
//			passed = false
//		}
		return passed
	}

	
	// MARK: IBActions
	@objc func loginButtonAct(_ sender: Any)
	{
		self.dismiss(animated: false, completion: nil)
	}
	@objc func showPassAct(_ sender: Any)
	{
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
		if areFieldsValid()
		{
			var ws = WebService()
			ws.startURL = R.string.WSbase
			ws.resource = APIResource.customers
			ws.keyAPI = R.string.APIkey
			let date = Date()
			let df = DateFormatter()
			df.dateFormat = "yyyy-MM-dd HH:mm:ss"
			let today = df.string(from: date)
			//let myIp =
			if addNew
			{
				ws.schema = Schema.blank
				let ipaddr: String = store.getIPAddress()!
	//			ws.get { (result) in
	//			}
				let newRow = Customer(id: "", id_customer: "", id_default_group: String(store.idDefaultGroup), id_lang: String(store.myLang), newsletter_date_add: switch1.isOn ? today : "", ip_registration_newsletter: switch1.isOn ? ipaddr : "", last_passwd_gen: "", secure_key: "", deleted: "0", passwd: passwordEdit.text != nil ? passwordEdit.text! : "", lastname: field2Edit.text != nil ? field2Edit.text! : "", firstname: fieldEdit1.text != nil ? fieldEdit1.text! : "", email: field3Edit.text != nil ? field3Edit.text! : "", id_gender: genderSwitch.selectedSegmentIndex == 0 ? R.string.mr : R.string.mrs, birthday: field4Edit.text, newsletter: switch1.isOn ? "1" : "0", optin: switch0.isOn ? "1" : "0", website: "", company: "", siret: "", ape: "", outstanding_allow_amount: "0", show_public_prices: "1", id_risk: "0", max_payment_days: "100", active: "1", note: "", is_guest: "0", id_shop: String(store.idShop), id_shop_group: String(store.idShopGgroup), date_add: today, date_upd: today, reset_password_token: "", reset_password_validity: "", associations: nil)
				//print(newRow)
				// Add a row
				//ws.schema = nil
				ws.xml = PSWebServices.object2psxml(object: newRow, resource: "\(ws.resource!)", resource2: ws.resource2(resource: "\(ws.resource!)"), excludeId: true)
				print(ws.xml!)
				ws.printURL()
				ws.add() 	{ 	(result) in
					if result.data != nil
					{
						let data = String(data: result.data! as Data, encoding: .utf8)
						print(data!)
						print("----add^")
					}
				}
			}
			else
			{
				ws.filter = ["id" : [4]]
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
				let str = PSWebServices.object2psxml(object: edited!, resource: "customers", resource2: "customer", excludeId: false)
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
		}
	}
	@IBAction func navCloseAct(_ sender: Any)
	{
		self.dismiss(animated: false, completion: nil)
	}
	

	@IBAction func navHelpAct(_ sender: Any)
	{
		let viewC = Assistance()
		viewC.array = R.array.help_my_account_information_guide
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
