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
	@IBOutlet weak var emailLabel: UILabel!
	@IBOutlet weak var passwordLabel: UILabel!
	@IBOutlet weak var rememberLabel: UILabel!
	@IBOutlet weak var forgotBtn: UIButton!
	@IBOutlet weak var createBtn: UIButton!
	@IBOutlet var usernameTextField: UITextField!
	@IBOutlet var passwordTextField: UITextField!
	var loginDictionary : NSDictionary?

	
	//MARK: Overrides
	override func viewDidLoad()
	{
		super.viewDidLoad()
		emailLabel.text = R.string.emailAddr
		passwordLabel.text = R.string.txtPass
		rememberLabel.text = R.string.remember
		//forgotBtn.titleLabel = R.string.forgotPW
		//createBtn.titleLabel = R.string.createAcc
		
	}
	
	override func didReceiveMemoryWarning()
	{
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	
	//MARK: Actions
	@IBAction func loginButtonClicked(_ sender: Any)
	{
		let sv = UIViewController.displaySpinner(onView: self.view)
		//WebServices.userLogin(userName: usernameTextField.text!, password: passwordTextField.text!, userType: usertypeStr) {(result, message, status) in
		WebServices.myLogin(userName: usernameTextField.text!, password: passwordTextField.text!) {(result, message, status) in
			if status
			{
				let loginDetails = result as? WebServices
				self.loginDictionary = loginDetails?.loginData
//				let status = self.loginDictionary?["status"] as? String
				if self.loginDictionary?["deleted"] as? Bool == true
				{
					self.alertMessage(alerttitle: R.string.acc, R.string.deld)
				}
				else if self.loginDictionary?["active"] as? Bool == false
				{
					self.alertMessage(alerttitle: R.string.acc, R.string.notAct)
				}
				else
				{
					// login correct
//					WebServices.getAddresses(id_customer: (self.loginDictionary?["id_customer"] as? Int)!) {(result, message, status) in
//						if status
//						{
//							let loginDetails = result as? WebServices
//						}
					self.alertMessage(alerttitle: R.string.acc, R.string.submitLogin)
				}
			}
			else
			{
				self.alertMessage(alerttitle: R.string.acc, R.string.err)
			}
		}
		UIViewController.removeSpinner(spinner: sv)
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
