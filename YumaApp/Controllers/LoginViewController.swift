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
	@IBOutlet weak var navTitle: UINavigationItem!
	@IBOutlet weak var navClose: UIBarButtonItem!
	@IBOutlet weak var navHelp: UIBarButtonItem!
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
	
	var rememberSwitchIsOn: Bool = true
	var passwordVisible: Bool = false
	let url = "\(R.string.URLbase)en/module/my_login/json"
	let store = DataStore.sharedInstance
	
	
	//MARK: Overrides
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		//logged in?
		//		let customer = store.customer
		//		if customer.count > 0
		if store.customer != nil && store.customer?.lastname != ""
		{
			let _ = UIViewController.displaySpinner(onView: self.view)
			swapout()
		}
		//////
		//		let logged = UserDefaults.standard.object(forKey: "Customer")//"logged")
		//		if logged != nil
		if false && UserDefaults.standard.object(forKey: "Customer") != nil
		{			//YES
			//			let customer = store.customer
			//			if customer[0].id_customer != nil
			//			{
			let _ = UIViewController.displaySpinner(onView: self.view)
			swapout()
			//			}
		}
		else		//DataStore?
		{
			//			if let _ = customer[0].id_customer
			//			{
			//				//print(customer!)
			//				self.present(MyAccountViewController(), animated: false, completion: nil)
			//			}
			if #available(iOS 11.0, *)
			{
				navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
			}
			else
			{
				navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
			}//***WARNING:***
			/*Unable to simultaneously satisfy constraints.
			Probably at least one of the constraints in the following list is one you don't want.
			Try this:
			(1) look at each constraint and try to figure out which you don't expect;
			(2) find the code that added the unwanted constraint or constraints and fix it.
			(
			"<NSLayoutConstraint:0x145ca3a0 V:|-(0)-[UIStackView:0x146faff0]   (Names: '|':UIView:0x146faf00 )>",
			"<NSLayoutConstraint:0x145d45d0 UINavigationBar:0x146eae60.top == UIView:0x146faf00.top + 20>",
			"<NSLayoutConstraint:0x146429e0 'UISV-canvas-connection' UIStackView:0x146faff0.top == UINavigationBar:0x146eae60.top>"
			)
			
			Will attempt to recover by breaking constraint
			<NSLayoutConstraint:0x146429e0 'UISV-canvas-connection' UIStackView:0x146faff0.top == UINavigationBar:0x146eae60.top>*/
			//IN A FILE?
			var docURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last
			docURL = docURL?.appendingPathComponent("logged.json")
			var contents = ""
			do
			{
				contents = try String(contentsOf: docURL!, encoding: .utf8)
				if contents != ""
				{
					print(contents)
				}
			}
			catch _
			{
				print("file read error")//:\(e)")
				let ud = UserDefaults.standard.string(forKey: "Customer")
				if ud != nil
				{
					let _ = UIViewController.displaySpinner(onView: self.view)
					let dataStr = ud?.data(using: .utf8)
					//UIViewController.removeSpinner(spinner: sv)
					do
					{
						let bits = try JSONDecoder().decode(Customer.self, from: dataStr!)
						store.customer = bits
						print("decoded customer (\(bits.id_customer ?? ""))")
						self.successfullyGotCustomer(bits)
						swapout()
					}
					catch let JSONerr
					{
						print("\(R.string.err) \(JSONerr)")
					}
				}
				else
				{
					print("no customer in user data")
				}
			}
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
				if Reachability.isConnectedToNetwork()
				{
					showPass.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showPassAct(_:))))
					usernameTextField.delegate = self
					passwordTextField.delegate = self
					usernameTextField.returnKeyType = .next
					passwordTextField.returnKeyType = .done
				}
				else
				{
					let alert = UIAlertController(title: R.string.internet, message: R.string.no_connect, preferredStyle: .alert)
					alert.addAction(UIAlertAction(title: R.string.dismiss, style: .default, handler: nil))
					self.present(alert, animated: false, completion: {
						self.dismiss(animated: false, completion: nil)
					})
				}
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
		let entry = UIView()
		let stack = UIStackView()
		
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
//		if view.frame.width > 500
//		{
//			drawLayoutWide()
//		}
//		else
//		{
//			drawLayoutNarrow()
//		}
		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)	//navigation
		navHelp.title = FontAwesome.questionCircle.rawValue
		navHelp.setTitleTextAttributes([NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)], for: .normal)
		emailLabel.text = R.string.emailAddr							//set labals for my language
		passwordLabel.text = R.string.txtPass
		rememberLabel.text = R.string.remember
		rememberSwitchIsOn = rememberSwitch.isOn
		forgotBtn.setTitle(R.string.forgotPW, for: .normal)
		createBtn.setTitle("\(R.string.accountMake)", for: .normal)
		//closeBtn.
		//helpBtn.
		loginBtn.setTitle(R.string.login.uppercased(), for: UIControlState.normal)
		loginBtn.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		errorUsernameBorder.layer.borderColor = UIColor.white.cgColor	//clear errors
		errorPasswordBorder.layer.borderColor = UIColor.white.cgColor
		invalidUsername.text = ""
		invalidPassword.text = ""
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
			{
				(customer) in
				
				UIViewController.removeSpinner(spinner: sv)
				if let _ = customer as? Bool
				{
					let alertViewController = UIAlertController(title: R.string.login, message: R.string.wrong, preferredStyle: .alert)
					alertViewController.addAction(UIAlertAction(title: R.string.ok, style: .default, handler: nil))
					var dwi2: DispatchWorkItem?
					dwi2 = DispatchWorkItem
					{
						self.present(alertViewController, animated: true, completion: (() -> Void)? {	dwi2?.cancel()	})
					}
					DispatchQueue.main.async(execute: dwi2!)
				}
				else
				{
					let cust = customer as! Customer
					if cust.deleted != "0"
					{
						//self.store.alertMessage(sender: self, alerttitle: R.string.acc, R.string.deld)
						self.store.Alert(fromView: self, title: R.string.acc, titleColor: R.color.YumaRed, /*titleBackgroundColor: <#T##UIColor?#>, titleFont: <#T##UIFont?#>,*/ message: R.string.deld, /*messageColor: <#T##UIColor?#>, messageBackgroundColor: <#T##UIColor?#>, messageFont: <#T##UIFont?#>,*/ dialogBackgroundColor: R.color.YumaYel, backgroundBackgroundColor: R.color.YumaRed, /*backgroundBlurStyle: <#T##UIBlurEffectStyle?#>, backgroundBlurFactor: <#T##CGFloat?#>,*/ borderColor: R.color.YumaDRed, borderWidth: 2, /*cornerRadius: <#T##CGFloat?#>,*/ shadowColor: R.color.YumaDRed, /*shadowOffset: <#T##CGSize?#>, shadowOpacity: <#T##Float?#>, shadowRadius: <#T##CGFloat?#>, alpha: <#T##CGFloat?#>,*/ hasButton1: true, button1Title: R.string.cancel, /*button1Style: <#T##UIAlertActionStyle?#>, button1Color: <#T##UIColor?#>, button1Font: <#T##UIFont?#>, button1Action: <#T##DataStore.Closure_Void?##DataStore.Closure_Void?##() -> Void#>,*/ hasButton2: false/*, button2Title: <#T##String?#>, button2Style: <#T##UIAlertActionStyle?#>, button2Color: <#T##UIColor?#>, button2Font: <#T##UIFont?#>, button2Action: <#T##DataStore.Closure_Void?##DataStore.Closure_Void?##() -> Void#>*/)
					}
					else if cust.active != "1"
					{
						//self.store.alertMessage(sender: self, alerttitle: R.string.acc, R.string.notAct)
						self.store.Alert(fromView: self, title: R.string.acc, titleColor: R.color.YumaRed, /*titleBackgroundColor: <#T##UIColor?#>, titleFont: <#T##UIFont?#>,*/ message: R.string.notAct, /*messageColor: <#T##UIColor?#>, messageBackgroundColor: <#T##UIColor?#>, messageFont: <#T##UIFont?#>,*/ dialogBackgroundColor: R.color.YumaYel, backgroundBackgroundColor: R.color.YumaRed, /*backgroundBlurStyle: <#T##UIBlurEffectStyle?#>, backgroundBlurFactor: <#T##CGFloat?#>,*/ borderColor: R.color.YumaDRed, borderWidth: 2, /*cornerRadius: <#T##CGFloat?#>,*/ shadowColor: R.color.YumaDRed, /*shadowOffset: <#T##CGSize?#>, shadowOpacity: <#T##Float?#>, shadowRadius: <#T##CGFloat?#>, alpha: <#T##CGFloat?#>,*/ hasButton1: true, button1Title: R.string.cancel, /*button1Style: <#T##UIAlertActionStyle?#>, button1Color: <#T##UIColor?#>, button1Font: <#T##UIFont?#>, button1Action: <#T##DataStore.Closure_Void?##DataStore.Closure_Void?##() -> Void#>,*/ hasButton2: false/*, button2Title: <#T##String?#>, button2Style: <#T##UIAlertActionStyle?#>, button2Color: <#T##UIColor?#>, button2Font: <#T##UIFont?#>, button2Action: <#T##DataStore.Closure_Void?##DataStore.Closure_Void?##() -> Void#>*/)
					}
					else
					{
						self.successfullyGotCustomer(cust)
					}
				}
		})
	}
	
	
	fileprivate func successfullyGotCustomer(_ customer: Customer)
	{
		print("customer logged-in with ID:\(customer.id_customer ?? customer.id ?? "0")")//String(describing: customer))")
		if rememberSwitchIsOn
		{
			//write json string to file
//			UserDefaults.standard.set(String(data: customer, encoding: .utf8), forKey: "Customer")
			
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
		let id = customer.id == nil ? Int(customer.id_customer!) : Int(customer.id!)
		getDetails(id_customer: id!)
	}

	
	func getDetails(id_customer: Int)
	{
		print("getDetails")
//		let sv2 = UIViewController.displaySpinner(onView: self.view)
		if store.customer != nil && store.orders.count < 1
		{
			let ord = UserDefaults.standard.string(forKey: "OrdersCustomer\(id_customer)")
			if ord == nil || ord == ""
				//		if UserDefaults.standard.string(forKey: "OrdersCustomer\(id_customer)") == ""
			{	//perform http get
				store.getOrders(id_customer: id_customer)
				{
					(orders, err) in
					
					if err != nil
					{
						print(err!)
						return
					}
					if let orders = orders
					{
						let ord = orders as? Orders
						let ords = ord?.orders?.count
						print("got \(ords ?? 0) orders")
					}
				}
			}
			else
			{
				//decode json string "ord"
				let tempStr: String = store.trimJSONValueToArray(string: ord!)
				let tempObj: [Order]
				do
				{
					tempObj = try JSONDecoder().decode([Order].self, from: tempStr.data(using: .utf8)!)
					for ords in tempObj
					{
						store.orders.append(ords)
					}
				}
				catch let jsonErr
				{
					print(jsonErr)
				}
				print("decoded \(store.orders.count) orders")
			}
		}
		if store.customer != nil && store.customer?.lastname != ""
		{
			let addr = UserDefaults.standard.string(forKey: "CartsCustomer\(id_customer)")
			if addr == nil || addr == ""
			{
				store.callGetCarts(id_customer: id_customer) { (carts, err) in
					if err == nil
					{
						print("got \((carts as [aCart]?)?.count ?? 0) carts")
						//print("got \((carts as [Carts]?)?.count ?? 0) carts")
					}
				}
			}
			else
			{
				let dataStr = addr?.data(using: .utf8)
				do
				{
					let carts = try JSONDecoder().decode(Carts.self, from: dataStr!)
					store.carts = carts.carts!
					print("decoded \(store.carts.count) carts")
				}
				catch let JSONerr
				{
					print("\(R.string.err) \(JSONerr)")
				}
			}
		}
		if store.addresses.count < 1
		{
			let addr = UserDefaults.standard.string(forKey: "AddressesCustomer\(id_customer)")
			if addr == nil || addr == ""
			{
				store.callGetAddresses(id_customer: id_customer, completion:
		//			PSWebServices.getAddresses(id_customer: Int(customer.id!)!, completionHandler:
					{
						(addresses) in

	//				UIViewController.removeSpinner(spinner: sv2)
						//print(addresses)
						//print("got \(addresses.addresses.count) addresses")
						//UserDefaults.standard.set(addresses, forKey: "CustomerAddresses")
						let addr = addresses.addresses
						print("got \(String(describing: addr?.count)) addresses")
	//					UserDefaults.standard.set(String(data: addr!, encoding: .utf8), forKey: "AddressesCustomer\(id_customer)")
	//					OperationQueue.main.addOperation
	//						{
	//							self.successfullyGotAddresses(id_customer: id_customer, addresses: addresses)
	//						}
					}
				)
			}
			else
			{
				let dataStr = addr?.data(using: .utf8)
				do
				{
					let addresses = try JSONDecoder().decode(Addresses.self, from: dataStr!)
					store.addresses = addresses.addresses!
					print("decoded \(String(describing: store.addresses.count)) addresses")
//					for add in 0..<addresses.addresses
//					{
//					store.addresses.append(add)
//					}
				}
				catch let JSONerr
				{
					print("\(R.string.err) \(JSONerr)")
				}
			}
		}
		//with storyboard
		//		let displayMA = self.storyboard?.instantiateViewController(withIdentifier: "MyAccountVC") as! MyAccountVC
		//		self.navigationController?.pushViewController(displayMA, animated: true)
		//without storyboard
		//		let displayMA = ViewController(nibName: "MyAccount", bundle: nil)
		if store.customer != nil && store.orderDetails.count < 1
		{
			for order in store.orders
			{
				let id_order = Int(order.id!)
				let ord = UserDefaults.standard.string(forKey: "Order\(id_order)Details")
				if ord == nil || ord == ""
					//		if UserDefaults.standard.string(forKey: "OrdersCustomer\(id_customer)") == ""
				{	//perform http get
					store.getOrderDetails(id_order: id_order)
					{
						(orders, err) in
						
						if err != nil
						{
							print(err!)
							return
						}
						if let orders = orders
						{
							let array = (orders as? OrderDetails)?.orderDetails
							for member in array!
							{
								self.store.orderDetails.append(member)
							}
							//let ords = ord?.count
							print("got an order detail")
						}
					}
				}
				else
				{
					//decode json string "ord"
					let tempStr: String = store.trimJSONValueToArray(string: ord!)
					let tempObj: [OrderDetail]
					do
					{
						tempObj = try JSONDecoder().decode([OrderDetail].self, from: tempStr.data(using: .utf8)!)
						for ords in tempObj
						{
							store.orderDetails.append(ords)
						}
					}
					catch let jsonErr
					{
						print(jsonErr)
					}
					print("decoding details for order \(order.id ?? 0)")
				}
				//print("getting \(store.orderDetails.count) order details")
			}
		}
		self.successfullyGotDetails(id_customer: id_customer)
	}

	fileprivate func successfullyGotDetails(id_customer: Int)
	{
		store.myLang = (store.customer != nil) ? Int((store.customer?.id_lang)!)! : 0
		weak var presentingViewController = self.presentingViewController
		self.dismiss(animated: false)
		{
			presentingViewController?.present(MyAccountViewController(), animated: true, completion: nil)
		}
	}
	
	@objc func swapout()
	{
		OperationQueue.main.addOperation
			{
				weak var presentingViewController = self.presentingViewController
				self.dismiss(animated: false, completion: {
//					LoginViewController().dismiss(animated: false, completion: {
//						self.present(MyAccountViewController(nibName: "MyAccountViewController", bundle: Bundle.main), animated: false, completion: nil)
					presentingViewController?.present(MyAccountViewController(), animated: false, completion: nil)
				})
			}
	}
	
	
//MARK: Actions
	@IBAction func remeberSwitchAct(_ sender: Any)
	{
		self.rememberSwitchIsOn = rememberSwitch.isOn
	}
	@objc func showPassAct(_ sender: Any)
	{
		//passwordTextField.updateFocusIfNeeded()
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
		passwordTextField.becomeFirstResponder()
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
		Reachability.isInternetAvailable(website: R.string.WSbase)
		{
			(available) in
			
			guard available else
			{
				self.store.flexView(view: self.loginBtn)
				let alertC = UIAlertController(title: "\(R.string.err) \(R.string.internet)", message: R.string.unableConnect, preferredStyle: .alert)
				let OKAct = UIAlertAction(title: R.string.dismiss, style: .default, handler: nil)
				alertC.addAction(OKAct)
				self.present(alertC, animated: true, completion: nil)
				return
			}
			self.errorUsernameBorder.layer.borderColor = UIColor.white.cgColor
			self.errorPasswordBorder.layer.borderColor = UIColor.white.cgColor
			self.invalidUsername.text = ""
			self.invalidPassword.text = ""
			var proceed = true
			if !(self.isValidEmail(self.usernameTextField.text!))
			{
				self.markUsernameBad()
				proceed = false
			}
			else
			{
				self.markUsernameGood()
			}
			if (self.passwordTextField.text?.count)! < 5
			{
				self.markPasswordBad()
				proceed = false
			}
			else
			{
				self.markPasswordGood()
			}
			if proceed
			{
				self.getCustomerDetails()
			}
		}
	}
	@IBAction func forgotBtnAct(_ sender: Any)
	{
		self.present(ForgotPWViewController(), animated: true, completion: nil)
	}
	@IBAction func createBtnAct(_ sender: Any)
	{
		self.present(MyAccInfoViewController(), animated: true, completion: nil)
	}

	
	func markUsernameBad()
	{
		self.errorUsernameBorder.layer.borderColor = UIColor.red.cgColor
		self.invalidUsername.text = "\(R.string.invalid) \(R.string.emailAddr)"
	}

	func markUsernameGood()
	{
		self.errorUsernameBorder.layer.borderColor = UIColor.clear.cgColor
		self.invalidUsername.text = ""
	}
	
	func markPasswordBad()
	{
		self.errorPasswordBorder.layer.borderColor = UIColor.red.cgColor
		self.invalidPassword.text = "\(R.string.invalid) \(R.string.emailAddr)"
	}
	
	func markPasswordGood()
	{
		self.errorPasswordBorder.layer.borderColor = UIColor.clear.cgColor
		self.invalidPassword.text = ""
	}
}


extension LoginViewController: UITextFieldDelegate
{
	func textFieldShouldReturn(_ textField: UITextField) -> Bool
	{
		if textField === self.usernameTextField
		{
			if !(self.isValidEmail(self.usernameTextField.text!))
			{
				markUsernameBad()
			}
			else
			{
				markUsernameGood()
				passwordTextField.becomeFirstResponder()
			}
		}
		else
		{
			if (self.passwordTextField.text?.count)! < 5
			{
				markPasswordBad()
			}
			else
			{
				markPasswordGood()
				self.getCustomerDetails()
			}
		}
		return true
	}
}
