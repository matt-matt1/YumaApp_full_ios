//
//  CheckoutStep1ViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-02.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class CheckoutStep1ViewController: UIViewController
{
	@IBOutlet weak var loginBtn: UIButton!
	@IBOutlet weak var orLabel: UILabel!
	@IBOutlet weak var withoutLabel: UILabel!
	@IBOutlet weak var signoutBtn: UIButton!
	@IBOutlet weak var loggedAsLabel: UILabel!
	@IBOutlet weak var withoutSwitch: UISwitch!
	let store = DataStore.sharedInstance
	

	override func viewDidLoad()
	{
        super.viewDidLoad()

        loginBtn.setTitle(R.string.login, for: .normal)
		//orLabel.text = R.string.or
		//withoutLabel.text = R.string.without
		withoutSwitch.tintColor = R.color.YumaRed
		signoutBtn.setTitle(R.string.SignOut, for: .normal)
		//loggedAsLabel.text = /*R.string.loggedInAs*/"Logged-in as" + " " + store.customer?.firstname + " " + store.customer?.lastname
    }

    override func didReceiveMemoryWarning() {
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

	@IBAction func loginBtnAct(_ sender: Any)
	{
		let sender = sender as! UIButton
		store.flexView(view: sender)
		sender.backgroundColor = R.color.YumaRed
		let spin = UIViewController.displaySpinner(onView: self.view)
		//		UIView.animate(withDuration: 1, animations:
		//			{
		//				sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		//		})
		self.present(LoginViewController(), animated: false, completion: (() -> Void)?
			{
				UIViewController.removeSpinner(spinner: spin)
				//				sender.view?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
				//				sender.view?.backgroundColor = UIColor.white
			})
	}
	@IBAction func withoutSwitchAct(_ sender: Any)
	{
	}
	@IBAction func signoutBtnAct(_ sender: Any)
	{
//		store.flexView(view: self.signOutBtn)
		store.flexView(view: self.signoutBtn)
		self.store.logout(self, presentingViewController: self.presentingViewController)
		//store.customer = nil
		//store.addresses = []
		//UserDefaults.standard.removeObject(forKey: "Customer")
//		OperationQueue.main.addOperation
//			{
//				weak var presentingViewController = self.presentingViewController
//				self.dismiss(animated: false, completion: {
//					presentingViewController?.present(LoginViewController(), animated: false, completion: nil)
//				})
//		}
	}
}
