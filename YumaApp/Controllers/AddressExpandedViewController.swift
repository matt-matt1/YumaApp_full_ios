//
//  AddressExpandedViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-07.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class AddressExpandedViewController: UIViewController
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
	@IBOutlet weak var button: GradientButton!
	var address: Address? = nil
	let store = DataStore.sharedInstance
	var pickerData: [[String]] = [[String]]()
	
	
	override func viewDidLoad()
	{
        super.viewDidLoad()

		if #available(iOS 11.0, *)
		{
			navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		}
		else
		{
			navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
		}
		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
		button.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		prepareLabels()
		fillDetails()
    }
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	
	func prepareLabels()
	{
		navTitle.title = R.string.Addr
		navClose.title = FontAwesome.times.rawValue
		navHelp.title = FontAwesome.questionCircle.rawValue
		navHelp.setTitleTextAttributes([NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)], for: .normal)
		navHelp.setTitleTextAttributes([
			NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)
			], for: UIControlState.selected)
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
		button.setTitle(R.string.upd.uppercased(), for: .normal)
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
			if self.store.debug > 5
			{
				print("build list for \(listFor.text ?? "")")
			}
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
