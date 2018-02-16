//
//  LoginViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-07.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController
{
	@IBOutlet weak var navBar: UINavigationBar!
	@IBOutlet weak var loginBtn: UIButton!
	@IBOutlet weak var window: UIView!
	@IBOutlet weak var rememberSwitch: UISwitch!
	@IBOutlet weak var showPass: UILabel!
	@IBOutlet weak var helpBtn: UIBarButtonItem!
	@IBOutlet weak var closeBtn: UIBarButtonItem!
	@IBOutlet weak var emailLabel: UILabel!
	@IBOutlet weak var passwordLabel: UILabel!
	@IBOutlet weak var rememberLabel: UILabel!
	@IBOutlet weak var forgotBtn: UIButton!
	@IBOutlet weak var createBtn: UIButton!
	@IBOutlet var usernameTextField: UITextField!
	@IBOutlet var passwordTextField: UITextField!
	@IBOutlet weak var errorPasswordBorder: UIView!
	@IBOutlet weak var errorUsernameBorder: UIView!
	@IBOutlet weak var invalidUsername: UILabel!
	@IBOutlet weak var invalidPassword: UILabel!
	
//	@IBOutlet weak var MANavBar: UINavigationBar!
//	@IBOutlet weak var MAInfo: GradientButton!
//	@IBOutlet weak var MAAddr: GradientButton!
//	@IBOutlet weak var MAOH: GradientButton!
//	@IBOutlet weak var MACS: GradientButton!
//
	var rememberSwitchIsOn: Bool = true
	var passwordVisible: Bool = false
	let url = "\(R.string.URLbase)en/module/my_login/json"
	let store = DataStore.sharedInstance


// MARK: My Methods
	func drawNavBar(_ attachTo: UIView)
	{
		let nav = UINavigationBar()
		nav.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed, R.color.YumaDRed], isVertical: true)
		let nClose = UINavigationItem()
		//nClose = leftBarButtonItem
		//nav.addSubview(UIView(nClose))
		let _ = nClose.leftBarButtonItem
		let nHelp = UINavigationItem(title: "help")
		let _ = nHelp.rightBarButtonItem
		attachTo.addSubview(nav)
		nav.heightAnchor.constraint(equalToConstant: 46.0)
	}
	func addFormEntry(isOneLine: Bool, label: String?, labelColor: UIColor?, labelBackgroundColor: UIColor?, editLeftMargin: CGFloat?, editTopMargin: CGFloat?, editRightMargin: CGFloat?, editBottomMargin: CGFloat?, editLeftPadding: CGFloat?, editTopPadding: CGFloat?, editRightPadding: CGFloat?, editBottomPadding: CGFloat?, editColor: UIColor?, editBackgroundColor: UIColor?, editBorderWidth: CGFloat?, editBorderColor: UIColor?, placeholder: String?, errorMessage: String?, horizontalSpacing: CGFloat?, verticalSpacing: CGFloat?, hasShowHidePassword: Bool) -> UIView
	{
		var entry = UIView()
		var stack = UIStackView()
		
		if isOneLine
		{
			//stack.alignment = UIStackViewAlignment.fill
			stack.axis = UILayoutConstraintAxis.horizontal
			if horizontalSpacing != nil
			{
				stack.spacing = horizontalSpacing!
			}
		}
		else
		{
			stack.axis = UILayoutConstraintAxis.vertical
			if verticalSpacing != nil
			{
				stack.spacing = verticalSpacing!
			}
		}
		
		if label != nil
		{
			let eLabel = UILabel()
			eLabel.text = label
			if labelColor != nil
			{
				eLabel.textColor = labelColor!
			}
			if labelBackgroundColor != nil
			{
				eLabel.backgroundColor = labelBackgroundColor!
			}
			stack.addArrangedSubview(eLabel)
		}
		
		let eEditView = UIView()
		let eEdit = UITextField()
		//eEdit.textInputMode = UITextInputMode()
		if editColor != nil
		{
			eEdit.textColor = editColor!
		}
		if editBackgroundColor != nil
		{
			eEdit.backgroundColor = editBackgroundColor!
		}
		if editBorderColor != nil
		{
			eEdit.layer.borderColor = editBorderColor!.cgColor
			if editBorderWidth != nil
			{
				eEdit.layer.borderWidth = min(editBorderWidth!, 0)
			}
		}
		if placeholder != nil
		{
			eEdit.placeholder = placeholder
		}
		if hasShowHidePassword
		{
			let editStack = UIStackView()
			editStack.axis = UILayoutConstraintAxis.horizontal
			let showPassword = UILabel()
			eEditView.addSubview(showPassword)
			showPassword.center.x = editStack.center.x
			showPassword.center.y = editStack.center.y
			eEdit.addSubview(editStack)
			if editLeftMargin == editRightMargin
			{
				eEdit.center.x = editStack.center.x
			}
		}
		else
		{
			if editLeftMargin == editRightMargin
			{
				eEdit.center.x = eEditView.center.x
			}
		}
		if editTopMargin == editBottomMargin
		{
			eEdit.center.y = eEditView.center.y
		}
		eEdit.translatesAutoresizingMaskIntoConstraints = false
		eEditView.addSubview(eEdit)
		if editLeftMargin != nil
		{
		//eEdit.leftAnchor.constraint(equalTo: NSLayoutAnchor., constant: editLeftMargin!)
		}
		stack.addArrangedSubview(eEditView)
		if editRightMargin != nil
		{
		//eEditView.leftAnchor.constraint(equalTo: <#T##NSLayoutAnchor<NSLayoutXAxisAnchor>#>, constant: editRightMargin!)
		}
		
		if errorMessage != nil
		{
			let eError = UILabel()
			eError.text = errorMessage
			stack.addArrangedSubview(eError)
		}
		
		entry.addSubview(stack)
		return entry
	}
	func drawPanel(_ attachTo: UIView?)
	{
		let panel = UIView()
		let myStack = UIStackView()
		panel.addSubview(myStack)
		if attachTo != nil
		{
			attachTo!.addSubview(panel)
		}
	}
	func drawLayoutWide()
	{
		let allStack = UIStackView()
		drawNavBar(allStack)
		drawPanel(allStack)
		self.view.addSubview(allStack)
	}
	func drawLayoutNarrow()
	{
		let allStack = UIStackView()
		drawNavBar(allStack)
		drawPanel(nil)//allStack)
		let field1 = addFormEntry(isOneLine: false, label: "Email Address", labelColor: nil, labelBackgroundColor: nil, editLeftMargin: 10.0, editTopMargin: 2.5, editRightMargin: 10.0, editBottomMargin: 2.5, editLeftPadding: 0.0, editTopPadding: 0.0, editRightPadding: 0.0, editBottomPadding: 0.0, editColor: nil, editBackgroundColor: nil, editBorderWidth: nil, editBorderColor: nil, placeholder: "eg. me@my.com", errorMessage: "Bad email address", horizontalSpacing: 10.0, verticalSpacing: 10.0, hasShowHidePassword: false)
		allStack.addArrangedSubview(field1)
		let field2 = addFormEntry(isOneLine: false, label: "Password", labelColor: nil, labelBackgroundColor: nil, editLeftMargin: 10.0, editTopMargin: 2.5, editRightMargin: 10.0, editBottomMargin: 2.5, editLeftPadding: 0.0, editTopPadding: 0.0, editRightPadding: 0.0, editBottomPadding: 0.0, editColor: nil, editBackgroundColor: nil, editBorderWidth: nil, editBorderColor: nil, placeholder: "min. 6 characters", errorMessage: "Bad password", horizontalSpacing: 10.0, verticalSpacing: 10.0, hasShowHidePassword: true)
		allStack.addArrangedSubview(field2)
		self.view.addSubview(allStack)
	}
	fileprivate func configureView()
	{
		if view.frame.width > 500
		{
			drawLayoutWide()
		}
		else
		{
			drawLayoutNarrow()
		}
		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)	//navigation
		emailLabel.text = R.string.emailAddr							//set labals for my language
		passwordLabel.text = R.string.txtPass
		rememberLabel.text = R.string.remember
		rememberSwitchIsOn = rememberSwitch.isOn
		forgotBtn.setTitle(R.string.forgotPW, for: .normal)
		createBtn.setTitle("\(R.string.accountMake)", for: .normal)
		//closeBtn.
		//helpBtn.
		loginBtn.setTitle(R.string.login, for: UIControlState.normal)
		errorUsernameBorder.layer.borderColor = UIColor.white.cgColor	//clear errors
		errorPasswordBorder.layer.borderColor = UIColor.white.cgColor
		invalidUsername.text = ""
		invalidPassword.text = ""
	}
	
	func alertMessage(alerttitle: String, _ message: String)
	{
		let alertViewController = UIAlertController(title: alerttitle, message: message, preferredStyle: .alert)
		alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		present(alertViewController, animated: true, completion: nil)
	}
	
	func isValidEmail(_ email: String) -> Bool
	{
		let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
		
		let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
		return emailTest.evaluate(with: email)
	}
	
	func getCustomerDetails()
	{
		let sv = UIViewController.displaySpinner(onView: self.view)
		let myUrl = "\(url)?email=\(usernameTextField.text ?? "")&passwd=\(passwordTextField.text ?? "")"
		//		rememberSwitchIsOn = rememberSwitch.isOn
		
		store.callGetCustomerDetails(from: myUrl, completion:
			
			//PSWebServices.getCustomer(from: myUrl)
			{
				(customer) in
				
				UIViewController.removeSpinner(spinner: sv)
				//			DispatchQueue.main.async//OperationQueue.main.addOperation
				//				{
				if customer.deleted != "0"
				{
					self.alertMessage(alerttitle: R.string.acc, R.string.deld)
				}
				else if customer.active != "1"
				{
					self.alertMessage(alerttitle: R.string.acc, R.string.notAct)
				}
				else
				{
					self.successfullyGotCustomer("", customer)
					//					self.successfullyGotCustomer(dataString!, customer)
				}
		})
	}
	
	fileprivate func successfullyGotCustomer(_ dataString: String, _ customer: Customer)
	{
		if rememberSwitchIsOn
		{
			//write json string to file
			UserDefaults.standard.set(dataString, forKey: "customer")
			
			var docURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last
			docURL = docURL?.appendingPathComponent("logged.json")
			//			UIViewController.removeSpinner(spinner: sv)
			//			try dataString.write(to: docURL, atomically: true)
			////			do
			////			{
			////				try dataString.write(toFile: "logged.json", atomically: true)
			////			}
			////			catch let error as NSError
			////			{
			////				print("error trying to write to logged.json : \(error)")
			////			}
		}
		getAddresses(customer: customer)
	}

	func getAddresses(customer: Customer)
	{
		//		let sv2 = UIViewController.displaySpinner(onView: self.view)
		if (customer.id != nil)
		{
			PSWebServices.getAddresses(id_customer: Int(customer.id!)!, completionHandler:
				{
					(addresses) in
					
					//				UIViewController.removeSpinner(spinner: sv2)
					//print(addresses)
					//print("got \(addresses.addresses.count) addresses")
					//UserDefaults.standard.set(addresses, forKey: "CustomerAddresses")
					OperationQueue.main.addOperation
						{
							self.successfullyGotAddresses(addresses: addresses)
					}
			})
		}
		else if customer.id_customer != nil
		{
			PSWebServices.getAddresses(id_customer: Int(customer.id_customer!)!, completionHandler:
				{
					(addresses) in
					
					//				UIViewController.removeSpinner(spinner: sv2)
					//print(addresses)
					//print("*got \(addresses.addresses.count) addresses")
					//UserDefaults.standard.set(addresses, forKey: "CustomerAddresses")
					OperationQueue.main.addOperation
						{
							self.successfullyGotAddresses(addresses: addresses)
					}
			})
		}
		self.present(MyAccountViewController(), animated: true, completion: nil)
		//with storyboard
		//		let displayMA = self.storyboard?.instantiateViewController(withIdentifier: "MyAccountVC") as! MyAccountVC
		//		self.navigationController?.pushViewController(displayMA, animated: true)
		//without storyboard
		//		let displayMA = ViewController(nibName: "MyAccount", bundle: nil)
	}

	fileprivate func successfullyGotAddresses(addresses: Addresses)
	{
		print("got \(addresses.addresses.count) addresses")
		UserDefaults.standard.set(String(describing: addresses), forKey: "CustomerAddresses")
//		self.present(MyAccountViewController(), animated: true, completion: nil)
//		var customerAddressesFormed: [String] = []
//		for addr in addresses.addresses
//		{
//			let formed = store.formatAddress(addr)
//			customerAddressesFormed.append(formed)
//			print(formed)
//		}
		//print(UserDefaults.standard.string(forKey: "CustomerAddresses")!)
	}
	
	
//MARK: Overrides
	override func viewDidLoad()
	{
		super.viewDidLoad()

		//logged in?
		let logged = UserDefaults.standard.object(forKey: "logged")
		if logged != nil
		{			//YES
//			let customer = store.customer
			//if let id_customer = customer[0].id_customer
		}
		else		//DataStore?
		{
//			if let _ = customer[0].id_customer
//			{
//				//print(customer!)
//				self.present(MyAccountViewController(), animated: false, completion: nil)
//			}
			//IN A FILE?
			var docURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last
			docURL = docURL?.appendingPathComponent("logged.json")
			if false
			{
				//if customer["id_customer"] > -1
				//if logged.json exists
				//read file
				//display my account
			}
			else	//NEITHER = not logged in
			{
				configureView()
				//		loginBtn.
				showPass.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showPassAct(_:))))
			}
		}
	}
	
	override func viewWillAppear(_ animated: Bool)
	{
	}
	
	override func didReceiveMemoryWarning()
	{
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
//MARK: Actions
	@IBAction func remeberSwitchAct(_ sender: Any)
	{
		self.rememberSwitchIsOn = rememberSwitch.isOn
	}
	@objc func showPassAct(_ sender: Any)
	{
		if passwordVisible
		{
			passwordTextField.isSecureTextEntry = true
			showPass.text = FontAwesome.eye.rawValue
		}
		else
		{
			passwordTextField.isSecureTextEntry = false
			showPass.text = FontAwesome.eyeSlash.rawValue
		}
		passwordVisible = !passwordVisible
	}
	@IBAction func helpBtnAct(_ sender: Any)
	{
	}
	@IBAction func closeBtnAct(_ sender: Any)
	{
		self.dismiss(animated: true, completion: nil)
	}
	@IBAction func loginButtonClicked(_ sender: Any)
	{
		errorUsernameBorder.layer.borderColor = UIColor.white.cgColor
		errorPasswordBorder.layer.borderColor = UIColor.white.cgColor
		invalidUsername.text = ""
		invalidPassword.text = ""
		var proceed = true
		if !(isValidEmail(usernameTextField.text!))
		{
			errorUsernameBorder.layer.borderColor = UIColor.red.cgColor
			invalidUsername.text = "\(R.string.invalid) \(R.string.emailAddr)"
			proceed = false
		}
		if (passwordTextField.text?.count)! < 5
		{
			errorPasswordBorder.layer.borderColor = UIColor.red.cgColor
			invalidPassword.text = "\(R.string.invalid) \(R.string.txtPass)"
			proceed = false
		}
		if proceed
		{
			getCustomerDetails()
		}
	}
	@IBAction func forgotBtnAct(_ sender: Any)
	{
		//self.present(ForgotPWViewController(), animated: true, completion: nil)
	}
	@IBAction func createBtnAct(_ sender: Any)
	{
		//self.present(CreateAccViewController(), animated: true, completion: nil)
	}
//	@IBAction func MAInfoAct(_ sender: Any)
//	{
//	}
//	@IBAction func MAAddrAct(_ sender: Any)
//	{
//	}
//	@IBAction func MAOHAct(_ sender: Any)
//	{
//	}
//	@IBAction func MACSAct(_ sender: Any)
//	{
//	}

}

//extension String
//{
//	func isValidEmail() -> Bool
//	{
//		let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
//		return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: characters.count)) != nil
//	}
//}
