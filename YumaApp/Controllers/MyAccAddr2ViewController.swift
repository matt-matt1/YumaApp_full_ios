//
//  MyAccAddr2ViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-18.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class MyAccAddr2ViewController: UIViewController
{
	@IBOutlet weak var navBar: UINavigationBar!
	@IBOutlet weak var navTitle: UINavigationItem!
	@IBOutlet weak var navClose: UIBarButtonItem!
	@IBOutlet weak var navHelp: UIBarButtonItem!
	@IBOutlet weak var stackFields: UIStackView!
	@IBOutlet weak var leftButtonLeft: GradientButton!
	@IBOutlet weak var leftButtonRight: GradientButton!
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
	@IBOutlet weak var vatBorder: UIView!
	@IBOutlet weak var vatLabel: UILabel!
	@IBOutlet weak var vatField: UITextField!
	@IBOutlet weak var vatInvalid: UILabel!
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
	@IBOutlet weak var rightPanelButton: GradientButton!
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var pageControl: UIPageControl!
	@IBOutlet weak var scrollForm: UIScrollView!
///////
	var address: Address? = nil
//	var pickerData: [[String]] = [[String]]()
///////
	let store = DataStore.sharedInstance
	var cellID = "addr2Cell"
	var addresses: [Address] = []
	var id_customer = 3
	let pickerCountry = UIPickerView()
	var pickerCountryData: [Country] = []//[String : Int] = [String : Int]()
	let pickerState = UIPickerView()
	var pickerStateData: [String] = [String]()
	static let selectCountry = Notification.Name("selectCountry")
	static let selectState = Notification.Name("selectState")
	var displaySelectACountryDONE = false
	var filtered: [Country] = []
	var filteredAttr: [NSMutableAttributedString] = []
	var isSearching = false
	private var tableView: UITableView!

	
	// MARK: Overrides
	override func viewDidLoad()
	{
        super.viewDidLoad()

		setTableView()
		setCollection()
		scrollForm.delegate = self
		getAddress()
		pageControl.numberOfPages = addresses.count
		pageControl.currentPage = 0
		setNavigation()
		if self.view.frame.width > 900
		{
			rightPanelButton.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 3.75, isVertical: true)
			if self.addresses.count > 0 && self.addresses.count > pageControl.currentPage
			{
				self.address = self.addresses[pageControl.currentPage]
			}
			prepareLabels()
			clearErrors()
			fillDetails()
			//set divider width
			leftButtonLeft.alpha = 0
			//add AddressExpandedViewController
		}
		let notificationCenter = NotificationCenter.default
		notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillHide, object: nil)
		notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
		notificationCenter.addObserver(self, selector: #selector(selectedACountry(_:)), name: AddressExpandedViewController.selectCountry, object: nil)
		notificationCenter.addObserver(self, selector: #selector(selectedAState(_:)), name: AddressExpandedViewController.selectState, object: nil)
    }

	
	override func viewDidAppear(_ animated: Bool)
	{
		super.viewDidAppear(animated)
		collectionView.reloadData()
	}


	override func didReceiveMemoryWarning()
	{
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


	// MARK: Methods
	fileprivate func setCollection()
	{
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView?.isPagingEnabled = true
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		collectionView.collectionViewLayout = layout
	}
	
	fileprivate func setNavigation()
	{
		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)	//navigation
		navTitle.title = "\(R.string.my_account) \(R.string.Addr)"
		navHelp.title = FontAwesome.questionCircle.rawValue
		navHelp.setTitleTextAttributes([NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)], for: .normal)
		navHelp.setTitleTextAttributes([
			NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)
			], for: UIControlState.highlighted)
		if UIScreen.main.scale < 2
		{
			let spacer = UIBarButtonItem(title: "|", style: .plain, target: self, action: nil)
			spacer.tintColor = R.color.YumaRed
			spacer.setTitleTextAttributes([
				NSAttributedStringKey.foregroundColor : R.color.YumaRed
				], for: UIControlState.normal)
			spacer.setTitleTextAttributes([
				NSAttributedStringKey.foregroundColor : R.color.YumaRed
				], for: UIControlState.highlighted)
			navTitle.rightBarButtonItems?.append(spacer)
		}
		let addNew = UIBarButtonItem(title: FontAwesome.plus.rawValue, style: .done, target: self, action: #selector(addNewAct(_:)))
		//cart.tintColor = R.color.YumaYel
		addNew.setTitleTextAttributes([
			NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)
			], for: UIControlState.normal)
		addNew.setTitleTextAttributes([
			NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)
			], for: UIControlState.highlighted)
		navTitle.rightBarButtonItems?.append(addNew)
		leftButtonLeft.setTitle(R.string.edit.uppercased(), for: .normal)
		leftButtonLeft.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		leftButtonRight.setTitle(R.string.delete.uppercased(), for: .normal)
		leftButtonRight.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
	}
	
	func getAddress()
	{
		if store.addresses.count < 1
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
			let caStr = UserDefaults.standard.string(forKey: "AddressesCustomer" + String((store.customer?.idCustomer!)!))
			//			let caStr = UserDefaults.standard.string(forKey: "CustomerAddresses")
			if caStr == nil || caStr == ""
			{
				let loading = UIViewController.displaySpinner(onView: self.view)
				//if store.addresses.count == 0
				store.callGetAddresses(id_customer: id_customer)
				{
					(addresses, error) in
					
					if error != nil
					{
						print(error!)
					}
					else
					{
						for address in (addresses?.addresses!)!
						{
							self.addresses.append(address)
						}
						UIViewController.removeSpinner(spinner: loading)
						//print(self.addresses)
					}
				}
			}
			else
			{
				var decoded: [Address]
				do
				{
					decoded = try JSONDecoder().decode([Address].self, from: (caStr?.data(using: .utf8))!)
					self.addresses = decoded
				}
				catch let jsonErr
				{
					print(jsonErr)
				}
			}
		}
		else
		{
			self.addresses = store.addresses
		}
	}
	
	
////////from AddressE...
	
	func clearErrors()
	{
		aliasBorder.borderColor = UIColor.clear
		aliasInvalid.alpha = 0
		fNameBorder.borderColor = UIColor.clear
		fNameInvalid.alpha = 0
		lNameBorder.borderColor = UIColor.clear
		lNameInvalid.alpha = 0
		bNameBorder.borderColor = UIColor.clear
		bNameInvalid.alpha = 0
		vatBorder.borderColor = UIColor.clear
		vatInvalid.alpha = 0
		addr1Border.borderColor = UIColor.clear
		addr1Invalid.alpha = 0
		addr2Border.borderColor = UIColor.clear
		addr2Invalid.alpha = 0
		cityBorder.borderColor = UIColor.clear
		cityInvalid.alpha = 0
		postcodeBorder.borderColor = UIColor.clear
		postcodeInvalid.alpha = 0
		stateBorder.borderColor = UIColor.clear
		stateInvalid.alpha = 0
		countryBorder.borderColor = UIColor.clear
		countryInvalid.alpha = 0
		phoneBorder.borderColor = UIColor.clear
		phoneInvalid.alpha = 0
		mobBorder.borderColor = UIColor.clear
		mobInvalid.alpha = 0
		otherBorder.borderColor = UIColor.clear
		otherInvalid.alpha = 0
	}

	func prepareLabels()
	{
//		navTitle.title = R.string.Addr
//		navClose.title = FontAwesome.times.rawValue
//		navHelp.title = FontAwesome.questionCircle.rawValue
//		navHelp.setTitleTextAttributes([NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)], for: .normal)
		aliasLabel.text = R.string.alias
		aliasInvalid.text = "\(R.string.invalid.capitalized) \(R.string.alias)"
		aliasField.placeholder = R.string.nickName
		fNameLabel.text = R.string.fName
		fNameInvalid.text = "\(R.string.invalid.capitalized) \(R.string.fName)"
		fNameField.autocapitalizationType = .words
		lNameLabel.text = R.string.lName
		lNameInvalid.text = "\(R.string.invalid.capitalized) \(R.string.lName)"
		lNameField.autocapitalizationType = .words
		bNameLabel.text = R.string.co
		bNameField.placeholder = R.string.optional
		bNameField.autocapitalizationType = .words
		let bNameOptional = UILabel()
		bNameOptional.text = R.string.optional
		bNameInvalid.text = "\(R.string.invalid.capitalized) \(R.string.co)"
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
		//print(bNameOptional.frame)
		//(bNameBorder.subviews.first?.subviews.first as! UIStackView).layoutIfNeeded()
		vatLabel.text = "\(R.string.taxNo)"
		vatInvalid.text = "\(R.string.invalid.capitalized) \(R.string.taxNo)"
		vatField.placeholder = R.string.optional
		addr1Label.text = R.string.addr1
		addr1Invalid.text = "\(R.string.invalid.capitalized) \(R.string.addr1)"
		addr2Label.text = R.string.addr2
		addr2Invalid.text = "\(R.string.invalid.capitalized) \(R.string.addr2)"
		addr2Field.placeholder = R.string.optional
		let addr2Optional = UILabel()
		addr2Optional.text = R.string.optional
		cityLabel.text = R.string.city
		cityInvalid.text = "\(R.string.invalid.capitalized) \(R.string.city)"
		cityField.autocapitalizationType = .words
		postcodeLabel.text = R.string.pcode
		postcodeInvalid.text = "\(R.string.invalid.capitalized) \(R.string.pcode)"
		postcodeField.placeholder = "eg. A1B 2C3"
		postcodeField.autocapitalizationType = .allCharacters
		//		let stateSelect = UIButton()
		//		stateSelect.setTitle(FontAwesome.caretSquareODown.rawValue, for: .normal)
		//		stateSelect.addTarget(self, action: #selector(makeSelect), for: .touchUpInside)
		countryLabel.text = R.string.country
		countryLabel.backgroundColor = R.color.YumaYel.withAlphaComponent(0.5)
		countryLabel.cornerRadius = 4
		countryLabel.borderWidth = 1
		countryLabel.borderColor = R.color.YumaRed
		countryLabel.textAlignment = .center
		countryInvalid.text = "\(R.string.invalid.capitalized) \(R.string.country)"
		countryLabel.isUserInteractionEnabled = true
		countryBorder.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(displaySelectACountry(_:))))
		stateLabel.text = R.string.state
		stateLabel.backgroundColor = R.color.YumaYel.withAlphaComponent(0.5)
		stateLabel.cornerRadius = 4
		stateLabel.borderWidth = 1
		stateLabel.borderColor = R.color.YumaRed
		stateLabel.textAlignment = .center
		stateField.placeholder = "\(R.string.select) \(R.string.country) \(R.string.first)"
		stateInvalid.text = "\(R.string.invalid.capitalized) \(R.string.state)"
		stateLabel.isUserInteractionEnabled = true
		//		let countrySelect = UIButton()
		//		countrySelect.setTitle(FontAwesome.angleDown.rawValue, for: .normal)
		//		countrySelect.addTarget(self, action: #selector(makeSelect), for: .touchUpInside)
		//		pickerCountry.dataSource = self
		//		pickerCountry.delegate = self
		//		for c in store.countries
		//		{
		//			pickerCountryData[c.name![store.myLang].value!] = Int(c.id!)
		//		}
		//		pickerCountryData = store.countries
		//		pickerState.dataSource = self
		//		pickerState.delegate = self
		phoneLabel.text = R.string.ph
		phoneInvalid.text = "\(R.string.invalid.capitalized) \(R.string.ph)"
		phoneField.placeholder = R.string.optional
		mobLabel.text = R.string.ph_mob
		mobInvalid.text = "\(R.string.invalid.capitalized) \(R.string.ph_mob)"
		mobField.placeholder = R.string.optional
		otherLabel.text = R.string.other
		otherInvalid.text = "\(R.string.invalid.capitalized) \(R.string.other)"
		otherField.placeholder = R.string.optional
		rightPanelButton.setTitle(R.string.upd.uppercased(), for: .normal)
	}


	func fillDetails()
	{
		if self.address != nil
		{
			aliasField.text = self.address?.alias
			fNameField.text = self.address?.firstname
			lNameField.text = self.address?.lastname
			bNameField.text = self.address?.company
			vatField.text = self.address?.vatNumber
			addr1Field.text = self.address?.address1
			addr2Field.text = self.address?.address2
			cityField.text = self.address?.city
			postcodeField.text = self.address?.postcode
			store.callGetStates(id_country: store.defaultCountry) { (states, err) in
				if let states = states as? [CountryState]
				{
					for s in states
					{
						self.pickerStateData.append((s.name)!)
					}
					OperationQueue.main.addOperation
						{
							self.stateLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.displaySelectAState(_:))))
					}
				}
			}
			for state in store.states
			{
				if state.id! == (self.address?.idState)!
				{
					stateField.text = state.name
					pickerState.selectRow(state.id!, inComponent: 0, animated: false)
					break
				}
			}
			for country in store.countries
			{
				if country.id! == (self.address?.idCountry)!
				{
					countryField.text = store.valueById(object: country.name!, id: store.myLang)//country.name?[store.myLang].value
					pickerCountry.selectRow(country.id!-1, inComponent: 0, animated: false)
					break
				}
			}
			countryField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
			countryField.addTarget(self, action: #selector(self.textFieldDidBeginEditing(_:)), for: UIControlEvents.editingDidBegin)
			countryField.addTarget(self, action: #selector(self.textFieldDidEndEditing(_:)), for: UIControlEvents.editingDidEnd)
			phoneField.text = self.address?.phone
			mobField.text = self.address?.phoneMobile
			otherField.text = self.address?.other
			fillStates((self.address?.idCountry)!)
		}
	}
	
	
	func checkFields() -> Bool
	{
//		clearErrors()
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
		}
		return status
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
				OperationQueue.main.addOperation
					{
						self.stateField.placeholder = "< \(R.string.select)"
						if self.stateLabel.gestureRecognizers == nil || (self.stateLabel.gestureRecognizers?.count)! < 2
						{
							self.stateBorder.alpha = 1
							self.stateLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.displaySelectAState(_:))))
						}
				}
			}
			else
			{
				OperationQueue.main.addOperation
					{
						self.stateBorder.alpha = 0.2
						self.stateLabel.removeGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.displaySelectAState(_:))))
				}
			}
		})
	}
////////end
	
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
	}


	@objc func displaySelectACountry(_ sender: Any)
	{
		displaySelectACountryDONE = true
		let vc = SelectCountryVC()
		vc.noteName = MyAccAddr2ViewController.selectCountry
		vc.defaultCountry = countryField.text
		vc.title = "\(R.string.select) \(R.string.country)"
		vc.buttonLeft.setTitle(R.string.close.uppercased(), for: .normal)
//		vc.buttonSingle.setTitle(R.string.close.uppercased(), for: .normal)
		vc.isModalInPopover = true
		vc.modalPresentationStyle = .overFullScreen
		self.present(vc, animated: true, completion: nil)
	}


	@objc func selectedACountry(_ sender: Notification)
	{
		if let row = sender.object as? (String, Int)
		{
			if countryField.text != row.0
			{
				countryField.text = row.0
				fillStates(row.1)
				stateField.text = ""
				stateField.placeholder = R.string.select
			}
		}
	}


	@objc func displaySelectAState(_ sender: Any)
	{
		if stateField.text != "N/A" //&& stateField.text != ""//!pickerStateData.isEmpty
		{
			let vc = SelectStateVC()
			vc.noteName = MyAccAddr2ViewController.selectState
			vc.defaultState = stateField.text
			vc.dialogWindow.layer.masksToBounds = true
			vc.dialogWindow.borderWidth = 3
			vc.dialogWindow.borderColor = R.color.YumaDRed.withAlphaComponent(0.75)
//			vc.buttonSingle.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
//			vc.buttonSingle.shadowColor = R.color.YumaDRed
//			vc.buttonSingle.shadowOffset = .zero
//			vc.buttonSingle.shadowRadius = 5
//			vc.buttonSingle.shadowOpacity = 0.5
//			vc.buttonSingle.setTitle(R.string.finish.uppercased(), for: .normal)
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
			vc.buttonLeft.setTitle(R.string.finish.uppercased(), for: .normal)
			vc.isModalInPopover = true
			vc.modalPresentationStyle = .overFullScreen
			self.present(vc, animated: true, completion: nil)
//			let sb = UIStoryboard(name: "HelpStoryboard", bundle: nil)
//			let vc = sb.instantiateInitialViewController() as? PickerViewController
//			if vc != nil
//			{
//				vc?.noteName = MyAccAddr2ViewController.selectState
//				self.present(vc!, animated: true, completion: nil)
//				vc?.dialog.shadowColor = 			R.color.YumaDRed
//				vc?.dialog.shadowOffset = 			.zero
//				vc?.dialog.shadowRadius = 			5
//				vc?.dialog.shadowOpacity = 			1
//				vc?.dialog.layer.cornerRadius = 	20
//				vc?.dialog.cornerRadius = 			20
//				vc?.titleLbl.text = 				"\(R.string.select) \(R.string.state)"
//				let country = countryField.text
//				if country != nil
//				{
//					vc?.titleLbl.text?.append(" (\(country!))")
//				}
////				vc?.button.backgroundColor = R.color.YumaRed
////				vc?.button.cornerRadius = 4
////				vc?.button.setTitleColor(UIColor.white, for: .normal)
////				vc?.button.shadowColor = R.color.YumaDRed
////				vc?.button.shadowOffset = .zero
////				vc?.button.shadowRadius = 3
////				vc?.button.shadowOpacity = 1
////				vc?.button.titleEdgeInsets = UIEdgeInsets(top: 2, left: 20, bottom: 2, right: 20)
//				vc?.button.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
//				vc?.button.setTitle(R.string.finish.uppercased(), for: .normal)
////				vc?.button.setTitle(R.string.select, for: .normal)
//				vc?.view.addSubview(pickerState)
//				pickerState.translatesAutoresizingMaskIntoConstraints = false
//				NSLayoutConstraint.activate([
//					pickerState.centerXAnchor.constraint(equalTo: (vc?.dialog.centerXAnchor)!),
//					pickerState.centerYAnchor.constraint(equalTo: (vc?.dialog.centerYAnchor)!),
//					])
//				vc?.button.addTarget(self, action: #selector(selectedAState(_:)), for: .touchUpInside)
//			}
//			else
//			{
//				print("HelpStoryboard has no initial view controller")
//			}
		}
	}
	
	@objc func selectedAState(_ sender: Notification)
	{
		if let row = sender.object as? CountryState
		{
			if stateField.text != row.name!
			{
				stateField.text = row.name!
				stateField.tag = row.id!+10
			}
		}
//		stateField.text = pickerStateData[pickerState.selectedRow(inComponent: 0)]
	}


	@objc func addNewAct(_ sender: Any)
	{
		let vc = AddNewAddressVC()
		self.present(vc, animated: true, completion: {
			//UserDefaults.standard.removeObject(forKey: "AddressesCustomer\(self.id_customer)")
			self.store.callGetAddresses(id_customer: self.id_customer, completion:
				{
					(addresses, error) in
					
					if error != nil
					{
						if self.store.debug > 0
						{
							print(error!)
						}
					}
					else
					{
						let addr = addresses?.addresses
						if self.store.debug > 5
						{
							print("got \(String(describing: addr?.count)) addresses")
						}
					}
			})
			self.collectionView.reloadData()
		})
	}

	@IBAction func leftButtonLeftAct(_ sender: Any)
	{
		store.flexView(view: leftButtonLeft)
		self.address = self.addresses[pageControl.currentPage]
		let vc = UIStoryboard(name: "AddrStoryboard", bundle: nil).instantiateViewController(withIdentifier: "AddressExpandedViewController") as! AddressExpandedViewController
		vc.address = self.addresses[pageControl.currentPage]
		present(vc, animated: false, completion: {
		})
	}
	@IBAction func leftButtonRightAct(_ sender: Any)
	{
		store.flexView(view: leftButtonRight)
		myAlertDialog(self, title: R.string.rusure, message: "\(R.string.delete) \"\(self.addresses[self.pageControl.currentPage].alias ?? "no name")\"", cancelTitle: R.string.cancel.uppercased(), cancelAction: nil, okTitle: R.string.delete.uppercased(), okAction: {
				self.addresses[self.pageControl.currentPage].deleted = true
				self.collectionView.reloadData()
				var edited = self.addresses[self.pageControl.currentPage]
				print("address was deleted \(edited.deleted! ? "OK" : "failed")")
				edited.deleted = true
				//					let encoder = JSONEncoder()
				//					encoder.outputFormatting = .prettyPrinted
				//					let data = try? encoder.encode(edited)
				//					print(String(data: data!, encoding: .utf8)!)
				let str = PSWebServices.object2psxml(object: edited, resource: "addresses", resource2: "address", omit: [], nilValue: "")
				//					let str = PSWebServices.objectToXML(object: edited, head: "<?xml version=\"1.0\" encoding=\"UTF-8\"?>", wrapperHead: "<prestashop xmlns:xlink=\"http://www.w3.org/1999/xlink\"><addresses>", wrapperTail: "</addresses></prestashop>")
				PSWebServices.postAddress(XMLStr: str)
				{
					(error) in
					if let error = error
					{
						print("fatal error: ", String(error.localizedDescription))
					}
					self.collectionView.reloadData()
				}
		}) {
		}
	}
	@IBAction func rightPanelButtonAct(_ sender: Any)
	{
		store.flexView(view: rightPanelButton)
		if checkFields()
		{
			myAlertDialog(self, title: R.string.upd, message: "\(R.string.save) \"\(self.address?.alias ?? "")\" \(R.string.ok)", cancelTitle: R.string.dismiss.uppercased(), cancelAction: nil, okTitle: R.string.delete.uppercased(), okAction: {
			}) {
			}
		}
	}
	@IBAction func navHelpAct(_ sender: Any)
	{
		let viewC = Assistance()
		if self.view.frame.width > 700
		{
			viewC.array = R.array.help_my_account_addresses_guide.wide
		}
		else
		{
			viewC.array = R.array.help_my_account_addresses_guide.narrow
		}
		viewC.title = "\(R.string.Addr.capitalized) \(R.string.help.capitalized)"
		viewC.modalTransitionStyle = .crossDissolve
		viewC.modalPresentationStyle = .overCurrentContext
		self.present(viewC, animated: true, completion: nil)
	}
	@IBAction func navCloseAct(_ sender: Any)
	{
		self.dismiss(animated: false, completion: nil)
	}
	
}



extension MyAccAddr2ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		return addresses.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! Addr2CollectionViewCell
		//let i = indexPath.item//var i = indexPath.item
		cell.setup(address: addresses[indexPath.item])
		return cell
	}
	
	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
	{
		let cellNum = Int(ceil(targetContentOffset.pointee.x / collectionView.frame.width))
		if cellNum < addresses.count
		{
			pageControl.currentPage = cellNum
			self.address = self.addresses[cellNum]
			fillDetails()
		}
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
	{
		//print("collView height was=\(view.frame.height), now=\(view.frame.height/3*2)")
		return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
	}
	
}



extension MyAccAddr2ViewController: UITableViewDelegate, UITableViewDataSource
{
	func setTableView()
	{
		tableView = UITableView(frame: CGRect(x: countryField.frame.origin.x + 5, y: countryField.frame.origin.y + countryField.frame.height + 400, width: countryField.frame.width, height: 3 * countryField.frame.height))
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "suggCell")
		tableView.dataSource = self
		tableView.delegate = self
	}
	
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
	{
		countryField.text = store.valueById(object: filtered[indexPath.row].name!, id: store.myLang)
		tableView.removeFromSuperview()
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return filtered.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let cell = tableView.dequeueReusableCell(withIdentifier: "suggCell", for: indexPath)
		cell.textLabel!.textColor = UIColor.blueApple
		cell.backgroundColor = UIColor.init(hex: "e0e0e0")
		cell.textLabel!.attributedText = filteredAttr[indexPath.row]
		return cell
	}
	
	
	@objc func textFieldDidBeginEditing(_ textField: UITextField)
	{
		self.view.addSubview(tableView)
	}
	
	@objc func textFieldDidEndEditing(_ textField: UITextField)
	{
		tableView.removeFromSuperview()
	}
	
	
	func hightlightSearchResult(searchString: String, resultString: String) -> NSMutableAttributedString
	{
		let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: resultString)
		let pattern = searchString.lowercased()
		let range: NSRange = NSMakeRange(0, resultString.count)
		
		let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options())
		
		regex.enumerateMatches(in: resultString.lowercased(), options: NSRegularExpression.MatchingOptions(), range: range) { (textCheckingResult, matchingFlags, stop) -> Void in
			let subRange = textCheckingResult?.range
			attributedString.addAttributes([NSAttributedStringKey.backgroundColor : UIColor.yellow, NSAttributedStringKey.foregroundColor : UIColor.red], range: subRange!)
		}
		return attributedString
	}
	
	@objc func textFieldDidChange(_ textField: UITextField)
	{
		if textField.text == nil || (textField.text?.isEmpty)!
		{
			isSearching = false
			filtered = store.countries
			//				view.endEditing(true)
		}
		else
		{
			filtered.removeAll()
			filtered = store.countries.filter({ (country) -> Bool in
				return (store.valueById(object: country.name!, id: store.myLang)?.lowercased().contains(textField.text!.lowercased()))!
			})
			//			let _ = filtered.sorted { (a, b) -> Bool in
			//				(store.valueById(object: a.name!, id: store.myLang)!) < (store.valueById(object: b.name!, id: store.myLang)!)
			//			}
			filteredAttr.removeAll()
			filtered.forEach { (country) in
				filteredAttr.append(hightlightSearchResult(searchString: textField.text!, resultString: store.valueById(object: country.name!, id: store.myLang)!))
			}
			isSearching = (filtered.count == 0) ? false : true
		}
		tableView.reloadData()
	}
	
}
