//
//  ForgotPWViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-19.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class ForgotPWViewController: UIViewController, UITextFieldDelegate
{
	@IBOutlet weak var navBar: UINavigationBar!
	@IBOutlet weak var navTitle: UINavigationItem!
	@IBOutlet weak var navClose: UIBarButtonItem!
	@IBOutlet weak var navHelp: UIBarButtonItem!
	@IBOutlet weak var fieldLabel: UILabel!
	@IBOutlet weak var fieldValue: UITextField!
	@IBOutlet weak var fieldInvalid: UILabel!
	@IBOutlet weak var button: GradientButton!
	@IBOutlet weak var fieldBorder: UIView!
	
	let url = "\(R.string.forgotPWLink)"
	let store = DataStore.sharedInstance
	var email = ""
//	var password = ""
	var result: Customer!
	var resetStr = ""
	var resetEncoded = ""


	// MARK: Overrides

	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		/*Unable to simultaneously satisfy constraints.
		Probably at least one of the constraints in the following list is one you don't want.
		Try this:
		(1) look at each constraint and try to figure out which you don't expect;
		(2) find the code that added the unwanted constraint or constraints and fix it.
		(
		"<NSLayoutConstraint:0x146336e0 V:|-(0)-[UIStackView:0x14631a10]   (Names: '|':UIView:0x14631920 )>",
		"<NSLayoutConstraint:0x14633920 UIView:0x14631920.top == UIView:0x14631830.topMargin>",
		"<NSLayoutConstraint:0x146a0e10 UINavigationBar:0x145ba260.top == UIView:0x14631830.top + 20>",
		"<NSLayoutConstraint:0x14633ca0 'UISV-canvas-connection' UIStackView:0x14631a10.top == UINavigationBar:0x145ba260.top>"
		)
		
		Will attempt to recover by breaking constraint
		<NSLayoutConstraint:0x14633ca0 'UISV-canvas-connection' UIStackView:0x14631a10.top == UINavigationBar:0x145ba260.top>*/
		
		//		if #available(iOS 11.0, *) {
		//			navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		//		} else {
		//			navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
		//		}
		configureView()
//		let notificationCenter = NotificationCenter.default
//		notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillHide, object: nil)
//		notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
	}

	
	override func didReceiveMemoryWarning()
	{
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


	// MARK: Methods

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
		navTitle.title = R.string.forgotPW
		fieldLabel.text = R.string.emailAddr							//set labals for my language
		button.setTitle(R.string.proceed.uppercased(), for: .normal)
//		navClose.title = FontAwesome.questionCircle.rawValue
//		navClose.setTitleTextAttributes([NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)], for: .normal)
//		navClose.setTitleTextAttributes([
//			NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)
//			], for: UIControlState.selected)
		navHelp.title = FontAwesome.questionCircle.rawValue
		navHelp.setTitleTextAttributes([NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)], for: .normal)
		navHelp.setTitleTextAttributes([
			NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)
			], for: UIControlState.highlighted)
		button.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		fieldBorder.layer.borderColor = UIColor.white.cgColor	//clear errors
		fieldInvalid.text = ""
		fieldValue.delegate = self
		if !email.isEmpty
		{
			fieldValue.text = email
		}
	}


	func textFieldShouldReturn(_ textField: UITextField) -> Bool
	{
		buttonAct(textField)
		return true
	}


	func alertMessage(alerttitle: String, _ message: String)
	{
		let alertViewController = UIAlertController(title: alerttitle, message: message, preferredStyle: .alert)
		alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		present(alertViewController, animated: true, completion: nil)
	}


	func isValidEmail(_ email: String) -> Bool
	{
		fieldBorder.borderColor = UIColor.clear
		fieldInvalid.text = ""
		let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
		
		let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
		return emailTest.evaluate(with: email)
	}

	
	// MARK: Actions
	
//	@objc func adjustForKeyboard(notification: Notification)
//	{
//		let userInfo = notification.userInfo!
//		let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
//		let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
//
//		if notification.name == Notification.Name.UIKeyboardWillHide
//		{
//			self.scrollForm.contentInset = UIEdgeInsets.zero
//		}
//		else
//		{
//			self.scrollForm.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
//		}
//		self.scrollForm.scrollIndicatorInsets = self.scrollForm.contentInset
//		//let selectedRange = self.scrollForm.selectedRange
//		//self.scrollForm.scrollRangeToVisible(selectedRange)
//	}


	@IBAction func navCloseAct(_ sender: Any)
	{
		self.dismiss(animated: false, completion: nil)
	}
	@IBAction func navHelpAct(_ sender: Any)
	{
		let viewC = Assistance()
		viewC.array = R.array.help_forgot_pw_guide
		viewC.title = "\(R.string.forgotPW.capitalized) \(R.string.help.capitalized)"
		viewC.modalTransitionStyle = .crossDissolve
		viewC.modalPresentationStyle = .overCurrentContext
		self.present(viewC, animated: true, completion: nil)
	}
	@IBAction func buttonAct(_ sender: Any)
	{
		if isValidEmail(fieldValue.text!)
		{
//			var results: [Customer] = []
			var ws = WebService()
			ws.startURL = R.string.WSbase
			ws.filter = ["email" : [fieldValue.text!]]
			ws.resource = APIResource.customers
			ws.display = ["full"]
			ws.outputAs = OutputFormat.JSON
			ws.keyAPI = R.string.APIkey
			ws.get { (cust) in
				if let data = cust.data
				{
					do
					{
						let dataString = String(data: data as Data, encoding: .utf8)
						let innerEnclosed = self.store.trimJSONValueToArray(string: dataString!)
						let inner1 = innerEnclosed.dropLast()
						let inner = inner1.dropFirst()
						let data = inner.data(using: .utf8)!
						self.result = try JSONDecoder().decode(Customer.self, from: data)
						let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any]
						self.result.id = jsonResult?["id"] as? Int		//for some reason the id is missing
						self.result.idCustomer = jsonResult?["id"] as? Int	//^so we get it from jsonser.
						if self.result.active! && !self.result.deleted! //&& self.result.resetPasswordToken == nil
						{
							let now = Date()
							let df = DateFormatter()
							df.dateFormat = "yyyy-MM-dd HH:mm:ss"
							let last: Date = (self.result.lastPasswdGen != nil && !(self.result.lastPasswdGen?.contains("00-"))!) ? df.date(from: self.result.lastPasswdGen!)! : Date()// = "1900-06-15 12:00:00"
							let after = (last.addingTimeInterval(TimeInterval(self.store.passwdTimeFront*60)))
							if after < now
							{
//								let df = DateFormatter()
//								df.dateFormat = "yyyy-MM-dd HH:mm:ss"
//								self.resetStr = df.string(from: Date())/*new__last_passwd_gen*/
//								self.resetEncoded = self.resetStr.sha1
////								let link = "\(R.string.forgotPWLink)?token=\(self.result.secureKey ?? "")&id_customer=\(self.result.idCustomer!)&reset_token=\(self.resetEncoded)"
////								print(link)
//								self.result.resetPasswordValidity = Date().addingTimeInterval(TimeInterval(self.store.passwdTimeResetValidity))
//								self.result.resetPasswordToken = self.resetEncoded
//								ws.xml = self.result.toXML()
//								ws.id = self.result.idCustomer!
//								print("xml=\(ws.xml!)")
//								ws.edit(completionHandler: { (httpResult) in
									DispatchQueue.main.async {
										let vc = SetPW()
										vc.modalTransitionStyle = .crossDissolve
										vc.modalPresentationStyle = .overCurrentContext
										vc.delegate = self
										self.present(vc, animated: false, completion: {
										})
									}
//								})
							}
							else
							{
								myAlertOnlyDismiss(self, title: R.string.forgotPW, message: R.string.tryAgainLater, dismissAction: {
								}, completion: {
								})
							}
						}
//						else if self.result.resetPasswordToken != nil
//						{
//							DispatchQueue.main.async {
//								let vc = SetPW()
//								vc.modalTransitionStyle = .crossDissolve
//								vc.modalPresentationStyle = .overCurrentContext
//								vc.delegate = self
//								self.present(vc, animated: false, completion: {
//								})
//							}
//						}
					}
					catch let JSONerr
					{
						myAlertOnlyDismiss(self, title: R.string.acc, message: R.string.notAct, dismissAction: {
						}, completion: {
							self.dismiss(animated: false, completion: {
							})
						})
						if self.store.debug > 0
						{
							print(JSONerr.localizedDescription)
						}
					}
				}
			}
		}
		else
		{
			fieldBorder.borderColor = UIColor.red
			fieldInvalid.text = "\(R.string.invalid) \(R.string.emailAddr)"
		}
	}
	
}



extension ForgotPWViewController: SetPWDelegate
{
	func SetPWValue(value: String)
	{
		self.result.passwd = value
		let df = DateFormatter()
		df.dateFormat = "yyyy-MM-dd HH:mm:ss"
		self.result.lastPasswdGen = df.string(from: Date())
		var ws = WebService()
		ws.startURL = R.string.WSbase
		ws.resource = APIResource.customers
		ws.keyAPI = R.string.APIkey
		ws.xml = self.result.toXML(header: XMLHeader(version: 1.0, encoding: "UTF-8"), wrapper: "prestashop", wrapperNS: "xmlns:xlink=\"http://www.w3.org/1999/xlink\"")
		ws.id = self.result.idCustomer!
//		ws.printURL()
		print("httpBody \(ws.xml!)")
		ws.edit { (httpResult) in
			let success = httpResult.success
//		self.store.PostHTTP(url: R.string.forgotPWLink, parameters: ["passwd": value, "confirmation": value, "token": (result.secureKey!), "id_customer": String((result.id!)), "reset_token": self.resetEncoded.isEmpty ? self.resetEncoded : ""], headers: ["Content-Type": "application/x-www-form-urlencoded"], body: nil, save: nil, asJSON: false, completion: { (success) in
		
			if !success //is Bool
			{
				myAlertOnlyDismiss(self, title: R.string.forgotPW, message: R.string.failed)
				if httpResult.error != nil
				{
					print((httpResult.error?.localizedDescription)! + (httpResult.error?.localizedFailureReason)! + httpResult.error.debugDescription)
				}
				else if let data = httpResult.data
				{
					print(String(data: data as Data, encoding: .utf8)!)
				}
			}
			else
			{
				myAlertOnlyDismiss(self, title: R.string.acc, message: String(data: httpResult.data! as Data, encoding: .utf8)!/*(success as! String).description*/, dismissAction: {
				}, completion: {
					print(success)
				})
			}
			//launch my account
		}//)
	}
}
