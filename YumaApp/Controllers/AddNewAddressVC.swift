//
//  AddNewAddressVC.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-05-24.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit
import SWXMLHash


class AddNewAddressVC: UIViewController, UITextFieldDelegate
{
//	var navBar = UINavigationBar()
//	var navClose = UIBarButtonItem()
//	var navHelp = UIBarButtonItem()
//	let allStack = UIStackView()
	let picker = UIPickerView()
	var pickerData: [String] = [String]()
	let stackAll: UIStackView =
	{
		let view = UIStackView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.axis = .vertical
		view.spacing = 0
		return view
	}()
	var navBar: UINavigationBar =
	{
		let view = UINavigationBar()
		view.backgroundColor = R.color.YumaDRed
		return view
	}()
	let navTitle: UINavigationItem =
	{
		let view = UINavigationItem()
		return view
	}()
	var navClose: UIBarButtonItem =
	{
		let view = UIBarButtonItem()
		view.image = Awesome.solid.times.asImage(size: 24)
		view.action = #selector(doDismiss(_:))
		view.style = UIBarButtonItemStyle.plain
		return view
	}()
	var navHelp: UIBarButtonItem =
	{
		let view = UIBarButtonItem()
		view.image = Awesome.solid.questionCircle.asImage(size: 24)
		view.action = #selector(doHelp(_:))
		view.style = UIBarButtonItemStyle.plain
		return view
	}()
	let viewOuter: UIView =
	{
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.lightGray
		return view
	}()
	let stackPanel: UIStackView =
	{
		let view = UIStackView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.lightGray
		return view
	}()
	let viewPanel: UIView =
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
		let view = InputField()
		view.label.textColor = UIColor.darkGray
		view.translatesAutoresizingMaskIntoConstraints = false
		view.fieldFrame.borderWidth = 2
		view.invalid.text = "\(R.string.invalid.capitalized) \(R.string.alias)"
		return view
	}()
	let company: InputField =
	{
		let view = InputField(frame: .zero, inputType: .textCapitalizeWords)
		view.label.textColor = UIColor.darkGray
		view.translatesAutoresizingMaskIntoConstraints = false
		view.textEdit.placeholder = R.string.optional
		view.fieldFrame.borderWidth = 2
		view.invalid.text = "\(R.string.invalid.capitalized) \(R.string.co)"
		return view
	}()
	let lastname: InputField =
	{
		let view = InputField(frame: .zero, inputType: .textCapitalizeWords)
		view.label.textColor = UIColor.darkGray
		view.translatesAutoresizingMaskIntoConstraints = false
		view.fieldFrame.borderWidth = 2
		view.invalid.text = "\(R.string.invalid.capitalized) \(R.string.lName)"
		return view
	}()
	let firstname: InputField =
	{
		let view = InputField(frame: .zero, inputType: .textCapitalizeWords)
		view.label.textColor = UIColor.darkGray
		view.translatesAutoresizingMaskIntoConstraints = false
		view.fieldFrame.borderWidth = 2
		view.invalid.text = "\(R.string.invalid.capitalized) \(R.string.fName)"
		return view
	}()
	let vatNo: InputField =
	{
		let view = InputField(frame: .zero, inputType: .textCapitalizeNone)
		view.label.textColor = UIColor.darkGray
		view.translatesAutoresizingMaskIntoConstraints = false
		view.textEdit.placeholder = R.string.optional
		view.fieldFrame.borderWidth = 2
		view.invalid.text = "\(R.string.invalid.capitalized) \(R.string.taxNo)"
		return view
	}()
	let addr1: InputField =
	{
		let view = InputField(frame: .zero, inputType: .textCapitalizeNone)
		view.label.textColor = UIColor.darkGray
		view.translatesAutoresizingMaskIntoConstraints = false
		view.fieldFrame.borderWidth = 2
		view.invalid.text = "\(R.string.invalid.capitalized) \(R.string.addr1)"
		return view
	}()
	let addr2: InputField =
	{
		let view = InputField(frame: .zero, inputType: .textCapitalizeNone)
		view.label.textColor = UIColor.darkGray
		view.translatesAutoresizingMaskIntoConstraints = false
		view.textEdit.placeholder = R.string.optional
		view.fieldFrame.borderWidth = 2
		view.invalid.text = "\(R.string.invalid.capitalized) \(R.string.addr2)"
		return view
	}()
	let pc: InputField =
	{
		let view = InputField(frame: .zero, inputType: .textCapitalizeNone)
		view.label.textColor = UIColor.darkGray
		view.translatesAutoresizingMaskIntoConstraints = false
		view.fieldFrame.borderWidth = 2
		view.invalid.text = "\(R.string.invalid.capitalized) \(R.string.pcode)"
		return view
	}()
	let city: InputField =
	{
		let view = InputField()
		view.label.textColor = UIColor.darkGray
		view.translatesAutoresizingMaskIntoConstraints = false
		view.fieldFrame.borderWidth = 2
		view.invalid.text = "\(R.string.invalid.capitalized) \(R.string.city)"
		return view
	}()
	let other: InputField =
	{
		let view = InputField()
		view.label.textColor = UIColor.darkGray
		view.translatesAutoresizingMaskIntoConstraints = false
		view.textEdit.placeholder = R.string.optional
		view.fieldFrame.borderWidth = 2
		view.invalid.text = "\(R.string.invalid.capitalized) \(R.string.other)"
		return view
	}()
	let phone: InputField =
	{
		let view = InputField(frame: .zero, inputType: .textCapitalizeNone)
		view.label.textColor = UIColor.darkGray
		view.translatesAutoresizingMaskIntoConstraints = false
		view.textEdit.placeholder = R.string.optional
		view.fieldFrame.borderWidth = 2
		view.invalid.text = "\(R.string.invalid.capitalized) \(R.string.ph)"
		return view
	}()
	let mob: InputField =
	{
		let view = InputField(frame: .zero, inputType: .textCapitalizeNone)
		view.label.textColor = UIColor.darkGray
		view.translatesAutoresizingMaskIntoConstraints = false
		view.textEdit.placeholder = R.string.optional
		view.fieldFrame.borderWidth = 2
		view.invalid.text = "\(R.string.invalid.capitalized) \(R.string.ph_mob)"
		return view
	}()
	let state: InputField =
	{
		let view = InputField(frame: .zero, inputType: .textCapitalizeSentances, hasShowHideIcon: false, likeButton: true)
		view.label.textColor = UIColor.darkGray
		view.translatesAutoresizingMaskIntoConstraints = false
		view.fieldFrame.borderWidth = 2
		view.labelLooksLikeButton = true
		view.invalid.text = "\(R.string.invalid.capitalized) \(R.string.state)"
		return view
	}()
	let country: InputField =
	{
		let view = InputField(frame: .zero, inputType: .textCapitalizeSentances, hasShowHideIcon: false, likeButton: true)
		view.label.textColor = UIColor.darkGray
		view.translatesAutoresizingMaskIntoConstraints = false
		view.fieldFrame.borderWidth = 2
		view.invalid.text = "\(R.string.invalid.capitalized) \(R.string.country)"
		view.labelLooksLikeButton = true
		return view
	}()
	let gapBeforeButton: UIView =
	{
		let view = UIView()
//		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	let button: GradientButton =
	{
		let view = GradientButton()
//		view.translatesAutoresizingMaskIntoConstraints = false
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
	var pickerStateData: [String] = [String]()
	static let selectCountry = Notification.Name("selectCountry")
	static let selectState = Notification.Name("selectState")
	var displaySelectACountryDONE = false
	var countryId = -1
	var stateId = -1


	// MARK: Overrides

	override func viewDidLoad()
	{
        super.viewDidLoad()

		view.backgroundColor = UIColor.lightGray
//		view.addSubview(allStack)
//		allStack.translatesAutoresizingMaskIntoConstraints = false
//		let allStackTop = allStack.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor)
//		allStackTop.priority = UILayoutPriority(rawValue: 750)
//		allStackTop.isActive = true
//		let allStackTop2 = allStack.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20)
//		allStackTop2.priority = UILayoutPriority(rawValue: 250)
//		allStackTop2.isActive = true
//		NSLayoutConstraint.activate([
//			allStack.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: 0),
//			allStack.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: 0),
//			allStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
//			])
		setupNavigation()
		setViews()
//        setupBackground()
//		allStack.addConstraintsWithFormat(format: "V:|[v0]-1-[v1]-5-|", views: navBar, panel)
		setupFields()
		drawButton()
		clearErrors()
		setupLabels()
		let notificationCenter = NotificationCenter.default
		notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillHide, object: nil)
		notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
		notificationCenter.addObserver(self, selector: #selector(selectedACountry(_:)), name: AddressExpandedViewController.selectCountry, object: nil)
		notificationCenter.addObserver(self, selector: #selector(selectedAState(_:)), name: AddressExpandedViewController.selectState, object: nil)
    }

	override func viewDidLayoutSubviews()
	{
		super.viewDidLayoutSubviews()
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
			notificationCenter.removeObserver(self, name: AddressExpandedViewController.selectState, object: nil)
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

	fileprivate func setViews()
	{
		viewPanel.addSubview(scroll)
		viewPanel.addConstraintsWithFormat(format: "H:|-5-[v0]-5-|", views: scroll)
		viewPanel.addConstraintsWithFormat(format: "V:|-10-[v0]-5-|", views: scroll)
//		scroll.topAnchor.constraint(equalTo: viewPanel.topAnchor, constant: 10).isActive = true
//		scroll.leadingAnchor.constraint(equalTo: viewPanel.leadingAnchor, constant: 5).isActive = true
//		scroll.bottomAnchor.constraint(equalTo: viewPanel.bottomAnchor, constant: -5).isActive = true
//		scroll.trailingAnchor.constraint(equalTo: viewPanel.trailingAnchor, constant: -5).isActive = true

		stackPanel.addSubview(viewPanel)
		stackPanel.addConstraintsWithFormat(format: "H:|-0-[v0]-0-|", views: viewPanel)
		stackPanel.addConstraintsWithFormat(format: "V:|-0-[v0]-0-|", views: viewPanel)
//		viewPanel.topAnchor.constraint(equalTo: stackPanel.topAnchor, constant: 0).isActive = true
//		viewPanel.leadingAnchor.constraint(equalTo: stackPanel.leadingAnchor, constant: 0).isActive = true
//		viewPanel.bottomAnchor.constraint(equalTo: stackPanel.bottomAnchor, constant: 0).isActive = true
//		viewPanel.trailingAnchor.constraint(equalTo: stackPanel.trailingAnchor, constant: 0).isActive = true
		
		viewOuter.addSubview(stackPanel)
		viewOuter.addConstraintsWithFormat(format: "H:|-5-[v0]-5-|", views: stackPanel)
		viewOuter.addConstraintsWithFormat(format: "V:|-0-[v0]-5-|", views: stackPanel)
//		stackPanel.topAnchor.constraint(equalTo: viewOuter.topAnchor, constant: 0).isActive = true
//		stackPanel.leadingAnchor.constraint(equalTo: viewOuter.leadingAnchor, constant: 5).isActive = true
//		stackPanel.bottomAnchor.constraint(equalTo: viewOuter.bottomAnchor, constant: -5).isActive = true
//		stackPanel.trailingAnchor.constraint(equalTo: viewOuter.trailingAnchor, constant: -5).isActive = true
		
		stackAll.addArrangedSubview(viewOuter)
		
		view.addSubview(stackAll)
		if #available(iOS 11.0, *) {
			stackAll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		} else {
			let topMargin = stackAll.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0)
			topMargin.priority = UILayoutPriority(rawValue: 250)
			topMargin.isActive = true
			let top20 = stackAll.topAnchor.constraint(equalTo: view.topAnchor, constant: 20)
			top20.priority = UILayoutPriority(rawValue: 750)
			top20.isActive = true
		}
		stackAll.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: 0).isActive = true
		stackAll.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: 0).isActive = true
		stackAll.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor, constant: 0).isActive = true
	}


	private func setupNavigation()
	{
		navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
		navBar.setItems([navTitle], animated: false)
		navBar.tintColor = UIColor.white
		stackAll.addArrangedSubview(navBar)
		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
		navBar.topItem?.title = R.string.addAddr.capitalized
		navClose = UIBarButtonItem(barButtonSystemItem: .stop, target: nil, action: #selector(doDismiss(_:)))
		navTitle.leftBarButtonItems = [navClose]
		navTitle.rightBarButtonItems = [navHelp]
		let line = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 2))
		line.backgroundColor = UIColor.black
		stackAll.addArrangedSubview(line)
	}


	func setupFields()
	{
		stack = UIStackView(arrangedSubviews: [alias, company, lastname, firstname, vatNo, addr1, addr2, pc, city, state, country, phone, mob, other, gapBeforeButton, button])
		stack.axis = .vertical
//		stack.alignment = .fill
//		stack.distribution = .fill
//		stack.spacing = 0
		scroll.addSubview(stack)
		alias.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 0).isActive = true
		alias.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 0).isActive = true
		stack.leadingAnchor.constraint(equalTo: viewPanel.leadingAnchor, constant: 5).isActive = true
		stack.trailingAnchor.constraint(equalTo: viewPanel.trailingAnchor, constant: -5).isActive = true
		stack.addConstraint(NSLayoutConstraint(item: gapBeforeButton, attribute: .height, relatedBy: .equal, toItem: stack, attribute: .height, multiplier: 0, constant: 10))
		stack.addConstraint(NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: button, attribute: .height, multiplier: 0, constant: 45))
		stack.addConstraint(NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: button, attribute: .width, multiplier: 0, constant: 200))

		scroll.addConstraintsWithFormat(format: "H:|-0-[v0]-0-|", views: stack)
		scroll.addConstraintsWithFormat(format: "V:|-20-[v0]-10-|", views: stack)
	}

//	2018-06-23 14:08:14.322 YumaApp[45781:4422172] Unable to simultaneously satisfy constraints.
//	Probably at least one of the constraints in the following list is one you don't want.
//	Try this:
//	(1) look at each constraint and try to figure out which you don't expect;
//	(2) find the code that added the unwanted constraint or constraints and fix it.
//	(
//	"<NSLayoutConstraint:0x17187630 H:|-(5)-[UIScrollView:0x1694f200]   (Names: '|':UIView:0x15df4b50 )>",
//	"<NSLayoutConstraint:0x17187d50 H:[UIScrollView:0x1694f200]-(5)-|   (Names: '|':UIView:0x15df4b50 )>",
//	"<NSLayoutConstraint:0x17187570 H:|-(0)-[UIView:0x15df4b50]   (Names: '|':UIStackView:0x15df82a0 )>",
//	"<NSLayoutConstraint:0x171880c0 H:[UIView:0x15df4b50]-(0)-|   (Names: '|':UIStackView:0x15df82a0 )>",
//	"<NSLayoutConstraint:0x17188270 H:|-(5)-[UIStackView:0x15df82a0]   (Names: '|':UIView:0x15dd87e0 )>",
//	"<NSLayoutConstraint:0x17188310 H:[UIStackView:0x15df82a0]-(5)-|   (Names: '|':UIView:0x15dd87e0 )>",
//	"<NSLayoutConstraint:0x1718a230 H:|-(0)-[UIStackView:0x1713a1e0]   (Names: '|':UIView:0x171842b0 )>",
//	"<NSLayoutConstraint:0x1718a8c0 UIStackView:0x1713a1e0.trailing == UIView:0x171842b0.trailing>",
//	"<NSLayoutConstraint:0x17249130 YumaApp.InputField:0x15d03df0.trailing == UIStackView:0x1718a420.trailing>",
//	"<NSLayoutConstraint:0x17249440 UIStackView:0x1718a420.trailing == UIView:0x15df4b50.trailing - 5>",
//	"<NSLayoutConstraint:0x172496d0 H:[YumaApp.GradientButton:0x17182b00'ADD NEW ADDRESS'(200)]>",
//	"<NSLayoutConstraint:0x172578b0 YumaApp.GradientButton:0x17182b00'ADD NEW ADDRESS'.centerX == UIScrollView:0x1694f200.centerX>",
//	"<NSLayoutConstraint:0x1723b480 'UISV-alignment' YumaApp.InputField:0x15d03df0.trailing == YumaApp.GradientButton:0x17182b00'ADD NEW ADDRESS'.trailing>",
//	"<NSLayoutConstraint:0x172440e0 'UISV-alignment' UINavigationBar:0x17184420.trailing == UIView:0x15dd87e0.trailing>",
//	"<NSLayoutConstraint:0x17253570 'UISV-alignment' UINavigationBar:0x17184420.leading == UIView:0x15dd87e0.leading>",
//	"<NSLayoutConstraint:0x1713bd70 'UISV-canvas-connection' UIStackView:0x1713a1e0.leading == UINavigationBar:0x17184420.leading>",
//	"<NSLayoutConstraint:0x17246c30 'UISV-canvas-connection' H:[UINavigationBar:0x17184420]-(0)-|   (Names: '|':UIStackView:0x1713a1e0 )>",
//	"<NSLayoutConstraint:0x172526c0 'UIView-Encapsulated-Layout-Width' H:[UIView:0x171842b0(1024)]>"
//	)
//	
//	Will attempt to recover by breaking constraint
//	<NSLayoutConstraint:0x1723b480 'UISV-alignment' YumaApp.InputField:0x15d03df0.trailing == YumaApp.GradientButton:0x17182b00'ADD NEW ADDRESS'.trailing>
//	
//	Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
//	The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
//	2018-06-23 14:08:14.336 YumaApp[45781:4422172] Unable to simultaneously satisfy constraints.
//	Probably at least one of the constraints in the following list is one you don't want.
//	Try this:
//	(1) look at each constraint and try to figure out which you don't expect;
//	(2) find the code that added the unwanted constraint or constraints and fix it.
//	(
//	"<NSLayoutConstraint:0x17187630 H:|-(5)-[UIScrollView:0x1694f200]   (Names: '|':UIView:0x15df4b50 )>",
//	"<NSLayoutConstraint:0x17187d50 H:[UIScrollView:0x1694f200]-(5)-|   (Names: '|':UIView:0x15df4b50 )>",
//	"<NSLayoutConstraint:0x17187570 H:|-(0)-[UIView:0x15df4b50]   (Names: '|':UIStackView:0x15df82a0 )>",
//	"<NSLayoutConstraint:0x171880c0 H:[UIView:0x15df4b50]-(0)-|   (Names: '|':UIStackView:0x15df82a0 )>",
//	"<NSLayoutConstraint:0x17188270 H:|-(5)-[UIStackView:0x15df82a0]   (Names: '|':UIView:0x15dd87e0 )>",
//	"<NSLayoutConstraint:0x17188310 H:[UIStackView:0x15df82a0]-(5)-|   (Names: '|':UIView:0x15dd87e0 )>",
//	"<NSLayoutConstraint:0x1718a230 H:|-(0)-[UIStackView:0x1713a1e0]   (Names: '|':UIView:0x171842b0 )>",
//	"<NSLayoutConstraint:0x1718a8c0 UIStackView:0x1713a1e0.trailing == UIView:0x171842b0.trailing>",
//	"<NSLayoutConstraint:0x15d6f4e0 H:|-(0)-[YumaApp.InputField:0x15d03df0]   (Names: '|':UIStackView:0x1718a420 )>",
//	"<NSLayoutConstraint:0x17249300 UIStackView:0x1718a420.leading == UIView:0x15df4b50.leading + 5>",
//	"<NSLayoutConstraint:0x172496d0 H:[YumaApp.GradientButton:0x17182b00'ADD NEW ADDRESS'(200)]>",
//	"<NSLayoutConstraint:0x172578b0 YumaApp.GradientButton:0x17182b00'ADD NEW ADDRESS'.centerX == UIScrollView:0x1694f200.centerX>",
//	"<NSLayoutConstraint:0x17247250 'UISV-alignment' YumaApp.InputField:0x15d03df0.leading == YumaApp.GradientButton:0x17182b00'ADD NEW ADDRESS'.leading>",
//	"<NSLayoutConstraint:0x172440e0 'UISV-alignment' UINavigationBar:0x17184420.trailing == UIView:0x15dd87e0.trailing>",
//	"<NSLayoutConstraint:0x17253570 'UISV-alignment' UINavigationBar:0x17184420.leading == UIView:0x15dd87e0.leading>",
//	"<NSLayoutConstraint:0x1713bd70 'UISV-canvas-connection' UIStackView:0x1713a1e0.leading == UINavigationBar:0x17184420.leading>",
//	"<NSLayoutConstraint:0x17246c30 'UISV-canvas-connection' H:[UINavigationBar:0x17184420]-(0)-|   (Names: '|':UIStackView:0x1713a1e0 )>",
//	"<NSLayoutConstraint:0x172526c0 'UIView-Encapsulated-Layout-Width' H:[UIView:0x171842b0(1024)]>"
//	)
//	
//	Will attempt to recover by breaking constraint
//	<NSLayoutConstraint:0x17247250 'UISV-alignment' YumaApp.InputField:0x15d03df0.leading == YumaApp.GradientButton:0x17182b00'ADD NEW ADDRESS'.leading>
//	
//	Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
//	The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.

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
		company.textEdit.autocapitalizationType = .words
		lastname.label.text = R.string.lName
		lastname.textEdit.autocapitalizationType = .words
		firstname.label.text = R.string.fName
		firstname.textEdit.autocapitalizationType = .words
		vatNo.label.text = R.string.taxNo
		addr1.label.text = R.string.addr1
		addr2.label.text = R.string.addr2
		pc.label.text = R.string.pcode
		pc.textEdit.autocapitalizationType = .allCharacters
		city.label.text = R.string.city
		city.textEdit.autocapitalizationType = .words
		state.label.text = R.string.state
		country.label.text = R.string.country
		country.label.isUserInteractionEnabled = true
		country.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(displaySelectACountry(_:))))
		phone.label.text = R.string.ph
		mob.label.text = R.string.ph_mob
		other.label.text = R.string.other
	}


	func loadEnteredValues(id: Int = 0) -> Address
	{
		let date = Date()
//		let df = DateFormatter()
//		df.dateFormat = "yyyy-MM-dd HH:mm:ss"
//		let today = df.string(from: date)
		let newRow = Address(id: id, idCustomer: store.customer?.idCustomer, idManufacturer: 0, idSupplier: 0, idWarehouse: 0, idCountry: max(0, countryId), idState: max(0, stateId), alias: alias.textEdit.text != nil ? alias.textEdit.text! : "", company: company.textEdit.text != nil ? company.textEdit.text! : "", lastname: lastname.textEdit.text != nil ? lastname.textEdit.text! : "", firstname: firstname.textEdit.text != nil ? firstname.textEdit.text! : "", vatNumber: vatNo.textEdit.text != nil ? vatNo.textEdit.text! : "", address1: addr1.textEdit.text != nil ? addr1.textEdit.text! : "", address2: addr2.textEdit.text != nil ? addr2.textEdit.text! : "", postcode: pc.textEdit.text != nil ? pc.textEdit.text! : "", city: city.textEdit.text != nil ? city.textEdit.text! : "", other: other.textEdit.text != nil ? other.textEdit.text! : "", phone: phone.textEdit.text != nil ? phone.textEdit.text! : "", phoneMobile: mob.textEdit.text != nil ? mob.textEdit.text! : "", dni: "", deleted: false, dateAdd: date, dateUpd: date)
//		let encode = try? JSONEncoder().encode(newRow)
//		if let jsonStr = String(data: encode!, encoding: .utf8)//encode != nil
//		{
//			let jsonStr = String(data: encode!, encoding: .utf8)!
			//{"id_supplier":"","other":"","lastname":"Last","company":"","firstname":"","phone_mobile":"","id_customer":"3","dni":"","deleted":"0","address1":"","alias":"","city":"","vat_number":"","id":0,"date_upd":"2018-05-28 17:21:24","address2":"","id_warehouse":"","phone":"","id_manufacturer":"","id_state":"TBD","postcode":"","date_add":"2018-05-28 17:21:24","id_country":"TBD"}
//			print(jsonStr)
//			UserDefaults.standard.set(encode, forKey: "updateAddress.\(df.string(from: date))")
//		}
//		print(newRow)
		return newRow
	}

	
	func checkFields() -> Bool
	{
		clearErrors()
		var allGood = true
		var i = 0
		for v in stack.subviews
		{
			if v.superclass != UIButton.self
			{
				if let field = v.subviews.first?.subviews[1].subviews.first as? UITextField
				{
					let invalid = v.subviews.first?.subviews.last as! UILabel
					if (field.placeholder == nil || field.placeholder != R.string.optional) && ((field.text?.isEmpty)! || String(field.text!).count < 2)
					{
						v.subviews.first?.borderColor = UIColor.red
						invalid.alpha = 1
						allGood = false
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
		return allGood
	}


	fileprivate func fillStates(_ countryId: Int)
	{
		store.callGetStates(id_country: countryId, completion:{ (states, err) in
			self.pickerStateData.removeAll()
			if let states = states as? [CountryState]
			{
				for s in states
				{
					self.pickerStateData.append(s.name!)
				}
			}
		})
	}


	func insertValuesInBlank(_ str: String) -> String
	{
		var arrayXML = str.replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "\t", with: "").trimmingCharacters(in: .whitespaces).components(separatedBy: ">")
		var i = 0
		for line in arrayXML
		{
			arrayXML[i] = "\(line)>"
			switch(line)
			{
			case "<alias":
				arrayXML[i] = "\n" + arrayXML[i] + "\(self.alias.textEdit.text!)"
				break
			case "<company":
				if self.company.textEdit.text != nil && !self.company.textEdit.text!.isEmpty
				{
					arrayXML[i] = "\n" + arrayXML[i] + "\(self.company.textEdit.text!)"
				}
				else
				{
					arrayXML[i] = "\n" + arrayXML[i]
				}
				break
			case "<lastname":
				arrayXML[i] = "\n" + arrayXML[i] + "\(self.lastname.textEdit.text!)"
				break
			case "<firstname":
				arrayXML[i] = "\n" + arrayXML[i] + "\(self.firstname.textEdit.text!)"
				break
			case "<vat_number":
				if self.vatNo.textEdit.text != nil && !self.vatNo.textEdit.text!.isEmpty
				{
					arrayXML[i] = "\n" + arrayXML[i] + "\(self.vatNo.textEdit.text!)"
				}
				else
				{
					arrayXML[i] = "\n" + arrayXML[i]
				}
				break
			case "<address1":
				arrayXML[i] = "\n" + arrayXML[i] + "\(self.addr1.textEdit.text!)"
				break
			case "<address2":
				if self.addr2.textEdit.text != nil && !self.addr2.textEdit.text!.isEmpty
				{
					arrayXML[i] = "\n" + arrayXML[i] + "\(self.addr2.textEdit.text!)"
				}
				else
				{
					arrayXML[i] = "\n" + arrayXML[i]
				}
				break
			case "<postcode":
				if self.pc.textEdit.text != nil && !self.pc.textEdit.text!.isEmpty
				{
					arrayXML[i] = "\n" + arrayXML[i] + "\(self.pc.textEdit.text!)"
				}
				else
				{
					arrayXML[i] = "\n" + arrayXML[i]
				}
				break
			case "<city":
				if self.city.textEdit.text != nil && !self.city.textEdit.text!.isEmpty
				{
					arrayXML[i] = "\n" + arrayXML[i] + "\(self.city.textEdit.text!)"
				}
				else
				{
					arrayXML[i] = "\n" + arrayXML[i]
				}
				break
			case "<id_state":
				if self.stateId > -1
				{
					arrayXML[i] = "\n" + arrayXML[i] + "\(self.stateId)"
				}
				else
				{
					arrayXML[i] = "\n" + arrayXML[i]
				}
				break
			case "<id_country":
				if self.countryId > -1
				{
					arrayXML[i] = "\n" + arrayXML[i] + "\(self.countryId)"
				}
				else
				{
					arrayXML[i] = "\n" + arrayXML[i] + "1"
				}
				break
			case "<other":
				if self.other.textEdit.text != nil && !self.other.textEdit.text!.isEmpty
				{
					arrayXML[i] = "\n" + arrayXML[i] + "\(self.other.textEdit.text!)"
				}
				else
				{
					arrayXML[i] = "\n" + arrayXML[i]
				}
				break
			case "<phone":
				if self.phone.textEdit.text != nil && !self.phone.textEdit.text!.isEmpty
				{
					arrayXML[i] = "\n" + arrayXML[i] + "\(self.phone.textEdit.text!)"
				}
				else
				{
					arrayXML[i] = "\n" + arrayXML[i]
				}
				break
			case "<phone_mobile":
				if self.mob.textEdit.text != nil && !self.mob.textEdit.text!.isEmpty
				{
					arrayXML[i] = "\n" + arrayXML[i] + "\(self.mob.textEdit.text!)"
				}
				else
				{
					arrayXML[i] = "\n" + arrayXML[i]
				}
				break
			case "<id_customer":
				arrayXML[i] = "\n" + arrayXML[i] + "\(store.customer?.idCustomer ?? 0)"
				break
			default:
				if i > 0 && !line.contains("</") && !line.contains("/>")
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
				OperationQueue.main.addOperation {
					myAlertOnlyDismiss(self, title: R.string.success, message: "\(R.string.alias): \(self.alias.textEdit.text!)"/*cust!*/, dismissAction: {
						self.dismiss(animated: false, completion: {
						})
					}, completion: {
					})
				}
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
			let spinner = UIViewController.displaySpinner(onView: self.view)
			var ws = WebService()
			ws.startURL = R.string.WSbase
			ws.resource = APIResource.addresses
			ws.keyAPI = R.string.APIkey
			let blank = UserDefaults.standard.string(forKey: "BlankSchemaXMLAddress")
			if blank != nil && !(blank?.isEmpty)!
			{
				ws.xml = insertValuesInBlank(blank!)
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
						self.store.blankSchemaXML["Address"] = str
						UserDefaults.standard.set(str, forKey: "BlankSchemaXMLAddress")
						ws.xml = self.insertValuesInBlank(str!)
						if ws.xml != nil && !(ws.xml?.isEmpty)!
						{
							self.addResource(ws, spinner)
//							ws.add(completionHandler: { (httpResult) in
//								let cust = String(data: httpResult.data! as Data, encoding: .utf8)
//								UIViewController.removeSpinner(spinner: spinner)
//								if self.store.debug > 4
//								{
//									print("PUT response: \(cust!)")
//								}
//								if httpResult.success
//								{
//									myAlertOnlyDismiss(self, title: R.string.success, message: "\(R.string.alias): \(self.alias.textEdit.text!)"/*cust!*/, dismissAction: {
//										self.dismiss(animated: false, completion: {
//										})
//									}, completion: {
//									})
//								}
//								else if (cust?.contains("<error"))!
//								{
//									let parser = XMLParser(data: (cust?.data(using: .utf8))!)
//									let ps = PrestashopXMLroot()
//									parser.delegate = ps
//									parser.parse()
//									var errors = ""
//									for err in ps.errors
//									{
//										errors.append("\(err.message) (\(err.code))")
//									}
//									myAlertOnlyDismiss(self, title: R.string.err, message: errors, dismissAction: {
//										self.dismiss(animated: false, completion: {
//										})
//									})
//								}
//							})
						}
					}
				}
			}
		}
	}

	@objc func displaySelectACountry(_ sender: Any)
	{
		displaySelectACountryDONE = true
		let vc = SelectCountryVC()
		vc.noteName = AddNewAddressVC.selectCountry
		vc.defaultCountry = country.textEdit.text
		vc.dialogWindow.layer.masksToBounds = true
		vc.dialogWindow.borderWidth = 3
		vc.dialogWindow.borderColor = R.color.YumaDRed.withAlphaComponent(0.75)
		//		vc..layer.shadowColor = R.color.YumaDRed.cgColor
		//		vc.dialogWindow.layer.shadowOffset = .zero
		//		vc.dialogWindow.layer.shadowRadius = 5
		//		vc.dialogWindow.layer.shadowOpacity = 1
		vc.buttonLeft.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		vc.buttonLeft.shadowColor = R.color.YumaDRed
		vc.buttonLeft.shadowOffset = .zero
		vc.buttonLeft.shadowRadius = 5
		vc.buttonLeft.shadowOpacity = 0.5
		vc.buttonRight.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		vc.buttonRight.shadowColor = R.color.YumaDRed
		vc.buttonRight.shadowOffset = .zero
		vc.buttonRight.shadowRadius = 5
		vc.buttonRight.shadowOpacity = 0.5
//		vc.buttonSingle.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
//		vc.buttonSingle.shadowColor = R.color.YumaDRed
//		vc.buttonSingle.shadowOffset = .zero
//		vc.buttonSingle.shadowRadius = 5
//		vc.buttonSingle.shadowOpacity = 0.5
		//		vc.buttonSingle.shadowColor = R.color.YumaDRed//UIColor.black
		//		vc.buttonSingle.shadowOffset = .zero
		//		vc.buttonSingle.shadowRadius = 5
		//		vc.buttonSingle.shadowOpacity = 0.5
		//		vc.title = "\(R.string.select.uppercased()) \(R.string.country.uppercased())"
		//		vc.buttonSingle.setTitle(R.string.finish.uppercased(), for: .normal)
		vc.buttonLeft.setTitle(R.string.finish.uppercased(), for: .normal)
		vc.isModalInPopover = true
		vc.modalPresentationStyle = .overFullScreen
		self.present(vc, animated: true, completion: nil)
	}
	
	
	@objc func selectedACountry(_ sender: Notification)
	{
		if let row = sender.object as? Country
		{
			countryId = row.id!
//			print(sender.description)
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
						self.state.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.displaySelectAState(_:))))
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
							self.state.removeGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.displaySelectAState(_:))))
							self.pickerStateData.removeAll()
						}
					}
				}
			}
		}
	}
	
	@objc func displaySelectAState(_ sender: Any)
	{
		if state.textEdit.text != "N/A"
		{
			let vc = SelectStateVC()
			vc.noteName = AddNewAddressVC.selectState
			vc.defaultState = state.textEdit.text
			vc.dialogWindow.layer.masksToBounds = true
			vc.dialogWindow.borderWidth = 3
			vc.dialogWindow.borderColor = R.color.YumaDRed.withAlphaComponent(0.75)
			//		vc..layer.shadowColor = R.color.YumaDRed.cgColor
			//		vc.dialogWindow.layer.shadowOffset = .zero
			//		vc.dialogWindow.layer.shadowRadius = 5
			//		vc.dialogWindow.layer.shadowOpacity = 1
			vc.buttonLeft.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
			vc.buttonLeft.shadowColor = R.color.YumaDRed
			vc.buttonLeft.shadowOffset = .zero
			vc.buttonLeft.shadowRadius = 5
			vc.buttonLeft.shadowOpacity = 0.5
			vc.buttonRight.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
			vc.buttonRight.shadowColor = R.color.YumaDRed
			vc.buttonRight.shadowOffset = .zero
			vc.buttonRight.shadowRadius = 5
			vc.buttonRight.shadowOpacity = 0.5
//			vc.buttonSingle.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
//			vc.buttonSingle.shadowColor = R.color.YumaDRed
//			vc.buttonSingle.shadowOffset = .zero
//			vc.buttonSingle.shadowRadius = 5
//			vc.buttonSingle.shadowOpacity = 0.5
			//		vc.buttonSingle.shadowColor = R.color.YumaDRed//UIColor.black
			//		vc.buttonSingle.shadowOffset = .zero
			//		vc.buttonSingle.shadowRadius = 5
			//		vc.buttonSingle.shadowOpacity = 0.5
			//		vc.title = "\(R.string.select.uppercased()) \(R.string.country.uppercased())"
//			vc.buttonSingle.setTitle(R.string.finish.uppercased(), for: .normal)
			vc.buttonLeft.setTitle(R.string.finish.uppercased(), for: .normal)
			vc.isModalInPopover = true
			vc.modalPresentationStyle = .overFullScreen
			self.present(vc, animated: true, completion: nil)
		}
	}
	
	@objc func selectedAState(_ sender: Notification)
	{
		if let row = sender.object as? CountryState
		{
			if state.textEdit.text != row.name!
			{
				state.textEdit.text = row.name!
				stateId = row.id!
			}
		}
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
		viewC.title = "\(R.string.addAddr.capitalized) \(R.string.help.capitalized)"
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
