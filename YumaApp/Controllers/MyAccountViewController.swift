//
//  MyAccountViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-15.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class MyAccountViewController: UIViewController
{
	@IBOutlet weak var navBar: UINavigationBar!
	@IBOutlet weak var navTitle: UINavigationItem!
	@IBOutlet weak var navClose: UIBarButtonItem!
	@IBOutlet weak var navHelp: UIBarButtonItem!
	@IBOutlet weak var infoBtn: UIButton!
	@IBOutlet weak var addrBtn: UIButton!
	@IBOutlet weak var orderHistBtn: UIButton!
	@IBOutlet weak var creditSlipsBtn: UIButton!

/*
	func coverStackOpen() -> UIStackView
	{
		let allStack = UIStackView(frame: CGRect(x: 0, y: 0, width: 375, height: 647))
		allStack.axis = UILayoutConstraintAxis.vertical
		return allStack
	}
	func coverStackClose_constraintToParent(stackView: UIStackView, addTo: UIView, constraintsLeading: CGFloat? = 0, constraintsTrailing: CGFloat? = 0, constraintsTop: CGFloat? = 0, constraintsBottom: CGFloat? = 0)
	{
		addTo.addSubview(stackView)
		stackView.leadingAnchor.constraint(equalTo: addTo.leadingAnchor, constant: constraintsLeading!).isActive = true
		stackView.trailingAnchor.constraint(equalTo: addTo.trailingAnchor, constant: constraintsTrailing!).isActive = true
		stackView.topAnchor.constraint(equalTo: addTo.topAnchor, constant: constraintsTop!).isActive = true
		stackView.bottomAnchor.constraint(equalTo: addTo.bottomAnchor, constant: constraintsBottom!).isActive = true
	}
	func coverStackClose_constraintToSafeLayoutMargins(stackView: UIStackView, addTo: UIView, constraintsLeft: CGFloat? = 0, constraintsRight: CGFloat? = 0, constraintsTop: CGFloat? = 0, constraintsBottom: CGFloat? = 0)
	{
		addTo.addSubview(stackView)
		stackView.leadingAnchor.constraint(equalTo: addTo.leadingAnchor, constant: addTo.layoutMargins.left).isActive = true
		stackView.trailingAnchor.constraint(equalTo: addTo.trailingAnchor, constant: addTo.layoutMargins.right).isActive = true
		stackView.topAnchor.constraint(equalTo: addTo.topAnchor, constant: addTo.layoutMargins.top).isActive = true
		stackView.bottomAnchor.constraint(equalTo: addTo.bottomAnchor, constant: addTo.layoutMargins.bottom).isActive = true
	}
	func topNavigationBarOpen(_ mX: CGFloat = 0, _ mY: CGFloat = 0, _ mWidth: CGFloat = 375, _ mHeight: CGFloat = 46) -> UINavigationBar
	{
		let navBar = UINavigationBar(frame: CGRect(x: mX, y: mY, width: mWidth, height: mHeight))
		return navBar
	}
	func topNavigationBarClose(navBar: UINavigationBar, addTo: UIView, constraintsLeading: CGFloat? = 0, constraintsTrailing: CGFloat? = 0, constraintsTop: CGFloat? = 0, constraintsBottom: CGFloat? = 0)
	{
		addTo.addSubview(navBar)
		navBar.leadingAnchor.constraint(equalTo: addTo.leadingAnchor, constant: constraintsLeading!).isActive = true
		navBar.trailingAnchor.constraint(equalTo: addTo.trailingAnchor, constant: constraintsTrailing!).isActive = true
		navBar.topAnchor.constraint(equalTo: addTo.topAnchor, constant: constraintsTop!).isActive = true
		navBar.bottomAnchor.constraint(equalTo: addTo.bottomAnchor, constant: constraintsBottom!).isActive = true
	}
	
	func drawXIB()
	{
		self.view.backgroundColor = R.color.YumaDRed
		//let screenSize: CGRect = UIScreen.main.bounds
		//let myView = UILayoutGuide()
		let allStack = coverStackOpen()
		
		let navBar = UINavigationBar()//frame: CGRect(x: 0, y: 40, width: screenSize.width, height: 46))
		//let navBar = topNavigationBarOpen(0, 35, 375, 46)
//		navBar.backgroundColor = UIColor.white
//		navBar.barTintColor = R.color.YumaRed
//		//navBar.titleTextAttributes
//		//navBar.tintColor = R.color.YumaYel
//		//topNavigationBarClose(navBar: navBar, addTo: allStack)
		allStack.addArrangedSubview(navBar)
		let navItem = UINavigationItem(title: "My Account*")
		let faClose = UIButton(type: .custom)
		faClose.setImage(UIImage(named: "myImage"), for: .normal)
		faClose.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
		faClose.addTarget(self, action: #selector(navCloseAct(_:)), for: .touchUpInside)
		let navClose = UIBarButtonItem(customView: faClose)
		//(title: "", style: .plain, target: self, action: #selector(navCloseAct(_:)))
		//navClose.titleTextAttributes(for: .normal)
		//(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(navCloseAct(_:)))
		navItem.leftBarButtonItem = navClose
		let navDone = UIBarButtonItem(title: "help", style: .plain, target: nil, action: nil)
		//(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil, action: nil)
		//navDone.title = "help"
		navItem.rightBarButtonItem = navDone
		navBar.setItems([navItem], animated: false)
		//navBar.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
		navBar.widthAnchor.constraint(equalToConstant: allStack.frame.width).isActive = true
		navBar.heightAnchor.constraint(equalToConstant: 46)
//		navBar.topAnchor.constraint(equalTo: allStack.topAnchor, constant: 40/*allStack.layoutMargins.top*/).isActive = true
		
		let mainView = UIView()//frame: CGRect(x: 5, y: 0, width: 300, height: 400))
		mainView.backgroundColor = UIColor.white
//
//		let mainStack = coverStackOpen()
		let mainStack = UIStackView(frame: CGRect(x: 5, y: 0, width: 300, height: 400))
		mainStack.backgroundColor = UIColor.green
//
//		let button1 = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
//		button1.backgroundColor = UIColor.blue
//		mainStack.addArrangedSubview(button1)
//
		mainView.addSubview(mainStack)
		//mainView.topAnchor.constraint(equalTo: navBar.bottomAnchor).isActive = true
		mainStack.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 5).isActive = true
		//mainStack.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
		//mainStack.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
		//mainStack.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 5).isActive = true
//
//		//coverStackClose_constraintToParent(stackView: mainStack, addTo: allStack)
		allStack.addArrangedSubview(mainView)
		mainView.bottomAnchor.constraint(equalTo: allStack.bottomAnchor).isActive = true
		mainView.widthAnchor.constraint(equalToConstant: allStack.frame.width).isActive = true
		//mainView.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 20).isActive = true
		
		//allStack.backgroundColor = UIColor.white
		//coverStackClose_constraintToSafeLayoutMargins(stackView: allStack, addTo: self.view)
		//myView
		self.view.addSubview(allStack)
	}
	
	func drawXIB2()
	{
//		<document type="com.apple.InterfaceBuilder3.CocoaTouch.XIB" version="3.0" toolsVersion="13771" targetRuntime="iOS.CocoaTouch" propertyAccessControl="none" useAutolayout="YES" useTraitCollections="YES" useSafeAreas="YES" colorMatched="YES">
//		<objects>
//		<placeholder placeholderIdentifier="IBFilesOwner" id="-1" userLabel="File's Owner" customClass="MyAccountViewController" customModule="YumaApp" customModuleProvider="target">
	//		<connections>
		//		<outlet property="CSBtn" destination="nwr-PL-aCb" id="xtB-AX-OVd"/>
		//		<outlet property="OHBtn" destination="r8j-Ha-uIZ" id="MwX-ZB-oYD"/>
		//		<outlet property="addrBtn" destination="fLC-bc-UyJ" id="98B-Hs-tzx"/>
		//		<outlet property="infoBtn" destination="mpL-7y-9XA" id="jhe-p5-Lqk"/>
		//		<outlet property="navBar" destination="E1l-b5-wV5" id="PED-cK-LVw"/>
		//		<outlet property="navClose" destination="hwu-ML-zq8" id="CzT-OZ-KB2"/>
		//		<outlet property="navHelp" destination="med-gd-apn" id="11Y-gv-6dS"/>
		//		<outlet property="navTitle" destination="xa0-22-DHC" id="g1D-BQ-Rpe"/>
		//		<outlet property="view" destination="1Eu-zr-YVG" id="Xwf-Ws-nHA"/>
	//		</connections>
//		</placeholder>
//		<placeholder placeholderIdentifier="IBFirstResponder" id="-2" customClass="UIResponder"/>
		let mainView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375, height: 667))
		mainView.clearsContextBeforeDrawing = false
		mainView.contentMode = UIViewContentMode.scaleToFill
		mainView.autoresizingMask = UIViewAutoresizing.flexibleWidth
		mainView.autoresizingMask = UIViewAutoresizing.flexibleHeight
				let topView = UIView(frame: CGRect(x: 0.0, y: 20, width: 375, height: 647))
		topView.contentMode = UIViewContentMode.scaleToFill
				topView.translatesAutoresizingMaskIntoConstraints = false
						let allStack = UIStackView(frame: CGRect(x: 0.0, y: 0.0, width: 375, height: 627))
		allStack.isOpaque = false
		allStack.contentMode = UIViewContentMode.scaleToFill
						allStack.axis = UILayoutConstraintAxis.vertical
						allStack.alignment = UIStackViewAlignment.center
						allStack.translatesAutoresizingMaskIntoConstraints = false
		let nBar = UINavigationBar(frame: CGRect(x: 0.0, y: 0.0, width: 375, height: 46))
		nBar.contentMode = UIViewContentMode.scaleToFill
								nBar.translatesAutoresizingMaskIntoConstraints = false
		let navItem = UINavigationItem(title: "My Account*")
//		let faClose = UIButton(type: .custom)
//		faClose.setImage(UIImage(named: "myImage"), for: .normal)
//		faClose.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//		faClose.addTarget(self, action: #selector(navCloseAct(_:)), for: .touchUpInside)
//		let navClose = UIBarButtonItem(customView: faClose)
		//(title: "", style: .plain, target: self, action: #selector(navCloseAct(_:)))
		//navClose.titleTextAttributes(for: .normal)
		//(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(navCloseAct(_:)))
		let navClose = UIBarButtonItem(title: "X", style: .done, target: self, action: #selector(navCloseAct(_:)))
		navItem.leftBarButtonItem = navClose
		let navDone = UIBarButtonItem(title: "help", style: .done, target: nil, action: nil)
		navItem.rightBarButtonItem = navDone
		nBar.setItems([navItem], animated: false)
		nBar.widthAnchor.constraint(equalToConstant: allStack.frame.width).isActive = true
		nBar.heightAnchor.constraint(equalToConstant: 46)
		nBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)

//									nBar.backgroundColor = R.color.YumaDRed
//									nBar.barTintColor = R.color.YumaRed
							//		<textAttributes key="titleTextAttributes">
//		let textAttributes = nBar.titleTextAttributes//[NSAttributedStringKey]
									//nBar.titleTextAttributes = [NSAttributedStringKey]
							//		<fontDescription key="fontDescription" type="system" pointSize="24"/>
		//textAttributes.
									//let fontDesc = UIFont(descriptor: UIFontDescriptor(self), size: 24)
							//		<color key="textColor" red="0.99942404029999998" green="0.98555368190000003" blue="0.0" alpha="1" colorSpace="custom" customColorSpace="sRGB"/>
									//let attr = [NSAttributedStringKey(nBar)]
							//		<color key="textShadowColor" red="0.1764705882" green="0.0078431372550000003" blue="0.0078431372550000003" alpha="1" colorSpace="calibratedRGB"/>
							//		<offsetWrapper key="textShadowOffset" horizontal="2" vertical="2"/>
							//		</textAttributes>
							//		<items>
									//		<barButtonItem key="leftBarButtonItem" style="done" systemItem="stop" id="hwu-ML-zq8">
									//		<color key="tintColor" white="1" alpha="1" colorSpace="custom" customColorSpace="genericGamma22GrayColorSpace"/>
									//		<connections>
									//		<action selector="navCloseAct:" destination="-1" id="kO3-2s-x19"/>
									//		</connections>
									//		</barButtonItem>
										//		<barButtonItem key="rightBarButtonItem" title="help" style="done" id="med-gd-apn">
										//		<color key="tintColor" white="1" alpha="1" colorSpace="custom" customColorSpace="genericGamma22GrayColorSpace"/>
										//		<connections>
										//		<action selector="navHelpAct:" destination="-1" id="qgh-E2-qpD"/>
										//		</connections>
									//		</barButtonItem>
								//		</navigationItem>
										//nBar.addSubview(nMyAcc)
							//		</items>
						//		</navigationBar>
								allStack.addArrangedSubview(nBar)
		//nBar.heightAnchor.constraint(equalToConstant: 46).isActive = true
		nBar.leadingAnchor.constraint(equalTo: allStack.leadingAnchor).isActive = true
		nBar.trailingAnchor.constraint(equalTo: allStack.trailingAnchor).isActive = true
		nBar.topAnchor.constraint(equalTo: allStack.topAnchor).isActive = true
							let lowerView = UIView(frame: CGRect(x: 0.0, y: 46, width: 375, height: 601))
		lowerView.backgroundColor = UIColor.lightGray
								let lowerStack = UIStackView(frame: CGRect(x: 5, y: 0.0, width: 365, height: 300))
								let innerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 365, height: 300))
		innerView.contentMode = UIViewContentMode.scaleToFill
		innerView.translatesAutoresizingMaskIntoConstraints = false
								let innerStack = UIStackView(frame: CGRect(x: 5, y: 20, width: 355, height: 260))
		//innerStack.isOpaque = true
		innerStack.contentMode = UIViewContentMode.scaleToFill
		innerStack.axis = UILayoutConstraintAxis.vertical
		//innerStack.distribution = UIStackViewDistribution.fillEqually
		innerStack.alignment = UIStackViewAlignment.center
		innerStack.spacing = 20
		//innerStack.translatesAutoresizingMaskIntoConstraints = false
								let mButton1 = UIButton(frame: CGRect(x: 88, y: 0.0, width: 179, height: 50))
		mButton1.isOpaque = false
		mButton1.cornerRadius = 3
		mButton1.contentMode = UIViewContentMode.scaleToFill
								mButton1.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
								mButton1.contentVerticalAlignment = UIControlContentVerticalAlignment.center
								//mButton1.buttonType = UIButtonType.roundedRect
								mButton1.reversesTitleShadowWhenHighlighted = true
								mButton1.translatesAutoresizingMaskIntoConstraints = false
		//lineBreakMode="middleTruncation"
		//springLoaded="YES"
		//customClass="GradientButton" customModule="YumaApp" customModuleProvider="target"
								mButton1.backgroundColor = R.color.YumaRed
						//		<fontDescription key="fontDescription" type="system" weight="medium" pointSize="16"/>
								//let mButton1Font = UIFont(descriptor: , size: 16)
						//		<size key="titleShadowOffset" width="1" height="1"/>
								//mButton1.titleShadowOffset
						//		<state key="normal" title="INFORMATION">
		mButton1.setTitle(R.string.Info, for: .normal)
		mButton1.setTitleColor(UIColor.white, for: .normal)
		mButton1.setTitleShadowColor(R.color.YumaDRed, for: .normal)
						//		</state>
		//mButton1.layer.cornerRadius = 3
		//mButton1.layer.addSublayer(mButton1.layer.cornerRadius(CGFloat(3)))
		mButton1.layer.borderColor = R.color.YumaDRed.cgColor
		mButton1.layer.borderWidth = 1
		//mButton1.layer.addSublayer(CALayer(layer: ))
		//mButton1.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4)
		let gradientLayer1 = CAGradientLayer()
		gradientLayer1.frame = mButton1.bounds
		//		gradientLayer.frame =  CGRect(origin: .zero, size: mButton1.bounds.size)
		//		gradientLayer.startPoint = CGPoint(x:0.5, y:0.0)
		//		gradientLayer.endPoint = CGPoint(x:0.5, y:1.0)
		gradientLayer1.colors = [R.color.YumaRed.cgColor, R.color.YumaYel.cgColor]
		mButton1.layer.addSublayer(gradientLayer1)
		//mButton1.layer.insertSublayer(gradientLayer1, at: 0)
		
		let gradientBorder: CAGradientLayer = CAGradientLayer()
		gradientBorder.frame = mButton1.bounds
		gradientBorder.colors = [R.color.YumaYel.cgColor, R.color.YumaRed.cgColor]
		//gradientBorder.locations = [0.0, 1.0]
		gradientBorder.startPoint = CGPoint(x: 0.0, y: 0.0)
		gradientBorder.endPoint = CGPoint(x: 0.0, y: 1.0)
		//mButton1.layer.addSublayer(gradientBorder)
		//mButton1.layer.insertSublayer(gradientBorder, at: 0)
		let shapeLayer = CAShapeLayer()
		shapeLayer.lineWidth = 3
		shapeLayer.path = UIBezierPath(rect: mButton1.bounds).cgPath
		shapeLayer.fillColor = nil
		shapeLayer.strokeColor = UIColor.black.cgColor
		gradientBorder.mask = shapeLayer
		mButton1.layer.addSublayer(gradientBorder)
//
//		let gradientLayer2 = CAGradientLayer()
//		gradientLayer2.frame =  CGRect(origin: .zero, size: mButton1.bounds.size)
//		gradientLayer2.startPoint = CGPoint(x:0.5, y:0.0)
//		gradientLayer2.endPoint = CGPoint(x:0.5, y:1.0)
//		gradientLayer2.colors = [R.color.YumaRed, R.color.YumaYel]
//		let shapeLayer2 = CAShapeLayer()
//		shapeLayer2.lineWidth = 2
//		shapeLayer2.path = UIBezierPath(rect: mButton1.bounds).cgPath
//		shapeLayer2.fillColor = nil//[R.color.YumaRed, R.color.YumaYel]
//		shapeLayer2.strokeColor = UIColor.black.cgColor
//		gradientLayer2.mask = shapeLayer
//		mButton1.layer.addSublayer(gradientLayer2)
		mButton1.layer.shadowRadius = 3
		mButton1.layer.shadowOpacity = 5
		mButton1.layer.shadowOffset = CGSize(width: 1, height: 1)
		mButton1.layer.shadowColor = UIColor.darkGray.cgColor
						//		<action selector="infoBtnAct:" destination="-1" eventType="touchUpInside" id="nrG-VQ-n4A"/>
		mButton1.addTarget(self, action: #selector(infoBtnAct(_:)), for: .touchUpInside)
		mButton1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(infoBtnAct(_:))))
								innerStack.addArrangedSubview(mButton1)
		mButton1.widthAnchor.constraint(equalToConstant: 91).isActive = true
//lineBreakMode="middleTruncation" springLoaded="YES" translatesAutoresizingMaskIntoConstraints="NO" id="fLC-bc-UyJ" customClass="GradientButton" customModule="YumaApp" customModuleProvider="target">
								let mButton2 = UIButton(frame: CGRect(x: 88, y: 70, width: 179, height: 50))
		mButton2.isOpaque = false
		//mButton2.cornerRadius = 3
		mButton2.contentMode = UIViewContentMode.scaleToFill
		mButton2.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
		mButton2.contentVerticalAlignment = UIControlContentVerticalAlignment.center
		//mButton2.buttonType = UIButtonType.roundedRect
		mButton2.reversesTitleShadowWhenHighlighted = true
		mButton2.translatesAutoresizingMaskIntoConstraints = false
		//mButton2.backgroundColor = R.color.YumaRed
		mButton2.layer.addBackgroundGradient(colors: [R.color.YumaRed, R.color.YumaYel], isVertical: true)
						//		<fontDescription key="fontDescription" type="system" weight="medium" pointSize="16"/>
						//		<size key="titleShadowOffset" width="1" height="1"/>
						//		<state key="normal" title="ADDRESSES">
		mButton2.setTitle(R.string.Addrs, for: .normal)
		mButton2.setTitleColor(UIColor.white, for: .normal)
		mButton2.setTitleShadowColor(R.color.YumaDRed, for: .normal)
		mButton2.layer.cornerRadius = 3
		mButton2.layer.borderColor = R.color.YumaDRed.cgColor
		mButton2.layer.borderWidth = 1
		//mButton2.layer.addSublayer(CALayer(layer: ))
		mButton2.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 2, isVertical: true)
		mButton2.layer.shadowRadius = 3
		mButton2.layer.shadowOpacity = 5
		mButton2.layer.shadowOffset = CGSize(width: 1, height: 1)
		mButton2.layer.shadowColor = UIColor.darkGray.cgColor
						//		<action selector="addrBtnAct:" destination="-1" eventType="touchUpInside" id="DUq-Mo-2V3"/>
		mButton2.addTarget(self, action: #selector(addrBtnAct(_:)), for: .touchUpInside)
								innerStack.addArrangedSubview(mButton2)
		let mButton3 = UIButton(frame: CGRect(x: 88, y: 70, width: 179, height: 50))
		mButton3.isOpaque = false
		mButton3.cornerRadius = 3
		mButton3.contentMode = UIViewContentMode.scaleToFill
		mButton3.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
		mButton3.contentVerticalAlignment = UIControlContentVerticalAlignment.center
		//mButton3.buttonType = UIButtonType.roundedRect
		mButton3.reversesTitleShadowWhenHighlighted = true
		//mButton3.lineBreakMode="middleTruncation"
		//mButton3.isSpringLoaded = true
		mButton3.translatesAutoresizingMaskIntoConstraints = false
		//customClass="GradientButton" customModule="YumaApp" customModuleProvider="target">
		mButton3.backgroundColor = R.color.YumaRed
		mButton3.layer.addBackgroundGradient(colors: [R.color.YumaRed, R.color.YumaYel], isVertical: true)
						//		<fontDescription key="fontDescription" type="system" weight="medium" pointSize="16"/>
						//		<size key="titleShadowOffset" width="1" height="1"/>
						//		<state key="normal" title="ORDER HISTORY">
		mButton3.setTitle(R.string.OrdHist, for: .normal)
		//mButton3.setAttributedTitle(NSAttributedString.attribute(NSAttributedString.DocumentType), for: .normal)
		mButton3.setTitleColor(UIColor.white, for: .normal)
		mButton3.setTitleShadowColor(R.color.YumaDRed, for: .normal)
		mButton3.layer.cornerRadius = 3
		mButton3.layer.borderColor = R.color.YumaDRed.cgColor
		mButton3.layer.borderWidth = 1
		//mButton3.layer.addSublayer(CALayer(layer: ))
		//mButton3.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4)
		mButton3.layer.shadowRadius = 3
		mButton3.layer.shadowOpacity = 5
		mButton3.layer.shadowOffset = CGSize(width: 1, height: 1)
		mButton3.layer.shadowColor = UIColor.darkGray.cgColor
		mButton3.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 1, isVertical: true)
						//		<action selector="OHBtnAct:" destination="-1" eventType="touchUpInside" id="Pl4-dj-ZMH"/>
		mButton3.addTarget(self, action: #selector(OHBtnAct(_:)), for: .touchUpInside)
		innerStack.addArrangedSubview(mButton3)
//lineBreakMode="middleTruncation" springLoaded="YES" translatesAutoresizingMaskIntoConstraints="NO" id="nwr-PL-aCb" customClass="GradientButton" customModule="YumaApp" customModuleProvider="target">
		let mButton4 = UIButton(frame: CGRect(x: 88, y: 70, width: 179, height: 50))
		mButton4.isOpaque = false
		mButton4.cornerRadius = 3
		mButton4.contentMode = UIViewContentMode.scaleToFill
		mButton4.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
		mButton4.contentVerticalAlignment = UIControlContentVerticalAlignment.center
		//mButton4.buttonType = UIButtonType.roundedRect
		mButton4.reversesTitleShadowWhenHighlighted = true
		mButton4.translatesAutoresizingMaskIntoConstraints = false
		mButton4.backgroundColor = R.color.YumaRed
						//		<fontDescription key="fontDescription" type="system" weight="medium" pointSize="16"/>
						//		<size key="titleShadowOffset" width="1" height="1"/>
						//		<state key="normal" title="CREDIT SLIPS">
		mButton4.setTitle(R.string.CreditSlips, for: .normal)
		mButton4.setTitleColor(UIColor.white, for: .normal)
		mButton4.setTitleShadowColor(R.color.YumaDRed, for: .normal)
		mButton4.layer.cornerRadius = 3
		mButton4.layer.borderColor = R.color.YumaDRed.cgColor
		mButton4.layer.borderWidth = 1
		//mButton4.layer.addSublayer(CALayer(layer: ))
		//mButton4.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4)
		mButton4.layer.shadowRadius = 3
		mButton4.layer.shadowOpacity = 5
		mButton4.layer.shadowOffset = CGSize(width: 1, height: 1)
		mButton4.layer.shadowColor = UIColor.darkGray.cgColor
						//		<action selector="CSBtnAct:" destination="-1" eventType="touchUpInside" id="r1g-Jc-k7O"/>
		mButton4.addTarget(self, action: #selector(CSBtnAct(_:)), for: .touchUpInside)
		innerStack.addArrangedSubview(mButton4)
		//innerStack.backgroundColor = UIColor.white
		mButton3.leadingAnchor.constraint(equalTo: mButton4.leadingAnchor).isActive = true
		mButton1.leadingAnchor.constraint(equalTo: mButton2.leadingAnchor).isActive = true
		//mButton1.leadingAnchor.constraint(equalTo: innerStack.leadingAnchor).isActive = true
		//mButton1.leadingAnchor.constraint(equalTo: innerStack.leadingAnchor, constant: (innerStack.frame.width-mButton1.frame.width)/2)
		//mButton1.frame.
		mButton1.centerXAnchor.constraint(equalTo: innerStack.centerXAnchor).isActive = true
		mButton2.leadingAnchor.constraint(equalTo: mButton3.leadingAnchor).isActive = true
								innerView.addSubview(innerStack)
		innerView.backgroundColor = UIColor.white//UIColor.lightGray
		innerView.shadowColor = UIColor.darkGray
		innerView.shadowOffset = CGSize(width: 0, height: 0)
		innerView.shadowOpacity = 1
		innerView.shadowRadius = 5
		innerStack.center.y = innerView.center.y
		innerStack.topAnchor.constraint(equalTo: innerView.topAnchor, constant: 20).isActive = true
		innerView.trailingAnchor.constraint(equalTo: innerStack.trailingAnchor, constant: 5).isActive = true
		innerView.bottomAnchor.constraint(equalTo: innerStack.bottomAnchor, constant: 20).isActive = true
		innerStack.leadingAnchor.constraint(equalTo: innerView.leadingAnchor, constant: 5).isActive = true
								lowerStack.addArrangedSubview(innerView)
		lowerView.addSubview(lowerStack)
						//		<color key="backgroundColor" white="0.66666666666666663" alpha="1" colorSpace="custom" customColorSpace="genericGamma22GrayColorSpace"/>
		lowerStack.topAnchor.constraint(equalTo: lowerView.topAnchor).isActive = true
		lowerStack.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 5).isActive = true
		lowerView.trailingAnchor.constraint(equalTo: lowerStack.trailingAnchor, constant: 5).isActive = true
		allStack.addSubview(lowerView)
		allStack.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor).isActive = true
		//allStack.topAnchor.constraint(equalTo: nBar.topAnchor).isActive = true
		//nBar.leadingAnchor.constraint(equalTo: allStack.leadingAnchor).isActive = true
//		allStack.bottomAnchor.constraint(equalTo: lowerView.topAnchor).isActive = true
		lowerView.leadingAnchor.constraint(equalTo: allStack.leadingAnchor).isActive = true
		topView.addSubview(allStack)
			//		<color key="backgroundColor" white="1" alpha="1" colorSpace="custom" customColorSpace="genericGamma22GrayColorSpace"/>
			//		<constraint firstAttribute="height" secondItem="8JR-70-lh1" secondAttribute="height" id="Efd-An-7yg"/>
		topView.heightAnchor.constraint(equalTo: allStack.heightAnchor).isActive = true
			//		<constraint firstItem="8JR-70-lh1" firstAttribute="leading" secondItem="xC0-7y-wXw" secondAttribute="leading" id="N2G-He-dxZ"/>
		topView.leadingAnchor.constraint(equalTo: allStack.leadingAnchor).isActive = true
			//		<constraint firstAttribute="bottom" secondItem="8JR-70-lh1" secondAttribute="bottom" id="Vb4-vW-jEK"/>
		//topView.bottomAnchor.constraint(equalTo: allStack.bottomAnchor)
			//		<constraint firstItem="8JR-70-lh1" firstAttribute="top" secondItem="xC0-7y-wXw" secondAttribute="top" id="d4w-mp-f9E"/>
		allStack.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
			//		<constraint firstAttribute="trailing" secondItem="8JR-70-lh1" secondAttribute="trailing" id="t8p-Zh-ZCc"/>
		topView.trailingAnchor.constraint(equalTo: allStack.trailingAnchor).isActive = true
		mainView.addSubview(topView)
	//		<color key="backgroundColor" red="1" green="1" blue="1" alpha="1" colorSpace="custom" customColorSpace="sRGB"/>
	//		<constraint firstItem="jzQ-Rd-WlE" firstAttribute="bottom" secondItem="xC0-7y-wXw" secondAttribute="bottom" id="DXz-Z0-od3"/>
		//topView.bottomAnchor.constraint(equalTo: self.view.layoutMargins.bottom).isActive = true
		topView.heightAnchor.constraint(equalToConstant: self.view.layoutMargins.top).isActive = true
	//		<constraint firstItem="xC0-7y-wXw" firstAttribute="leading" secondItem="1Eu-zr-YVG" secondAttribute="leading" id="X5Q-q9-VGM"/>
		topView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
	//		<constraint firstAttribute="trailing" secondItem="xC0-7y-wXw" secondAttribute="trailing" id="bP1-9b-a8G"/>
		mainView.trailingAnchor.constraint(equalTo: topView.trailingAnchor).isActive = true
	//		<constraint firstItem="xC0-7y-wXw" firstAttribute="top" secondItem="jzQ-Rd-WlE" secondAttribute="top" id="uL3-Ej-79o"/>
		//topView.topAnchor.constraint(equalTo: self.view.frame.)
	//		<viewLayoutGuide key="safeArea" id="jzQ-Rd-WlE"/>
	//		<point key="canvasLocation" x="25.5" y="59"/>
		self.view.addSubview(mainView)
	}
*/
    override func viewDidLoad()
	{
        super.viewDidLoad()
		if #available(iOS 11.0, *)
		{
			navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		}
		else
		{
			navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
		}
		self.navigationItem.title = R.string.my_account//not working
		navTitle.title = R.string.my_account
		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
		infoBtn.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		addrBtn.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		orderHistBtn.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		creditSlipsBtn.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
        //drawXIB2()
		let store = DataStore.sharedInstance
		//print("\n\(store.addresses)\n\n")
		store.callGetCarriers()
		{
			(carriers) in
//			print(carriers)
		}
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

	
	@IBAction func CSBtnAct(_ sender: Any)
	{
		print("MyAccCSViewController")
		self.present(MyAccCSViewController(), animated: true, completion: nil)
	}
	@IBAction func OHBtnAct(_ sender: Any)
	{
		print("MyAccOHViewController")
		self.present(MyAccOHViewController(), animated: true, completion: nil)
	}
	@IBAction func addrBtnAct(_ sender: Any)
	{
		print("MyAccAddrViewController")
		let vc = UIStoryboard(name: "AddrStoryboard", bundle: nil).instantiateInitialViewController() as UIViewController!
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		//self.present(MyAccAddrViewController(), animated: true, completion: nil)
		self.present(vc!/*(collectViewLayout: layout)*/, animated: true, completion: nil)
	}
	@IBAction func infoBtnAct(_ sender: Any)
	{
		print("MyAccInfoViewController")
		self.present(MyAccInfoViewController(), animated: true, completion: nil)
	}
	@IBAction func navHelpAct(_ sender: Any)
	{
	}
	@IBAction func navCloseAct(_ sender: Any)
	{
		self.dismiss(animated: true, completion: nil)
	}
	
}
