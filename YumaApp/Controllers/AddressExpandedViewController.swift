//
//  AddressExpandedViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-07.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class AddressExpandedViewController: UIViewController, UITextFieldDelegate
{
	@IBOutlet weak var navBar: UINavigationBar!
	@IBOutlet weak var navTitle: UINavigationItem!
	@IBOutlet weak var navClose: UIBarButtonItem!
	@IBOutlet weak var navHelp: UIBarButtonItem!
	@IBOutlet weak var stackFields: UIStackView!
	@IBOutlet weak var aliasBorder: UIView!
	@IBOutlet weak var aliasLabel: UILabel!
	@IBOutlet weak var aliasField: UITextField!
	@IBOutlet weak var aliasInvalid: UILabel!
	@IBOutlet weak var fNameBorder: UIView!
	@IBOutlet weak var fNameLabel: UILabel!
	@IBOutlet weak var fNameField: UITextField!
	@IBOutlet weak var fNameInvalid: UILabel!
	@IBOutlet weak var lNameBorder: UIView!
	@IBOutlet weak var lNameLabel: UILabel!
	@IBOutlet weak var lNameField: UITextField!
	@IBOutlet weak var lNameInvalid: UILabel!
	@IBOutlet weak var bNameBorder: UIView!
	@IBOutlet weak var bNameLabel: UILabel!
	@IBOutlet weak var bNameField: UITextField!
	@IBOutlet weak var bNameInvalid: UILabel!
	@IBOutlet weak var addr1Border: UIView!
	@IBOutlet weak var addr1Label: UILabel!
	@IBOutlet weak var addr1Field: UITextField!
	@IBOutlet weak var addr1Invalid: UILabel!
	@IBOutlet weak var addr2Border: UIView!
	@IBOutlet weak var addr2Label: UILabel!
	@IBOutlet weak var addr2Field: UITextField!
	@IBOutlet weak var addr2Invalid: UILabel!
	@IBOutlet weak var cityBorder: UIView!
	@IBOutlet weak var cityLabel: UILabel!
	@IBOutlet weak var cityField: UITextField!
	@IBOutlet weak var cityInvalid: UILabel!
	@IBOutlet weak var postcodeBorder: UIView!
	@IBOutlet weak var postcodeLabel: UILabel!
	@IBOutlet weak var postcodeField: UITextField!
	@IBOutlet weak var postcodeInvalid: UILabel!
	@IBOutlet weak var stateBorder: UIView!
	@IBOutlet weak var stateLabel: UILabel!
	@IBOutlet weak var stateField: UITextField!
	@IBOutlet weak var stateInvalid: UILabel!
	@IBOutlet weak var countryBorder: UIView!
	@IBOutlet weak var countryLabel: UILabel!
	@IBOutlet weak var countryField: UITextField!
	@IBOutlet weak var countryInvalid: UILabel!
	@IBOutlet weak var phoneBorder: UIView!
	@IBOutlet weak var phoneLabel: UILabel!
	@IBOutlet weak var phoneField: UITextField!
	@IBOutlet weak var phoneInvalid: UILabel!
	@IBOutlet weak var mobBorder: UIView!
	@IBOutlet weak var mobLabel: UILabel!
	@IBOutlet weak var mobField: UITextField!
	@IBOutlet weak var mobInvalid: UILabel!
	@IBOutlet weak var otherBorder: UIView!
	@IBOutlet weak var otherLabel: UILabel!
	@IBOutlet weak var otherField: UITextField!
	@IBOutlet weak var otherInvalid: UILabel!
	@IBOutlet weak var button: GradientButton!
	@IBOutlet weak var scrollForm: UIScrollView!
	var address: Address? = nil
	let store = DataStore.sharedInstance
//	let picker = UIPickerView()
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

		setupNavigation()
		button.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		clearErrors()
		prepareLabels()
		fillDetails()
		let notificationCenter = NotificationCenter.default
		notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillHide, object: nil)
		notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
//		notificationCenter.addObserver(self, selector: #selector(textFieldDidChange(_:)), name: Notification.Name.UITextFieldTextDidChange, object: nil)
		notificationCenter.addObserver(self, selector: #selector(selectedACountry(_:)), name: AddressExpandedViewController.selectCountry, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


	// MARK: Methods
	fileprivate func setupNavigation()
	{
		if #available(iOS 11.0, *)
		{
			navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		}
		else
		{
			navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
		}
		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
		navTitle.title = R.string.Addr
		navClose.title = FontAwesome.times.rawValue
		navHelp.title = FontAwesome.questionCircle.rawValue
		navHelp.setTitleTextAttributes([NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)], for: .normal)
		if #available (iOS 10.0, *)
		{
			navHelp.setTitleTextAttributes([
				NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)
				], for: UIControlState.selected)
		}
		else
		{
			navHelp.setTitleTextAttributes([
				NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)
				], for: UIControlState.highlighted)
		}
	}


	func clearErrors()
	{
		aliasBorder.borderColor = UIColor.clear
		aliasInvalid.text = ""
		fNameBorder.borderColor = UIColor.clear
		fNameInvalid.text = ""
		lNameBorder.borderColor = UIColor.clear
		lNameInvalid.text = ""
		bNameBorder.borderColor = UIColor.clear
		bNameInvalid.text = ""
		addr1Border.borderColor = UIColor.clear
		addr1Invalid.text = ""
		addr2Border.borderColor = UIColor.clear
		addr2Invalid.text = ""
		cityBorder.borderColor = UIColor.clear
		cityInvalid.text = ""
		postcodeBorder.borderColor = UIColor.clear
		postcodeInvalid.text = ""
		stateBorder.borderColor = UIColor.clear
		stateInvalid.text = ""
		countryBorder.borderColor = UIColor.clear
		countryInvalid.text = ""
		phoneBorder.borderColor = UIColor.clear
		phoneInvalid.text = ""
		mobBorder.borderColor = UIColor.clear
		mobInvalid.text = ""
		otherBorder.borderColor = UIColor.clear
		otherInvalid.text = ""
	}

	func prepareLabels()
	{
		aliasLabel.text = R.string.alias
		aliasField.placeholder = R.string.nickName
		fNameLabel.text = R.string.fName
		lNameLabel.text = R.string.lName
		bNameLabel.text = R.string.co
		bNameField.placeholder = R.string.optional
		let bNameOptional = UILabel()
		bNameOptional.text = R.string.optional
		//print(bNameOptional.frame)
//		(bNameBorder.subviews.first?.subviews.first as! UIStackView).addArrangedSubview(bNameOptional)
//^
//[LayoutConstraints] Unable to simultaneously satisfy constraints.
//		(
//		"<NSLayoutConstraint:0x60400028d020 H:[UIView:0x7f96d5743340]-(0)-|   (active, names: '|':UIStackView:0x7f96d5742e50 )>",
//		"<NSLayoutConstraint:0x60400028f960 'UISV-canvas-connection' H:[UILabel:0x7f96d565c810'Optional']-(0)-|   (active, names: '|':UIStackView:0x7f96d5742e50 )>",
//		"<NSLayoutConstraint:0x60400028fa00 'UISV-spacing' H:[UIView:0x7f96d5743340]-(10)-[UILabel:0x7f96d565c810'Optional']   (active)>"
//		)
//
//Will attempt to recover by breaking constraint
//	<NSLayoutConstraint:0x60400028fa00 'UISV-spacing' H:[UIView:0x7f96d5743340]-(10)-[UILabel:0x7f96d565c810'Optional']   (active)>
		//(bNameBorder.subviews.first?.subviews.first as! UIStackView).layoutIfNeeded()
		addr1Label.text = R.string.addr1
		addr2Label.text = R.string.addr2
		addr2Field.placeholder = R.string.optional
		let addr2Optional = UILabel()
		addr2Optional.text = R.string.optional
		cityLabel.text = R.string.city
		postcodeLabel.text = R.string.pcode
		postcodeField.placeholder = "eg. A1B 2C3"
//		let stateSelect = UIButton()
//		stateSelect.setTitle(FontAwesome.caretSquareODown.rawValue, for: .normal)
//		stateSelect.addTarget(self, action: #selector(makeSelect), for: .touchUpInside)
		countryLabel.text = R.string.country
		countryLabel.isUserInteractionEnabled = true
		countryLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(displaySelectACountry(_:))))
		stateLabel.text = R.string.state
		stateLabel.isUserInteractionEnabled = true
//		stateLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(displaySelectAState(_:))))
//		let countrySelect = UIButton()
//		countrySelect.setTitle(FontAwesome.angleDown.rawValue, for: .normal)
//		countrySelect.addTarget(self, action: #selector(makeSelect), for: .touchUpInside)
		pickerCountry.dataSource = self
		pickerCountry.delegate = self
//		for c in store.countries
//		{
//			pickerCountryData[c.name![store.myLang].value!] = Int(c.id!)
//		}
		pickerCountryData = store.countries
		pickerState.dataSource = self
		pickerState.delegate = self
		store.callGetStates(id_country: store.defaultCountry) { (states, err) in
			let states = states as! [CountryState]
			for s in states
			{
				self.pickerStateData.append((s.name)!)
			}
		}
		phoneLabel.text = R.string.ph
		mobLabel.text = R.string.ph_mob
		otherLabel.text = R.string.other
		button.setTitle(R.string.upd.uppercased(), for: .normal)
	}


	func fillDetails()
	{
		if self.address != nil
		{
			aliasField.text = self.address?.alias
			fNameField.text = self.address?.firstname
			lNameField.text = self.address?.lastname
			bNameField.text = self.address?.company
			addr1Field.text = self.address?.address1
			addr2Field.text = self.address?.address2
			cityField.text = self.address?.city
			postcodeField.text = self.address?.postcode
			for state in store.states
			{
				if state.id! == Int((self.address?.id_state)!)!
				{
					stateField.text = state.name
					pickerState.selectRow(state.id!, inComponent: 0, animated: false)
					break
				}
			}
			for country in store.countries
			{
				if country.id! == Int((self.address?.id_country)!)!
				{
					countryField.text = store.valueById(object: country.name!, id: store.myLang)//country.name?[store.myLang].value
					pickerCountry.selectRow(country.id!-1, inComponent: 0, animated: false)
					break
				}
			}
			phoneField.text = self.address?.phone
			mobField.text = self.address?.phone_mobile
			otherField.text = self.address?.other
			fillStates(Int((self.address?.id_country)!)!)
		}
	}


	func checkFields() -> Bool
	{
		clearErrors()
		var status = true
		for v in stackFields.subviews
		{
			if true
			{
				if let field = v.subviews.first?.subviews.first?.subviews.last?.subviews.last as? UITextField
				{
					let invalid = v.subviews.first?.subviews.last as! UILabel
					if field.placeholder != R.string.optional && ((field.text?.isEmpty)! || String(field.text!).count < 2)
					{
						v.borderColor = UIColor.red
						invalid.text = R.string.invalid
						status = true
					}
					else
					{
						v.borderColor = UIColor.clear
						invalid.text = ""
					}
				}
			}
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

	@objc func textFieldDidChange(_ sender: Any)
	{
		if let note = sender as? Notification, let textFieldChanged = note.object as? UITextField
		{
			switch textFieldChanged
			{
			case self.stateField:
				break
			case self.countryField:
				break
			default:
				break
			}
		}
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
		vc.defaultCountry = countryField.text
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
			if countryField.text != store.valueById(object: row.name!, id: store.myLang)
			{
				countryField.text = store.valueById(object: row.name!, id: store.myLang)
				if row.containsStates != nil && row.containsStates != false
				{
					if stateBorder.alpha < 1
					{
						stateBorder.alpha = 1
					}
					fillStates(row.id!)
					stateField.placeholder = R.string.select
					OperationQueue.main.addOperation
					{
						if self.stateLabel.gestureRecognizers == nil || (self.stateLabel.gestureRecognizers?.count)! < 2
						{
							self.stateLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.displaySelectAState(_:))))
						}
					}
				}
				else
				{
					stateBorder.alpha = 0.2
					OperationQueue.main.addOperation
					{
						self.stateLabel.removeGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.displaySelectAState(_:))))
					}
				}
				stateField.text = ""
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
				let country = countryField.text
				if country != nil
				{
					vc?.titleLbl.text?.append(" (\(country!))")
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
		stateField.text = pickerStateData[pickerState.selectedRow(inComponent: 0)]
	}

	@IBAction func navHelpAct(_ sender: Any)
	{
	}
	@IBAction func navCloseAct(_ sender: Any)
	{
		self.dismiss(animated: false, completion: nil)
	}
	@IBAction func buttonAct(_ sender: Any)
	{
		store.flexView(view: button)
		if checkFields()
		{
			DispatchQueue.main.async
				{
					let alert = UIAlertController(title: R.string.upd, message: "\(R.string.save) \"\(self.address?.alias ?? "")\" \(R.string.ok)", preferredStyle: .alert)
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
					coloredBG.alpha = 				0.3
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
//					alert.addAction(UIAlertAction(title: R.string.delete.uppercased(), style: .destructive, handler: { (action) in
//						print("delete item:\(self.address!.alias),\(self.store.formatAddress(self.address))")
//						coloredBG.removeFromSuperview()
//						blurFxView.removeFromSuperview()
//						self.address?.deleted = "1"
//						//self.collectionView.reloadData()
//					}))
					self.present(alert, animated: true, completion:
						{
					})
			}
		}
	}
}



extension AddressExpandedViewController : UIPickerViewDataSource, UIPickerViewDelegate
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
