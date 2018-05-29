//
//  AddNewAddressVC.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-05-24.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


class AddNewAddressVC: UIViewController, UITextFieldDelegate
{
	var navBar = UINavigationBar()
	var navClose = UIBarButtonItem()
	var navHelp = UIBarButtonItem()
	let allStack = UIStackView()
	let picker = UIPickerView()
	var pickerData: [String] = [String]()
	let panel: UIView =
	{
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.white
		view.shadowColor = UIColor.darkGray
		view.shadowOffset = .zero
		view.shadowRadius = 5
		view.shadowOpacity = 1
		return view
	}()
	let alias: InputField =
	{
		let view = InputField(frame: .zero, inputType: .textCapitalizeSentances, hasShowHideIcon: false)
		view.label.textColor = UIColor.darkGray
		view.translatesAutoresizingMaskIntoConstraints = false
		view.fieldFrame.borderWidth = 2
		view.invalid.text = "\(R.string.invalid.capitalized) \(R.string.alias)"
		return view
	}()
	let company: InputField =
	{
		let view = InputField(frame: .zero, inputType: .textCapitalizeWords, hasShowHideIcon: false)
		view.label.textColor = UIColor.darkGray
		view.translatesAutoresizingMaskIntoConstraints = false
		view.textEdit.placeholder = R.string.optional
		view.fieldFrame.borderWidth = 2
		view.invalid.text = "\(R.string.invalid.capitalized) \(R.string.co)"
		return view
	}()
	let lastname: InputField =
	{
		let view = InputField(frame: .zero, inputType: .textCapitalizeWords, hasShowHideIcon: false)
		view.label.textColor = UIColor.darkGray
		view.translatesAutoresizingMaskIntoConstraints = false
		view.fieldFrame.borderWidth = 2
		view.invalid.text = "\(R.string.invalid.capitalized) \(R.string.lName)"
		return view
	}()
	let firstname: InputField =
	{
		let view = InputField(frame: .zero, inputType: .textCapitalizeWords, hasShowHideIcon: false)
		view.label.textColor = UIColor.darkGray
		view.translatesAutoresizingMaskIntoConstraints = false
		view.fieldFrame.borderWidth = 2
		view.invalid.text = "\(R.string.invalid.capitalized) \(R.string.fName)"
		return view
	}()
	let vatNo: InputField =
	{
		let view = InputField(frame: .zero, inputType: .textCapitalizeNone, hasShowHideIcon: false)
		view.label.textColor = UIColor.darkGray
		view.translatesAutoresizingMaskIntoConstraints = false
		view.textEdit.placeholder = R.string.optional
		view.fieldFrame.borderWidth = 2
		view.invalid.text = "\(R.string.invalid.capitalized) \(R.string.taxNo)"
		return view
	}()
	let addr1: InputField =
	{
		let view = InputField(frame: .zero, inputType: .textCapitalizeNone, hasShowHideIcon: false)
		view.label.textColor = UIColor.darkGray
		view.translatesAutoresizingMaskIntoConstraints = false
		view.fieldFrame.borderWidth = 2
		view.invalid.text = "\(R.string.invalid.capitalized) \(R.string.addr1)"
		return view
	}()
	let addr2: InputField =
	{
		let view = InputField(frame: .zero, inputType: .textCapitalizeNone, hasShowHideIcon: false)
		view.label.textColor = UIColor.darkGray
		view.translatesAutoresizingMaskIntoConstraints = false
		view.textEdit.placeholder = R.string.optional
		view.fieldFrame.borderWidth = 2
		view.invalid.text = "\(R.string.invalid.capitalized) \(R.string.addr2)"
		return view
	}()
	let pc: InputField =
	{
		let view = InputField(frame: .zero, inputType: .textCapitalizeNone, hasShowHideIcon: false)
		view.label.textColor = UIColor.darkGray
		view.translatesAutoresizingMaskIntoConstraints = false
		view.fieldFrame.borderWidth = 2
		view.invalid.text = "\(R.string.invalid.capitalized) \(R.string.pcode)"
		return view
	}()
	let city: InputField =
	{
		let view = InputField(frame: .zero, inputType: .textCapitalizeSentances, hasShowHideIcon: false)
		view.label.textColor = UIColor.darkGray
		view.translatesAutoresizingMaskIntoConstraints = false
		view.fieldFrame.borderWidth = 2
		view.invalid.text = "\(R.string.invalid.capitalized) \(R.string.city)"
		return view
	}()
	let other: InputField =
	{
		let view = InputField(frame: .zero, inputType: .textCapitalizeSentances, hasShowHideIcon: false)
		view.label.textColor = UIColor.darkGray
		view.translatesAutoresizingMaskIntoConstraints = false
		view.textEdit.placeholder = R.string.optional
		view.fieldFrame.borderWidth = 2
		view.invalid.text = "\(R.string.invalid.capitalized) \(R.string.other)"
		return view
	}()
	let phone: InputField =
	{
		let view = InputField(frame: .zero, inputType: .textCapitalizeNone, hasShowHideIcon: false)
		view.label.textColor = UIColor.darkGray
		view.translatesAutoresizingMaskIntoConstraints = false
		view.textEdit.placeholder = R.string.optional
		view.fieldFrame.borderWidth = 2
		view.invalid.text = "\(R.string.invalid.capitalized) \(R.string.ph)"
		return view
	}()
	let mob: InputField =
	{
		let view = InputField(frame: .zero, inputType: .textCapitalizeNone, hasShowHideIcon: false)
		view.label.textColor = UIColor.darkGray
		view.translatesAutoresizingMaskIntoConstraints = false
		view.textEdit.placeholder = R.string.optional
		view.fieldFrame.borderWidth = 2
		view.invalid.text = "\(R.string.invalid.capitalized) \(R.string.ph_mob)"
		return view
	}()
	let state: InputField =
	{
		let view = InputField(frame: .zero, inputType: .textCapitalizeSentances, hasShowHideIcon: false)
		view.label.textColor = UIColor.darkGray
		view.translatesAutoresizingMaskIntoConstraints = false
		view.fieldFrame.borderWidth = 2
		view.invalid.text = "\(R.string.invalid.capitalized) \(R.string.state)"
		return view
	}()
	let country: InputField =
	{
		let view = InputField(frame: .zero, inputType: .textCapitalizeSentances, hasShowHideIcon: false)
		view.label.textColor = UIColor.darkGray
		view.translatesAutoresizingMaskIntoConstraints = false
		view.fieldFrame.borderWidth = 2
		view.invalid.text = "\(R.string.invalid.capitalized) \(R.string.country)"
		return view
	}()
	let gapBeforeButton: UIView =
	{
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	let button: GradientButton =
	{
		let view = GradientButton()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.setTitle(R.string.addAddr.uppercased(), for: .normal)
		view.titleLabel?.shadowOffset = CGSize(width: 2, height: 2)
		view.titleLabel?.shadowRadius = 3
		view.titleLabel?.textColor = UIColor.white
		view.setTitleShadowColor(R.color.YumaDRed, for: .normal)
		view.topGradientColor = R.color.YumaRed
		view.bottomGradientColor = R.color.YumaDRed
//		view.bottomGradientColor = R.color.YumaYel
		view.cornerRadius = 3
		view.shadowColor = UIColor.darkGray
		view.shadowOffset = CGSize(width: 1, height: 1)
		view.shadowRadius = 3
		view.borderColor = R.color.YumaDRed
		view.borderWidth = 1
		let titleShadow: NSShadow =
		{
			let view = NSShadow()
			view.shadowColor = UIColor.black
//			view.shadowRadius = 3
			view.shadowOffset = CGSize(width: 1, height: 1)
			return view
		}()
		view.setAttributedTitle(NSAttributedString(string: view.title(for: .normal)!, attributes: [NSAttributedStringKey.font : UIFont(name: "AvenirNext-Bold", size: 17)!, NSAttributedStringKey.shadow : titleShadow]), for: .normal)
		return view
	}()
	var stack: UIStackView =
	{
		let view = UIStackView()
		view.translatesAutoresizingMaskIntoConstraints = false
//		view.axis = .vertical
		view.alignment = .fill
		view.distribution = .fill
		view.spacing = 5
//		view.backgroundColor = UIColor.blue	///!!!!?????
//		view.borderColor = UIColor.red
//		view.borderWidth = 2
		return view
	}()
	let scroll: UIScrollView =
	{
		let view = UIScrollView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	let store = DataStore.sharedInstance
	let pickerCountry = UIPickerView()
	var pickerCountryData: [Country] = []//[String : Int] = [String : Int]()
	let pickerState = UIPickerView()
	var pickerStateData: [String] = [String]()
	static let selectCountry = Notification.Name("selectCountry")
	var displaySelectACountryDONE = false


	// MARK: Overrides

	override func viewDidLoad()
	{
        super.viewDidLoad()

		view.backgroundColor = UIColor.lightGray
		view.addSubview(allStack)
		allStack.translatesAutoresizingMaskIntoConstraints = false
		let allStackTop = allStack.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor)
		allStackTop.priority = UILayoutPriority(rawValue: 750)
		allStackTop.isActive = true
		let allStackTop2 = allStack.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20)
		allStackTop2.priority = UILayoutPriority(rawValue: 250)
		allStackTop2.isActive = true
		NSLayoutConstraint.activate([
			allStack.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: 0),
			allStack.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: 0),
			allStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
			])
		setupNavigation()
        setupBackground()
		allStack.addConstraintsWithFormat(format: "V:|[v0]-1-[v1]-5-|", views: navBar, panel)
		setupFields()
		drawButton()
		clearErrors()
		setupLabels()
		let notificationCenter = NotificationCenter.default
		notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillHide, object: nil)
		notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
		notificationCenter.addObserver(self, selector: #selector(selectedACountry(_:)), name: AddressExpandedViewController.selectCountry, object: nil)
    }

	override func viewDidLayoutSubviews()
	{
		super.viewDidLayoutSubviews()
		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
//		print("view:x=\(view.frame.origin.x), y=\(view.frame.origin.y), w=\(view.frame.width), h=\(view.frame.height)")
//		print("alias:x=\(self.alias.frame.origin.x), y=\(self.alias.frame.origin.y), w=\(self.alias.frame.width), h=\(self.alias.frame.height)")
//		print("stack:x=\(self.stack.frame.origin.x), y=\(self.stack.frame.origin.y), w=\(self.stack.frame.width), h=\(self.stack.frame.height)")
//		print("scroll:x=\(self.scroll.frame.origin.x), y=\(self.scroll.frame.origin.y), w=\(self.scroll.frame.width), h=\(self.scroll.frame.height), cw=\(self.scroll.contentSize.width), ch=\(self.scroll.contentSize.height)")
		let _ = button.addBackgroundGradient(colors: [R.color.YumaRed.cgColor, R.color.YumaYel.cgColor], isVertical: true)
		button.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
	}

	override func viewWillAppear(_ animated: Bool)
	{
		super.viewWillAppear(animated)
//		self.navigationController?.navigationItem.hidesBackButton = true//self.navigationItem.hidesBackButton = true
	}

//	override init(frame: CGRect)
//	{
//		super.init(frame: frame)
//		self.navigationController?.navigationItem.hidesBackButton = true
//	}
//
//	required init?(coder aDecoder: NSCoder)
//	{
//		super.init(coder: aDecoder)
//		fatalError("init(coder:) has not been implemented")
//	}

	deinit
	{
		if #available(iOS 9, *)
		{
			//
		}
		else	//	only required for iOS 8 and below
		{
			let notificationCenter = NotificationCenter.default
			notificationCenter.removeObserver(self, name: Notification.Name.UIKeyboardWillHide, object: nil)
			notificationCenter.removeObserver(self, name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
			notificationCenter.removeObserver(self, name: AddressExpandedViewController.selectCountry, object: nil)
		}
	}

	override func viewDidDisappear(_ animated: Bool)
	{
		super.viewDidDisappear(animated)
	}

	override func didReceiveMemoryWarning()
	{
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


	// MARK: Methods

	private func setupNavigation()
	{
//		navBar = (navigationController?.navigationBar)!
//		let navAppear = UINavigationBar.appearance()
//		navAppear.barTintColor = R.color.YumaRed
		allStack.addSubview(navBar)
		allStack.addConstraintsWithFormat(format: "H:|[v0]|", views: navBar)
//		navBar.topAnchor.constraint(equalTo: allStack.topAnchor, constant: 0).isActive = true
//		navBar.heightAnchor.constraint(equalToConstant: 46).isActive = true
		let navLeft = UINavigationItem(title: "")
		navClose = UIBarButtonItem(title: FontAwesome.times.rawValue, style: UIBarButtonItemStyle.done, target: self, action: #selector(doDismiss(_:)))
		navClose.setTitleTextAttributes([NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)], for: .normal)
		navClose.setTitleTextAttributes([
			NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)
			], for: UIControlState.highlighted)
		navLeft.leftBarButtonItem = navClose
		navLeft.setHidesBackButton(true, animated: false)
		let navRight = UINavigationItem(title: "")
		navHelp = UIBarButtonItem(title: FontAwesome.questionCircle.rawValue, style: UIBarButtonItemStyle.done, target: self, action: #selector(doHelp(_:)))
		navHelp.setTitleTextAttributes([NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)], for: .normal)
		navHelp.setTitleTextAttributes([
			NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)
			], for: UIControlState.highlighted)
		navRight.rightBarButtonItem = navHelp
		navBar.setItems([navLeft, navRight], animated: false)
		navBar.topItem?.title = R.string.addAddr.capitalized
		navBar.isTranslucent = false
		self.navigationItem.setHidesBackButton(true, animated: false)
//		navBar.backItem?.hidesBackButton = true
//		navigationController?.navigationBar.topItem?.hidesBackButton = false
		navBar.layer.masksToBounds = false
		navBar.layer.shadowColor = /*UIColor.black.cgColor*/R.color.YumaDRed.cgColor
		navBar.layer.shadowOpacity = 1//0.8
		navBar.layer.shadowOffset = CGSize(width: 0, height: 1.0)
		navBar.layer.shadowRadius = 1
	}


	private func setupBackground()
	{
		panel.translatesAutoresizingMaskIntoConstraints = false
		allStack.addSubview(panel)
		NSLayoutConstraint.activate([
			panel.trailingAnchor.constraint(equalTo: allStack.trailingAnchor, constant: -5),
			panel.leadingAnchor.constraint(equalTo: allStack.leadingAnchor, constant: 5)
			])
	}


	func setupFields()
	{
		stack = UIStackView(arrangedSubviews: [alias, company, lastname, firstname, vatNo, addr1, addr2, pc, city, state, country, phone, mob, other, gapBeforeButton, button])
//		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
//		stack.alignment = .fill
//		stack.distribution = .fill
//		stack.spacing = 0
		scroll.addSubview(stack)
		stack.addConstraintsWithFormat(format: "H:|[v0]|", views: alias)
		stack.addConstraintsWithFormat(format: "H:|[v0]|", views: gapBeforeButton)
		stack.addConstraint(NSLayoutConstraint(item: gapBeforeButton, attribute: .height, relatedBy: .equal, toItem: stack, attribute: .height, multiplier: 0, constant: 10))
		stack.addConstraint(NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: stack, attribute: .height, multiplier: 0, constant: 45))
		stack.addConstraint(NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: stack, attribute: .width, multiplier: 0, constant: 200))
		scroll.addConstraintsWithFormat(format: "H:|[v0]|", views: stack)
		scroll.addConstraintsWithFormat(format: "V:|-20-[v0]-10-|", views: stack)
		panel.addSubview(scroll)
		panel.addConstraintsWithFormat(format: "H:|-5-[v0]-5-|", views: scroll)
		panel.addConstraintsWithFormat(format: "V:|[v0]|", views: scroll)
		panel.addConstraint(NSLayoutConstraint(item: stack, attribute: .width, relatedBy: .equal, toItem: scroll, attribute: .width, multiplier: 1, constant: 0))
	}


	func drawButton()
	{
		button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:))))
		scroll.addConstraint(NSLayoutConstraint(item: button, attribute: .centerX, relatedBy: .equal, toItem: scroll, attribute: .centerX, multiplier: 1, constant: 0))
	}


	func clearErrors()
	{
		alias.fieldFrame.borderColor = UIColor.clear
		alias.invalid.alpha = 0
		company.fieldFrame.borderColor = UIColor.clear
		company.invalid.alpha = 0
		lastname.fieldFrame.borderColor = UIColor.clear
		lastname.invalid.alpha = 0
		firstname.fieldFrame.borderColor = UIColor.clear
		firstname.invalid.alpha = 0
		vatNo.fieldFrame.borderColor = UIColor.clear
		vatNo.invalid.alpha = 0
		addr1.fieldFrame.borderColor = UIColor.clear
		addr1.invalid.alpha = 0
		addr2.fieldFrame.borderColor = UIColor.clear
		addr2.invalid.alpha = 0
		pc.fieldFrame.borderColor = UIColor.clear
		pc.invalid.alpha = 0
		city.fieldFrame.borderColor = UIColor.clear
		city.invalid.alpha = 0
		state.fieldFrame.borderColor = UIColor.clear
		state.invalid.alpha = 0
		country.fieldFrame.borderColor = UIColor.clear
		country.invalid.alpha = 0
		phone.fieldFrame.borderColor = UIColor.clear
		phone.invalid.alpha = 0
		mob.fieldFrame.borderColor = UIColor.clear
		mob.invalid.alpha = 0
		other.fieldFrame.borderColor = UIColor.clear
		other.invalid.alpha = 0
	}


	func setupLabels()
	{
		alias.label.text = R.string.alias
		company.label.text = R.string.co
		lastname.label.text = R.string.lName
		firstname.label.text = R.string.fName
		vatNo.label.text = R.string.taxNo
		addr1.label.text = R.string.addr1
		addr2.label.text = R.string.addr2
		pc.label.text = R.string.pcode
		city.label.text = R.string.city
		state.label.text = R.string.state
		country.label.text = R.string.country
		country.label.isUserInteractionEnabled = true
		country.label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(displaySelectACountry(_:))))
		phone.label.text = R.string.ph
		mob.label.text = R.string.ph_mob
		other.label.text = R.string.other
	}


	func loadEnteredValues() -> Address
	{
		let date = Date()
		let df = DateFormatter()
		df.dateFormat = "yyyy-MM-dd HH:mm:ss"
		let today = df.string(from: date)
		let newRow = Address(id: 0, id_customer: String((store.customer?.id_customer)!), id_manufacturer: "", id_supplier: "", id_warehouse: "", id_country: "TBD", id_state: "TBD", alias: alias.textEdit.text != nil ? alias.textEdit.text! : "", company: company.textEdit.text != nil ? company.textEdit.text! : "", lastname: lastname.textEdit.text != nil ? lastname.textEdit.text! : "", firstname: firstname.textEdit.text != nil ? firstname.textEdit.text! : "", vat_number: vatNo.textEdit.text != nil ? vatNo.textEdit.text! : "", address1: addr1.textEdit.text != nil ? addr1.textEdit.text! : "", address2: addr2.textEdit.text != nil ? addr2.textEdit.text! : "", postcode: pc.textEdit.text != nil ? pc.textEdit.text! : "", city: city.textEdit.text != nil ? city.textEdit.text! : "", other: other.textEdit.text != nil ? other.textEdit.text! : "", phone: phone.textEdit.text != nil ? phone.textEdit.text! : "", phone_mobile: mob.textEdit.text != nil ? mob.textEdit.text! : "", dni: "", deleted: "0", date_add: today, date_upd: today)
		let encode = try? JSONEncoder().encode(newRow)
		if let jsonStr = String(data: encode!, encoding: .utf8)//encode != nil
		{
//			let jsonStr = String(data: encode!, encoding: .utf8)!
			//{"id_supplier":"","other":"","lastname":"Last","company":"","firstname":"","phone_mobile":"","id_customer":"3","dni":"","deleted":"0","address1":"","alias":"","city":"","vat_number":"","id":0,"date_upd":"2018-05-28 17:21:24","address2":"","id_warehouse":"","phone":"","id_manufacturer":"","id_state":"TBD","postcode":"","date_add":"2018-05-28 17:21:24","id_country":"TBD"}
//			print(jsonStr)
//			UserDefaults.standard.set(encode, forKey: "updateAddress.\(df.string(from: date))")
		}
		return newRow
	}

	
	func checkFields() -> Bool
	{
//		clearErrors()
		var status = true
		var i = 0
		for v in stack.subviews
		{
			if v.superclass != UIButton.self
			{
				if let field = v.subviews.first?.subviews[1].subviews.first as? UITextField
				{
//					let label =  v.subviews.first?.subviews.first as! UILabel
					let invalid = v.subviews.first?.subviews.last as! UILabel
					if (field.placeholder == nil || field.placeholder != R.string.optional) && ((field.text?.isEmpty)! || String(field.text!).count < 2)
					{
						v.subviews.first?.borderColor = UIColor.red
						invalid.alpha = 1
						status = true
					}
					else
					{
						v.borderColor = UIColor.clear
						invalid.alpha = 0
					}
				}
			}
			i += 1
		}
		return status
	}


	// MARK: Actions
	
	@objc func adjustForKeyboard(notification: Notification)
	{
		let userInfo = notification.userInfo!
		let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
		let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
		
		if notification.name == Notification.Name.UIKeyboardWillHide
		{
			self.scroll.contentInset = UIEdgeInsets.zero
		}
		else
		{
			self.scroll.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
		}
		self.scroll.scrollIndicatorInsets = self.scroll.contentInset
		//let selectedRange = self.scrollForm.selectedRange
		//self.scrollForm.scrollRangeToVisible(selectedRange)
	}


	@objc func buttonTapped(_ sender: UITapGestureRecognizer)
	{
		store.flexView(view: button)
		if checkFields()
		{
			let newRow = loadEnteredValues()
//			print("ready to add new address:\(newRow)")
			let spinner = UIViewController.displaySpinner(onView: self.view)
			var ws = WebService()
			ws.startURL = R.string.WSbase
			ws.resource = APIResource.addresses
			ws.keyAPI = R.string.APIkey
			ws.xml = PSWebServices.object2psxml(object: newRow, resource: "\(ws.resource!)", resource2: ws.resource2(resource: "\(ws.resource!)"), omit: ["id"])
			let url = ws.makeURL()//ws.startURL! + ws.resource!.rawValue + ws.keyAPI!
			print("posting to:\"\(url)\"")
			print(ws.xml!)
			store.PostHTTP(url: url/*"\(R.string.WSbase)\(APIResource.addresses)?\(R.string.API_key)"*/, parameters: nil, headers: ["Content-Type": "text/xml; charset=utf-8", "Accept": "text/xml"], body: "\(ws.xml!)", save: nil) 	{ 	(result) in
				UIViewController.removeSpinner(spinner: spinner)
				let title = R.string.Addr
				OperationQueue.main.addOperation
				{
					let alert = 					UIAlertController(title: title, message: result as? String, preferredStyle: .alert)
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
		}
//		self.dismiss(animated: true, completion: nil)
	}

	@objc func displaySelectACountry(_ sender: Any)
	{
		displaySelectACountryDONE = true
		//		if !pickerCountryData.isEmpty
		//		{
		//			let sb = UIStoryboard(name: "HelpStoryboard", bundle: nil)
		//			let vc = sb.instantiateInitialViewController() as? PickerViewController
		//			if vc != nil
		//			{
		//				vc?.defaultCountry = countryField.text
		//				self.present(vc!, animated: true, completion: nil)
		//				//			let blurFxView = 					UIVisualEffectView(effect: UIBlurEffect(style: .dark))
		//				//			blurFxView.frame = 					self.view.bounds
		//				//			blurFxView.alpha = 					0.5
		//				//			blurFxView.autoresizingMask = 		[.flexibleWidth, .flexibleHeight]
		//				//			vc?.backgroundView.addSubview(blurFxView)
		//				vc?.dialog.layer.cornerRadius = 	20
		//				vc?.dialog.layer.masksToBounds = 	true
		//				vc?.dialog.layer.shadowColor = 		UIColor.black.cgColor
		//				vc?.dialog.layer.shadowOffset = 	.zero
		//				vc?.dialog.layer.shadowRadius = 	5
		//				vc?.dialog.layer.shadowOpacity = 	1
		//				vc?.titleLbl.text = 				"\(R.string.select) \(R.string.country)"
		//				vc?.titleLbl.shadowOffset = 		CGSize(width: 1, height: 1)
		//				vc?.titleLbl.shadowColor = 			R.color.YumaDRed
		//				vc?.titleLbl.shadowRadius = 		3
		//				vc?.button.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		//				//				vc?.button.setAttributedTitle(NSAttributedString(string: R.string.finish.uppercased(), attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 20), NSAttributedStringKey.backgroundColor : R.color.YumaRed, NSAttributedStringKey.foregroundColor : UIColor.white, NSAttributedStringKey.shadow : R.shadow.darkGray3_downright1()]), for: .normal)
		//				vc?.button.setTitle(R.string.finish.uppercased(), for: .normal)
		//				vc?.view.addSubview(pickerCountry)
		//				pickerCountry.translatesAutoresizingMaskIntoConstraints = false
		//				NSLayoutConstraint.activate([
		//					pickerCountry.centerXAnchor.constraint(equalTo: (vc?.dialog.centerXAnchor)!),
		//					pickerCountry.centerYAnchor.constraint(equalTo: (vc?.dialog.centerYAnchor)!),
		//					])
		//				vc?.button.addTarget(self, action: #selector(selectedACountry(_:)), for: .touchUpInside)
		//			}
		//			else
		//			{
		//				print("HelpStoryboard has no initial view controller")
		//			}
		//		}
		
		let vc = SelectCountryVC()
		vc.defaultCountry = country.textEdit.text
		vc.dialogWindow.layer.masksToBounds = true
		vc.dialogWindow.borderWidth = 3
		vc.dialogWindow.borderColor = R.color.YumaDRed.withAlphaComponent(0.75)
		//		vc..layer.shadowColor = R.color.YumaDRed.cgColor
		//		vc.dialogWindow.layer.shadowOffset = .zero
		//		vc.dialogWindow.layer.shadowRadius = 5
		//		vc.dialogWindow.layer.shadowOpacity = 1
		vc.buttonSingle.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		vc.buttonSingle.shadowColor = R.color.YumaDRed
		vc.buttonSingle.shadowOffset = .zero
		vc.buttonSingle.shadowRadius = 5
		vc.buttonSingle.shadowOpacity = 0.5
		//		vc.buttonSingle.shadowColor = R.color.YumaDRed//UIColor.black
		//		vc.buttonSingle.shadowOffset = .zero
		//		vc.buttonSingle.shadowRadius = 5
		//		vc.buttonSingle.shadowOpacity = 0.5
		//		vc.title = "\(R.string.select.uppercased()) \(R.string.country.uppercased())"
		vc.buttonSingle.setTitle(R.string.finish.uppercased(), for: .normal)
		vc.isModalInPopover = true
		vc.modalPresentationStyle = .overFullScreen
		self.present(vc, animated: true, completion: nil)
	}
	
	
	@objc func selectedACountry(_ sender: Notification)
	{
		if let row = sender.object as? Country
		{
			if country.textEdit.text != store.valueById(object: row.name!, id: store.myLang)
			{
				country.textEdit.text = store.valueById(object: row.name!, id: store.myLang)
				state.textEdit.text = ""
				if row.containsStates != nil && row.containsStates != false
				{
//					if state.alpha < 1
//					{
//						state.alpha = 1
//					}
					fillStates(row.id!)
					state.textEdit.placeholder = R.string.select
					OperationQueue.main.addOperation
					{
						// WHY CAN'T REMOVE GESTURE...
						//						if self.stateLabel.gestureRecognizers != nil && (self.stateLabel.gestureRecognizers?.count)! > 0
						//						{
						//							self.stateLabel.removeGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.displaySelectAState(_:))))
						//						}
						self.state.textEdit.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.displaySelectAState(_:))))
					}
				}
				else
				{
//					state.alpha = 0.2
					state.textEdit.text = "N/A"
					OperationQueue.main.addOperation
					{
						if self.state.textEdit.gestureRecognizers != nil && (self.state.textEdit.gestureRecognizers?.count)! > 0
						{
							self.state.textEdit.removeGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.displaySelectAState(_:))))
							self.pickerStateData.removeAll()
						}
					}
				}
			}
		}
	}
	
	@objc func displaySelectAState(_ sender: Any)
	{
		if !pickerStateData.isEmpty
		{
			let sb = UIStoryboard(name: "HelpStoryboard", bundle: nil)
			let vc = sb.instantiateInitialViewController() as? PickerViewController
			if vc != nil
			{
				self.present(vc!, animated: true, completion: nil)
				//			let blurFxView = 					UIVisualEffectView(effect: UIBlurEffect(style: .dark))
				//			blurFxView.frame = 					self.view.bounds
				//			blurFxView.alpha = 					0.5
				//			blurFxView.autoresizingMask = 		[.flexibleWidth, .flexibleHeight]
				//			vc?.backgroundView.addSubview(blurFxView)
				vc?.dialog.layer.cornerRadius = 	20
				vc?.dialog.layer.masksToBounds = 	true
				vc?.dialog.layer.shadowColor = 		UIColor.black.cgColor
				vc?.dialog.layer.shadowOffset = 	.zero
				vc?.dialog.layer.shadowRadius = 	5
				vc?.dialog.layer.shadowOpacity = 	1
				vc?.titleLbl.text = 				"\(R.string.select) \(R.string.state)"
				let myCountry = country.textEdit.text
				if myCountry != nil
				{
					vc?.titleLbl.text?.append(" (\(myCountry!.uppercased()))")
				}
				vc?.titleLbl.shadowOffset = 		CGSize(width: 1, height: 1)
				vc?.titleLbl.shadowColor = 			R.color.YumaDRed
				vc?.titleLbl.shadowRadius = 		3
				vc?.button.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
				//				vc?.button.setAttributedTitle(NSAttributedString(string: R.string.finish.uppercased(), attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 20), NSAttributedStringKey.backgroundColor : R.color.YumaRed, NSAttributedStringKey.foregroundColor : UIColor.white, NSAttributedStringKey.shadow : R.shadow.darkGray3_downright1()]), for: .normal)
				vc?.button.setTitle(R.string.finish.uppercased(), for: .normal)
				vc?.view.addSubview(pickerState)
				pickerState.translatesAutoresizingMaskIntoConstraints = false
				NSLayoutConstraint.activate([
					pickerState.centerXAnchor.constraint(equalTo: (vc?.dialog.centerXAnchor)!),
					pickerState.centerYAnchor.constraint(equalTo: (vc?.dialog.centerYAnchor)!),
					])
				vc?.button.addTarget(self, action: #selector(selectedAState(_:)), for: .touchUpInside)
			}
			else
			{
				print("HelpStoryboard has no initial view controller")
			}
		}
	}
	
	@objc func selectedAState(_ sender: Any)
	{
		//		store.flexView(view: sender)
		state.textEdit.text = pickerStateData[pickerState.selectedRow(inComponent: 0)]
	}


	@objc func doAction(notify: Notification)
	{
		let dest = notify.object as! UIViewController
		self.present(dest, animated: false, completion: nil)
	}
	
	@objc func doDismiss(_ sender: UITapGestureRecognizer)
	{
		self.dismiss(animated: false, completion: nil)
	}
	
	@objc func doHelp(_ sender: UITapGestureRecognizer)
	{
		let viewC = Assistance()
		viewC.array = R.array.help_add_address_guide
		viewC.modalTransitionStyle   = .crossDissolve
		viewC.modalPresentationStyle = .overCurrentContext
		self.present(viewC, animated: true, completion: nil)
	}


	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
	{
		if textField == phone || textField == other || textField == mob
		{
			// don't allow lowercase & uppercase letters - ie. good for date, time, numbers
			let charsNotAllowed = CharacterSet.lowercaseLetters.intersection(.uppercaseLetters)
			if let _ = string.rangeOfCharacter(from: charsNotAllowed, options: .caseInsensitive)
			{
				return false
			}
			else
			{
				return true
			}
		}
		else if textField == city || textField == firstname || textField == lastname
		{
			// only allow lowercase & uppercase letters & spaces & dashes - ie. no numbers or symbols
			if string.isEmpty
			{
				return true
			}
			let charsAllowed = CharacterSet.lowercaseLetters.intersection(.uppercaseLetters).intersection(.whitespaces).intersection(CharacterSet(charactersIn: "-"))
			if let canPassRange = string.rangeOfCharacter(from: charsAllowed, options: .caseInsensitive)
			{
				let validCharCount = string.distance(from: canPassRange.lowerBound, to: canPassRange.upperBound)
				return validCharCount == string.count
			}
			else
			{
				return false
			}
		}
		else	// all else can pass
		{
			return true
		}
	}

	func textFieldShouldReturn(_ textField: UITextField) -> Bool
	{	// force all fields to skip to next field when return-key is pressed, ie. only one line
		textField.resignFirstResponder()
		return true
	}


	@objc func dropdownList(_ sender: UITapGestureRecognizer)
	{
		let sb = UIStoryboard(name: "HelpStoryboard", bundle: nil)
		let vc = sb.instantiateInitialViewController() as? PickerViewController
		if vc != nil
		{
			self.present(vc!, animated: true, completion: nil)
			//			let blurFxView = 					UIVisualEffectView(effect: UIBlurEffect(style: .dark))
			//			blurFxView.frame = 					self.view.bounds
			//			blurFxView.alpha = 					0.5
			//			blurFxView.autoresizingMask = 		[.flexibleWidth, .flexibleHeight]
			//			vc?.backgroundView.addSubview(blurFxView)
			vc?.dialog.shadowColor = 			R.color.YumaDRed
			vc?.dialog.shadowOffset = 			.zero
			vc?.dialog.shadowRadius = 			5
			vc?.dialog.shadowOpacity = 			1
			vc?.dialog.layer.cornerRadius = 	20
			vc?.dialog.cornerRadius = 			20
			vc?.titleLbl.text = 				R.string.select + " " + R.string.prod
			vc?.button.setTitle(R.string.select, for: .normal)
			vc?.view.addSubview(picker)
			picker.translatesAutoresizingMaskIntoConstraints = false
			NSLayoutConstraint.activate([
				picker.centerXAnchor.constraint(equalTo: (vc?.dialog.centerXAnchor)!),
				picker.centerYAnchor.constraint(equalTo: (vc?.dialog.centerYAnchor)!),
				])
			vc?.button.addTarget(self, action: #selector(writePickedValue(_:)), for: .touchUpInside)
		}
		else
		{
			print("HelpStoryboard has no initial view controller")
		}
	}

	@objc func writePickedValue(_ sender: UIButton?)
	{
//		self.addMessageField.text = pickerData[picker.selectedRow(inComponent: 0)]
	}

}



extension AddNewAddressVC: UIPickerViewDataSource, UIPickerViewDelegate
{
	func numberOfComponents(in pickerView: UIPickerView) -> Int
	{
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
	{
		if pickerView == pickerState
		{
			return pickerStateData.count
		}
		else
		{
			return pickerCountryData.count
		}
	}
	
	//	func findCountryNameById(_ id: Int) -> String?
	//	{
	//		for c in pickerCountryData
	//		{
	//			if c.id == id
	//			{
	//				return c.name?[store.myLang].value
	//			}
	//		}
	////		for (k, v) in pickerCountryData
	////		{
	////			if v == id
	////			{
	////				return k
	////			}
	////		}
	//		return nil
	//	}
	
	fileprivate func fillStates(_ countryId: Int)
	{
		store.callGetStates(id_country: countryId, completion:{ (states, err) in
			//			if err == nil
			//			{
			self.pickerStateData.removeAll()
			if let states = states as? [CountryState]
			{
				for s in states
				{
					self.pickerStateData.append(s.name!)
				}
				//					OperationQueue.main.addOperation
				//					{
				//						self.stateField.placeholder = R.string.select
				//						if self.stateLabel.gestureRecognizers == nil || (self.stateLabel.gestureRecognizers?.count)! < 2
				//						{
				//							self.stateBorder.alpha = 1
				//							self.stateLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.displaySelectAState(_:))))
				//						}
				//					}
			}
			//				else
			//				{
			//					OperationQueue.main.addOperation
			//					{
			//						self.stateBorder.alpha = 0.2
			//						self.stateLabel.removeGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.displaySelectAState(_:))))
			//					}
			//				}
		}
			/*		}*/)
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
	{
		if pickerView == pickerState
		{
			return pickerStateData[row]
		}
		else if pickerView == pickerCountry
		{
			for c in pickerCountryData
			{
				if c.id == row+1
				{
					if displaySelectACountryDONE
					{
						fillStates(c.id!)
					}
				}
			}
			//			for (k, v) in pickerCountryData
			//			{
			//				if v == row+1
			//				{
			////					countryField.text = k
			//					if displaySelectACountryDONE
			//					{
			//						fillStates(v)
			//					}
			//					return k
			//				}
			//			}
			return "\(R.string.select) \(R.string.country)"
		}
		return R.string.select
	}
	
}
