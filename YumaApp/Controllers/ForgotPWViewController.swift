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
	var resetB64 = ""


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


	override func didReceiveMemoryWarning()
	{
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	
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
//						print(dataString!)
						let innerEnclosed = self.store.trimJSONValueToArray(string: dataString!)
						let inner1 = innerEnclosed.dropLast()
						let inner = inner1.dropFirst()
						let data = inner.data(using: .utf8)!
//						if let regex = try? NSRegularExpression(pattern: "\"id\":\"([^\"]*).*", options: .caseInsensitive)
//						{
//							let string = dataString! as NSString
//							regex.matches(in: dataString!, options: [], range: NSRange(location: 0, length: string.length)).map{
//								string.substring(with: $0.range)
//							})
//						}
						let dataNums = matches(for: "[0-9]", in: dataString!)
//						let data = data as Data
						self.result = try JSONDecoder().decode(Customer.self, from: data)
						self.result.id = Int(dataNums[0])
						self.result.idCustomer = Int(dataNums[0])
						if self.result.active! && !self.result.deleted!
						{
							let now = Date()
							let last: Date = (self.result.lastPasswdGen != now) ? self.result.lastPasswdGen! : Date()// = "1900-06-15 12:00:00"
							let after = (last.addingTimeInterval(TimeInterval(self.store.passwdTimeFront)))
							if after < now
							{
								let df = DateFormatter()
								df.dateFormat = "yyyy-MM-dd HH:mm:ss"
								self.resetStr = df.string(from: Date())/*new__last_passwd_gen*/
								self.resetB64 = self.resetStr/*new__last_passwd_gen*/.toBase64()!
//								ws.edit(completionHandler: { (httpResult) in
//									//
//								})
//								self.store.PutHTTP(url: "", parameters: ["last_passwd_gen" : resetStr], headers: ["" : ""], body: "", completion: { (done) in
//									//
//								})
								//eg. http://yumatechnical.com/en/password-recovery?token=baef23c3484858f93935c13fcebd891f&id_customer=3&reset_token=cb95ebe931744087686a8c4b0f48a5ee24ceb0a7
								let link = "\(R.string.forgotPWLink)?token=\(self.result.secureKey ?? "")&id_customer=\(self.result.idCustomer!)&reset_token=\(self.resetB64)"
								print(link)
								DispatchQueue.main.async {
									let vc = SetPW()
									vc.modalTransitionStyle = .crossDissolve
									vc.modalPresentationStyle = .overCurrentContext
									vc.delegate = self
									self.present(vc, animated: false, completion: {
									})
								}
							}
							else
							{
								myAlertOnlyDismiss(self, title: R.string.forgotPW, message: R.string.tryAgain, dismissAction: {
								}, completion: {
								})
							}
						}
						myAlertOnlyDismiss(self, title: R.string.acc, message: R.string.notAct, dismissAction: {
						}, completion: {
							self.dismiss(animated: false, completion: {
							})
						})
					}
					catch let JSONerr
					{
						if self.store.debug > 0
						{
							print(JSONerr)
						}
						myAlertOnlyDismiss(self, title: R.string.acc, message: R.string.notAct)
//						OperationQueue.main.addOperation
//						{
//							let alert = 					UIAlertController(title: R.string.acc, message: "\(R.string.notAct)", preferredStyle: .alert)
//							let coloredBG = 				UIView()
//							let blurFx = 					UIBlurEffect(style: .dark)
//							let blurFxView = 				UIVisualEffectView(effect: blurFx)
//							alert.titleAttributes = 		[NSAttributedString.StringAttribute(key: .foregroundColor, value: R.color.YumaRed)]
//							alert.messageAttributes = 		[NSAttributedString.StringAttribute(key: .foregroundColor, value: UIColor.darkGray)]
//							alert.view.superview?.backgroundColor = R.color.YumaRed
//							alert.view.shadowColor = 		R.color.YumaDRed
//							alert.view.shadowOffset = 		.zero
//							alert.view.shadowRadius = 		5
//							alert.view.shadowOpacity = 		1
//							alert.view.backgroundColor = 	R.color.YumaYel
//							alert.view.cornerRadius = 		15
//							coloredBG.backgroundColor = 	R.color.YumaRed
//							coloredBG.alpha = 				0.4
//							coloredBG.frame = 				self.view.bounds
//							self.view.addSubview(coloredBG)
//							blurFxView.frame = 				self.view.bounds
//							blurFxView.alpha = 				0.5
//							blurFxView.autoresizingMask = 	[.flexibleWidth, .flexibleHeight]
//							self.view.addSubview(blurFxView)
//							alert.addAction(UIAlertAction(title: R.string.dismiss.uppercased(), style: .default, handler:
//								{ 	(action) in
//									coloredBG.removeFromSuperview()
//									blurFxView.removeFromSuperview()
//									//self.dismiss(animated: false, completion: nil)
//							}))
//							self.present(alert, animated: true, completion:
//							{
//							})
//						}
					}
				}
			}
//			store.callGetCustomerDetails(from: "\(R.string.WSbase)customers?\(R.string.APIfull)&\(R.string.APIjson)&\(R.string.API_key)") { (cust) in
//				print(cust)
//			}
//			store.PostHTTP(url: R.string.forgotPWLink, parameters: ["email": fieldValue.text!], headers: ["Content-Type": "application/x-www-form-urlencoded"], body: nil, save: nil) 	{ 	(link) in
//				self.alertMessage(alerttitle: R.string.login, link as! String)
//			}
//			let send = "\(url)?email=\(fieldValue)"
//			print("getting response for '\(send)'")
//			store.get(from: send, completion:
//				{
//					(customer) in
//				}
//			)
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
		self.store.PostHTTP(url: R.string.forgotPWLink, parameters: ["passwd": value, "confirmation": value, "token": (result.secureKey!), "id_customer": String((result.id!)), "reset_token": self.resetB64.isEmpty ? self.resetB64 : ""], headers: ["Content-Type": "application/x-www-form-urlencoded"], body: nil, save: nil, asJSON: false, completion: { (success) in
			myAlertOnlyDismiss(self, title: R.string.acc, message: (success as! String).description, dismissAction: {
			}, completion: {
				print(success)
			})
			//launch my account
		})
	}
}
