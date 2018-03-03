//
//  SwipingControllerTaps.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-01.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


extension SwipingController
{
	@objc func loginTapped(_ sender: UITapGestureRecognizer)
	{
		sender.view?.backgroundColor = R.color.YumaRed
		UIView.animate(withDuration: 1, animations:
			{
				sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		})
		self.present(LoginViewController(), animated: false, completion: (() -> Void)?
			{
				sender.view?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
				sender.view?.backgroundColor = UIColor.white
			})
	}
	
	@objc func cartTapped(_ sender: UITapGestureRecognizer)
	{
		sender.view?.backgroundColor = R.color.YumaRed
		UIView.animate(withDuration: 1, animations:
			{
				sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		})//CartContentsViewController
		//SwipingController
		//MyAccAddrViewController
		//		let sb = UIStoryboard(name: "CartStoryboard", bundle: nil)
		//		let vc = sb.instantiateViewController(withIdentifier: "VC") as UIViewController
		//let layout = UICollectionViewFlowLayout()
		//CartViewController
//		let sb = UIStoryboard(name: "CartStoryboard", bundle: nil)
//		let vc = sb.instantiateInitialViewController()/*withIdentifier: "CartViewController")*/ as UIViewController!
		let vc = UIStoryboard(name: "CartStoryboard", bundle: nil).instantiateInitialViewController() as UIViewController!
		self.present(vc!, animated: false, completion: (() -> Void)?
			{
				sender.view?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
				sender.view?.backgroundColor = UIColor.white
			})
		//		self.present(ContactUsViewController(), animated: true, completion: nil)
	}

	@objc func enTapped(_ sender: UITapGestureRecognizer)
	{
		sender.view?.backgroundColor = R.color.YumaRed
		UIView.animate(withDuration: 1, animations:
			{
				sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		})
		let vc = WebpageViewController()
		vc.pageURL = R.string.enweb
		vc.pageTitle = R.string.en
		self.present(vc, animated: false, completion: (() -> Void)?
			{
				sender.view?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
				sender.view?.backgroundColor = UIColor.white
			})
	}

	@objc func aboutTapped(_ sender: UITapGestureRecognizer)
	{
		sender.view?.backgroundColor = R.color.YumaRed
		UIView.animate(withDuration: 1, animations:
			{
				sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		})
		let vc = WebpageViewController()
		vc.pageURL = R.string.aboutweb
		vc.pageTitle = R.string.about
		self.present(vc, animated: false, completion: (() -> Void)?
			{
				sender.view?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
				sender.view?.backgroundColor = UIColor.white
			})
	}

	@objc func qcTapped(_ sender: UITapGestureRecognizer)
	{
		sender.view?.backgroundColor = R.color.YumaRed
		UIView.animate(withDuration: 1, animations:
			{
				sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		})
		let vc = WebpageViewController()
		vc.pageURL = R.string.qcweb
		vc.pageTitle = R.string.qc
		self.present(vc, animated: false, completion: (() -> Void)?
			{
				sender.view?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
				sender.view?.backgroundColor = UIColor.white
			})
	}

	@objc func contactTapped(_ sender: UITapGestureRecognizer)
	{
		sender.view?.backgroundColor = R.color.YumaRed
		UIView.animate(withDuration: 1, animations:
			{
				sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		})
		self.present(ContactUsViewController(), animated: false, completion: (() -> Void)?
			{
				sender.view?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
				sender.view?.backgroundColor = UIColor.white
			})
	}

	@objc func printTapped(_ sender: UITapGestureRecognizer)
	{
		sender.view?.backgroundColor = R.color.YumaRed
		UIView.animate(withDuration: 1, animations:
			{
				sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		})
		self.present(PrintersViewController(), animated: false, completion: (() -> Void)?
			{
				sender.view?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
				sender.view?.backgroundColor = UIColor.white
			})
	}

	@objc func laptopTapped(_ sender: UITapGestureRecognizer)
	{
		sender.view?.backgroundColor = R.color.YumaRed
		UIView.animate(withDuration: 1, animations:
			{
				sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		})
		self.present(LaptopsViewController(), animated: false, completion: (() -> Void)?
			{
				sender.view?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
				sender.view?.backgroundColor = UIColor.white
			})
	}

	@objc func servicesTapped(_ sender: UITapGestureRecognizer)
	{
		sender.view?.backgroundColor = R.color.YumaRed
		UIView.animate(withDuration: 1, animations:
			{
				sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		})
		//		self.present(ViewController(), animated: false, completion: (() -> Void)?
		//			{
		sender.view?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
		sender.view?.backgroundColor = UIColor.white
		//			})
	}

	@objc func tonersTapped(_ sender: UITapGestureRecognizer)
	{
		sender.view?.backgroundColor = R.color.YumaRed
		UIView.animate(withDuration: 1, animations:
			{
				sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		})
		//		self.present(ViewController(), animated: false, completion: (() -> Void)?
		//			{
		sender.view?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
		sender.view?.backgroundColor = UIColor.white
		//			})
	}

}

