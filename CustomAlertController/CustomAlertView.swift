//
//  CustomAlertView.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-22.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


///
///eg.
/// let alert = CustomAlert(title: "Hello there!! 👋🏻👋🏻", image: UIImage(named: "img")!)
/// alert.show(animated: true)
///
class CustomAlertView: UIView, AlertModal
{
	var backgroundView = UIView()
	var dialogView = UIView()
	var overlayColor = R.color.YumaRed
	var overlayAlpha: CGFloat = 0.7
	var dialogColor = UIColor.white
	var dialogShadowColor = UIColor.black
	var titleColor = R.color.YumaYel//UIColor.darkGray
	var titleBackgroundColor = R.color.YumaRed//UIColor.blue//UIColor.white
	var titleHeight: CGFloat = 75
	var titleFont = UIFont.boldSystemFont(ofSize: 18)
	var titleMessageSeparatorLineColor = UIColor.clear/*UIColor.groupTableViewBackground*/
	var titleMessageSeparatorLineHeight: CGFloat = 1
	var messageColor = UIColor.darkGray
	var messageBackgroundColor = UIColor.white
	var messageHeight: CGFloat = 50
	var messageFont = UIFont.systemFont(ofSize: 14)
	var messageButtonsSeparatorLineColor = UIColor.lightGray//UIColor.groupTableViewBackground
	var messageButtonsSeparatorLineHeight: CGFloat = 1
	var buttonsBackgroundColor = UIColor.white
	var buttonsHeight: CGFloat = 30
	var button1Text = "dismiss"
	var button1TextColor = UIColor.blue
	var button1Font = UIFont.systemFont(ofSize: 18)
	var button1Color = UIColor.blue
	var button1BackgroundColor = UIColor.red//white
	var button2Text: String?
	var button2TextColor = UIColor.blue
	var button2Font = UIFont.systemFont(ofSize: 18)
	var button2Color: UIColor?
	var button2BackgroundColor: UIColor?
	var button3Text: String?
	var button3Font = UIFont.systemFont(ofSize: 18)
	var button3TextColor = UIColor.blue
	var button3Color: UIColor?
	var button3BackgroundColor: UIColor?
	var buttonNum = 0
	var backgroundBlurRadius = 10
	var dismissOnTapBackground = false

	
	convenience init(title: String?, message: String?/*, completion: CompletionHandler*/)
	{
		self.init(frame: UIScreen.main.bounds)

		backgroundView.frame = frame
		backgroundView.backgroundColor = overlayColor//R.color.YumaRed
		backgroundView.alpha = overlayAlpha//0.6
		//backgroundView = backgroundBlurRadius
		addSubview(backgroundView)

		let dialogViewWidth = frame.width-64
		
		let titleLabel               = UILabel()
		titleLabel.backgroundColor   = titleBackgroundColor
		titleLabel.widthAnchor.constraint(equalToConstant: dialogViewWidth).isActive = true
		titleLabel.heightAnchor.constraint(equalToConstant: titleHeight).isActive = true
		titleLabel.text  = title
		titleLabel.font = titleFont
		titleLabel.textColor = titleColor
		titleLabel.textAlignment = .center

		let separatorLine               = UIView()
		separatorLine.heightAnchor.constraint(equalToConstant: titleMessageSeparatorLineHeight).isActive = true
		separatorLine.widthAnchor.constraint(equalToConstant: dialogViewWidth).isActive = true
		separatorLine.backgroundColor = titleMessageSeparatorLineColor
		
		let messageLabel               = UILabel()
		messageLabel.backgroundColor   = messageBackgroundColor
		messageLabel.widthAnchor.constraint(equalToConstant: dialogViewWidth).isActive = true
		messageLabel.heightAnchor.constraint(equalToConstant: messageHeight).isActive = true
		messageLabel.text  = message
		messageLabel.font = messageFont
		messageLabel.textColor = messageColor
		messageLabel.textAlignment = .center
		
		let separatorLine2              = UIView()
		separatorLine2.heightAnchor.constraint(equalToConstant: messageButtonsSeparatorLineHeight).isActive = true
		separatorLine2.widthAnchor.constraint(equalToConstant: dialogViewWidth).isActive = true
		separatorLine2.backgroundColor = messageButtonsSeparatorLineColor
		
		let button1              = UILabel()
		button1.translatesAutoresizingMaskIntoConstraints = false
		//button1.widthAnchor.constraint(equalToConstant: dialogViewWidth).isActive = true
		button1.textColor = button1Color
		button1.text = button1Text
		button1.font = button1Font
		button1.textAlignment = .center
		button1.translatesAutoresizingMaskIntoConstraints = false
		let button1Wrapper = UIView()
		button1Wrapper.backgroundColor = button1BackgroundColor
		button1Wrapper.addSubview(button1)
		//button1Wrapper.translatesAutoresizingMaskIntoConstraints = false
		button1Wrapper.leadingAnchor.constraint(equalTo: button1.leadingAnchor, constant: -5).isActive = true
		button1Wrapper.trailingAnchor.constraint(equalTo: button1.trailingAnchor, constant: 5).isActive = true
		button1Wrapper.centerYAnchor.constraint(equalTo: button1.centerYAnchor).isActive = true
		button1Wrapper.heightAnchor.constraint(equalToConstant: buttonsHeight).isActive = true

//		let button2              = UILabel()
//		if button2.text != nil
//		{
//			button2.backgroundColor = button2BackgroundColor
//			button2.textColor = button2Color
//			button2.text = button2Text
//			button2.font = button2Font
//			button2.textAlignment = .center
//		}
//
//		let button3              = UILabel()
//		if button3.text != nil
//		{
//			button3.backgroundColor = button3BackgroundColor
//			button3.textColor = button3Color
//			button3.text = button3Text
//			button3.font = button3Font
//			button3.textAlignment = .center
//		}
	
		let buttonsStack = UIStackView()
		buttonsStack.distribution = .equalSpacing
		buttonsStack.alignment = UIStackViewAlignment.center
		//buttonsStack.widthAnchor.constraint(equalToConstant: dialogViewWidth).isActive = true
		buttonsStack.translatesAutoresizingMaskIntoConstraints = false
		buttonsStack.layoutIfNeeded()
		buttonsStack.spacing = 0
		buttonsStack.addArrangedSubview(button1Wrapper)
//		if button2.text != nil
//		{
//			buttonsStack.addArrangedSubview(button2)
//		}
//		if button3.text != nil
//		{
//			buttonsStack.addArrangedSubview(button3)
//		}
		let buttonsView = UIView()
		buttonsView.backgroundColor = buttonsBackgroundColor
		buttonsView.heightAnchor.constraint(equalToConstant: buttonsHeight).isActive = true
		buttonsView.widthAnchor.constraint(equalToConstant: dialogViewWidth).isActive = true
		buttonsView.addSubview(buttonsStack)
		NSLayoutConstraint.activate([
			buttonsStack.centerYAnchor.constraint(equalTo: buttonsView.centerYAnchor),
			buttonsStack.centerXAnchor.constraint(equalTo: buttonsView.centerXAnchor),
			])
		
		let stackView   = UIStackView()
		stackView.axis  = UILayoutConstraintAxis.vertical
		stackView.distribution  = UIStackViewDistribution.equalSpacing
		stackView.alignment = UIStackViewAlignment.center
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.spacing   = 0
		
		//titleLabel.layoutIfNeeded()
		stackView.addArrangedSubview(titleLabel)
		//separatorLine.layoutIfNeeded()
		stackView.addArrangedSubview(separatorLine)
		//messageLabel.layoutIfNeeded()
		stackView.addArrangedSubview(messageLabel)
		//separatorLine2.layoutIfNeeded()
		stackView.addArrangedSubview(separatorLine2)
		//buttonsView.layoutIfNeeded()
		stackView.addArrangedSubview(buttonsView)
		stackView.layoutIfNeeded()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		
		dialogView.addSubview(stackView)
		
		//Constraints
		stackView.centerXAnchor.constraint(equalTo: dialogView.centerXAnchor).isActive = true
		stackView.centerYAnchor.constraint(equalTo: dialogView.centerYAnchor).isActive = true
		
//		let titleLabel = UILabel()//frame: CGRect(x: 8, y: 8, width: dialogViewWidth-16, height: 30))
//		titleLabel.backgroundColor = titleBackgroundColor
//		titleLabel.widthAnchor.constraint(equalToConstant: dialogViewWidth).isActive = true
//		titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
//		if title != nil
//		{
//			titleLabel.text = title
//		}
//		titleLabel.textColor = titleColor
//		titleLabel.textAlignment = .center
//
//		let separatorLineView = UIView()
////		if !hasTitleMessageSeperatorLinbe && title != nil
////		{
////			separatorLineView.backgroundColor = titleMessageSeparatorLineColor
////		}
////		else
////		{
////			separatorLineView.backgroundColor = UIColor.clear
////		}
//		separatorLineView.backgroundColor = (!hasTitleMessageSeperatorLinbe && title != nil) ? titleMessageSeparatorLineColor : UIColor.clear
////		separatorLineView.frame.origin = CGPoint(x: 0, y: titleLabel.frame.height + 8)
////		separatorLineView.frame.size = CGSize(width: dialogViewWidth, height: 1)
//		separatorLineView.widthAnchor.constraint(equalToConstant: dialogViewWidth).isActive = true
//		separatorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
//
//		let msgLabel = UILabel()
//		//msgLabel.frame.origin = CGPoint(x: 8, y: separatorLineView.frame.height + separatorLineView.frame.origin.y + 8)
//		//msgLabel.frame.size = CGSize(width: dialogViewWidth - 16 , height: 30)
//		if message != nil
//		{
//			msgLabel.text = message
//		}
//		msgLabel.textColor = messageColor
//		msgLabel.textAlignment = .center
//		msgLabel.backgroundColor = messageBackgroundColor
//
//		let stack = UIStackView()
//		stack.axis = UILayoutConstraintAxis.vertical
//		stack.distribution = UIStackViewDistribution.fill
//		stack.alignment = UIStackViewAlignment.center
//		stack.spacing = 0
//		stack.addArrangedSubview(titleLabel)//dialogView.addSubview(titleLabel)
//		stack.addArrangedSubview(separatorLineView)//dialogView.addSubview(separatorLineView)
//		stack.addArrangedSubview(msgLabel)//dialogView.addSubview(msgLabel)
//
//		let dialogViewHeight = titleLabel.frame.height + 8 + separatorLineView.frame.height + 8 + msgLabel.frame.height + 8
//		//dialogView.frame.origin = CGPoint(x: 32, y: frame.height)
//		//dialogView.frame.size = CGSize(width: frame.width-64, height: dialogViewHeight)
		dialogView.backgroundColor = dialogColor
		dialogView.shadowColor = dialogShadowColor//R.color.YumaDRed
		dialogView.shadowOffset = CGSize(width: 1, height: 1)
		dialogView.shadowOpacity = 1
		dialogView.shadowRadius = 5
		dialogView.layoutIfNeeded()
//		dialogView.subviews.forEach({ (view) in
//			view.layer.cornerRadius = 6
//		})
		//dialogView.cornerRadius = 10
		dialogView.layer.cornerRadius = 6
		//dialogView.layer.masksToBounds = true
//		dialogView.clipsToBounds = true
//		stack.translatesAutoresizingMaskIntoConstraints = false
//		dialogView.addSubview(stack)
		addSubview(dialogView)
//		NSLayoutConstraint.activate([
//			stack.topAnchor.constraint(equalTo: dialogView.topAnchor),
//			stack.leadingAnchor.constraint(equalTo: dialogView.leadingAnchor),
//			stack.heightAnchor.constraint(equalToConstant: dialogViewHeight),
//			stack.widthAnchor.constraint(equalToConstant: dialogViewWidth),
//			//stack.bottomAnchor.constraint(equalTo: dialogView.bottomAnchor),
//			//stack.trailingAnchor.constraint(equalTo: dialogView.trailingAnchor),
//			])
		if dismissOnTapBackground
		{
			backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
		}
	}

	@objc func didTappedOnBackgroundView()
	{
		dismiss(animated: true)
	}
	
	override init(frame: CGRect)
	{
		super.init(frame: frame)
	}
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
	
	@objc func myAction()
	{
		dismiss(animated: true)
	}
	
	func button(text: String, action: (() -> Void)?, textColor: UIColor?, backgroundColor: UIColor?)
	{
		self.button1Text = text
		var dialogViews = self.dialogView.subviews//1:SV
		let diaglogStack = dialogViews[0].subviews//5:L,V,L,V,V
		let buttonsStackView = diaglogStack[4].subviews[0] as! UIStackView
		var buttonsStack = buttonsStackView.subviews
		//var primaryButton = buttonsStackView[0]//1:L
		//var buttons = self.dialogView.subviews[0].subviews[4].subviews[0].subviews
//		buttonsStack[buttonNum].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(myAction)))
		let myBtn = UILabel()
		myBtn.translatesAutoresizingMaskIntoConstraints = false
		myBtn.text = text
		myBtn.textColor = textColor
		let myBtnWrapper = UIView()
		buttonsStackView.layoutIfNeeded()
		myBtnWrapper.backgroundColor = backgroundColor
		myBtnWrapper.addSubview(myBtn)
		NSLayoutConstraint.activate([
			myBtn.heightAnchor.constraint(equalToConstant: buttonsStack[0].frame.size.height),//Constant
			myBtn.centerYAnchor.constraint(equalTo: myBtnWrapper.centerYAnchor),
			myBtn.leadingAnchor.constraint(equalTo: myBtnWrapper.leadingAnchor, constant: 5),
			myBtn.trailingAnchor.constraint(equalTo: myBtnWrapper.trailingAnchor, constant: -5),
			])
		//(buttonsStack as! UIStackView).addArrangedSubview(myBtn)
		buttonsStackView.addArrangedSubview(myBtnWrapper)
		//primaryButton.append(myBtn)
		//buttonsStack.layoutIfNeeded()
//		if textColor != nil
//		{
//			self.button1Color = textColor!
//		}
//		if backgroundColor != nil
//		{
//			self.button1BackgroundColor = backgroundColor!
//		}
		buttonNum += 1
		if buttonNum > 2
		{
			print("may only have 3 buttons!")
		}
	}
	
}
