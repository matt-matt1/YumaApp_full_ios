//
//  AppDelegate.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-01-29.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
	var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
	{
		window = UIWindow(frame: UIScreen.main.bounds)
		//window = UIWindow()
		window?.makeKeyAndVisible()

//		let layout = UICollectionViewFlowLayout()
//		layout.scrollDirection = .horizontal
//		//let collection = CollectionViewController(collectionViewLayout: layout)
//		let collection = SwipingController(collectionViewLayout: layout)
//		//let collection = UINavigationController(rootViewController: CheckoutCollection(collectionViewLayout: layout))
//		window?.rootViewController = collection

//		let vc = SQLiteViewController()
		let vc = TestSQliteViewController()
		window?.rootViewController = vc
		
//		if let statusbar = UIApplication.shared.value(forKey: "statusBar") as? UIView
//		{
//			statusbar.backgroundColor = UIColor.lightGray
//		}

//		let myView = UIViewController()
//		myView.view.backgroundColor = .purple
//		window?.rootViewController = myView
		
		let shadow = NSShadow()
		shadow.shadowColor = R.color.YumaDRed
		shadow.shadowOffset = CGSize(width: 1, height: 1)
		shadow.shadowBlurRadius = 3
		let navBarAppearance = UINavigationBar.appearance()
		navBarAppearance.tintColor = UIColor.white
//		navBarAppearance.barTintColor = UIColor.lightGray//R.color.YumaRed
		navBarAppearance.titleTextAttributes = [NSAttributedStringKey.foregroundColor : R.color.YumaYel,
												NSAttributedStringKey.shadow : shadow]
		navBarAppearance.shadowImage = UIImage()
		navBarAppearance.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
		//UIBarButtonItem.appearance().setTitleTextAttributes([
		//	NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 30)
		//	], for: .normal)

		UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
		
//		let statusBarBackground = UIView()
//		statusBarBackground.backgroundColor = UIColor.gray//UIColor(red: 194/255, green: 31/255, blue: 31/255, alpha: 1)
//		window?.addSubview(statusBarBackground)
//		window?.addConstraintsWithFormat(format: "H:|[v0]|", views: statusBarBackground)
//		window?.addConstraintsWithFormat(format: "V:|[v0(20)]", views: statusBarBackground)
		return true
	}
	
	func applicationDidReceiveMemoryWarning(_ application: UIApplication)
	{
		print("applicationDidReceiveMemoryWarning")
		let store = DataStore.sharedInstance
		store.addresses.removeAll()
		store.carriers.removeAll()
		store.carts.removeAll()
		//store.customer
		store.countries.removeAll()
		store.categories.removeAll()
		store.categories.removeAll()
		store.currencies.removeAll()
		store.combinations.removeAll()
		store.configurations.removeAll()
		store.customerMessages.removeAll()
		store.customerThreads.removeAll()
		store.langs.removeAll()
		store.locale.removeAll()
		store.laptops.removeAll()
		store.manufacturers.removeAll()
		store.myCart.removeAll()
		//store.myOrder
		store.myOrderRows.removeAll()
		store.orderCarriers.removeAll()
		store.orders.removeAll()
		store.orderStates.removeAll()
		store.orderDetails.removeAll()
		store.orderHistories.removeAll()
		store.productOptions.removeAll()
		store.printers.removeAll()
		store.products.removeAll()
		store.properties.removeAll()
		store.productOptionValues.removeAll()
		store.services.removeAll()
		store.shares.removeAll()
		store.states.removeAll()
		store.storeContacts.removeAll()
		store.tags.removeAll()
		store.taxes.removeAll()
		store.toners.removeAll()
	}

	func applicationWillResignActive(_ application: UIApplication)
	{
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(_ application: UIApplication)
	{
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(_ application: UIApplication)
	{
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(_ application: UIApplication)
	{
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(_ application: UIApplication)
	{
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}

}

