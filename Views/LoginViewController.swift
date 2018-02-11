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
	var loginDictionary: NSDictionary?
	var addrDictionary: NSDictionary?
	var passwordVisible: Bool = false

	
//MARK: Overrides
	override func viewDidLoad()
	{
		super.viewDidLoad()
		emailLabel.text = R.string.emailAddr
		passwordLabel.text = R.string.txtPass
		rememberLabel.text = R.string.remember
		forgotBtn.setTitle(R.string.forgotPW, for: .normal)
		createBtn.setTitle(R.string.createAcc, for: .normal)
		//closeBtn.
		//helpBtn.
		loginBtn.setTitle(R.string.login, for: UIControlState.normal)
//		loginBtn.
		showPass.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showPassAct(_:))))
		
		//if logged in
//		let customer = UserDefaults.standard.object(forKey: "customer")
//		print(customer!)
		//if customer["id_customer"] > -1
		//display my account
		//if logged.json exists
		var docURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last
		docURL = docURL?.appendingPathComponent("logged.json")
		//read file
		//display my account
	}
	
	override func viewWillAppear(_ animated: Bool)
	{
		window.layer.shadowOffset = CGSize(width: 1, height: 1)
		window.layer.shadowColor = R.color.YumaDRed.cgColor
		window.layer.shadowRadius = 15
		window.clipsToBounds = true
		window.layer.masksToBounds = false
		self.view.layer.masksToBounds = false
	}
	
	override func didReceiveMemoryWarning()
	{
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	
//MARK: Actions
	@IBAction func remeberSwitchAct(_ sender: Any) {
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
		let sv = UIViewController.displaySpinner(onView: self.view)
		WebServices.myLogin(userName: usernameTextField.text!, password: passwordTextField.text!)
		{
			(result, message, status) in
			if status
			{
				let loginDetails = result as? WebServices
				self.loginDictionary = loginDetails?.loginData
				if self.loginDictionary?["deleted"] as? Bool == true
				{
					UIViewController.removeSpinner(spinner: sv)
					self.alertMessage(alerttitle: R.string.acc, R.string.deld)
				}
				else if self.loginDictionary?["active"] as? Bool == false
				{
					UIViewController.removeSpinner(spinner: sv)
					self.alertMessage(alerttitle: R.string.acc, R.string.notAct)
				}
				else
				{
					if self.rememberSwitch.isOn
					{
						//write json string to file
						UserDefaults.standard.set(self.loginDictionary, forKey: "customer")

						var docURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last
						docURL = docURL?.appendingPathComponent("logged.json")
						UIViewController.removeSpinner(spinner: sv)
//						try self.loginDictionary?.write(to: docURL, atomically: true)
////						do
////						{
////							try self.loginDictionary?.write(toFile: "logged.json", atomically: true)
////						}
////						catch let error as NSError
////						{
////							print("error trying to write to logged.json : \(error)")
////						}
					}
					let sv2 = UIViewController.displaySpinner(onView: self.view)
					let id: Int = Int((self.loginDictionary?["id_customer"] as? String!)!)!
					WebServices.getAddresses(id_customer: id) {(result, message, status) in
						if status
						{
							let addrDetails = result as? WebServices
							self.addrDictionary = addrDetails?.addrData
							UIViewController.removeSpinner(spinner: sv2)
							if self.addrDictionary != nil
							{
								print(self.addrDictionary!)
							}
						}
						self.alertMessage(alerttitle: R.string.Addr, (status) ? "true" : "false")
					}
				}
			}
			else
			{
				self.alertMessage(alerttitle: R.string.acc, R.string.err)
			}
		}
	}
	@IBAction func forgotBtnAct(_ sender: Any)
	{
		//load VC
	}
	@IBAction func createBtnAct(_ sender: Any)
	{
		//load VC
	}

	
//MARK: Methods
	func alertMessage(alerttitle: String, _ message: String)
	{
		let alertViewController = UIAlertController(title: alerttitle, message: message, preferredStyle: .alert)
		alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		present(alertViewController, animated: true, completion: nil)
	}

}
