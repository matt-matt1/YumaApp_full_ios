//
//  SelectDate.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-06-17.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


class SelectDateVC: UIViewController, UISearchControllerDelegate
{
	let dformatter: DateFormatter =
	{
		let view = DateFormatter()
		view.dateFormat = "yyyy-MM-dd"
		return view
	}()
	let datePicker: UIDatePicker =
	{
		let view = UIDatePicker()
		view.timeZone = NSTimeZone.local
		view.datePickerMode = UIDatePickerMode.date
		view.backgroundColor = UIColor.white
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	var selectedDate = ""
	let dialogWindow: UIView =
	{
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.isUserInteractionEnabled = true
		view.backgroundColor = UIColor.white
		view.cornerRadius = 20
		view.shadowColor = R.color.YumaDRed.withAlphaComponent(0.5)
		view.shadowRadius = 5
		view.shadowOffset = .zero
		view.shadowOpacity = 1
		return view
	}()
	let titleLabel: UILabel =
	{
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = R.color.YumaRed
		view.text = "Title"
		//		view.cornerRadius = 20
		view.clipsToBounds = true
		view.layer.masksToBounds = true
		view.textColor = UIColor.white
		view.textAlignment = .center
		let titleShadow: NSShadow =
		{
			let view = NSShadow()
			view.shadowColor = UIColor.black
			view.shadowOffset = CGSize(width: 1, height: 1)
			return view
		}()
		view.attributedText = NSAttributedString(string: view.text!, attributes: [NSAttributedStringKey.font : UIFont(name: "AvenirNext-Bold", size: 20)!, NSAttributedStringKey.shadow : titleShadow])
		view.font = UIFont(name: "ArialRoundedMTBold", size: 20)
		view.shadowColor = UIColor.black
		view.shadowRadius = 3
		view.shadowOffset = CGSize(width: 1, height: 1)
		return view
	}()
	let buttonLeft: GradientButton =
	{
		let view = GradientButton()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.setTitle(R.string.cancel.uppercased(), for: .normal)
		view.titleLabel?.shadowOffset = CGSize(width: 2, height: 2)
		view.titleLabel?.shadowRadius = 3
		view.titleLabel?.textColor = UIColor.white
		view.setTitleShadowColor(R.color.YumaDRed, for: .normal)
		//view.widthAnchor.constraint(equalToConstant: 200).isActive = true
		view.backgroundColor = R.color.YumaRed.withAlphaComponent(0.8)
		view.cornerRadius = 3
		view.shadowColor = UIColor.darkGray
		view.shadowOffset = CGSize(width: 1, height: 1)
		view.shadowRadius = 3
		view.borderColor = R.color.YumaDRed
		view.borderWidth = 1
		//		view.shadowOpacity = 0.9
		let titleShadow: NSShadow =
		{
			let view = NSShadow()
			view.shadowColor = UIColor.black
			//			view.shadowRadius = 3
			view.shadowOffset = CGSize(width: 1, height: 1)
			return view
		}()
		view.setAttributedTitle(NSAttributedString(string: view.title(for: .normal)!, attributes: [NSAttributedStringKey.font : UIFont(name: "AvenirNext-DemiBold", size: 17)!, NSAttributedStringKey.shadow : titleShadow]), for: .normal)
		view.layer.addBackgroundGradient(colors: [R.color.YumaRed, R.color.YumaYel], isVertical: true)
		view.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 3.6, isVertical: true)
		return view
	}()
	let buttonRight: GradientButton =
	{
		let view = GradientButton()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.setTitle(R.string.cont.uppercased(), for: .normal)
		view.titleLabel?.shadowOffset = CGSize(width: 2, height: 2)
		view.titleLabel?.shadowRadius = 3
		view.titleLabel?.textColor = UIColor.white
		view.setTitleShadowColor(R.color.YumaDRed, for: .normal)
		//view.widthAnchor.constraint(equalToConstant: 200).isActive = true
		view.backgroundColor = R.color.YumaRed.withAlphaComponent(0.8)
		view.cornerRadius = 3
		view.shadowColor = UIColor.darkGray
		view.shadowOffset = CGSize(width: 1, height: 1)
		view.shadowRadius = 3
		//		view.layer.addBackgroundGradient(colors: [R.color.YumaRed, R.color.YumaYel], isVertical: true)
		//		view.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		view.borderColor = R.color.YumaDRed
		view.borderWidth = 1
		//		view.shadowOpacity = 0.9
		let titleShadow: NSShadow =
		{
			let view = NSShadow()
			view.shadowColor = UIColor.black
			//			view.shadowRadius = 3
			view.shadowOffset = CGSize(width: 1, height: 1)
			return view
		}()
		view.setAttributedTitle(NSAttributedString(string: view.title(for: .normal)!, attributes: [NSAttributedStringKey.font : UIFont(name: "AvenirNext-DemiBold", size: 17)!, NSAttributedStringKey.shadow : titleShadow]), for: .normal)
		view.layer.addBackgroundGradient(colors: [R.color.YumaRed, R.color.YumaYel], isVertical: true)
		view.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		return view
	}()
	let backgroundAlpha: CGFloat = 0.7
	let titleBarHeight: CGFloat = 50
	let buttonHeight: CGFloat = 42
	let minWidth: CGFloat = 300
	let maxWidth: CGFloat = 600
	let minHeight: CGFloat = 300
	let maxHeight: CGFloat = 600
	var dialogWidth: CGFloat = 0
	var dialogHeight: CGFloat = 0
	var noteName = Notification.Name("")
	let store = DataStore.sharedInstance


	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		dialogWidth = min(max(view.frame.width/2, minWidth), maxWidth)
		dialogHeight = min(max(view.frame.height/2, minHeight), maxHeight)
		self.view.backgroundColor = R.color.YumaRed.withAlphaComponent(backgroundAlpha)
		
		drawTitle()
		drawDatePicker()
		drawButton()
		
		let str = "V:|[v0(\(titleBarHeight))][v1]-5-[v2(\(buttonHeight))]-5-|"
		dialogWindow.addConstraintsWithFormat(format: str, views: titleLabel, datePicker, buttonLeft)
		
		drawDialog()
	}


	override func viewDidLayoutSubviews()
	{
		super.viewDidLayoutSubviews()
		//		let _ = titleLabel.addBackgroundGradient(colors: [R.color.YumaDRed.cgColor, R.color.YumaRed.cgColor], isVertical: true)
		titleLabel.text = "\(R.string.select.uppercased()) \(R.string.bDate.uppercased())"
		//		titleLabel.font = UIFont.systemFont(ofSize: 21)
		let _ = buttonLeft.addBackgroundGradient(colors: [R.color.YumaRed.cgColor, R.color.YumaYel.cgColor], isVertical: true)
		buttonLeft.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		let _ = buttonRight.addBackgroundGradient(colors: [R.color.YumaRed.cgColor, R.color.YumaYel.cgColor], isVertical: true)
		buttonRight.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
	}


	func drawTitle()
	{
		dialogWindow.addSubview(titleLabel)
		dialogWindow.addConstraintsWithFormat(format: "H:|[v0]|", views: titleLabel)
		dialogWindow.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0, constant: titleBarHeight))
	}


	func drawDatePicker()
	{
		if !selectedDate.isEmpty
		{
//			let df = DateFormatter()
//			df.dateFormat = "yyyy-mm-dd"
			datePicker.setDate(dformatter.date(from: selectedDate)!, animated: false)
		}
		dialogWindow.addSubview(datePicker)
		dialogWindow.addConstraintsWithFormat(format: "H:|[v0]|", views: datePicker)
		datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
	}


	@objc func datePickerValueChanged(_ sender: UIDatePicker)
	{
//		let df = DateFormatter()
//		df.dateFormat = "yyyy-mm-dd"
		selectedDate = dformatter.string(from: sender.date)
	}


	func drawButton()
	{
		buttonLeft.setTitle(R.string.dismiss.uppercased(), for: .normal)
		buttonRight.setTitle(R.string.complete.uppercased(), for: .normal)
		dialogWindow.addSubview(buttonLeft)
		dialogWindow.addSubview(buttonRight)
		dialogWindow.addConstraintsWithFormat(format: "H:|-20-[v0(\(dialogWidth/3))]", views: buttonLeft)
		dialogWindow.addConstraintsWithFormat(format: "H:[v0(\(dialogWidth/3))]-20-|", views: buttonRight)
		dialogWindow.addConstraint(NSLayoutConstraint(item: buttonLeft, attribute: .centerY, relatedBy: .equal, toItem: buttonRight, attribute: .centerY, multiplier: 1, constant: 0))
		dialogWindow.addConstraintsWithFormat(format: "V:[v0(\(buttonHeight))]-5-|", views: buttonLeft)
		dialogWindow.addConstraintsWithFormat(format: "V:[v0(\(buttonHeight))]-5-|", views: buttonRight)
		buttonLeft.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonLeftTapped(_:))))
		buttonRight.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonRightTapped(_:))))
	}


	func drawDialog()
	{
		view.addSubview(dialogWindow)
		view.addConstraint(NSLayoutConstraint(item: dialogWindow, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0, constant: dialogWidth))
		view.addConstraint(NSLayoutConstraint(item: dialogWindow, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0, constant: dialogHeight))
		view.addConstraint(NSLayoutConstraint(item: dialogWindow, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0))
		view.addConstraint(NSLayoutConstraint(item: dialogWindow, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0))
	}


	override func didReceiveMemoryWarning()
	{
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


	// MARK: Actions
	@objc func buttonLeftTapped(_ sender: UITapGestureRecognizer)
	{
		store.flexView(view: buttonLeft)
		self.dismiss(animated: true, completion: nil)
	}
	
	@objc func buttonRightTapped(_ sender: UITapGestureRecognizer)
//	@objc func buttonSingleTapped(_ sender: UITapGestureRecognizer)
	{
//		print(selectedDate)
		self.dismiss(animated: true, completion: nil)
//		if noteName == nil
//		{
//			noteName = MyAccInfoViewController.selectBDate
//		}
		NotificationCenter.default.post(name: noteName, object: selectedDate as String)
	}
	
}
