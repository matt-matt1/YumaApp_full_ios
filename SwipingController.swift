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
	var cellId = "cellID"
	let pageContent: [Slide] = [Slide(id: 1, image: "home-slider-printers", caption1: "Laser Printers", caption2: "", target: "", width: 0, height: 0),
								Slide(id: 1, image: "home-slider-cartridges", caption1: "Toner Cartridges", caption2: "that last", target: "", width: 0, height: 0),
								Slide(id: 1, image: "home-slider-laptops", caption1: "Laptop Computers", caption2: "", target: "", width: 0, height: 0)]
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
	private lazy var pageControl: UIPageControl =
	{
		let pc = UIPageControl()
		pc.numberOfPages = pageContent.count
		pc.currentPage = 0
		pc.currentPageIndicatorTintColor = R.color.YumaRed
		pc.pageIndicatorTintColor = R.color.YumaYel
		return pc
	}()
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		self.view.backgroundColor = UIColor.white

		drawLayout()
//		UIView.animate(withDuration: 2, animations:
//			{
//				tv.transform = CGAffineTransform(translationX: tv.frame.maxX, y: 200)
//		})


		collectionView?.backgroundColor = UIColor.white
		collectionView?.register(PageCell.self, forCellWithReuseIdentifier: cellId)
		collectionView?.isPagingEnabled = true
		
		Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(handleCycle), userInfo: nil, repeats: true)
	}
	
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
		collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
	}
	
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
			stack.bottomAnchor.constraint(equalTo: view.topAnchor, constant: (view.frame.height/3)-1).isActive = true
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
	
	func drawIconPanel(iconText: String, labelText: String) -> UIView
	{
		let myIcon = UILabel()
		myIcon.translatesAutoresizingMaskIntoConstraints = false
		myIcon.attributedText = NSMutableAttributedString(string: iconText, attributes: R.attribute.iconText)
		myIcon.textAlignment = .center
		//myIcon.textColor = R.color.YumaRed
		myIcon.heightAnchor.constraint(equalToConstant: 50).isActive = true
		
		let myLabel = UILabel()
		myLabel.translatesAutoresizingMaskIntoConstraints = false
		myLabel.text = R.string.login
		myLabel.textAlignment = .center
		myLabel.attributedText = NSMutableAttributedString(string: labelText, attributes: R.attribute.labelText)
		
		let myStack = UIStackView(arrangedSubviews: [myIcon, myLabel])
		myStack.translatesAutoresizingMaskIntoConstraints = false
		myStack.axis = UILayoutConstraintAxis.vertical
		myStack.widthAnchor.constraint(equalToConstant: 90).isActive = true
		myStack.heightAnchor.constraint(equalToConstant: 120).isActive = true
		
		let viewStack = UIView()//frame: CGRect(x: 0, y: 0, width: 90, height: 120))
		viewStack.translatesAutoresizingMaskIntoConstraints = false
		viewStack.backgroundColor = .green
		viewStack.addSubview(myStack)
		myStack.topAnchor.constraint(equalTo: viewStack.topAnchor).isActive = true
		myStack.leadingAnchor.constraint(equalTo: viewStack.leadingAnchor).isActive = true
		myStack.bottomAnchor.constraint(equalTo: viewStack.bottomAnchor).isActive = true
		myStack.trailingAnchor.constraint(equalTo: viewStack.trailingAnchor).isActive = true
//		myIcon.topAnchor.constraint(equalTo: myStack.topAnchor, constant: 10).isActive = true
		//loginStack.widthAnchor.constraint(equalToConstant: 90).isActive = true
		//loginStack.heightAnchor.constraint(equalToConstant: 120).isActive = true

		let viewView = UIView()
		viewView.backgroundColor = .blue
		//viewView.translatesAutoresizingMaskIntoConstraints = false
		viewView.addSubview(viewStack)
		viewStack.topAnchor.constraint(equalTo: viewView.topAnchor, constant: 2).isActive = true
		viewStack.leadingAnchor.constraint(equalTo: viewView.leadingAnchor, constant: 2).isActive = true
		//viewStack.centerXAnchor.constraint(equalTo: viewView.centerXAnchor).isActive = true
		//viewStack.centerYAnchor.constraint(equalTo: viewView.centerYAnchor).isActive = true
		
		let all = UIView()//frame: CGRect(x: 0, y: 0, width: 90, height: 120))
//		all.translatesAutoresizingMaskIntoConstraints = false
		all.backgroundColor = UIColor.lightGray
//		let panel = UIView()
//		panel.translatesAutoresizingMaskIntoConstraints = false
//		panel.backgroundColor = UIColor.green
//		let pIcon = UITextView()
//		pIcon.translatesAutoresizingMaskIntoConstraints = false
//		pIcon.text = iconText
//		let pLabel = UITextView()
//		pLabel.translatesAutoresizingMaskIntoConstraints = false
//		pLabel.text = labelText
//		panel.addSubview(pIcon)
//		panel.addSubview(pLabel)
//		all.addSubview(panel)
//		all.addSubview(myStack)
//		all.addSubview(viewStack)
		all.addSubview(viewView)
//		viewView.topAnchor.constraint(equalTo: all.topAnchor, constant: 2).isActive = true
//		viewView.leadingAnchor.constraint(equalTo: all.leadingAnchor, constant: 2).isActive = true
		//all.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			//myIcon.centerXAnchor.constraint(equalTo: myStack.centerXAnchor),
			myIcon.trailingAnchor.constraint(equalTo: myStack.trailingAnchor),
			//myIcon.topAnchor.constraint(equalTo: myStack.topAnchor, constant: 20),
			//myIcon.heightAnchor.constraint(equalToConstant: 50),
			myIcon.leadingAnchor.constraint(equalTo: myStack.leadingAnchor),
//			myLabel.centerXAnchor.constraint(equalTo: myStack.centerXAnchor),
//			myLabel.bottomAnchor.constraint(equalTo: myStack.bottomAnchor, constant: 20),
//			panel.topAnchor.constraint(equalTo: all.topAnchor, constant: 1),
//			panel.leadingAnchor.constraint(equalTo: all.leadingAnchor, constant: 1),
//			panel.centerXAnchor.constraint(equalTo: all.centerXAnchor),
//			panel.centerYAnchor.constraint(equalTo: all.centerYAnchor)
			myLabel.trailingAnchor.constraint(equalTo: myStack.trailingAnchor),
			myLabel.leadingAnchor.constraint(equalTo: myStack.leadingAnchor)
			])
		return all
	}
	
	func drawTopStack() -> UIStackView
	{
		let loginStack = drawIconPanel(iconText: FontAwesome.user.rawValue, labelText: R.string.login)
//		let loginIcon = UILabel()
//		loginIcon.translatesAutoresizingMaskIntoConstraints = false
//		loginIcon.attributedText = NSMutableAttributedString(string: FontAwesome.user.rawValue, attributes: R.attribute.iconText)
//		loginIcon.textAlignment = .center
//		loginIcon.textColor = R.color.YumaRed
//
//		let loginLabel = UILabel()
//		loginLabel.translatesAutoresizingMaskIntoConstraints = false
//		loginLabel.text = R.string.login
//		loginLabel.textAlignment = .center
//		loginLabel.attributedText = NSMutableAttributedString(string: R.string.login, attributes: R.attribute.labelText)
//
//		let loginStack = UIStackView(arrangedSubviews: [loginIcon, loginLabel])
//		loginStack.translatesAutoresizingMaskIntoConstraints = false
//		loginStack.axis = UILayoutConstraintAxis.vertical
//		//loginStack.widthAnchor.constraint(equalToConstant: 90).isActive = true
//		//loginStack.heightAnchor.constraint(equalToConstant: 120).isActive = true
		
		let myLogo = UIImageView(image: #imageLiteral(resourceName: "logo"))
		myLogo.translatesAutoresizingMaskIntoConstraints = false
		myLogo.contentMode = .scaleAspectFit
		
		let cartIcon = UILabel()
		cartIcon.translatesAutoresizingMaskIntoConstraints = false
		cartIcon.attributedText = NSMutableAttributedString(string: FontAwesome.shoppingCart.rawValue, attributes: R.attribute.iconText)
		cartIcon.textAlignment = .center
		//cartIcon.textColor = R.color.YumaRed
		
		let cartLabel = UILabel()
		cartLabel.translatesAutoresizingMaskIntoConstraints = false
		cartLabel.text = R.string.login
		cartLabel.textAlignment = .center
		cartLabel.attributedText = NSMutableAttributedString(string: R.string.cart, attributes: R.attribute.labelText)
		
		let cartStack = UIStackView(arrangedSubviews: [cartIcon, cartLabel])
		cartStack.translatesAutoresizingMaskIntoConstraints = false
		cartStack.axis = UILayoutConstraintAxis.vertical
		cartStack.backgroundColor = UIColor.clear
		cartStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cartTapped(_:))))
		
//		let cartView = UIView()
//		cartView.addSubview(cartStack)
//		cartView.layer.borderColor = UIColor.lightGray.cgColor
//		cartView.layer.borderWidth = 2

		let topStack = UIStackView(arrangedSubviews: [loginStack, myLogo, cartStack])//cartView])
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
	
	@objc func cartTapped(_ sender: UITapGestureRecognizer)
	{
		sender.view?.backgroundColor = R.color.YumaRed
		UIView.animate(withDuration: 1, animations:
			{
				sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		})//CartContentsViewController
		//SwipingController
		self.present(ContactUsViewController(), animated: false, completion: (() -> Void)?
			{
				sender.view?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
				sender.view?.backgroundColor = UIColor.white
			})

//		self.present(ContactUsViewController(), animated: true, completion: nil)
	}

	func drawButtons() -> UIStackView
	{
		let tempLabel = UILabel()
		tempLabel.translatesAutoresizingMaskIntoConstraints = false
		tempLabel.text = R.string.login

		let myLogo = UIImageView(image: #imageLiteral(resourceName: "logo"))
		myLogo.translatesAutoresizingMaskIntoConstraints = false
		myLogo.contentMode = .scaleAspectFit

		let tempLabel2 = UILabel()
		tempLabel2.translatesAutoresizingMaskIntoConstraints = false
		tempLabel2.text = R.string.toners

		let stack = UIStackView(arrangedSubviews: [tempLabel, myLogo, tempLabel2])
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.distribution = UIStackViewDistribution.fillEqually
		stack.addArrangedSubview(myLogo)

		view.addSubview(stack)
		stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 100).isActive = true
		return stack
	}

	func drawLayout()
	{
		let topStack = drawTopStack()
		view.addSubview(topStack)
		topStack.heightAnchor.constraint(equalToConstant: 120).isActive = true
		if #available(iOS 11.0, *) {
			NSLayoutConstraint.activate([
				topStack.topAnchor.constraint(equalTo: view.topAnchor),
				topStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
				topStack.trailingAnchor.constraint(equalTo: view.trailingAnchor)
				])
		} else {
			topStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
			if view.frame.height > view.frame.width
			{
				topStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
				topStack.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
				topStack.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
			}
			else
			{
				topStack.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
				topStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
				topStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
			}
		}

		let buttons = drawButtons()
		//print(buttons)
		//		topStack.heightAnchor.constraint(equalToConstant: 120).isActive = true
		//		if #available(iOS 11.0, *) {
		//			NSLayoutConstraint.activate([
		//				topStack.topAnchor.constraint(equalTo: view.topAnchor),
		//				topStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
		//				topStack.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		//				])
		//		} else {
		//			topStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
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

		let controls = setUpControls()
		self.view.addSubview(controls)

//		let topStack = UIStackView()
//		topStack.axis = UILayoutConstraintAxis.horizontal
//		topStack.distribution = UIStackViewDistribution.fill
//		topStack.backgroundColor = UIColor.blue
//		let middleStack = UIStackView()
//		middleStack.axis = UILayoutConstraintAxis.horizontal
//		middleStack.distribution = UIStackViewDistribution.fill
//		middleStack.backgroundColor = UIColor.green
//		let bottomStack = UIStackView()
//		bottomStack.axis = UILayoutConstraintAxis.horizontal
//		bottomStack.distribution = UIStackViewDistribution.fill
//		bottomStack.backgroundColor = UIColor.red
//		mainStacks.addSubview(topStack)
//		mainStacks.addSubview(middleStack)
//		mainStacks.addSubview(bottomStack)
//		self.view.addSubview(mainStacks)
		drawIconPanels()
	}

	func drawIconPanels()
	{
		let loginI = drawIconPanel(iconText: FontAwesome.user.rawValue, labelText: R.string.login)
		loginI.translatesAutoresizingMaskIntoConstraints = false
		loginI.backgroundColor = UIColor.brown
		self.view.addSubview(loginI)
		loginI.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 1).isActive = true
		loginI.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 1).isActive = true
		loginI.widthAnchor.constraint(equalToConstant: 90)
		loginI.heightAnchor.constraint(equalToConstant: 120)
	}
	
	override func numberOfSections(in collectionView: UICollectionView) -> Int
	{
		return 1
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return pageContent.count
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
	{
		return 0
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
	{
		return CGSize(width: view.frame.width, height: view.frame.height/2)
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PageCell
		//cell.backgroundColor = indexPath.item % 2 == 0 ? .red : .green
		let page = pageContent[indexPath.item]
		cell.page = page
		//cell.myImage.image = UIImage(named: page.image)
		//cell.myMain.text = page.caption1
		//cell.mySub.text = page.caption2
		return cell
	}
}
