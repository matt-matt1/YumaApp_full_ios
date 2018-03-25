//
//  SwipingController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-24.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout
{
	//EXTENSION FILES:
		//SwipingControllerCollection
		//SwipingControllerTaps
	
	//MARK: Properties
	var cellId = "cellID"
	let pageContent: [Slide] = [
		Slide(id: 1, image: "home-slider-printers", caption1: "Laser Printers", caption2: "", target: #selector(printTapped(_:))),
		Slide(id: 1, image: "home-slider-cartridges", caption1: "Toner Cartridges", caption2: "that last", target: #selector(tonersTapped(_:))),
		Slide(id: 1, image: "home-slider-laptops", caption1: "Laptop Computers", caption2: "", target: #selector(laptopTapped(_:)))
	]
	let store = DataStore.sharedInstance
	let prevBtn: UIButton =
	{
		let button = UIButton(type: .system)
		button.setTitle("PREV", for: .normal)
		button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
		return button
	}()
	let nextBtn: UIButton =
	{
		let button = UIButton(type: .system)
		button.setTitle("NEXT", for: .normal)
		button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
		return button
	}()
	lazy var pageControl: UIPageControl =
	{
		let pc = UIPageControl()
		pc.numberOfPages = pageContent.count
		pc.currentPage = 0
		pc.currentPageIndicatorTintColor = R.color.YumaRed
		pc.pageIndicatorTintColor = R.color.YumaYel
		return pc
	}()
	
	
	//MARK: Methods
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		self.view.backgroundColor = UIColor.white

		drawLayout()

		collectionView?.backgroundColor = UIColor.white
		collectionView?.register(PageCell.self, forCellWithReuseIdentifier: cellId)
		collectionView?.isPagingEnabled = true
		collectionView?.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true

		if Reachability.isConnectedToNetwork()
		{
			store.callGetCountries { (countries) in
				print("got \((countries as! [Country]).count) countries")
			}
			store.callGetStates(id_country: 0) { (states) in
				print("got \((states as! [CountryState]).count) states")
			}
			store.callGetCarriers { (carriers, err) in
				if err == nil
				{
					print("got \((carriers as [Carrier]!).count) carriers")
				}
				else
				{
					print("\(R.string.err) \(err?.localizedDescription ?? err.debugDescription)")
				}
			}
			store.getOrderStates { (os, err) in	//a pair of errors
				if err == nil
				{
					let array = (os as! OrderStates).order_states
					print("got \(array?.count ?? 0) order states")
				}
				else
				{
					print("Error getting order states: \(String(describing: err))")
				}
			}
			store.callGetLanguages { (lang, err) in
				if err == nil
				{
					print("got \((lang as! [Language]).count) languages")
				}
				else
				{
					print("\(R.string.err) \(err?.localizedDescription ?? err.debugDescription)")
				}
			}
			store.callGetManufacturers { (manus, err) in
				if err == nil
				{
					print("got \((manus as! [Manufacturer]).count) manufacturers")
				}
				else
				{
					print("\(R.string.err) \(err?.localizedDescription ?? err.debugDescription)")
				}
			}
			store.callGetCategories { (cats, err) in
				if err == nil
				{
					print("got \((cats as! [aCategory]).count) categories")
				}
				else
				{
					print("\(R.string.err) \(err?.localizedDescription ?? err.debugDescription)")
				}
			}
			store.callGetCombinations { (combs, err) in
				if err == nil
				{
					print("got \((combs as! [Combination]).count) combinations")
				}
				else
				{
					print("\(R.string.err) \(err?.localizedDescription ?? err.debugDescription)")
				}
			}
			Alert(self, title: "Hello there!! 👋🏻👋🏻", message: "message", shadowColor: R.color.YumaDRed)
			store.callGetProductOptions { (opts, err) in
				if err == nil
				{
					print("got \((opts as! [ProductOption]).count) product options")
				}
				else
				{
					print("\(R.string.err) \(err?.localizedDescription ?? err.debugDescription)")
				}
			}
			store.callGetCurrencies { (currs, err) in
				if err == nil
				{
					print("got \((currs as! [Currency]).count) currencies")
				}
				else
				{
					print("\(R.string.err) \(err?.localizedDescription ?? err.debugDescription)")
				}
			}
			let myClient = MyClient()
//			myClient.getREST(from: , completion: { (<#Result<Address?, APIError>#>) in
//				<#code#>
//			})
			myClient.getREST(from: .addresses(filters: [
				Addresses_filter.idCustomer : "3",
				Addresses_filter.idCountry : "4",
				//Addresses_filter.idManufacturer : "0",
				]), completion: { (addr) in
				//
			})
//			myClient.getREST(from: .addresses(nil, nil), completion: { (addr) in
//				//
//			})
			//let str = collect.addresses(addresses_filter.idCustomer, "3")
			//print("\(str)")
			store.callGetTaxes { (taxes, err) in
				if err == nil
				{
					print("got \((taxes as [Tax]!).count) taxes")
				}
				else
				{
					print("\(R.string.err) \(err?.localizedDescription ?? err.debugDescription)")
				}
			}
			store.callGetTags { (tags, err) in
				if err == nil
				{
					print("got \((tags as [myTag]!).count) tags")
				}
				else
				{
					print("\(R.string.err) \(err?.localizedDescription ?? err.debugDescription)")
				}
			}
			store.callGetProductOptionValues{ (opts, err) in
				if err == nil
				{
					print("got \((opts as [ProductOptionValue]!).count) product option values")
				}
				else
				{
					print("\(R.string.err) \(err?.localizedDescription ?? err.debugDescription)")
				}
			}
		}
		Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(handleCycle), userInfo: nil, repeats: true)
	}
	
	
	func Alert(_ fromView: 			UIViewController,
			   title: 				String,
			   titleColor: 			UIColor? = 		.black,
			   titleFont: 			UIFont? = 		UIFont(name: "AlNile-Bold", size: 16),//.boldSystemFont(ofSize: 16),
			   message: 			String,
			   messageColor: 		UIColor? = 		.darkGray,
			   messageFont: 		UIFont? = 		UIFont(name: "AvenirNext-Regular", size: 15),//.systemFont(ofSize: 14),
			   backgroundColor: 	UIColor? = 		.white,
			   borderColor: 		UIColor? = 		.clear,
			   borderWidth: 		CGFloat? = 		0,
			   buttonColor: 		UIColor? = 		UIColor(red: 0.1520819664, green: 0.5279997587, blue: 0.985317409, alpha: 1),
			   cornerRadius: 		CGFloat? = 		10,
			   shadowColor: 		UIColor? = 		.black,
			   shadowOffset: 		CGSize? = 		.zero,
			   shadowOpacity: 		Float? = 		1,
			   shadowRadius: 		CGFloat? = 		8,
			   alpha: 				CGFloat? = 		1,
			   hasOKButton: 		Bool = 			true,
			   OKButtonTitle: 		String? = 		"OK",
			   OKButtonFont: 		UIFont? = 		UIFont(name: "AvenirNext-Regular", size: 16),
			   OKAction: 			(() -> Void)? = nil,
			   hasCancelButton: 	Bool = 			false,
			   cancelButtonTitle: 	String? = 		"Cancel")
	{
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

		//var titleAttr: NSMutableAttributedString
		var titleAttr: [NSAttributedStringKey : Any?] = [:]
		if titleFont != nil
		{
			//titleAttr.addAttribute(.font, value: titleFont!, range: NSRange.init(location: 0, length: title.count))
			titleAttr.updateValue(titleFont, forKey: .font)// [NSAttributedStringKey.font : titleFont]
		}
		if titleColor != nil
		{
//			titleAttr.addAttribute(.foregroundColor, value: titleColor!, range: NSRange.init(location: 0, length: title.count))
			titleAttr.updateValue(titleColor, forKey: .foregroundColor)
		}
		let titleString = NSAttributedString(string: title, attributes: titleAttr)
		alertController.setValue(titleString, forKey: "attributedTitle")

		//var messageAttr: NSMutableAttributedString
		var messageAttr: [NSAttributedStringKey : Any?]? = [:]
		if messageFont != nil
		{
			//messageAttr.addAttribute(.font, value: messageFont!, range: NSRange.init(location: 0, length: title.count))
			messageAttr?.updateValue(messageFont, forKey: .font)
		}
		if messageColor != nil
		{
			//messageAttr.addAttribute(.foregroundColor, value: messageColor!, range: NSRange.init(location: 0, length: title.count))
			messageAttr?.updateValue(messageColor, forKey: .foregroundColor)
		}
		let messageString = NSAttributedString(string: message, attributes: messageAttr)
		alertController.setValue(messageString, forKey: "attributedMessage")
		
		if hasOKButton
		{
			let okAction = UIAlertAction(title: "OK", style: .default)
			{
				(action) in

				fromView.dismiss(animated: false, completion: nil)
				if OKAction != nil
				{
					OKAction
				}
			}
			alertController.addAction(okAction)
		}
		if hasCancelButton
		{
			let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
			alertController.addAction(cancelAction)
		}
		if shadowColor != nil
		{
			alertController.view.shadowColor = shadowColor!
		}
		if shadowOffset != nil
		{
			alertController.view.shadowOffset = shadowOffset!
		}
		if shadowOpacity != nil
		{
			alertController.view.shadowOpacity = shadowOpacity!
		}
		if shadowRadius != nil
		{
			alertController.view.shadowRadius = shadowRadius!
		}
		if cornerRadius != nil
		{
			alertController.view.cornerRadius = cornerRadius!
		}
		if backgroundColor != nil
		{
			alertController.view.backgroundColor = backgroundColor
		}
		if borderWidth != nil
		{
			alertController.view.borderWidth = borderWidth!
		}
		if borderColor != nil
		{
			alertController.view.borderColor = borderColor!
		}
		if cornerRadius != nil
		{
			alertController.view.cornerRadius = cornerRadius!
		}
		if alpha != nil
		{
			alertController.view.alpha = alpha!
		}
		if buttonColor != nil
		{
			alertController.view.tintColor = buttonColor!
		}
		
//		let subview = alertController.view.subviews.first! as UIView
//		let alertContentView = subview.subviews.first! as UIView
//		alertContentView.backgroundColor = BackgroundColor
//		alertContentView.layer.cornerRadius = 10
//		alertContentView.alpha = 1
//		alertContentView.layer.borderWidth = 1
//		alertContentView.layer.borderColor = BorderColor.cgColor
		
		//alertContentView.tintColor = UIColor.whiteColor()
//		alertController.view.tintColor = ButtonColor

		DispatchQueue.main.async {
			fromView.present(alertController, animated: true) {
				// ...
			}
		}
	}
	
	
	//MARK: Swiping Controls
	@objc private func handlePrev()
	{
		let nextId = max(pageControl.currentPage - 1, 0)
		let indexPath = IndexPath(item: nextId, section: 0)
		pageControl.currentPage = nextId
		collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
	}
	
	@objc private func handleNext()
	{
		let nextId = min(pageControl.currentPage + 1, pageContent.count - 1)
		let indexPath = IndexPath(item: nextId, section: 0)
		pageControl.currentPage = nextId
		collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
	}
	
	@objc private func handleCycle()
	{
		var nextId = pageControl.currentPage + 1
		if nextId > pageContent.count - 1
		{
			nextId = 0
		}
		let indexPath = IndexPath(item: nextId, section: 0)
		pageControl.currentPage = nextId
		//		UIView.animate(withDuration: 2, animations:
		//			{
		//				tv.transform = CGAffineTransform(translationX: tv.frame.maxX, y: 200)
		//		})
		collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
	}
	
	//MARK: Drawing Methods
	fileprivate func setUpControls() -> UIStackView
	{
//		prevBtn.translatesAutoresizingMaskIntoConstraints = false
//		prevBtn.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
//
//		nextBtn.translatesAutoresizingMaskIntoConstraints = false
//		nextBtn.frame = CGRect(x: 0, y: 0, width: 100, height: 50)

		let stack = UIStackView(arrangedSubviews: [/*prevBtn, */pageControl/*, nextBtn*/])
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.distribution = .fillEqually
		view.addSubview(stack)

		stack.heightAnchor.constraint(equalToConstant: 50).isActive = true
//		if #available(iOS 11.0, *) {
//			NSLayoutConstraint.activate([
//				stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//				stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//				stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
//				])
//		} else {
			stack.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 150/*(view.frame.height/3)-1*/).isActive = true
			stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
			//stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
			if view.frame.height > view.frame.width
			{
				stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
				stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
			}
			else
			{
				stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
				stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
			}
//		}
		return stack
	}
	
	func drawIconPanel(iconText: String, labelText: String, actionSelector: Selector) -> UIView
	{
		let myIcon = UILabel()
		myIcon.translatesAutoresizingMaskIntoConstraints = false
		myIcon.attributedText = NSMutableAttributedString(string: iconText, attributes: R.attribute.iconText)
		myIcon.textAlignment = .center
		myIcon.shadowColor = R.color.YumaYel
		myIcon.shadowOffset = CGSize(width: 2, height: 2)
		
		let myLabel = UILabel()
		myLabel.translatesAutoresizingMaskIntoConstraints = false
		myLabel.text = R.string.login
		myLabel.textAlignment = .center
		myLabel.attributedText = NSMutableAttributedString(string: labelText, attributes: R.attribute.labelText)
		myLabel.shadowColor = R.color.YumaYel
		myLabel.shadowOffset = CGSize(width: 1, height: 1)
		myLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
		myLabel.numberOfLines = 3
		
		let myStack = UIStackView(arrangedSubviews: [myIcon, myLabel])
		myStack.translatesAutoresizingMaskIntoConstraints = false
		myStack.axis = UILayoutConstraintAxis.vertical
		myStack.backgroundColor = UIColor.lightText
		myStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: actionSelector))
		//myStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(myTapped(_:))))
		NSLayoutConstraint.activate([
			myIcon.topAnchor.constraint(equalTo: myStack.topAnchor),
			myIcon.leadingAnchor.constraint(equalTo: myStack.leadingAnchor),
			myIcon.trailingAnchor.constraint(equalTo: myStack.trailingAnchor),
			myIcon.heightAnchor.constraint(equalToConstant: 50)
			])
		
		let myViewStack = UIView()
		myViewStack.translatesAutoresizingMaskIntoConstraints = false
		myViewStack.addSubview(myStack)
		NSLayoutConstraint.activate([
			myStack.topAnchor.constraint(equalTo: myViewStack.topAnchor),
			myStack.leadingAnchor.constraint(equalTo: myViewStack.leadingAnchor),
			myStack.bottomAnchor.constraint(equalTo: myViewStack.bottomAnchor),
			myStack.trailingAnchor.constraint(equalTo: myViewStack.trailingAnchor)
			])
		
		let myViewInner = UIView()
		myViewInner.translatesAutoresizingMaskIntoConstraints = false
		myViewInner.layer.borderColor = UIColor.lightGray.cgColor
		myViewInner.layer.borderWidth = 1
		myViewInner.addSubview(myViewStack)
		NSLayoutConstraint.activate([
			myViewStack.topAnchor.constraint(equalTo: myViewInner.topAnchor, constant: 2),
			myViewStack.leadingAnchor.constraint(equalTo: myViewInner.leadingAnchor, constant: 2),
			myViewStack.bottomAnchor.constraint(equalTo: myViewInner.bottomAnchor, constant: -2),
			myViewStack.trailingAnchor.constraint(equalTo: myViewInner.trailingAnchor, constant: -2)
			])

		let myViewOuter = UIView()
		myViewOuter.translatesAutoresizingMaskIntoConstraints = false
		myViewOuter.layer.borderColor = UIColor.lightGray.cgColor
		myViewOuter.layer.borderWidth = 1
		myViewOuter.addSubview(myViewInner)
		NSLayoutConstraint.activate([
			myViewInner.topAnchor.constraint(equalTo: myViewOuter.topAnchor, constant: 2),
			myViewInner.leadingAnchor.constraint(equalTo: myViewOuter.leadingAnchor, constant: 2),
			myViewInner.bottomAnchor.constraint(equalTo: myViewOuter.bottomAnchor, constant: -2),
			myViewInner.trailingAnchor.constraint(equalTo: myViewOuter.trailingAnchor, constant: -2)
			])

		let myView = UIView()
		myView.translatesAutoresizingMaskIntoConstraints = false
		myView.addSubview(myViewOuter)
		NSLayoutConstraint.activate([
			myViewStack.topAnchor.constraint(equalTo: myView.topAnchor, constant: 3),
			myViewStack.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 3),
			myViewStack.bottomAnchor.constraint(equalTo: myView.bottomAnchor, constant: -3),
			myViewStack.trailingAnchor.constraint(equalTo: myView.trailingAnchor, constant: -3),
			myView.heightAnchor.constraint(equalToConstant: 120),
			//myView.widthAnchor.constraint(equalToConstant: 90)	// trows wobbly
			])
		return myView
	}
	
	func drawTopStack() -> UIStackView
	{
		let loginPanel = drawIconPanel(iconText: FontAwesome.user.rawValue, labelText: R.string.login, actionSelector: #selector(loginTapped(_:)))
		loginPanel.widthAnchor.constraint(equalToConstant: 90).isActive = true
		let loginGap = UIView()
		let loginStack = UIStackView(arrangedSubviews: [loginPanel, loginGap])
		
		let myLogo = UIImageView(image: #imageLiteral(resourceName: "logo"))
		myLogo.translatesAutoresizingMaskIntoConstraints = false
		myLogo.contentMode = .scaleAspectFit

		let cartPanel = drawIconPanel(iconText: FontAwesome.shoppingCart.rawValue, labelText: R.string.cart, actionSelector: #selector(cartTapped(_:)))
		cartPanel.widthAnchor.constraint(equalToConstant: 90).isActive = true
		let cartGap = UIView()
		let cartStack = UIStackView(arrangedSubviews: [cartGap, cartPanel])
		let topStack = UIStackView(arrangedSubviews: [loginStack, myLogo, cartStack])
		topStack.translatesAutoresizingMaskIntoConstraints = false
		topStack.distribution = UIStackViewDistribution.fillEqually
		//topStack.addArrangedSubview(loginStack)
		//topStack.addArrangedSubview(myLogo)
		//topStack.addArrangedSubview(cartStack)
		//loginStack.widthAnchor.constraint(equalToConstant: 90).isActive = true
		//loginStack.heightAnchor.constraint(equalToConstant: 120).isActive = true

//		NSLayoutConstraint.activate([
//			loginStack.topAnchor.constraint(equalTo: topStack.topAnchor),
//			loginStack.leadingAnchor.constraint(equalTo: topStack.leadingAnchor),
//			loginStack.widthAnchor.constraint(equalToConstant: 90),
//			loginStack.heightAnchor.constraint(equalToConstant: 120)
//			])
		return topStack
	}
	
	
	
	func drawButtonsTop() -> UIStackView
	{
		let topRow = UIStackView(arrangedSubviews: [
			drawIconPanel(iconText: FontAwesome.home.rawValue, 			labelText: R.string.en, 		actionSelector: #selector(enTapped(_:))),
			drawIconPanel(iconText: FontAwesome.certificate.rawValue, 	labelText: R.string.about, 		actionSelector: #selector(aboutTapped(_:))),
			drawIconPanel(iconText: FontAwesome.flag.rawValue, 			labelText: R.string.qc, 		actionSelector: #selector(qcTapped(_:))),
			drawIconPanel(iconText: FontAwesome.phone.rawValue, 		labelText: R.string.contact, 	actionSelector: #selector(contactTapped(_:)))
			])
		topRow.translatesAutoresizingMaskIntoConstraints = false
		topRow.distribution = UIStackViewDistribution.fillEqually
		topRow.spacing = 2
		return topRow
	}

	func drawButtonsBottom() -> UIStackView
	{
		let bottomRow = UIStackView(arrangedSubviews: [
			drawIconPanel(iconText: FontAwesome.print.rawValue, 	labelText: R.string.printers, 	actionSelector: #selector(printTapped(_:))),
			drawIconPanel(iconText: FontAwesome.laptop.rawValue, 	labelText: R.string.laptops, 	actionSelector: #selector(laptopTapped(_:))),
			drawIconPanel(iconText: FontAwesome.wrench.rawValue, 	labelText: R.string.services, 	actionSelector: #selector(servicesTapped(_:))),
			drawIconPanel(iconText: FontAwesome.cubes.rawValue, 	labelText: R.string.toners, 	actionSelector: #selector(tonersTapped(_:)))
			])
		bottomRow.translatesAutoresizingMaskIntoConstraints = false
		bottomRow.distribution = UIStackViewDistribution.fillEqually
		bottomRow.spacing = 2
		return bottomRow
	}
		
	func drawLayout()
	{
		let topStack = drawTopStack()
		topStack.translatesAutoresizingMaskIntoConstraints = false
		//topStack.backgroundColor = UIColor.green
		//view.addSubview(topStack)

		let buttonsTop = drawButtonsTop()
		let buttonsBottom = drawButtonsBottom()
		
		let buttons = UIStackView(arrangedSubviews: [buttonsTop, buttonsBottom])
		buttons.translatesAutoresizingMaskIntoConstraints = false
		buttons.distribution = UIStackViewDistribution.equalCentering
		buttons.spacing = 0
		if self.view.frame.height > self.view.frame.width	// do on rotate...
		{
			buttons.axis = UILayoutConstraintAxis.vertical
			buttons.heightAnchor.constraint(equalToConstant: 240).isActive = true
		}
		else
		{
			buttons.heightAnchor.constraint(equalToConstant: 120).isActive = true
		}
		buttonsTop.topAnchor.constraint(equalTo: buttons.topAnchor, constant: 0).isActive = true
		buttonsBottom.bottomAnchor.constraint(equalTo: buttons.bottomAnchor).isActive = true
		buttonsTop.widthAnchor.constraint(equalTo: buttonsBottom.widthAnchor, multiplier: 1).isActive = true
		//view.addSubview(buttons)

		let controls = setUpControls()
		controls.translatesAutoresizingMaskIntoConstraints = false
		//self.view.addSubview(controls)
		
		let collArea = UIView()
		collArea.translatesAutoresizingMaskIntoConstraints = false

		let mainStack = UIStackView(arrangedSubviews: [topStack, controls, collArea, buttons])
		mainStack.axis = UILayoutConstraintAxis.vertical
		mainStack.distribution = UIStackViewDistribution.fill
		mainStack.translatesAutoresizingMaskIntoConstraints = false
		self.view.addSubview(mainStack)
		if #available(iOS 11.0, *) {
			NSLayoutConstraint.activate([
				mainStack.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
				mainStack.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
				mainStack.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
				mainStack.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
				])
		} else {
			NSLayoutConstraint.activate([
				mainStack.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
				mainStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
				mainStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
				])
		}

		//was above
		topStack.heightAnchor.constraint(equalToConstant: 120).isActive = true
		
		NSLayoutConstraint.activate([
			topStack.topAnchor.constraint(equalTo: mainStack.topAnchor),
			topStack.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor),
			topStack.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor),
			//topStack.heightAnchor.constraint(equalToConstant: 120),

			controls.topAnchor.constraint(equalTo: topStack.bottomAnchor),
			controls.leadingAnchor.constraint(equalTo: topStack.leadingAnchor),
			controls.trailingAnchor.constraint(equalTo: topStack.trailingAnchor),
			])
		NSLayoutConstraint.activate([
			collArea.topAnchor.constraint(equalTo: controls.bottomAnchor),
			collArea.leadingAnchor.constraint(equalTo: controls.leadingAnchor),
			collArea.trailingAnchor.constraint(equalTo: controls.trailingAnchor),
			collArea.bottomAnchor.constraint(equalTo: buttons.topAnchor),
			
			//buttons.topAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: -240),
			buttons.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor),
			buttons.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor),
//			if view.frame.height > view.frame.width
//			{
			buttons.bottomAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: 0),
			])
//		if #available(iOS 11.0, *) {
//			NSLayoutConstraint.activate([
//				topStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//				topStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//				topStack.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//				])
//		} else {
//			//			topStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
//			if view.frame.height > view.frame.width
//			{
//				topStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
//				topStack.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//				topStack.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//			}
//			else
//			{
//				topStack.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//				topStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
//				topStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
//			}
//		}

		//was above
//		if #available(iOS 11.0, *) {
//			NSLayoutConstraint.activate([
//				buttons.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -240),
//				buttons.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//				buttons.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//				buttons.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//				])
//		} else {
//			buttons.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
//			if view.frame.height > view.frame.width
//			{
//				buttons.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -240).isActive = true
//				buttons.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
//				buttons.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//				buttons.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//			}
//			else
//			{
//				buttons.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -120).isActive = true
//				buttons.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//				buttons.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
//				buttons.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
//			}
//		}
	}
	
}

//unused
class VerticalTopAlignLabel: UILabel
{
	override func drawText(in rect:CGRect)
	{
		guard let labelText = text else { 	return super.drawText(in: rect) 	}
		
		let attributedText = NSAttributedString(string: labelText, attributes: [NSAttributedStringKey.font: font])
		var newRect = rect
		newRect.size.height = attributedText.boundingRect(with: rect.size, options: .usesLineFragmentOrigin, context: nil).size.height
		
		if numberOfLines != 0
		{
			newRect.size.height = min(newRect.size.height, CGFloat(numberOfLines) * font.lineHeight)
		}
		super.drawText(in: newRect)
	}
	
}
