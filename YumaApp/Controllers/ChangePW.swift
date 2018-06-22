//
//  ChangePW.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-05-09.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


protocol PopupDelegate
{
	func popupValueSelected(value: String)
}


private let reuseIdentifier = "helpCell"

class ChangePW: UIViewController, UIGestureRecognizerDelegate
{
	let store = DataStore.sharedInstance
	let dialogWindow: UIView =
	{
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.white
		view.isUserInteractionEnabled = true
		view.cornerRadius = 20
		view.shadowColor = R.color.YumaDRed
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
	let exisiting: InputField =
	{
		let view = InputField(frame: .zero, inputType: .hiddenLikePassword, hasShowHideIcon: true)
		view.translatesAutoresizingMaskIntoConstraints = false
		view.label.text = R.string.exist
		view.label.textColor = UIColor.darkGray
		view.inputType = .hiddenLikePassword
		view.displayShowHideIcon = true
		return view
	}()
	let generate: UILabel =
	{
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.text = R.string.generate
		view.textColor = R.color.YumaRed
		view.shadowColor = R.color.YumaYel
		view.shadowOffset = CGSize(width: 1, height: 1)
		view.shadowRadius = 3
		//NEVER PLACE GESTURE-RECOGNIOSERS HERE
		//view.isUserInteractionEnabled = true
		//view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(doGenerate(_:))))
		return view
	}()
	let newPW: InputField =
	{
		let view = InputField(frame: .zero, inputType: .hiddenLikePassword, hasShowHideIcon: true)
		view.translatesAutoresizingMaskIntoConstraints = false
		view.label.text = R.string.newPW
		view.label.textColor = UIColor.darkGray
		view.inputType = .hiddenLikePassword
		view.displayShowHideIcon = true
		return view
	}()
	let verifyPW: InputField =
	{
		let view = InputField(frame: .zero, inputType: .hiddenLikePassword, hasShowHideIcon: true)
		view.translatesAutoresizingMaskIntoConstraints = false
		view.label.text = R.string.verify
		view.label.textColor = UIColor.darkGray
		view.inputType = .hiddenLikePassword
		view.displayShowHideIcon = true
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
	var delegate: PopupDelegate?
//	let redArea = UIView()
	//let blueArea = UIView()
//	let greenArea = UIView()
//	let purpleArea = UIView()
	let stack: UIStackView =
	{
		let view = UIStackView()
		return view
	}()


	// MARK: Overrides
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		dialogWidth = min(max(view.frame.width/2, minWidth), maxWidth)
		dialogHeight = min(max(view.frame.height/2, minHeight), maxHeight)
		UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveEaseOut, animations: {
			self.view.backgroundColor = R.color.YumaRed.withAlphaComponent(self.backgroundAlpha)
		}, completion: nil)

		drawTitle()
		drawFields()
		drawButton()

		let str = "V:|[v0(\(titleBarHeight))]-5-[v1]-5-[v2(\(buttonHeight))]-5-|"
		dialogWindow.addConstraintsWithFormat(format: str, views: titleLabel, stack, buttonLeft)

		drawDialog()
	}


	override func viewDidLayoutSubviews()
	{
		super.viewDidLayoutSubviews()
		_ = buttonLeft.addBackgroundGradient(colors: [R.color.YumaRed.cgColor, R.color.YumaYel.cgColor], isVertical: true)
		buttonLeft.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		_ = buttonRight.addBackgroundGradient(colors: [R.color.YumaRed.cgColor, R.color.YumaYel.cgColor], isVertical: true)
		buttonRight.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
	}


	// MARK: Methods
	private func drawTitle()
	{
		titleLabel.text = R.string.changePass.uppercased()
		dialogWindow.addSubview(titleLabel)
		dialogWindow.addConstraintsWithFormat(format: "H:|[v0]|", views: titleLabel)
	}


	func drawFields()
	{
		generate.isUserInteractionEnabled = true
		generate.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(doGenerate(_:))))
		clearErrors()
		stack.addArrangedSubview(exisiting)
		stack.addArrangedSubview(generate)
		stack.addArrangedSubview(newPW)
		stack.addArrangedSubview(verifyPW)
		stack.spacing = 5
		stack.isUserInteractionEnabled = true
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.distribution = .fillProportionally
		stack.axis = .vertical
		dialogWindow.addSubview(stack)
		stack.addConstraintsWithFormat(format: "H:|[v0]|", views: exisiting)
		stack.addConstraintsWithFormat(format: "H:|-100-[v0]|", views: generate)
		stack.addConstraintsWithFormat(format: "H:|[v0]|", views: newPW)
		stack.addConstraintsWithFormat(format: "H:|[v0]|", views: verifyPW)
		stack.addConstraintsWithFormat(format: "V:|[v0(90)][v1]-5-[v2(90)]-5-[v3(90)]|", views: exisiting, generate, newPW, verifyPW)
		dialogWindow.addConstraintsWithFormat(format: "V:[v0]", views: stack)
		dialogWindow.addConstraintsWithFormat(format: "H:|-5-[v0]-5-|", views: stack)
	}


	func clearErrors()
	{
		exisiting.fieldFrame.borderColor = UIColor.clear
		exisiting.invalid.text = ""
		newPW.fieldFrame.borderColor = UIColor.clear
		newPW.invalid.text = ""
		verifyPW.fieldFrame.borderColor = UIColor.clear
		verifyPW.invalid.text = ""
	}


	func drawButton()
	{
		buttonLeft.setTitle(R.string.dismiss.uppercased(), for: .normal)
		buttonRight.setTitle(R.string.complete.uppercased(), for: .normal)
		dialogWindow.addSubview(buttonLeft)
		dialogWindow.addSubview(buttonRight)
		dialogWindow.addConstraintsWithFormat(format: "H:|-20-[v0(\(dialogWidth/3))][v1(\(dialogWidth/3))]-20-|", views: buttonLeft, buttonRight)
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


	private func checkFields() -> Bool
	{
		var success = true
		clearErrors()
		if exisiting.textEdit.text == nil || (exisiting.textEdit.text != nil && (exisiting.textEdit.text?.isEmpty)!)
		{
			exisiting.invalid.text = "\(R.string.invalid) \(R.string.txtPass)"
			exisiting.fieldFrame.borderColor = UIColor.red
			success = false
		}
		if newPW.textEdit.text == nil || (newPW.textEdit.text != nil && (newPW.textEdit.text?.isEmpty)!)
		{
			newPW.invalid.text = "\(R.string.invalid) \(R.string.txtPass)"
			newPW.fieldFrame.borderColor = UIColor.red
			success = false
		}
		if verifyPW.textEdit.text == nil || (verifyPW.textEdit.text != nil && ((verifyPW.textEdit.text?.isEmpty)! || verifyPW.textEdit.text != newPW.textEdit.text))
		{
			verifyPW.invalid.text = "\(R.string.invalid) \(R.string.txtPass)"
			verifyPW.fieldFrame.borderColor = UIColor.red
			success = false
		}
		return success
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
	{
		store.flexView(view: buttonRight)
		if checkFields()
		{
			delegate?.popupValueSelected(value: newPW.textEdit.text!)
			self.dismiss(animated: true, completion: nil)
		}
	}

	@objc func doGenerate(_ sender: UITapGestureRecognizer)
	{
		if (newPW.textEdit.text != nil && !(newPW.textEdit.text?.isEmpty)!) || (verifyPW.textEdit.text != nil && !(verifyPW.textEdit.text?.isEmpty)!)
		{
			OperationQueue.main.addOperation
			{
				myAlertOKCancel(self, title: R.string.txtPass, message: R.string.overw, okAction: {
//					coloredBG.removeFromSuperview()
//					blurFxView.removeFromSuperview()
					let (passwd, formatted) = self.store.makePassword()
					self.newPW.textEdit.text = passwd
					self.verifyPW.textEdit.text = passwd
					self.store.myAlert(title: R.string.txtPass, message: "", attributedMessage: formatted, viewController: self)
				}, cancelAction: {
				}, completion: {
				})
//				let alert = 					UIAlertController(title: R.string.txtPass, message: R.string.overw, preferredStyle: .alert)
//				let coloredBG = 				UIView()
//				let blurFx = 					UIBlurEffect(style: .dark)
//				let blurFxView = 				UIVisualEffectView(effect: blurFx)
//				alert.titleAttributes = 		[NSAttributedString.StringAttribute(key: .foregroundColor, value: R.color.YumaRed)]
//				alert.messageAttributes = 		[NSAttributedString.StringAttribute(key: .foregroundColor, value: UIColor.darkGray)]
//				alert.view.superview?.backgroundColor = R.color.YumaRed
//				alert.view.shadowColor = 		R.color.YumaDRed
//				alert.view.shadowOffset = 		.zero
//				alert.view.shadowRadius = 		5
//				alert.view.shadowOpacity = 		1
//				alert.view.backgroundColor = 	R.color.YumaYel
//				alert.view.cornerRadius = 		15
//				coloredBG.backgroundColor = 	R.color.YumaRed
//				coloredBG.alpha = 				0.4
//				coloredBG.frame = 				self.view.bounds
//				self.view.addSubview(coloredBG)
//				blurFxView.frame = 				self.view.bounds
//				blurFxView.alpha = 				0.5
//				blurFxView.autoresizingMask = 	[.flexibleWidth, .flexibleHeight]
//				self.view.addSubview(blurFxView)
//				alert.addAction(UIAlertAction(title: R.string.cancel.uppercased(), style: .default, handler:
//					{ 	(action) in
//						coloredBG.removeFromSuperview()
//						blurFxView.removeFromSuperview()
//						return
//						//self.dismiss(animated: false, completion: nil)
//				}))
//				alert.addAction(UIAlertAction(title: R.string.proceed.uppercased(), style: .default, handler:
//					{ 	(action) in
//						coloredBG.removeFromSuperview()
//						blurFxView.removeFromSuperview()
//						let (passwd, formatted) = self.store.makePassword()
//						self.newPW.textEdit.text = passwd
//						self.verifyPW.textEdit.text = passwd
//						self.store.myAlert(title: R.string.txtPass, message: "", attributedMessage: formatted, viewController: self)
//				}))
//				self.present(alert, animated: true, completion:
//				{
//				})
			}
		}
		else
		{
			let (passwd, formatted) = store.makePassword()
			newPW.textEdit.text = passwd
			verifyPW.textEdit.text = passwd
			store.myAlert(title: R.string.txtPass, message: "", attributedMessage: formatted, viewController: self)
		}
	}
	
}
