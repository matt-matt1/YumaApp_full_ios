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
	@IBOutlet weak var rightPanelButton: GradientButton!
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var pageControl: UIPageControl!
///////
	var address: Address? = nil
	var pickerData: [[String]] = [[String]]()
///////
	let store = DataStore.sharedInstance
	var cellID = "addr2Cell"
	var addresses: [Address] = []
	var id_customer = 3

	@IBOutlet weak var scrollForm: UIScrollView!
	
	// MARK: Overrides
	override func viewDidLoad()
	{
        super.viewDidLoad()

		collectionView.delegate = self
		collectionView.dataSource = self
		getAddress()
		pageControl.numberOfPages = addresses.count
		pageControl.currentPage = 0
		collectionView?.isPagingEnabled = true
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		collectionView.collectionViewLayout = layout
		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)	//navigation
		navTitle.title = "\(R.string.my_account) \(R.string.Addr)"
		navHelp.title = FontAwesome.questionCircle.rawValue
		navHelp.setTitleTextAttributes([NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)], for: .normal)
		navHelp.setTitleTextAttributes([
			NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)
			], for: UIControlState.selected)
		leftButtonLeft.setTitle(R.string.edit.uppercased(), for: .normal)
		leftButtonLeft.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		leftButtonRight.setTitle(R.string.delete.uppercased(), for: .normal)
		leftButtonRight.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		if self.view.frame.width > 900
		{
			rightPanelButton.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
			self.address = self.addresses[pageControl.currentPage]
			prepareLabels()
			fillDetails()
			//set divider width
			leftButtonLeft.alpha = 0
			//add AddressExpandedViewController
		}
		let notificationCenter = NotificationCenter.default
		notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillHide, object: nil)
		notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
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
			let caStr = UserDefaults.standard.string(forKey: "AddressesCustomer\(store.customer?.id_customer ?? "0")")
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
	func prepareLabels()
	{
//		navTitle.title = R.string.Addr
//		navClose.title = FontAwesome.times.rawValue
//		navHelp.title = FontAwesome.questionCircle.rawValue
//		navHelp.setTitleTextAttributes([NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)], for: .normal)
		aliasLabel.text = R.string.alias
		aliasField.placeholder = R.string.nickName
		aliasBorder.borderColor = UIColor.white
		aliasInvalid.text = ""
		fNameLabel.text = R.string.fName
		fNameBorder.borderColor = UIColor.white
		fNameInvalid.text = ""
		lNameLabel.text = R.string.lName
		lNameBorder.borderColor = UIColor.white
		lNameInvalid.text = ""
		bNameLabel.text = R.string.co
		bNameBorder.borderColor = UIColor.white
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
		bNameInvalid.text = ""
		addr1Label.text = R.string.addr1
		addr1Border.borderColor = UIColor.white
		addr1Invalid.text = ""
		addr2Label.text = R.string.addr2
		addr2Border.borderColor = UIColor.white
		addr2Field.placeholder = R.string.optional
		let addr2Optional = UILabel()
		addr2Optional.text = R.string.optional
		//(addr2Border.subviews.first?.subviews.first as! UIStackView).addArrangedSubview(addr2Optional)
		addr2Invalid.text = ""
		cityLabel.text = R.string.city
		cityBorder.borderColor = UIColor.white
		cityInvalid.text = ""
		postcodeLabel.text = R.string.pcode
		postcodeBorder.borderColor = UIColor.white
		postcodeInvalid.text = ""
		postcodeField.placeholder = "eg. A1B 2C3"
		stateLabel.text = R.string.state
		stateBorder.borderColor = UIColor.white
		stateInvalid.text = ""
		let stateSelect = UIButton()
		stateSelect.setTitle(FontAwesome.caretSquareODown.rawValue, for: .normal)
		stateSelect.addTarget(self, action: #selector(makeSelect), for: .touchUpInside)
		//(stateBorder.subviews.first?.subviews.first as! UIStackView).addArrangedSubview(stateSelect)
		countryLabel.text = R.string.country
		countryBorder.borderColor = UIColor.white
		countryInvalid.text = ""
		let countrySelect = UIButton()
		countrySelect.setTitle(FontAwesome.angleDown.rawValue, for: .normal)
		countrySelect.addTarget(self, action: #selector(makeSelect), for: .touchUpInside)
		//(countryBorder.subviews.first?.subviews.first as! UIStackView).addArrangedSubview(countrySelect)
		rightPanelButton.setTitle(R.string.upd.uppercased(), for: .normal)
		//pickerData = [[R.string.country, R.string.state]]
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
					break
				}
			}
			for country in store.countries
			{
				if country.id! == Int((self.address?.id_country)!)!
				{
					countryField.text = country.name?[store.myLang].value
					break
				}
			}
		}
	}
	
	
	func checkFields() -> Bool
	{
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
		//let selectedRange = self.scrollForm.selectedRange
		//self.scrollForm.scrollRangeToVisible(selectedRange)
	}


	@IBAction func leftButtonLeftAct(_ sender: Any)
	{
		self.address = self.addresses[pageControl.currentPage]
		let vc = UIStoryboard(name: "AddrStoryboard", bundle: nil).instantiateViewController(withIdentifier: "AddressExpandedViewController") as! AddressExpandedViewController
		vc.address = self.addresses[pageControl.currentPage]
		present(vc, animated: false, completion: nil)
	}
	@IBAction func leftButtonRightAct(_ sender: Any)
	{
		DispatchQueue.main.async
			{
				let alert = UIAlertController(title: R.string.rusure, message: "\(R.string.delete) \"\(self.addresses[self.pageControl.currentPage].alias)\"", preferredStyle: .alert)
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
				alert.addAction(UIAlertAction(title: R.string.cancel.uppercased(), style: .default, handler: { (action) in
					coloredBG.removeFromSuperview()
					blurFxView.removeFromSuperview()
				}))
				alert.addAction(UIAlertAction(title: R.string.delete.uppercased(), style: .destructive, handler: { (action) in
					//print("delete item:\(self.addresses[self.pageControl.currentPage].alias),\(self.store.formatAddress(self.addresses[self.pageControl.currentPage]))")
					coloredBG.removeFromSuperview()
					blurFxView.removeFromSuperview()
					self.addresses[self.pageControl.currentPage].deleted = "1"
					self.collectionView.reloadData()
					var edited = self.addresses[self.pageControl.currentPage]
					print("address was deleted \(edited.deleted ?? "")")
					edited.deleted = "1"
					//					let encoder = JSONEncoder()
					//					encoder.outputFormatting = .prettyPrinted
					//					let data = try? encoder.encode(edited)
					//					print(String(data: data!, encoding: .utf8)!)
					let str = PSWebServices.object2psxml(object: edited, resource: "addresses", resource2: "address", excludeId: false)
					//					let str = PSWebServices.objectToXML(object: edited, head: "<?xml version=\"1.0\" encoding=\"UTF-8\"?>", wrapperHead: "<prestashop xmlns:xlink=\"http://www.w3.org/1999/xlink\"><addresses>", wrapperTail: "</addresses></prestashop>")
					PSWebServices.postAddress(XMLStr: str)
					{
						(error) in
						if let error = error
						{
							print("fatal error: ", String(error.localizedDescription))
						}
					}
				}))
				self.present(alert, animated: true, completion:
					{
				})
		}
	}
	@IBAction func rightPanelButtonAct(_ sender: Any)
	{
		store.flexView(view: rightPanelButton)
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



extension MyAccAddr2ViewController: UIPickerViewDataSource, UIPickerViewDelegate
{
	func numberOfComponents(in pickerView: UIPickerView) -> Int
	{
		return 2
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
	{
		return pickerData.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
	{
		return pickerData[component][row]//R.string.plsChoose
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
	{
		stateField.text = pickerData[component][row]
		countryField.text = pickerData[component][row]
	}
	
	
	@objc func makeSelect(sender: UIButton!)
	{
		if let listFor = sender.superview?.subviews.first as? UILabel
		{
			print("build list for \(listFor.text ?? "")")
			let picker = UIPickerView()
			picker.dataSource = self
			picker.delegate = self
			//pickerData[0].append(R.string.plsChoose)
			for country in store.countries
			{
				pickerData[0].append(country.name![self.store.myLang].value!)
			}
			for state in store.states
			{
				pickerData[1].append(state.name!)
			}
		}
	}
	
	
}
