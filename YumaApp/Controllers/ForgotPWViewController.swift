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
		fieldLabel.text = R.string.emailAddr							//set labals for my language
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

		if #available(iOS 11.0, *) {
			navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		} else {
			navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
		}
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
