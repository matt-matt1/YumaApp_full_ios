//
//  TabBarController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-07-25.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


struct TabIcons
{
	let textName: String
	let iconText: String?
	let iconAttr: NSAttributedString?
	let iconImage: UIImage?
	let viewController: UIViewController
	let canClose: Bool
	let closeTarget: Any?
	let closeAction: Selector?
	let canHelp: Bool
	let helpTarget: Any?
	let helpAction: Selector?
}


class TabBarController: UITabBarController
{
	let statusAndNavigationBars: UIView =
	{
		let view = UIView()
		view.backgroundColor = UIColor.gray
		view.frame = UIApplication.shared.statusBarFrame
		return view
	}()
//	let navItem = UINavigationItem(title: "")
//	var navBar: UINavigationBar =
//	{
//		let view = UINavigationBar()
//		view.backgroundColor = R.color.YumaDRed
//		return view
//	}()
	let navTitle: UINavigationItem =
	{
		let view = UINavigationItem()
		return view
	}()
	var navClose: UIBarButtonItem =
	{
		let view = UIBarButtonItem()
		view.image = Awesome.solid.times.asImage(size: 24)
		//view.action = #selector(navCloseAct(_:))
		view.style = UIBarButtonItemStyle.plain
		return view
	}()
	var navHelp: UIBarButtonItem =
	{
		let view = UIBarButtonItem()
		view.image = Awesome.solid.questionCircle.asImage(size: 24)
		view.style = UIBarButtonItemStyle.plain
		return view
	}()
	var array: [TabIcons] = []
	var myClose: UIBarButtonItem!


	// MARK: Overrides:

	override func viewDidLoad()
	{
        super.viewDidLoad()
		
		drawNavigation()
		fillArray()
		decorateTabBar()
		makeTabsFromArray()//makeTabs()
    }

    override func didReceiveMemoryWarning()
	{
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	@objc func navCloseAct(_ sender: UITapGestureRecognizer)
	{
		//
	}


	// MARK: Methods

	func imageFromLayer(_ layer: CALayer) -> UIImage?
	{
		var gradientImage: UIImage?
		UIGraphicsBeginImageContext(layer.frame.size)
		if let context = UIGraphicsGetCurrentContext()
		{
			layer.render(in: context)
			gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: UIImageResizingMode.stretch)
		}
		UIGraphicsEndImageContext()
		return gradientImage
	}

	func fillArray()
	{
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		let AboutVC = WebpageViewController()
		AboutVC.pageTitle = R.string.about
		AboutVC.pageURL = R.string.aboutweb
		let french = WebpageViewController()
		french.pageTitle = R.string.qc
		french.pageURL = R.string.qcweb
		array = [
			TabIcons(textName: "Contact Us", iconText: nil, iconAttr: nil, iconImage: Awesome.solid.phone.asImage(size: 30), viewController: ContactUsViewController(), canClose: false, closeTarget: nil, closeAction: nil, canHelp: true, helpTarget: ContactUsViewController.self, helpAction: #selector(ContactUsViewController.navHelpAct(_:))),
			TabIcons(textName: "Home", iconText: nil, iconAttr: nil, iconImage: Awesome.solid.home.asImage(size: 30), viewController: SwipingController(collectionViewLayout: layout), canClose: false, closeTarget: nil, closeAction: nil, canHelp: false, helpTarget: nil, helpAction: nil),
			TabIcons(textName: "Login", iconText: nil, iconAttr: nil, iconImage: Awesome.solid.userCircle.asImage(size: 30), viewController: LoginViewController(), canClose: false, closeTarget: nil, closeAction: nil, canHelp: true, helpTarget: LoginViewController.self, helpAction: #selector(LoginViewController.helpBtnAct(_:))),
			TabIcons(textName: "Cart", iconText: nil, iconAttr: nil, iconImage: Awesome.solid.shoppingCart.asImage(size: 30), viewController: CartViewController(), canClose: false, closeTarget: nil, closeAction: nil, canHelp: true, helpTarget: CartViewController.self, helpAction: #selector(CartViewController.navHelpAct(_:))),
			TabIcons(textName: "About Us", iconText: nil, iconAttr: Awesome.solid.certificate.asAttributedText(fontSize: 30), iconImage: Awesome.solid.certificate.asImage(size: 30), viewController: AboutVC/*WebpageViewController()*/, canClose: false, closeTarget: nil, closeAction: nil, canHelp: false, helpTarget: nil, helpAction: nil),
			TabIcons(textName: "Printers", iconText: nil, iconAttr: nil, iconImage: Awesome.solid.print.asImage(size: 30), viewController: ProductsViewController(), canClose: false, closeTarget: nil, closeAction: nil, canHelp: true, helpTarget: ProductsViewController.self, helpAction: #selector(ProductsViewController.navHelpAct(_:))),
			TabIcons(textName: "Cartridges", iconText: nil, iconAttr: nil, iconImage: Awesome.solid.cubes.asImage(size: 30), viewController: ProductsViewController(), canClose: false, closeTarget: nil, closeAction: nil, canHelp: true, helpTarget: ProductsViewController.self, helpAction: #selector(ProductsViewController.navHelpAct(_:))),
			TabIcons(textName: "French-Canadian", iconText: nil, iconAttr: nil, iconImage: Awesome.solid.flag.asImage(size: 30), viewController: french, canClose: false, closeTarget: nil, closeAction: nil, canHelp: false, helpTarget: nil, helpAction: nil),
			TabIcons(textName: "Laptops", iconText: nil, iconAttr: nil, iconImage: Awesome.solid.laptop.asImage(size: 30), viewController: ProductsViewController(), canClose: false, closeTarget: nil, closeAction: nil, canHelp: true, helpTarget: ProductsViewController.self, helpAction: #selector(ProductsViewController.navHelpAct(_:)))]
	}

	fileprivate func drawNavigation()
	{
		//		let home = SwipingController()
		//		home.title = "Home"
		//		home.tabBarItem.image = Awesome.solid.home.asImage(size: 30)

		let navigationBar = UINavigationBar()//UIView()
		//		navigationBar.backgroundColor = R.color.YumaRed
		//		navigationBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
		let gradient = CAGradientLayer()
		//		var bounds = navigationBar.bounds
		//		bounds.size.height += UIApplication.shared.statusBarFrame.size.height
		//		gradient.frame = bounds
		if #available(iOS 11.0, *)
		{
			gradient.frame = CGRect(x: 0, y: view.safeAreaLayoutGuide.layoutFrame.origin.y, width: view.frame.width, height: 44)
		}
		else
		{
			gradient.frame = CGRect(x: 0, y: 44, width: view.frame.width, height: 44)
		}
		gradient.colors = [R.color.YumaDRed.cgColor, R.color.YumaRed.cgColor]
		gradient.startPoint = CGPoint(x: 0, y: 0)
		gradient.endPoint = CGPoint(x: 0, y: 1)
		if let image = imageFromLayer(gradient)
		{
			//			navigationBar.navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
			navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
		}
		//		navigationBar.isTranslucent = false
		//		navigationBar.navigationBar.shadowColor = UIColor.darkGray
		//		navigationBar.navigationBar.shadowOffset = CGSize(width: 0, height: 2)
		//		navigationBar.navigationBar.shadowRadius = 2
		//		navigationBar.navigationBar.shadowOpacity = 1
		navigationBar.shadowColor = UIColor.darkGray
		navigationBar.shadowOffset = CGSize(width: 0, height: 2)
		navigationBar.shadowRadius = 3
		navigationBar.shadowOpacity = 1
//		navigationBar.items = [UINavigationItem(title: "Title")]
		
		//		navigationBar.backItem = navClose
		//		navigationBar.topItem?.backBarButtonItem = navClose
//		let navItem = UINavigationItem(title: "")
//		navClose.action = #selector(ContactUsViewController.dismiss(animated:completion:))
		navHelp.action = #selector(ContactUsViewController.navHelpAct(_:))
		myClose = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.stop, target: ContactUsViewController.self, action: nil)
//		navigationBar.topItem?.rightBarButtonItems = [navHelp]
		navTitle.rightBarButtonItems = [navHelp]
		navTitle.leftBarButtonItems = [myClose]
		navigationBar.setItems([navTitle], animated: false)
		//		navigationBar.navigationItem.title = "AbC"
		navigationBar.translatesAutoresizingMaskIntoConstraints = false
		//		view.addSubview(navigationBar.navigationBar)
		view.addSubview(navigationBar)
		NSLayoutConstraint.activate([
			navigationBar.topAnchor.constraint(equalTo: view.safeTopAnchor),
			navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//			navigationBar.heightAnchor.constraint(equalTo: view, multiplier: 1)
			navigationBar.heightAnchor.constraint(equalToConstant: (view.frame.height>2000) ? 44 : 20)
			])
//		let statusAndNavigationBars = UIView()
//		statusAndNavigationBars.backgroundColor = UIColor.gray
//		statusAndNavigationBars.frame = UIApplication.shared.statusBarFrame
		//		statusAndNavigationBars.translatesAutoresizingMaskIntoConstraints = false
		if UIDevice.current.orientation == UIDeviceOrientation.portrait || UIDevice.current.orientation == .portraitUpsideDown
		{
			view.insertSubview(statusAndNavigationBars, at: 0)
		}
		//.addSubview(statusAndNavigationBars)
		//		NSLayoutConstraint.activate([
		//			statusAndNavigationBars.topAnchor.constraint(equalTo: view.topAnchor),
		//			statusAndNavigationBars.leadingAnchor.constraint(equalTo: view.leadingAnchor),
		//			statusAndNavigationBars.bottomAnchor.constraint(equalTo: navigationBar)
		//			])
		
		//UINavigationBar.appearance()..navigationBar.applyNavigationGradient(colors: [UIColor.red , UIColor.yellow])
	}

	override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator)
	{
		super.willTransition(to: newCollection, with: coordinator)
		if UIDevice.current.orientation.isLandscape
		{
			//print("Landscape")
			statusAndNavigationBars.removeFromSuperview()
		}
		else
		{
			//print("Portrait")
			view.insertSubview(statusAndNavigationBars, at: 0)
		}
	}

	fileprivate func decorateTabBar()
	{
		tabBar.barTintColor = R.color.YumaYel
		tabBar.tintColor = R.color.YumaRed
		tabBar.shadowColor = UIColor.darkGray
		tabBar.shadowOffset = .zero
		tabBar.shadowRadius = 5
		tabBar.shadowOpacity = 0.75
	}

	override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem)
	{
		navTitle.leftBarButtonItems = nil
		navTitle.rightBarButtonItems = nil
		navTitle.title = item.title
//		if tab.canClose
//		{
//			let leftNavBtn = UIBarButtonItem(barButtonSystemItem: .stop, target: tab.closeTarget, action: tab.closeAction)
//			navTitle.leftBarButtonItems = [leftNavBtn]
//		}
//		if tab.canHelp
//		{
//			navHelp.action = tab.helpAction
//			navHelp.target = tab.helpTarget as AnyObject
//			navTitle.rightBarButtonItems = [navHelp]
//		}
	}

	func makeTabsFromArray()
	{
		for tab in array
		{
			let navContainer = UINavigationController(rootViewController: tab.viewController)
			navContainer.title = tab.textName
//			navigationItem.title = tab.textName
			navContainer.navigationItem.title = /*.navigationBar*//*.items?.insert(UINavigationItem(title: tab.textName), at: 1)*//*.topItem?.title =*/ tab.textName
			if tab.iconImage != nil
			{
				navContainer.tabBarItem.image = tab.iconImage
			}
//			else if tab.iconAttr != nil
//			{
//				navContainer.tabBarItem.setTitleTextAttributes(tab.iconAttr, for: UIControlState.normal) = tab.iconText
//			}
			else if tab.iconText != nil
			{
				navContainer.tabBarItem.title = tab.iconText
			}
			if viewControllers == nil
			{
				viewControllers = [navContainer]
			}
			else
			{
				viewControllers!.append(navContainer)
			}
		}
		navTitle.title = array[0].textName
	}

	fileprivate func makeTabs()	// not used
	{
		let aboutVC = WebpageViewController()
		aboutVC.pageURL = R.string.aboutweb
		aboutVC.pageTitle = R.string.about
		//		aboutVC.title = "AboutUs"
		//		aboutVC.tabBarItem.image = Awesome.solid.certificate.asImage(size: 30)
		let navAbout = UINavigationController(rootViewController: aboutVC)
		navAbout.title = R.string.about
		navAbout.tabBarItem.image = Awesome.solid.certificate.asImage(size: 30)
		//		navAbout.navigationBar.topItem?.title = "Resources"
		//		navAbout.navigationBar.setItems([navTitle], animated: false)
		//		navAbout.navigationBar.tintColor = UIColor.white
		//		navAbout.navigationBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
		navClose = UIBarButtonItem(barButtonSystemItem: .stop, target: nil, action: #selector(navCloseAct(_:)))
		navAbout.navigationItem.leftBarButtonItems = [navClose]
		//		navTitle.leftBarButtonItems = [navClose]
		navAbout.navigationItem.rightBarButtonItems = [navHelp]
		
		let contactVC = ContactUsViewController()
		//		childVC.tabBarItem.image = Awesome.regular.addressBook.asImage(size: 30)
		//		childVC.title = "Contact Us"
		let navContact = UINavigationController(rootViewController: contactVC)
		navContact.navigationItem.title = R.string.contact
		navContact.title = R.string.contact//"Contact Us"
		navContact.tabBarItem.image = Awesome.regular.addressBook.asImage(size: 30)
		
		//		let menuVC = slideMenu()
		//		let menuNav = UINavigationController(rootViewController: menuVC)
		
		//		let maNav = UINavigationController(rootViewController: MyAccountViewController())
		//		maNav.title = "Login"
		//		maNav.tabBarItem.image = Awesome.regular.userCircle.asImage(size: 23)
		
		viewControllers = [navContact, navAbout]
		//		viewControllers = [/*home,*/ aboutVC, childVC]
	}

}
