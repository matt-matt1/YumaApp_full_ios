//
//  ForgotPWViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-19.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class ForgotPWViewController: UIViewController
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
		fieldLabel.text = R.string.forgotPW							//set labals for my language
		button.setTitle(R.string.proceed.uppercased(), for: .normal)
		//closeBtn.
		//helpBtn.
		button.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		fieldBorder.layer.borderColor = UIColor.white.cgColor	//clear errors
		fieldInvalid.text = ""
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

	
	override func viewDidLoad()
	{
        super.viewDidLoad()

        configureView()
    }

    override func didReceiveMemoryWarning()
	{
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
	
	@IBAction func navCloseAct(_ sender: Any)
	{
		self.dismiss(animated: false, completion: nil)
	}
	@IBAction func navHelpAct(_ sender: Any)
	{
	}
	@IBAction func buttonAct(_ sender: Any)
	{
		if isValidEmail(fieldValue.text!)
		{
			let send = "\(url)?email=\(fieldValue)"
			print("getting response for '\(send)'")
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
