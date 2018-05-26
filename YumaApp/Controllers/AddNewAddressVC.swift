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
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	let company: InputField =
	{
		let view = InputField(frame: .zero, inputType: .textCapitalizeWords, hasShowHideIcon: false)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	let lastname: InputField =
	{
		let view = InputField(frame: .zero, inputType: .textCapitalizeWords, hasShowHideIcon: false)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	let firstname: InputField =
	{
		let view = InputField(frame: .zero, inputType: .textCapitalizeWords, hasShowHideIcon: false)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	let vatNo: InputField =
	{
		let view = InputField(frame: .zero, inputType: .textCapitalizeNone, hasShowHideIcon: false)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	let addr1: InputField =
	{
		let view = InputField(frame: .zero, inputType: .textCapitalizeNone, hasShowHideIcon: false)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	let addr2: InputField =
	{
		let view = InputField(frame: .zero, inputType: .textCapitalizeNone, hasShowHideIcon: false)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	let pc: InputField =
	{
		let view = InputField(frame: .zero, inputType: .textCapitalizeNone, hasShowHideIcon: false)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	let city: InputField =
	{
		let view = InputField(frame: .zero, inputType: .textCapitalizeSentances, hasShowHideIcon: false)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	let other: InputField =
	{
		let view = InputField(frame: .zero, inputType: .textCapitalizeSentances, hasShowHideIcon: false)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	let phone: InputField =
	{
		let view = InputField(frame: .zero, inputType: .textCapitalizeNone, hasShowHideIcon: false)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	let mob: InputField =
	{
		let view = InputField(frame: .zero, inputType: .textCapitalizeNone, hasShowHideIcon: false)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	let state: InputField =
	{
		let view = InputField(frame: .zero, inputType: .textCapitalizeSentances, hasShowHideIcon: false)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	let country: InputField =
	{
		let view = InputField(frame: .zero, inputType: .textCapitalizeSentances, hasShowHideIcon: false)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()


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
//			allStack.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 0),
			allStack.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: 0),
			allStack.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: 0),
			allStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
			])
		setupNavigation()
        setupBackground()
		allStack.addConstraintsWithFormat(format: "V:|[v0][v1]-5-|", views: navBar, panel)
		setupFields()
		clearErrors()
		setupLabels()
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
		let navAppear = UINavigationBar.appearance()
		navAppear.barTintColor = R.color.YumaRed
//		navAppear.setBackgroundImage(gradientV(size: navBar.frame.size, colors: [R.color.YumaDRed, R.color.YumaRed]), for: .default)
//		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
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
		navBar.topItem?.title = R.string.addAddr
		navBar.isTranslucent = false
	}

	func gradientV(size: CGSize, colors: [UIColor]) -> UIImage?
	{
		let cgcolors = colors.map { 	$0.cgColor 	}
		UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
		guard let context = UIGraphicsGetCurrentContext() else { 	return nil 	}
		defer { 	UIGraphicsEndImageContext() 	}
		var locations: [CGFloat] = [0.0, 1.0]
		guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: cgcolors as NSArray as CFArray, locations: &locations) else { 	return nil 	}
		context.drawLinearGradient(gradient, start: CGPoint(x: 0.0, y: 0.0), end: CGPoint(x: 0.0, y: size.height), options: [])
		return UIGraphicsGetImageFromCurrentImageContext()
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
		let scroll = UIScrollView()
		scroll.translatesAutoresizingMaskIntoConstraints = false
//		scroll.backgroundColor = UIColor.clear
		let stack = UIStackView(arrangedSubviews: [alias, company, lastname, firstname, vatNo, addr1, addr2, pc, city, phone, other, mob, state, country])
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.alignment = .fill
		stack.distribution = .fill
		stack.spacing = 5
		stack.backgroundColor = UIColor.blue	///!!!!?????
		scroll.addSubview(stack)
		NSLayoutConstraint.activate([
			alias.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 0),
			alias.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 0),
			company.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 0),
			company.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 0),
			lastname.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 0),
			lastname.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 0),
			firstname.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 0),
			firstname.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 0),
			vatNo.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 0),
			vatNo.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 0),
			addr1.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 0),
			addr1.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 0),
			addr2.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 0),
			addr2.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 0),
			pc.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 0),
			pc.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 0),
			city.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 0),
			city.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 0),
			phone.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 0),
			phone.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 0),
			other.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 0),
			other.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 0),
			mob.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 0),
			mob.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 0),
			state.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 0),
			state.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 0),
			country.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 0),
			country.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 0),
			stack.topAnchor.constraint(equalTo: scroll.topAnchor, constant: 0),
			stack.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 0),
			stack.bottomAnchor.constraint(equalTo: scroll.bottomAnchor, constant: 0),
			stack.trailingAnchor.constraint(equalTo: scroll.trailingAnchor, constant: 0),
			])
		panel.addSubview(scroll)
		scroll.contentSize.width = view.frame.width-20
		NSLayoutConstraint.activate([
			scroll.topAnchor.constraint(equalTo: panel.topAnchor, constant: 0),
			scroll.leadingAnchor.constraint(equalTo: panel.leadingAnchor, constant: 5),
			scroll.bottomAnchor.constraint(equalTo: panel.bottomAnchor, constant: 0),
			scroll.trailingAnchor.constraint(equalTo: panel.trailingAnchor, constant: -5),
			])
	}

	
	func clearErrors()
	{
		alias.fieldFrame.borderColor = UIColor.clear
		alias.fieldFrame.borderWidth = 2
		alias.invalid.text = ""
		company.fieldFrame.borderColor = UIColor.clear
		company.fieldFrame.borderWidth = 2
		company.invalid.text = ""
		lastname.fieldFrame.borderColor = UIColor.clear
		lastname.fieldFrame.borderWidth = 2
		lastname.invalid.text = ""
		firstname.fieldFrame.borderColor = UIColor.clear
		firstname.fieldFrame.borderWidth = 2
		firstname.invalid.text = ""
		vatNo.fieldFrame.borderColor = UIColor.clear
		vatNo.fieldFrame.borderWidth = 2
		vatNo.invalid.text = ""
		addr1.fieldFrame.borderColor = UIColor.clear
		addr1.fieldFrame.borderWidth = 2
		addr1.invalid.text = ""
		addr2.fieldFrame.borderColor = UIColor.clear
		addr2.fieldFrame.borderWidth = 2
		addr2.invalid.text = ""
		pc.fieldFrame.borderColor = UIColor.clear
		pc.fieldFrame.borderWidth = 2
		pc.invalid.text = ""
		city.fieldFrame.borderColor = UIColor.clear
		city.fieldFrame.borderWidth = 2
		city.invalid.text = ""
		state.fieldFrame.borderColor = UIColor.clear
		state.fieldFrame.borderWidth = 2
		state.invalid.text = ""
		country.fieldFrame.borderColor = UIColor.clear
		country.fieldFrame.borderWidth = 2
		country.invalid.text = ""
		phone.fieldFrame.borderColor = UIColor.clear
		phone.fieldFrame.borderWidth = 2
		phone.invalid.text = ""
		other.fieldFrame.borderColor = UIColor.clear
		other.fieldFrame.borderWidth = 2
		other.invalid.text = ""
		mob.fieldFrame.borderColor = UIColor.clear
		mob.fieldFrame.borderWidth = 2
		mob.invalid.text = ""
	}


	func setupLabels()
	{
		alias.label.text = R.string.alias
		company.label.text = R.string.co
		lastname.label.text = R.string.lName
		firstname.label.text = R.string.fName
		vatNo.label.text = R.string.tax
		addr1.label.text = R.string.addr1
		addr2.label.text = R.string.addr2
		pc.label.text = R.string.pcode
		city.label.text = R.string.city
		state.label.text = R.string.state
		country.label.text = R.string.country
		phone.label.text = R.string.ph
		other.label.text = R.string.other
		mob.label.text = R.string.ph_mob
	}


	// MARK: Actions

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
		viewC.array = R.array.help_checkout_guide
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
