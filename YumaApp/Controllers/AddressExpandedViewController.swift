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
	@IBOutlet weak var button: GradientButton!
	@IBOutlet weak var scrollForm: UIScrollView!
	var address: Address? = nil
	let store = DataStore.sharedInstance
	var pickerStateData: [String] = [String]()
	static let selectCountry = Notification.Name("selectCountry")
	static let selectState = Notification.Name("selectState")
	var displaySelectACountryDONE = false
	var countryId = -1
	var stateId = -1
	var filtered: [Country] = []
	var filteredAttr: [NSMutableAttributedString] = []
	var isSearching = false
	private var tableView: UITableView!
	var countryFrame: CGRect!


	// MARK: Overrides
	override func viewDidLoad()
	{
        super.viewDidLoad()

		//setTableView()
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
		notificationCenter.addObserver(self, selector: #selector(selectedAState(_:)), name: AddressExpandedViewController.selectState, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	override func viewDidLayoutSubviews()
	{
		countryFrame = self.view.convert(countryField.frame, from: countryField.superview)
//		if countryFrame.origin.y > view.frame.height
//		{
//			scrollForm.scrollRectToVisible(countryFrame, animated: false)
//			countryFrame = self.view.convert(countryField.frame, from: countryField.superview)
//		}
		if (countryFrame.origin.y + countryFrame.height + 10 + (3 * countryFrame.height)) < scrollForm.contentSize.height//view.frame.height
		{	//	position below field
			tableView = UITableView(frame: CGRect(x: countryFrame.origin.x + 5, y: countryFrame.origin.y + countryFrame.height + 10, width: countryFrame.width, height: 3 * countryFrame.height))
		}
		else if (countryFrame.origin.y - 10 - (3 * countryFrame.height)) > view.frame.origin.y
		{	//	position above field
			tableView = UITableView(frame: CGRect(x: countryFrame.origin.x + 5, y: countryFrame.origin.y - (3 * countryFrame.height) - 10, width: countryFrame.width, height: 3 * countryFrame.height))
		}
		else
		{
			print("cannot position country suggestions")
		}
//		setTableView()
	}

	deinit
	{
		if #available(iOS 9, *)
		{
			//
		}
		else
		{
			let notificationCenter = NotificationCenter.default
			notificationCenter.removeObserver(self, name: Notification.Name.UIKeyboardWillHide, object: nil)
			notificationCenter.removeObserver(self, name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
			notificationCenter.removeObserver(self, name: AddressExpandedViewController.selectCountry, object: nil)
			notificationCenter.removeObserver(self, name: AddressExpandedViewController.selectState, object: nil)
		}
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


	func prepareLabels()
	{
		aliasLabel.text = R.string.alias
		aliasInvalid.text = "\(R.string.invalid.capitalized) \(R.string.alias)"
		aliasField.placeholder = R.string.nickName
		fNameLabel.text = R.string.fName
		fNameInvalid.text = "\(R.string.invalid.capitalized) \(R.string.fName)"
		lNameLabel.text = R.string.lName
		lNameInvalid.text = "\(R.string.invalid.capitalized) \(R.string.lName)"
		bNameLabel.text = R.string.co
		bNameField.placeholder = R.string.optional
		let bNameOptional = UILabel()
		bNameOptional.text = R.string.optional
		bNameInvalid.text = "\(R.string.invalid.capitalized) \(R.string.co)"
		vatLabel.text = R.string.taxNo
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
		postcodeLabel.text = R.string.pcode
		postcodeInvalid.text = "\(R.string.invalid.capitalized) \(R.string.pcode)"
		postcodeField.placeholder = "eg. A1B 2C3"
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
		stateInvalid.text = "\(R.string.invalid.capitalized) \(R.string.state)"
		stateLabel.isUserInteractionEnabled = true
		phoneLabel.text = R.string.ph
		phoneInvalid.text = "\(R.string.invalid.capitalized) \(R.string.ph)"
		phoneField.placeholder = R.string.optional
		mobLabel.text = R.string.ph_mob
		mobInvalid.text = "\(R.string.invalid.capitalized) \(R.string.ph_mob)"
		mobField.placeholder = R.string.optional
		otherLabel.text = R.string.other
		otherInvalid.text = "\(R.string.invalid.capitalized) \(R.string.other)"
		otherField.placeholder = R.string.optional
		button.setTitle(R.string.upd.uppercased(), for: .normal)
	}


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
					break
				}
			}
			for country in store.countries
			{
				if country.id! == (self.address?.idCountry)!
				{
					countryField.text = store.valueById(object: country.name!, id: store.myLang)
					break
				}
			}
			countryField.addTarget(self, action: #selector(self.textFieldDidChange2(_:)), for: .editingChanged)
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


	func loadEnteredValues(id: Int = 0) -> Address
	{
		let date = Date()
		let newRow = Address(id: id, idCustomer: Int((store.customer?.idCustomer)!), idManufacturer: 0, idSupplier: 0, idWarehouse: 0, idCountry: countryId, idState: stateId, alias: aliasField.text != nil ? aliasField.text! : "", company: bNameField.text != nil ? bNameField.text! : "", lastname: lNameField.text != nil ? lNameField.text! : "", firstname: fNameField.text != nil ? fNameField.text! : "", vatNumber: vatField.text != nil ? vatField.text! : "", address1: addr1Field.text != nil ? addr1Field.text! : "", address2: addr2Field.text != nil ? addr2Field.text! : "", postcode: postcodeField.text != nil ? postcodeField.text! : "", city: cityField.text != nil ? cityField.text! : "", other: otherField.text != nil ? otherField.text! : "", phone: phoneField.text != nil ? phoneField.text! : "", phoneMobile: mobField.text != nil ? mobField.text! : "", dni: "", deleted: false, dateAdd: date, dateUpd: date)
		return newRow
	}


	func insertValuesInBlank(_ str: String) -> String
	{
		var arrayXML = str.replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "\t", with: "").trimmingCharacters(in: .whitespaces).components(separatedBy: ">")
		var changed = false
		var i = 0
		for line in arrayXML
		{
			arrayXML[i] = "\(line)>"
			switch(line)
			{
			case "<id":
				arrayXML[i] = "\n" + arrayXML[i] + "\((address?.id)!)"
				break
			case "<alias":
				arrayXML[i] = "\n" + arrayXML[i] + "\(self.aliasField.text!)"
				changed = true
				break
			case "<company":
				if self.bNameField.text != nil && !self.bNameField.text!.isEmpty
				{
					arrayXML[i] = "\n" + arrayXML[i] + "\(self.bNameField.text!)"
					changed = true
				}
				else
				{
					arrayXML[i] = "\n" + arrayXML[i]
				}
				break
			case "<lastname":
				arrayXML[i] = "\n" + arrayXML[i] + "\(self.lNameField.text!)"
				changed = true
				break
			case "<firstname":
				arrayXML[i] = "\n" + arrayXML[i] + "\(self.fNameField.text!)"
				changed = true
				break
			case "<vat_number":
				if self.vatField.text != nil && !self.vatField.text!.isEmpty
				{
					arrayXML[i] = "\n" + arrayXML[i] + "\(self.vatField.text!)"
				}
				else
				{
					arrayXML[i] = "\n" + arrayXML[i]
				}
				break
			case "<address1":
				arrayXML[i] = "\n" + arrayXML[i] + "\(self.addr1Field.text!)"
				changed = true
				break
			case "<address2":
				if self.addr2Field.text != nil && !self.addr2Field.text!.isEmpty
				{
					arrayXML[i] = "\n" + arrayXML[i] + "\(self.addr2Field.text!)"
					changed = true
				}
				else
				{
					arrayXML[i] = "\n" + arrayXML[i]
				}
				break
			case "<postcode":
				if self.postcodeField.text != nil && !self.postcodeField.text!.isEmpty
				{
					arrayXML[i] = "\n" + arrayXML[i] + "\(self.postcodeField.text!)"
					changed = true
				}
				else
				{
					arrayXML[i] = "\n" + arrayXML[i]
				}
				break
			case "<city":
				if self.cityField.text != nil && !self.cityField.text!.isEmpty
				{
					arrayXML[i] = "\n" + arrayXML[i] + "\(self.cityField.text!)"
					changed = true
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
					changed = true
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
					changed = true
				}
				else
				{
					arrayXML[i] = "\n" + arrayXML[i] + "1"
				}
				break
			case "<other":
				if self.otherField.text != nil && !self.otherField.text!.isEmpty
				{
					arrayXML[i] = "\n" + arrayXML[i] + "\(self.otherField.text!)"
					changed = true
				}
				else
				{
					arrayXML[i] = "\n" + arrayXML[i]
				}
				break
			case "<phone":
				if self.phoneField.text != nil && !self.phoneField.text!.isEmpty
				{
					arrayXML[i] = "\n" + arrayXML[i] + "\(self.phoneField.text!)"
					changed = true
				}
				else
				{
					arrayXML[i] = "\n" + arrayXML[i]
				}
				break
			case "<phone_mobile":
				if self.mobField.text != nil && !self.mobField.text!.isEmpty
				{
					arrayXML[i] = "\n" + arrayXML[i] + "\(self.mobField.text!)"
					changed = true
				}
				else
				{
					arrayXML[i] = "\n" + arrayXML[i]
				}
				break
			case "<id_customer":
				arrayXML[i] = "\n" + arrayXML[i] + "\(store.customer?.idCustomer ?? 0)"
				changed = true
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
		return changed ? String(str.dropLast()) : ""
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


	fileprivate func parseBlankInsert(_ blank: String?, _ ws: inout WebService, _ spinner: UIView)
	{
		ws.xml = insertValuesInBlank(blank!)
		ws.id = (address?.id)!
//		let parser = XMLParser(data: (blank?.data(using: .utf8))!)
//		let ps = PrestashopXMLroot()
//		parser.delegate = ps
//		parser.parse()
//		var addrs = ""
//		var xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<prestashop xmlns:xlink=\"http://www.w3.org/1999/xlink\">\n<address>"
//		for a in ps.addresses
//		{
//			//addrs.append("\(a.address1!) \(a.address2!) \(a.firstname!) \(a.lastname!) (\(a.alias!))")
//			xml += "\n\t<id>\((address?.id)!)</id>"
//			xml += "\n\t<id_customer>\((store.customer?.idCustomer)!)</id_customer>"
//			xml += "\n\t<id_manufacturer></id_manufacturer>"
//			xml += "\n\t<id_supplier></id_supplier>"
//			xml += "\n\t<id_warehouse></id_warehouse>"
//			xml += "\n\t<id_country>\(countryId)</id_country>"
//			xml += "\n\t<id_state>\(stateId)</id_state>"
//			xml += "\n\t<alias>\(aliasField.text!)</alias>"
//			xml += "\n\t<company>\(bNameField.text!)</company>"
//			xml += "\n\t<lastname>\(lNameField.text!)</lastname>"
//			xml += "\n\t<firstname>\(fNameField.text!)</firstname>"
//			xml += "\n\t<vat_number></vat_number>"//missing?
//			xml += "\n\t<address1>\(addr1Field.text!)</address1>"
//			xml += "\n\t<address2>\(addr2Field.text!)</address2>"
//			xml += "\n\t<postcode>\(postcodeField.text!)</postcode>"
//			xml += "\n\t<city>\(cityField.text!)</city>"
//			xml += "\n\t<other>\(otherField.text!)</other>"
//			xml += "\n\t<phone>\(phoneField.text!)</phone>"
//			xml += "\n\t<phone_mobile>\(mobField.text!)</phone_mobile>"
//			xml += "\n\t<dni></dni>"
//			xml += "\n\t<deleted>0</deleted>"
//			xml += "\n\t<date_add>\(a.dateAdd!)</date_add>"
//			xml += "\n\t<date_upd>\(Data())</date_upd>"
////			for node in a.dictionaryWithValues(forKeys: [])
////			{
////				let line = "\n\t<\(node.key)>\(node.value)<\(node.key)>"
////				xml += line
////			}
//		}
//		xml += "\n</address>\n</prestashop>"
//		ws.xml = xml
		print(ws.xml!)

//		ws.xml = ""//insertValuesInBlank(blank!)
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
					myAlertOnlyDismiss(self, title: R.string.Addr, message: "\((self.address?.alias)!) \(R.string.ok)", dismissAction: {
						self.dismiss(animated: false, completion: {
						})
					}, completion: {
						self.dismiss(animated: false, completion: {
						})
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
		let vc = SelectCountryVC()
		vc.defaultCountry = countryField.text
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
			if countryField.text != store.valueById(object: row.name!, id: store.myLang)
			{
				countryField.text = store.valueById(object: row.name!, id: store.myLang)
				countryId = row.id!
				stateField.text = ""
				if row.containsStates != nil && row.containsStates != false
				{
//					if stateBorder.alpha < 1
//					{
//						stateBorder.alpha = 1
//					}
					fillStates(row.id!)
					stateField.placeholder = "< \(R.string.select)"
					OperationQueue.main.addOperation
					{
						// WHY CAN'T REMOVE GESTURE...
//						if self.stateLabel.gestureRecognizers != nil && (self.stateLabel.gestureRecognizers?.count)! > 0
//						{
//							self.stateLabel.removeGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.displaySelectAState(_:))))
//						}
						self.stateLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.displaySelectAState(_:))))
					}
				}
				else
				{
//					stateBorder.alpha = 0.2
					stateField.text = "N/A"
					OperationQueue.main.addOperation
					{
						if self.stateLabel.gestureRecognizers != nil && (self.stateLabel.gestureRecognizers?.count)! > 0
						{
							self.stateLabel.removeGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.displaySelectAState(_:))))
							self.pickerStateData.removeAll()
						}
					}
				}
			}
		}
	}

	@objc func displaySelectAState(_ sender: Any)
	{
		if stateField.text != "N/A"
		{
			let vc = SelectStateVC()
			vc.noteName = AddressExpandedViewController.selectState
			vc.defaultState = stateField.text
			vc.dialogWindow.layer.masksToBounds = true
			vc.dialogWindow.borderWidth = 3
			vc.dialogWindow.borderColor = R.color.YumaDRed.withAlphaComponent(0.75)
			//		vc..layer.shadowColor = R.color.YumaDRed.cgColor
			//		vc.dialogWindow.layer.shadowOffset = .zero
			//		vc.dialogWindow.layer.shadowRadius = 5
			//		vc.dialogWindow.layer.shadowOpacity = 1
//			vc.buttonSingle.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
//			vc.buttonSingle.shadowColor = R.color.YumaDRed
//			vc.buttonSingle.shadowOffset = .zero
//			vc.buttonSingle.shadowRadius = 5
//			vc.buttonSingle.shadowOpacity = 0.5
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
			//		vc.buttonSingle.shadowColor = R.color.YumaDRed//UIColor.black
			//		vc.buttonSingle.shadowOffset = .zero
			//		vc.buttonSingle.shadowRadius = 5
			//		vc.buttonSingle.shadowOpacity = 0.5
			//		vc.title = "\(R.string.select.uppercased()) \(R.string.country.uppercased())"
//			vc.buttonSingle.setTitle(R.string.finish.uppercased(), for: .normal)
			vc.isModalInPopover = true
			vc.modalPresentationStyle = .overFullScreen
			self.present(vc, animated: true, completion: nil)
		}
	}

	@objc func selectedAState(_ sender: Notification)
	{
		if let row = sender.object as? CountryState
		{
			if stateField.text != row.name!
			{
				stateField.text = row.name!
				stateId = row.id!
			}
		}
	}

	@IBAction func navHelpAct(_ sender: Any)
	{
		let viewC = Assistance()
		viewC.array = R.array.help_add_address_guide
		viewC.title = "\(R.string.Addr.capitalized) \(R.string.help.capitalized)"
		viewC.modalTransitionStyle   = .crossDissolve
		viewC.modalPresentationStyle = .overCurrentContext
		self.present(viewC, animated: true, completion: nil)
	}
	@IBAction func navCloseAct(_ sender: Any)
	{
		self.dismiss(animated: false, completion: nil)
	}
	
	@IBAction func buttonAct(_ sender: Any)
	{
		store.flexView(view: button)
		if checkFields()	//update the address:
		{
			let spinner = UIViewController.displaySpinner(onView: self.view)
			var ws = WebService()
			ws.startURL = R.string.WSbase
			ws.resource = APIResource.addresses
			ws.keyAPI = R.string.APIkey
			let blank = UserDefaults.standard.string(forKey: "BlankSchemaXMLAddress")
			if blank != nil && !(blank?.isEmpty)!
			{
				parseBlankInsert(blank, &ws, spinner)
			}
			else
			{
				ws.schema = .blank
				ws.get { (httpResult) in
					let blank = String(data: httpResult.data! as Data, encoding: .utf8)
//					UIViewController.removeSpinner(spinner: spinner)
					self.parseBlankInsert(blank, &ws, spinner)
				}
			}
		}
	}

}



extension AddressExpandedViewController: UITableViewDelegate, UITableViewDataSource
{
	func setTableView()
	{
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
	
	@objc func textFieldDidChange2(_ textField: UITextField)
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
