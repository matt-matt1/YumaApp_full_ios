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
	let backgroundAlpha: CGFloat = 0.7
	let titleBarHeight: CGFloat = 50
	let buttonHeight: CGFloat = 42
	let minWidth: CGFloat = 300
	let maxWidth: CGFloat = 600
	let minHeight: CGFloat = 420
	let maxHeight: CGFloat = 800
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
//		2018-06-23 12:39:35.410 YumaApp[45137:4391137] Unable to simultaneously satisfy constraints.
//		Probably at least one of the constraints in the following list is one you don't want.
//		Try this:
//		(1) look at each constraint and try to figure out which you don't expect;
//		(2) find the code that added the unwanted constraint or constraints and fix it.
//		(
//		"<NSLayoutConstraint:0x171c7820 H:|-(10)-[UITextField:0x171a4530]   (Names: '|':UIView:0x15d45060 )>",
//		"<NSLayoutConstraint:0x171c7aa0 H:[UITextField:0x171a4530]-(4)-[UILabel:0x171ae4b0'\Uf06e']>",
//		"<NSLayoutConstraint:0x171c7b00 H:[UILabel:0x171ae4b0'\Uf06e'(21)]>",
//		"<NSLayoutConstraint:0x171c7ad0 H:[UILabel:0x171ae4b0'\Uf06e']-(10)-|   (Names: '|':UIView:0x15d45060 )>",
//		"<NSLayoutConstraint:0x171c7e20 H:|-(10)-[UILabel:0x171bf8f0'Exisiting']   (Names: '|':UIView:0x17293fb0 )>",
//		"<NSLayoutConstraint:0x171c7f10 H:[UILabel:0x171bf8f0'Exisiting'(120)]>",
//		"<NSLayoutConstraint:0x171c7f50 H:[UILabel:0x171bf8f0'Exisiting']-(10)-[UIView:0x15d45060]>",
//		"<NSLayoutConstraint:0x171c7f80 H:[UIView:0x15d45060]-(10)-|   (Names: '|':UIView:0x17293fb0 )>",
//		"<NSLayoutConstraint:0x171c8330 H:|-(0)-[UIView:0x17293fb0]   (Names: '|':YumaApp.InputField:0x17293bb0 )>",
//		"<NSLayoutConstraint:0x171c8380 H:[UIView:0x17293fb0]-(0)-|   (Names: '|':YumaApp.InputField:0x17293bb0 )>",
//		"<NSLayoutConstraint:0x172a5b20 'fittingSizeHTarget' H:[YumaApp.InputField:0x17293bb0(0)]>"
//		)
//
//		Will attempt to recover by breaking constraint
//		<NSLayoutConstraint:0x171c7aa0 H:[UITextField:0x171a4530]-(4)-[UILabel:0x171ae4b0'']>
//
//		Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
//		The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
//		2018-06-23 12:39:35.414 YumaApp[45137:4391137] Unable to simultaneously satisfy constraints.
//		Probably at least one of the constraints in the following list is one you don't want.
//		Try this:
//		(1) look at each constraint and try to figure out which you don't expect;
//		(2) find the code that added the unwanted constraint or constraints and fix it.
//		(
//		"<NSLayoutConstraint:0x171c7e20 H:|-(10)-[UILabel:0x171bf8f0'Exisiting']   (Names: '|':UIView:0x17293fb0 )>",
//		"<NSLayoutConstraint:0x171c7f10 H:[UILabel:0x171bf8f0'Exisiting'(120)]>",
//		"<NSLayoutConstraint:0x171c7f50 H:[UILabel:0x171bf8f0'Exisiting']-(10)-[UIView:0x15d45060]>",
//		"<NSLayoutConstraint:0x171c7f80 H:[UIView:0x15d45060]-(10)-|   (Names: '|':UIView:0x17293fb0 )>",
//		"<NSLayoutConstraint:0x171c8330 H:|-(0)-[UIView:0x17293fb0]   (Names: '|':YumaApp.InputField:0x17293bb0 )>",
//		"<NSLayoutConstraint:0x171c8380 H:[UIView:0x17293fb0]-(0)-|   (Names: '|':YumaApp.InputField:0x17293bb0 )>",
//		"<NSLayoutConstraint:0x172a5b20 'fittingSizeHTarget' H:[YumaApp.InputField:0x17293bb0(0)]>"
//		)
//
//		Will attempt to recover by breaking constraint
//		<NSLayoutConstraint:0x171c7f50 H:[UILabel:0x171bf8f0'Exisiting']-(10)-[UIView:0x15d45060]>
//
//		Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
//		The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
//		2018-06-23 12:39:35.417 YumaApp[45137:4391137] Unable to simultaneously satisfy constraints.
//		Probably at least one of the constraints in the following list is one you don't want.
//		Try this:
//		(1) look at each constraint and try to figure out which you don't expect;
//		(2) find the code that added the unwanted constraint or constraints and fix it.
//		(
//		"<NSLayoutConstraint:0x171c7d60 H:|-(10)-[UILabel:0x171a3730]   (Names: '|':UIView:0x17293fb0 )>",
//		"<NSLayoutConstraint:0x171c7df0 H:[UILabel:0x171a3730]-(10)-|   (Names: '|':UIView:0x17293fb0 )>",
//		"<NSLayoutConstraint:0x171c8330 H:|-(0)-[UIView:0x17293fb0]   (Names: '|':YumaApp.InputField:0x17293bb0 )>",
//		"<NSLayoutConstraint:0x171c8380 H:[UIView:0x17293fb0]-(0)-|   (Names: '|':YumaApp.InputField:0x17293bb0 )>",
//		"<NSLayoutConstraint:0x172a5b20 'fittingSizeHTarget' H:[YumaApp.InputField:0x17293bb0(0)]>"
//		)
//
//		Will attempt to recover by breaking constraint
//		<NSLayoutConstraint:0x171c7df0 H:[UILabel:0x171a3730]-(10)-|   (Names: '|':UIView:0x17293fb0 )>
//
//		Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
//		The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
//		2018-06-23 12:39:35.428 YumaApp[45137:4391137] Unable to simultaneously satisfy constraints.
//		Probably at least one of the constraints in the following list is one you don't want.
//		Try this:
//		(1) look at each constraint and try to figure out which you don't expect;
//		(2) find the code that added the unwanted constraint or constraints and fix it.
//		(
//		"<NSLayoutConstraint:0x171cb750 H:|-(10)-[UITextField:0x171c8b70]   (Names: '|':UIView:0x171c8a80 )>",
//		"<NSLayoutConstraint:0x171cb820 H:[UITextField:0x171c8b70]-(4)-[UILabel:0x171c9640'\Uf06e']>",
//		"<NSLayoutConstraint:0x171cb880 H:[UILabel:0x171c9640'\Uf06e'(21)]>",
//		"<NSLayoutConstraint:0x171cb850 H:[UILabel:0x171c9640'\Uf06e']-(10)-|   (Names: '|':UIView:0x171c8a80 )>",
//		"<NSLayoutConstraint:0x171cba90 H:|-(10)-[UILabel:0x171c8790'New password']   (Names: '|':UIView:0x171c86d0 )>",
//		"<NSLayoutConstraint:0x171cbb80 H:[UILabel:0x171c8790'New password'(120)]>",
//		"<NSLayoutConstraint:0x171cbbc0 H:[UILabel:0x171c8790'New password']-(10)-[UIView:0x171c8a80]>",
//		"<NSLayoutConstraint:0x171cbbf0 H:[UIView:0x171c8a80]-(10)-|   (Names: '|':UIView:0x171c86d0 )>",
//		"<NSLayoutConstraint:0x171cbf70 H:|-(0)-[UIView:0x171c86d0]   (Names: '|':YumaApp.InputField:0x171c85a0 )>",
//		"<NSLayoutConstraint:0x171cbfe0 H:[UIView:0x171c86d0]-(0)-|   (Names: '|':YumaApp.InputField:0x171c85a0 )>",
//		"<NSLayoutConstraint:0x172a8120 'fittingSizeHTarget' H:[YumaApp.InputField:0x171c85a0(0)]>"
//		)
//
//		Will attempt to recover by breaking constraint
//		<NSLayoutConstraint:0x171cb820 H:[UITextField:0x171c8b70]-(4)-[UILabel:0x171c9640'']>
//
//		Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
//		The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
//		2018-06-23 12:39:35.431 YumaApp[45137:4391137] Unable to simultaneously satisfy constraints.
//		Probably at least one of the constraints in the following list is one you don't want.
//		Try this:
//		(1) look at each constraint and try to figure out which you don't expect;
//		(2) find the code that added the unwanted constraint or constraints and fix it.
//		(
//		"<NSLayoutConstraint:0x171cba90 H:|-(10)-[UILabel:0x171c8790'New password']   (Names: '|':UIView:0x171c86d0 )>",
//		"<NSLayoutConstraint:0x171cbb80 H:[UILabel:0x171c8790'New password'(120)]>",
//		"<NSLayoutConstraint:0x171cbbc0 H:[UILabel:0x171c8790'New password']-(10)-[UIView:0x171c8a80]>",
//		"<NSLayoutConstraint:0x171cbbf0 H:[UIView:0x171c8a80]-(10)-|   (Names: '|':UIView:0x171c86d0 )>",
//		"<NSLayoutConstraint:0x171cbf70 H:|-(0)-[UIView:0x171c86d0]   (Names: '|':YumaApp.InputField:0x171c85a0 )>",
//		"<NSLayoutConstraint:0x171cbfe0 H:[UIView:0x171c86d0]-(0)-|   (Names: '|':YumaApp.InputField:0x171c85a0 )>",
//		"<NSLayoutConstraint:0x172a8120 'fittingSizeHTarget' H:[YumaApp.InputField:0x171c85a0(0)]>"
//		)
//
//		Will attempt to recover by breaking constraint
//		<NSLayoutConstraint:0x171cbbc0 H:[UILabel:0x171c8790'New password']-(10)-[UIView:0x171c8a80]>
//
//		Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
//		The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
//		2018-06-23 12:39:35.435 YumaApp[45137:4391137] Unable to simultaneously satisfy constraints.
//		Probably at least one of the constraints in the following list is one you don't want.
//		Try this:
//		(1) look at each constraint and try to figure out which you don't expect;
//		(2) find the code that added the unwanted constraint or constraints and fix it.
//		(
//		"<NSLayoutConstraint:0x171cb9c0 H:|-(10)-[UILabel:0x171c9360]   (Names: '|':UIView:0x171c86d0 )>",
//		"<NSLayoutConstraint:0x171cba60 H:[UILabel:0x171c9360]-(10)-|   (Names: '|':UIView:0x171c86d0 )>",
//		"<NSLayoutConstraint:0x171cbf70 H:|-(0)-[UIView:0x171c86d0]   (Names: '|':YumaApp.InputField:0x171c85a0 )>",
//		"<NSLayoutConstraint:0x171cbfe0 H:[UIView:0x171c86d0]-(0)-|   (Names: '|':YumaApp.InputField:0x171c85a0 )>",
//		"<NSLayoutConstraint:0x172a8120 'fittingSizeHTarget' H:[YumaApp.InputField:0x171c85a0(0)]>"
//		)
//
//		Will attempt to recover by breaking constraint
//		<NSLayoutConstraint:0x171cba60 H:[UILabel:0x171c9360]-(10)-|   (Names: '|':UIView:0x171c86d0 )>
//
//		Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
//		The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
//		2018-06-23 12:39:35.446 YumaApp[45137:4391137] Unable to simultaneously satisfy constraints.
//		Probably at least one of the constraints in the following list is one you don't want.
//		Try this:
//		(1) look at each constraint and try to figure out which you don't expect;
//		(2) find the code that added the unwanted constraint or constraints and fix it.
//		(
//		"<NSLayoutConstraint:0x171cef00 H:|-(10)-[UITextField:0x171cc4c0]   (Names: '|':UIView:0x171cc400 )>",
//		"<NSLayoutConstraint:0x171cefd0 H:[UITextField:0x171cc4c0]-(4)-[UILabel:0x171ccf10'\Uf06e']>",
//		"<NSLayoutConstraint:0x171cf030 H:[UILabel:0x171ccf10'\Uf06e'(21)]>",
//		"<NSLayoutConstraint:0x171cf000 H:[UILabel:0x171ccf10'\Uf06e']-(10)-|   (Names: '|':UIView:0x171cc400 )>",
//		"<NSLayoutConstraint:0x171cf240 H:|-(10)-[UILabel:0x171cc2f0'Verify']   (Names: '|':UIView:0x171cc230 )>",
//		"<NSLayoutConstraint:0x171cf330 H:[UILabel:0x171cc2f0'Verify'(120)]>",
//		"<NSLayoutConstraint:0x171cf370 H:[UILabel:0x171cc2f0'Verify']-(10)-[UIView:0x171cc400]>",
//		"<NSLayoutConstraint:0x171cf3a0 H:[UIView:0x171cc400]-(10)-|   (Names: '|':UIView:0x171cc230 )>",
//		"<NSLayoutConstraint:0x171cf720 H:|-(0)-[UIView:0x171cc230]   (Names: '|':YumaApp.InputField:0x171cc100 )>",
//		"<NSLayoutConstraint:0x171cf790 H:[UIView:0x171cc230]-(0)-|   (Names: '|':YumaApp.InputField:0x171cc100 )>",
//		"<NSLayoutConstraint:0x171dc250 'fittingSizeHTarget' H:[YumaApp.InputField:0x171cc100(0)]>"
//		)
//
//		Will attempt to recover by breaking constraint
//		<NSLayoutConstraint:0x171cefd0 H:[UITextField:0x171cc4c0]-(4)-[UILabel:0x171ccf10'']>
//
//		Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
//		The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
//		2018-06-23 12:39:35.449 YumaApp[45137:4391137] Unable to simultaneously satisfy constraints.
//		Probably at least one of the constraints in the following list is one you don't want.
//		Try this:
//		(1) look at each constraint and try to figure out which you don't expect;
//		(2) find the code that added the unwanted constraint or constraints and fix it.
//		(
//		"<NSLayoutConstraint:0x171cf240 H:|-(10)-[UILabel:0x171cc2f0'Verify']   (Names: '|':UIView:0x171cc230 )>",
//		"<NSLayoutConstraint:0x171cf330 H:[UILabel:0x171cc2f0'Verify'(120)]>",
//		"<NSLayoutConstraint:0x171cf370 H:[UILabel:0x171cc2f0'Verify']-(10)-[UIView:0x171cc400]>",
//		"<NSLayoutConstraint:0x171cf3a0 H:[UIView:0x171cc400]-(10)-|   (Names: '|':UIView:0x171cc230 )>",
//		"<NSLayoutConstraint:0x171cf720 H:|-(0)-[UIView:0x171cc230]   (Names: '|':YumaApp.InputField:0x171cc100 )>",
//		"<NSLayoutConstraint:0x171cf790 H:[UIView:0x171cc230]-(0)-|   (Names: '|':YumaApp.InputField:0x171cc100 )>",
//		"<NSLayoutConstraint:0x171dc250 'fittingSizeHTarget' H:[YumaApp.InputField:0x171cc100(0)]>"
//		)
//
//		Will attempt to recover by breaking constraint
//		<NSLayoutConstraint:0x171cf370 H:[UILabel:0x171cc2f0'Verify']-(10)-[UIView:0x171cc400]>
//
//		Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
//		The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
//		2018-06-23 12:39:35.452 YumaApp[45137:4391137] Unable to simultaneously satisfy constraints.
//		Probably at least one of the constraints in the following list is one you don't want.
//		Try this:
//		(1) look at each constraint and try to figure out which you don't expect;
//		(2) find the code that added the unwanted constraint or constraints and fix it.
//		(
//		"<NSLayoutConstraint:0x171cf170 H:|-(10)-[UILabel:0x171ccc30]   (Names: '|':UIView:0x171cc230 )>",
//		"<NSLayoutConstraint:0x171cf210 H:[UILabel:0x171ccc30]-(10)-|   (Names: '|':UIView:0x171cc230 )>",
//		"<NSLayoutConstraint:0x171cf720 H:|-(0)-[UIView:0x171cc230]   (Names: '|':YumaApp.InputField:0x171cc100 )>",
//		"<NSLayoutConstraint:0x171cf790 H:[UIView:0x171cc230]-(0)-|   (Names: '|':YumaApp.InputField:0x171cc100 )>",
//		"<NSLayoutConstraint:0x171dc250 'fittingSizeHTarget' H:[YumaApp.InputField:0x171cc100(0)]>"
//		)
//
//		Will attempt to recover by breaking constraint
//		<NSLayoutConstraint:0x171cf210 H:[UILabel:0x171ccc30]-(10)-|   (Names: '|':UIView:0x171cc230 )>
//
//		Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
//		The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
//		2018-06-23 12:39:35.464 YumaApp[45137:4391137] Unable to simultaneously satisfy constraints.
//		Probably at least one of the constraints in the following list is one you don't want.
//		Try this:
//		(1) look at each constraint and try to figure out which you don't expect;
//		(2) find the code that added the unwanted constraint or constraints and fix it.
//		(
//		"<NSLayoutConstraint:0x171c7820 H:|-(10)-[UITextField:0x171a4530]   (Names: '|':UIView:0x15d45060 )>",
//		"<NSLayoutConstraint:0x171c7aa0 H:[UITextField:0x171a4530]-(4)-[UILabel:0x171ae4b0'\Uf06e']>",
//		"<NSLayoutConstraint:0x171c7b00 H:[UILabel:0x171ae4b0'\Uf06e'(21)]>",
//		"<NSLayoutConstraint:0x171c7ad0 H:[UILabel:0x171ae4b0'\Uf06e']-(10)-|   (Names: '|':UIView:0x15d45060 )>",
//		"<NSLayoutConstraint:0x171c7e20 H:|-(10)-[UILabel:0x171bf8f0'Exisiting']   (Names: '|':UIView:0x17293fb0 )>",
//		"<NSLayoutConstraint:0x171c7f10 H:[UILabel:0x171bf8f0'Exisiting'(120)]>",
//		"<NSLayoutConstraint:0x171c7f50 H:[UILabel:0x171bf8f0'Exisiting']-(10)-[UIView:0x15d45060]>",
//		"<NSLayoutConstraint:0x171c7f80 H:[UIView:0x15d45060]-(10)-|   (Names: '|':UIView:0x17293fb0 )>",
//		"<NSLayoutConstraint:0x171c8330 H:|-(0)-[UIView:0x17293fb0]   (Names: '|':YumaApp.InputField:0x17293bb0 )>",
//		"<NSLayoutConstraint:0x171c8380 H:[UIView:0x17293fb0]-(0)-|   (Names: '|':YumaApp.InputField:0x17293bb0 )>",
//		"<NSLayoutConstraint:0x172aa3c0 'fittingSizeHTarget' H:[YumaApp.InputField:0x17293bb0(0)]>"
//		)
//
//		Will attempt to recover by breaking constraint
//		<NSLayoutConstraint:0x171c7aa0 H:[UITextField:0x171a4530]-(4)-[UILabel:0x171ae4b0'']>
//
//		Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
//		The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
//		2018-06-23 12:39:35.468 YumaApp[45137:4391137] Unable to simultaneously satisfy constraints.
//		Probably at least one of the constraints in the following list is one you don't want.
//		Try this:
//		(1) look at each constraint and try to figure out which you don't expect;
//		(2) find the code that added the unwanted constraint or constraints and fix it.
//		(
//		"<NSLayoutConstraint:0x171c7e20 H:|-(10)-[UILabel:0x171bf8f0'Exisiting']   (Names: '|':UIView:0x17293fb0 )>",
//		"<NSLayoutConstraint:0x171c7f10 H:[UILabel:0x171bf8f0'Exisiting'(120)]>",
//		"<NSLayoutConstraint:0x171c7f50 H:[UILabel:0x171bf8f0'Exisiting']-(10)-[UIView:0x15d45060]>",
//		"<NSLayoutConstraint:0x171c7f80 H:[UIView:0x15d45060]-(10)-|   (Names: '|':UIView:0x17293fb0 )>",
//		"<NSLayoutConstraint:0x171c8330 H:|-(0)-[UIView:0x17293fb0]   (Names: '|':YumaApp.InputField:0x17293bb0 )>",
//		"<NSLayoutConstraint:0x171c8380 H:[UIView:0x17293fb0]-(0)-|   (Names: '|':YumaApp.InputField:0x17293bb0 )>",
//		"<NSLayoutConstraint:0x172aa3c0 'fittingSizeHTarget' H:[YumaApp.InputField:0x17293bb0(0)]>"
//		)
//
//		Will attempt to recover by breaking constraint
//		<NSLayoutConstraint:0x171c7f50 H:[UILabel:0x171bf8f0'Exisiting']-(10)-[UIView:0x15d45060]>
//
//		Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
//		The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
//		2018-06-23 12:39:35.473 YumaApp[45137:4391137] Unable to simultaneously satisfy constraints.
//		Probably at least one of the constraints in the following list is one you don't want.
//		Try this:
//		(1) look at each constraint and try to figure out which you don't expect;
//		(2) find the code that added the unwanted constraint or constraints and fix it.
//		(
//		"<NSLayoutConstraint:0x171c7d60 H:|-(10)-[UILabel:0x171a3730]   (Names: '|':UIView:0x17293fb0 )>",
//		"<NSLayoutConstraint:0x171c7df0 H:[UILabel:0x171a3730]-(10)-|   (Names: '|':UIView:0x17293fb0 )>",
//		"<NSLayoutConstraint:0x171c8330 H:|-(0)-[UIView:0x17293fb0]   (Names: '|':YumaApp.InputField:0x17293bb0 )>",
//		"<NSLayoutConstraint:0x171c8380 H:[UIView:0x17293fb0]-(0)-|   (Names: '|':YumaApp.InputField:0x17293bb0 )>",
//		"<NSLayoutConstraint:0x172aa3c0 'fittingSizeHTarget' H:[YumaApp.InputField:0x17293bb0(0)]>"
//		)
//
//		Will attempt to recover by breaking constraint
//		<NSLayoutConstraint:0x171c7df0 H:[UILabel:0x171a3730]-(10)-|   (Names: '|':UIView:0x17293fb0 )>
//
//		Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
//		The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
//		2018-06-23 12:39:35.488 YumaApp[45137:4391137] Unable to simultaneously satisfy constraints.
//		Probably at least one of the constraints in the following list is one you don't want.
//		Try this:
//		(1) look at each constraint and try to figure out which you don't expect;
//		(2) find the code that added the unwanted constraint or constraints and fix it.
//		(
//		"<NSLayoutConstraint:0x171cb750 H:|-(10)-[UITextField:0x171c8b70]   (Names: '|':UIView:0x171c8a80 )>",
//		"<NSLayoutConstraint:0x171cb820 H:[UITextField:0x171c8b70]-(4)-[UILabel:0x171c9640'\Uf06e']>",
//		"<NSLayoutConstraint:0x171cb880 H:[UILabel:0x171c9640'\Uf06e'(21)]>",
//		"<NSLayoutConstraint:0x171cb850 H:[UILabel:0x171c9640'\Uf06e']-(10)-|   (Names: '|':UIView:0x171c8a80 )>",
//		"<NSLayoutConstraint:0x171cba90 H:|-(10)-[UILabel:0x171c8790'New password']   (Names: '|':UIView:0x171c86d0 )>",
//		"<NSLayoutConstraint:0x171cbb80 H:[UILabel:0x171c8790'New password'(120)]>",
//		"<NSLayoutConstraint:0x171cbbc0 H:[UILabel:0x171c8790'New password']-(10)-[UIView:0x171c8a80]>",
//		"<NSLayoutConstraint:0x171cbbf0 H:[UIView:0x171c8a80]-(10)-|   (Names: '|':UIView:0x171c86d0 )>",
//		"<NSLayoutConstraint:0x171cbf70 H:|-(0)-[UIView:0x171c86d0]   (Names: '|':YumaApp.InputField:0x171c85a0 )>",
//		"<NSLayoutConstraint:0x171cbfe0 H:[UIView:0x171c86d0]-(0)-|   (Names: '|':YumaApp.InputField:0x171c85a0 )>",
//		"<NSLayoutConstraint:0x15e3b520 'fittingSizeHTarget' H:[YumaApp.InputField:0x171c85a0(0)]>"
//		)
//
//		Will attempt to recover by breaking constraint
//		<NSLayoutConstraint:0x171cb820 H:[UITextField:0x171c8b70]-(4)-[UILabel:0x171c9640'']>
//
//		Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
//		The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
//		2018-06-23 12:39:35.491 YumaApp[45137:4391137] Unable to simultaneously satisfy constraints.
//		Probably at least one of the constraints in the following list is one you don't want.
//		Try this:
//		(1) look at each constraint and try to figure out which you don't expect;
//		(2) find the code that added the unwanted constraint or constraints and fix it.
//		(
//		"<NSLayoutConstraint:0x171cba90 H:|-(10)-[UILabel:0x171c8790'New password']   (Names: '|':UIView:0x171c86d0 )>",
//		"<NSLayoutConstraint:0x171cbb80 H:[UILabel:0x171c8790'New password'(120)]>",
//		"<NSLayoutConstraint:0x171cbbc0 H:[UILabel:0x171c8790'New password']-(10)-[UIView:0x171c8a80]>",
//		"<NSLayoutConstraint:0x171cbbf0 H:[UIView:0x171c8a80]-(10)-|   (Names: '|':UIView:0x171c86d0 )>",
//		"<NSLayoutConstraint:0x171cbf70 H:|-(0)-[UIView:0x171c86d0]   (Names: '|':YumaApp.InputField:0x171c85a0 )>",
//		"<NSLayoutConstraint:0x171cbfe0 H:[UIView:0x171c86d0]-(0)-|   (Names: '|':YumaApp.InputField:0x171c85a0 )>",
//		"<NSLayoutConstraint:0x15e3b520 'fittingSizeHTarget' H:[YumaApp.InputField:0x171c85a0(0)]>"
//		)
//
//		Will attempt to recover by breaking constraint
//		<NSLayoutConstraint:0x171cbbc0 H:[UILabel:0x171c8790'New password']-(10)-[UIView:0x171c8a80]>
//
//		Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
//		The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
//		2018-06-23 12:39:35.497 YumaApp[45137:4391137] Unable to simultaneously satisfy constraints.
//		Probably at least one of the constraints in the following list is one you don't want.
//		Try this:
//		(1) look at each constraint and try to figure out which you don't expect;
//		(2) find the code that added the unwanted constraint or constraints and fix it.
//		(
//		"<NSLayoutConstraint:0x171cb9c0 H:|-(10)-[UILabel:0x171c9360]   (Names: '|':UIView:0x171c86d0 )>",
//		"<NSLayoutConstraint:0x171cba60 H:[UILabel:0x171c9360]-(10)-|   (Names: '|':UIView:0x171c86d0 )>",
//		"<NSLayoutConstraint:0x171cbf70 H:|-(0)-[UIView:0x171c86d0]   (Names: '|':YumaApp.InputField:0x171c85a0 )>",
//		"<NSLayoutConstraint:0x171cbfe0 H:[UIView:0x171c86d0]-(0)-|   (Names: '|':YumaApp.InputField:0x171c85a0 )>",
//		"<NSLayoutConstraint:0x15e3b520 'fittingSizeHTarget' H:[YumaApp.InputField:0x171c85a0(0)]>"
//		)
//
//		Will attempt to recover by breaking constraint
//		<NSLayoutConstraint:0x171cba60 H:[UILabel:0x171c9360]-(10)-|   (Names: '|':UIView:0x171c86d0 )>
//
//		Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
//		The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
//		2018-06-23 12:39:35.508 YumaApp[45137:4391137] Unable to simultaneously satisfy constraints.
//		Probably at least one of the constraints in the following list is one you don't want.
//		Try this:
//		(1) look at each constraint and try to figure out which you don't expect;
//		(2) find the code that added the unwanted constraint or constraints and fix it.
//		(
//		"<NSLayoutConstraint:0x171cef00 H:|-(10)-[UITextField:0x171cc4c0]   (Names: '|':UIView:0x171cc400 )>",
//		"<NSLayoutConstraint:0x171cefd0 H:[UITextField:0x171cc4c0]-(4)-[UILabel:0x171ccf10'\Uf06e']>",
//		"<NSLayoutConstraint:0x171cf030 H:[UILabel:0x171ccf10'\Uf06e'(21)]>",
//		"<NSLayoutConstraint:0x171cf000 H:[UILabel:0x171ccf10'\Uf06e']-(10)-|   (Names: '|':UIView:0x171cc400 )>",
//		"<NSLayoutConstraint:0x171cf240 H:|-(10)-[UILabel:0x171cc2f0'Verify']   (Names: '|':UIView:0x171cc230 )>",
//		"<NSLayoutConstraint:0x171cf330 H:[UILabel:0x171cc2f0'Verify'(120)]>",
//		"<NSLayoutConstraint:0x171cf370 H:[UILabel:0x171cc2f0'Verify']-(10)-[UIView:0x171cc400]>",
//		"<NSLayoutConstraint:0x171cf3a0 H:[UIView:0x171cc400]-(10)-|   (Names: '|':UIView:0x171cc230 )>",
//		"<NSLayoutConstraint:0x171cf720 H:|-(0)-[UIView:0x171cc230]   (Names: '|':YumaApp.InputField:0x171cc100 )>",
//		"<NSLayoutConstraint:0x171cf790 H:[UIView:0x171cc230]-(0)-|   (Names: '|':YumaApp.InputField:0x171cc100 )>",
//		"<NSLayoutConstraint:0x171e1c80 'fittingSizeHTarget' H:[YumaApp.InputField:0x171cc100(0)]>"
//		)
//
//		Will attempt to recover by breaking constraint
//		<NSLayoutConstraint:0x171cefd0 H:[UITextField:0x171cc4c0]-(4)-[UILabel:0x171ccf10'']>
//
//		Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
//		The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
//		2018-06-23 12:39:35.512 YumaApp[45137:4391137] Unable to simultaneously satisfy constraints.
//		Probably at least one of the constraints in the following list is one you don't want.
//		Try this:
//		(1) look at each constraint and try to figure out which you don't expect;
//		(2) find the code that added the unwanted constraint or constraints and fix it.
//		(
//		"<NSLayoutConstraint:0x171cf240 H:|-(10)-[UILabel:0x171cc2f0'Verify']   (Names: '|':UIView:0x171cc230 )>",
//		"<NSLayoutConstraint:0x171cf330 H:[UILabel:0x171cc2f0'Verify'(120)]>",
//		"<NSLayoutConstraint:0x171cf370 H:[UILabel:0x171cc2f0'Verify']-(10)-[UIView:0x171cc400]>",
//		"<NSLayoutConstraint:0x171cf3a0 H:[UIView:0x171cc400]-(10)-|   (Names: '|':UIView:0x171cc230 )>",
//		"<NSLayoutConstraint:0x171cf720 H:|-(0)-[UIView:0x171cc230]   (Names: '|':YumaApp.InputField:0x171cc100 )>",
//		"<NSLayoutConstraint:0x171cf790 H:[UIView:0x171cc230]-(0)-|   (Names: '|':YumaApp.InputField:0x171cc100 )>",
//		"<NSLayoutConstraint:0x171e1c80 'fittingSizeHTarget' H:[YumaApp.InputField:0x171cc100(0)]>"
//		)
//
//		Will attempt to recover by breaking constraint
//		<NSLayoutConstraint:0x171cf370 H:[UILabel:0x171cc2f0'Verify']-(10)-[UIView:0x171cc400]>
//
//		Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
//		The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
//		2018-06-23 12:39:35.516 YumaApp[45137:4391137] Unable to simultaneously satisfy constraints.
//		Probably at least one of the constraints in the following list is one you don't want.
//		Try this:
//		(1) look at each constraint and try to figure out which you don't expect;
//		(2) find the code that added the unwanted constraint or constraints and fix it.
//		(
//		"<NSLayoutConstraint:0x171cf170 H:|-(10)-[UILabel:0x171ccc30]   (Names: '|':UIView:0x171cc230 )>",
//		"<NSLayoutConstraint:0x171cf210 H:[UILabel:0x171ccc30]-(10)-|   (Names: '|':UIView:0x171cc230 )>",
//		"<NSLayoutConstraint:0x171cf720 H:|-(0)-[UIView:0x171cc230]   (Names: '|':YumaApp.InputField:0x171cc100 )>",
//		"<NSLayoutConstraint:0x171cf790 H:[UIView:0x171cc230]-(0)-|   (Names: '|':YumaApp.InputField:0x171cc100 )>",
//		"<NSLayoutConstraint:0x171e1c80 'fittingSizeHTarget' H:[YumaApp.InputField:0x171cc100(0)]>"
//		)
//
//		Will attempt to recover by breaking constraint
//		<NSLayoutConstraint:0x171cf210 H:[UILabel:0x171ccc30]-(10)-|   (Names: '|':UIView:0x171cc230 )>
//
//		Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
//		The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
//		2018-06-23 12:39:35.530 YumaApp[45137:4391137] Unable to simultaneously satisfy constraints.
//		Probably at least one of the constraints in the following list is one you don't want.
//		Try this:
//		(1) look at each constraint and try to figure out which you don't expect;
//		(2) find the code that added the unwanted constraint or constraints and fix it.
//		(
//		"<NSLayoutConstraint:0x15edbbb0 H:|-(0)-[YumaApp.InputField:0x17293bb0]   (Names: '|':UIStackView:0x17291860 )>",
//		"<NSLayoutConstraint:0x15defd00 H:|-(100)-[UILabel:0x171c8490'Generate']   (Names: '|':UIStackView:0x17291860 )>",
//		"<NSLayoutConstraint:0x171e3660 'UISV-alignment' YumaApp.InputField:0x17293bb0.leading == UILabel:0x171c8490'Generate'.leading>"
//		)
//
//		Will attempt to recover by breaking constraint
//		<NSLayoutConstraint:0x171e3660 'UISV-alignment' YumaApp.InputField:0x17293bb0.leading == UILabel:0x171c8490'Generate'.leading>
//
//		Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
//		The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
//		2018-06-23 12:39:35.541 YumaApp[45137:4391137] Unable to simultaneously satisfy constraints.
//		Probably at least one of the constraints in the following list is one you don't want.
//		Try this:
//		(1) look at each constraint and try to figure out which you don't expect;
//		(2) find the code that added the unwanted constraint or constraints and fix it.
//		(
//		"<NSLayoutConstraint:0x171c7820 H:|-(10)-[UITextField:0x171a4530]   (Names: '|':UIView:0x15d45060 )>",
//		"<NSLayoutConstraint:0x171c7aa0 H:[UITextField:0x171a4530]-(4)-[UILabel:0x171ae4b0'\Uf06e']>",
//		"<NSLayoutConstraint:0x171c7b00 H:[UILabel:0x171ae4b0'\Uf06e'(21)]>",
//		"<NSLayoutConstraint:0x171c7ad0 H:[UILabel:0x171ae4b0'\Uf06e']-(10)-|   (Names: '|':UIView:0x15d45060 )>",
//		"<NSLayoutConstraint:0x171c7e20 H:|-(10)-[UILabel:0x171bf8f0'Exisiting']   (Names: '|':UIView:0x17293fb0 )>",
//		"<NSLayoutConstraint:0x171c7f10 H:[UILabel:0x171bf8f0'Exisiting'(120)]>",
//		"<NSLayoutConstraint:0x171c7f50 H:[UILabel:0x171bf8f0'Exisiting']-(10)-[UIView:0x15d45060]>",
//		"<NSLayoutConstraint:0x171c7f80 H:[UIView:0x15d45060]-(10)-|   (Names: '|':UIView:0x17293fb0 )>",
//		"<NSLayoutConstraint:0x171c8330 H:|-(0)-[UIView:0x17293fb0]   (Names: '|':YumaApp.InputField:0x17293bb0 )>",
//		"<NSLayoutConstraint:0x171c8380 H:[UIView:0x17293fb0]-(0)-|   (Names: '|':YumaApp.InputField:0x17293bb0 )>",
//		"<NSLayoutConstraint:0x171e5c40 'fittingSizeHTarget' H:[YumaApp.InputField:0x17293bb0(0)]>"
//		)
//
//		Will attempt to recover by breaking constraint
//		<NSLayoutConstraint:0x171c7aa0 H:[UITextField:0x171a4530]-(4)-[UILabel:0x171ae4b0'']>
//
//		Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
//		The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
//		2018-06-23 12:39:35.545 YumaApp[45137:4391137] Unable to simultaneously satisfy constraints.
//		Probably at least one of the constraints in the following list is one you don't want.
//		Try this:
//		(1) look at each constraint and try to figure out which you don't expect;
//		(2) find the code that added the unwanted constraint or constraints and fix it.
//		(
//		"<NSLayoutConstraint:0x171c7e20 H:|-(10)-[UILabel:0x171bf8f0'Exisiting']   (Names: '|':UIView:0x17293fb0 )>",
//		"<NSLayoutConstraint:0x171c7f10 H:[UILabel:0x171bf8f0'Exisiting'(120)]>",
//		"<NSLayoutConstraint:0x171c7f50 H:[UILabel:0x171bf8f0'Exisiting']-(10)-[UIView:0x15d45060]>",
//		"<NSLayoutConstraint:0x171c7f80 H:[UIView:0x15d45060]-(10)-|   (Names: '|':UIView:0x17293fb0 )>",
//		"<NSLayoutConstraint:0x171c8330 H:|-(0)-[UIView:0x17293fb0]   (Names: '|':YumaApp.InputField:0x17293bb0 )>",
//		"<NSLayoutConstraint:0x171c8380 H:[UIView:0x17293fb0]-(0)-|   (Names: '|':YumaApp.InputField:0x17293bb0 )>",
//		"<NSLayoutConstraint:0x171e5c40 'fittingSizeHTarget' H:[YumaApp.InputField:0x17293bb0(0)]>"
//		)
//
//		Will attempt to recover by breaking constraint
//		<NSLayoutConstraint:0x171c7f50 H:[UILabel:0x171bf8f0'Exisiting']-(10)-[UIView:0x15d45060]>
//
//		Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
//		The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
//		2018-06-23 12:39:35.550 YumaApp[45137:4391137] Unable to simultaneously satisfy constraints.
//		Probably at least one of the constraints in the following list is one you don't want.
//		Try this:
//		(1) look at each constraint and try to figure out which you don't expect;
//		(2) find the code that added the unwanted constraint or constraints and fix it.
//		(
//		"<NSLayoutConstraint:0x171c7d60 H:|-(10)-[UILabel:0x171a3730]   (Names: '|':UIView:0x17293fb0 )>",
//		"<NSLayoutConstraint:0x171c7df0 H:[UILabel:0x171a3730]-(10)-|   (Names: '|':UIView:0x17293fb0 )>",
//		"<NSLayoutConstraint:0x171c8330 H:|-(0)-[UIView:0x17293fb0]   (Names: '|':YumaApp.InputField:0x17293bb0 )>",
//		"<NSLayoutConstraint:0x171c8380 H:[UIView:0x17293fb0]-(0)-|   (Names: '|':YumaApp.InputField:0x17293bb0 )>",
//		"<NSLayoutConstraint:0x171e5c40 'fittingSizeHTarget' H:[YumaApp.InputField:0x17293bb0(0)]>"
//		)
//
//		Will attempt to recover by breaking constraint
//		<NSLayoutConstraint:0x171c7df0 H:[UILabel:0x171a3730]-(10)-|   (Names: '|':UIView:0x17293fb0 )>
//
//		Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
//		The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
//		2018-06-23 12:39:35.560 YumaApp[45137:4391137] Unable to simultaneously satisfy constraints.
//		Probably at least one of the constraints in the following list is one you don't want.
//		Try this:
//		(1) look at each constraint and try to figure out which you don't expect;
//		(2) find the code that added the unwanted constraint or constraints and fix it.
//		(
//		"<NSLayoutConstraint:0x171cb750 H:|-(10)-[UITextField:0x171c8b70]   (Names: '|':UIView:0x171c8a80 )>",
//		"<NSLayoutConstraint:0x171cb820 H:[UITextField:0x171c8b70]-(4)-[UILabel:0x171c9640'\Uf06e']>",
//		"<NSLayoutConstraint:0x171cb880 H:[UILabel:0x171c9640'\Uf06e'(21)]>",
//		"<NSLayoutConstraint:0x171cb850 H:[UILabel:0x171c9640'\Uf06e']-(10)-|   (Names: '|':UIView:0x171c8a80 )>",
//		"<NSLayoutConstraint:0x171cba90 H:|-(10)-[UILabel:0x171c8790'New password']   (Names: '|':UIView:0x171c86d0 )>",
//		"<NSLayoutConstraint:0x171cbb80 H:[UILabel:0x171c8790'New password'(120)]>",
//		"<NSLayoutConstraint:0x171cbbc0 H:[UILabel:0x171c8790'New password']-(10)-[UIView:0x171c8a80]>",
//		"<NSLayoutConstraint:0x171cbbf0 H:[UIView:0x171c8a80]-(10)-|   (Names: '|':UIView:0x171c86d0 )>",
//		"<NSLayoutConstraint:0x171cbf70 H:|-(0)-[UIView:0x171c86d0]   (Names: '|':YumaApp.InputField:0x171c85a0 )>",
//		"<NSLayoutConstraint:0x171cbfe0 H:[UIView:0x171c86d0]-(0)-|   (Names: '|':YumaApp.InputField:0x171c85a0 )>",
//		"<NSLayoutConstraint:0x171e85f0 'fittingSizeHTarget' H:[YumaApp.InputField:0x171c85a0(0)]>"
//		)
//
//		Will attempt to recover by breaking constraint
//		<NSLayoutConstraint:0x171cb820 H:[UITextField:0x171c8b70]-(4)-[UILabel:0x171c9640'']>
//
//		Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
//		The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
//		2018-06-23 12:39:35.564 YumaApp[45137:4391137] Unable to simultaneously satisfy constraints.
//		Probably at least one of the constraints in the following list is one you don't want.
//		Try this:
//		(1) look at each constraint and try to figure out which you don't expect;
//		(2) find the code that added the unwanted constraint or constraints and fix it.
//		(
//		"<NSLayoutConstraint:0x171cba90 H:|-(10)-[UILabel:0x171c8790'New password']   (Names: '|':UIView:0x171c86d0 )>",
//		"<NSLayoutConstraint:0x171cbb80 H:[UILabel:0x171c8790'New password'(120)]>",
//		"<NSLayoutConstraint:0x171cbbc0 H:[UILabel:0x171c8790'New password']-(10)-[UIView:0x171c8a80]>",
//		"<NSLayoutConstraint:0x171cbbf0 H:[UIView:0x171c8a80]-(10)-|   (Names: '|':UIView:0x171c86d0 )>",
//		"<NSLayoutConstraint:0x171cbf70 H:|-(0)-[UIView:0x171c86d0]   (Names: '|':YumaApp.InputField:0x171c85a0 )>",
//		"<NSLayoutConstraint:0x171cbfe0 H:[UIView:0x171c86d0]-(0)-|   (Names: '|':YumaApp.InputField:0x171c85a0 )>",
//		"<NSLayoutConstraint:0x171e85f0 'fittingSizeHTarget' H:[YumaApp.InputField:0x171c85a0(0)]>"
//		)
//
//		Will attempt to recover by breaking constraint
//		<NSLayoutConstraint:0x171cbbc0 H:[UILabel:0x171c8790'New password']-(10)-[UIView:0x171c8a80]>
//
//		Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
//		The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
//		2018-06-23 12:39:35.567 YumaApp[45137:4391137] Unable to simultaneously satisfy constraints.
//		Probably at least one of the constraints in the following list is one you don't want.
//		Try this:
//		(1) look at each constraint and try to figure out which you don't expect;
//		(2) find the code that added the unwanted constraint or constraints and fix it.
//		(
//		"<NSLayoutConstraint:0x171cb9c0 H:|-(10)-[UILabel:0x171c9360]   (Names: '|':UIView:0x171c86d0 )>",
//		"<NSLayoutConstraint:0x171cba60 H:[UILabel:0x171c9360]-(10)-|   (Names: '|':UIView:0x171c86d0 )>",
//		"<NSLayoutConstraint:0x171cbf70 H:|-(0)-[UIView:0x171c86d0]   (Names: '|':YumaApp.InputField:0x171c85a0 )>",
//		"<NSLayoutConstraint:0x171cbfe0 H:[UIView:0x171c86d0]-(0)-|   (Names: '|':YumaApp.InputField:0x171c85a0 )>",
//		"<NSLayoutConstraint:0x171e85f0 'fittingSizeHTarget' H:[YumaApp.InputField:0x171c85a0(0)]>"
//		)
//
//		Will attempt to recover by breaking constraint
//		<NSLayoutConstraint:0x171cba60 H:[UILabel:0x171c9360]-(10)-|   (Names: '|':UIView:0x171c86d0 )>
//
//		Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
//		The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
//		2018-06-23 12:39:35.579 YumaApp[45137:4391137] Unable to simultaneously satisfy constraints.
//		Probably at least one of the constraints in the following list is one you don't want.
//		Try this:
//		(1) look at each constraint and try to figure out which you don't expect;
//		(2) find the code that added the unwanted constraint or constraints and fix it.
//		(
//		"<NSLayoutConstraint:0x171cef00 H:|-(10)-[UITextField:0x171cc4c0]   (Names: '|':UIView:0x171cc400 )>",
//		"<NSLayoutConstraint:0x171cefd0 H:[UITextField:0x171cc4c0]-(4)-[UILabel:0x171ccf10'\Uf06e']>",
//		"<NSLayoutConstraint:0x171cf030 H:[UILabel:0x171ccf10'\Uf06e'(21)]>",
//		"<NSLayoutConstraint:0x171cf000 H:[UILabel:0x171ccf10'\Uf06e']-(10)-|   (Names: '|':UIView:0x171cc400 )>",
//		"<NSLayoutConstraint:0x171cf240 H:|-(10)-[UILabel:0x171cc2f0'Verify']   (Names: '|':UIView:0x171cc230 )>",
//		"<NSLayoutConstraint:0x171cf330 H:[UILabel:0x171cc2f0'Verify'(120)]>",
//		"<NSLayoutConstraint:0x171cf370 H:[UILabel:0x171cc2f0'Verify']-(10)-[UIView:0x171cc400]>",
//		"<NSLayoutConstraint:0x171cf3a0 H:[UIView:0x171cc400]-(10)-|   (Names: '|':UIView:0x171cc230 )>",
//		"<NSLayoutConstraint:0x171cf720 H:|-(0)-[UIView:0x171cc230]   (Names: '|':YumaApp.InputField:0x171cc100 )>",
//		"<NSLayoutConstraint:0x171cf790 H:[UIView:0x171cc230]-(0)-|   (Names: '|':YumaApp.InputField:0x171cc100 )>",
//		"<NSLayoutConstraint:0x172b9960 'fittingSizeHTarget' H:[YumaApp.InputField:0x171cc100(0)]>"
//		)
//
//		Will attempt to recover by breaking constraint
//		<NSLayoutConstraint:0x171cefd0 H:[UITextField:0x171cc4c0]-(4)-[UILabel:0x171ccf10'']>
//
//		Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
//		The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
//		2018-06-23 12:39:35.582 YumaApp[45137:4391137] Unable to simultaneously satisfy constraints.
//		Probably at least one of the constraints in the following list is one you don't want.
//		Try this:
//		(1) look at each constraint and try to figure out which you don't expect;
//		(2) find the code that added the unwanted constraint or constraints and fix it.
//		(
//		"<NSLayoutConstraint:0x171cf240 H:|-(10)-[UILabel:0x171cc2f0'Verify']   (Names: '|':UIView:0x171cc230 )>",
//		"<NSLayoutConstraint:0x171cf330 H:[UILabel:0x171cc2f0'Verify'(120)]>",
//		"<NSLayoutConstraint:0x171cf370 H:[UILabel:0x171cc2f0'Verify']-(10)-[UIView:0x171cc400]>",
//		"<NSLayoutConstraint:0x171cf3a0 H:[UIView:0x171cc400]-(10)-|   (Names: '|':UIView:0x171cc230 )>",
//		"<NSLayoutConstraint:0x171cf720 H:|-(0)-[UIView:0x171cc230]   (Names: '|':YumaApp.InputField:0x171cc100 )>",
//		"<NSLayoutConstraint:0x171cf790 H:[UIView:0x171cc230]-(0)-|   (Names: '|':YumaApp.InputField:0x171cc100 )>",
//		"<NSLayoutConstraint:0x172b9960 'fittingSizeHTarget' H:[YumaApp.InputField:0x171cc100(0)]>"
//		)
//
//		Will attempt to recover by breaking constraint
//		<NSLayoutConstraint:0x171cf370 H:[UILabel:0x171cc2f0'Verify']-(10)-[UIView:0x171cc400]>
//
//		Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
//		The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
//		2018-06-23 12:39:35.586 YumaApp[45137:4391137] Unable to simultaneously satisfy constraints.
//		Probably at least one of the constraints in the following list is one you don't want.
//		Try this:
//		(1) look at each constraint and try to figure out which you don't expect;
//		(2) find the code that added the unwanted constraint or constraints and fix it.
//		(
//		"<NSLayoutConstraint:0x171cf170 H:|-(10)-[UILabel:0x171ccc30]   (Names: '|':UIView:0x171cc230 )>",
//		"<NSLayoutConstraint:0x171cf210 H:[UILabel:0x171ccc30]-(10)-|   (Names: '|':UIView:0x171cc230 )>",
//		"<NSLayoutConstraint:0x171cf720 H:|-(0)-[UIView:0x171cc230]   (Names: '|':YumaApp.InputField:0x171cc100 )>",
//		"<NSLayoutConstraint:0x171cf790 H:[UIView:0x171cc230]-(0)-|   (Names: '|':YumaApp.InputField:0x171cc100 )>",
//		"<NSLayoutConstraint:0x172b9960 'fittingSizeHTarget' H:[YumaApp.InputField:0x171cc100(0)]>"
//		)
//
//		Will attempt to recover by breaking constraint
//		<NSLayoutConstraint:0x171cf210 H:[UILabel:0x171ccc30]-(10)-|   (Names: '|':UIView:0x171cc230 )>
//
//		Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
//		The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
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
		stack.addConstraintsWithFormat(format: "H:|[v0]|", views: exisiting)
		stack.addConstraintsWithFormat(format: "H:|-100-[v0]|", views: generate)
		stack.addConstraintsWithFormat(format: "H:|[v0]|", views: newPW)
		stack.addConstraintsWithFormat(format: "H:|[v0]|", views: verifyPW)
//		stack.addConstraintsWithFormat(format: "V:|[v0(90)][v1]-5-[v2(90)]-5-[v3(90)]|", views: exisiting, generate, newPW, verifyPW)
		dialogWindow.addSubview(stack)
//		dialogWindow.addConstraintsWithFormat(format: "V:[v0]", views: stack)
		dialogWindow.addConstraintsWithFormat(format: "H:|[v0]|", views: stack)
		exisiting.invalid.text = "\(R.string.wrong) \(R.string.txtPass)"
		newPW.invalid.text = "\(R.string.invalid) \(R.string.txtPass) - \(R.string.minPass)"
		verifyPW.invalid.text = "\(R.string.txtPass) \(R.string.mismatch)"
	}


	func clearErrors()
	{
		exisiting.fieldFrame.borderColor = UIColor.clear
		exisiting.invalid.alpha = 0
		newPW.invalid.alpha = 0
		verifyPW.invalid.alpha = 0
		newPW.fieldFrame.borderColor = UIColor.clear
		verifyPW.fieldFrame.borderColor = UIColor.clear
	}


	func drawButton()
	{
		buttonLeft.setTitle(R.string.dismiss.uppercased(), for: .normal)
		buttonRight.setTitle(R.string.complete.uppercased(), for: .normal)
		dialogWindow.addSubview(buttonLeft)
		dialogWindow.addSubview(buttonRight)
		dialogWindow.addConstraintsWithFormat(format: "H:|-15-[v0(\(dialogWidth/3))]", views: buttonLeft)
		dialogWindow.addConstraintsWithFormat(format: "H:[v0(\(dialogWidth/3))]-15-|", views: buttonRight)
		dialogWindow.addConstraint(NSLayoutConstraint(item: buttonLeft, attribute: .centerY, relatedBy: .equal, toItem: buttonRight, attribute: .centerY, multiplier: 1, constant: 0))
		dialogWindow.addConstraint(NSLayoutConstraint(item: buttonRight, attribute: .height, relatedBy: .equal, toItem: dialogWindow, attribute: .height, multiplier: 0, constant: buttonHeight))
		buttonLeft.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonLeftTapped(_:))))
		buttonRight.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonRightTapped(_:))))
	}
	
	
	func drawDialog()
	{
		view.addSubview(dialogWindow)
		view.addConstraint(NSLayoutConstraint(item: dialogWindow, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0, constant: dialogWidth+10))
		view.addConstraint(NSLayoutConstraint(item: dialogWindow, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0, constant: dialogHeight+10))
		view.addConstraint(NSLayoutConstraint(item: dialogWindow, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0))
		view.addConstraint(NSLayoutConstraint(item: dialogWindow, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0))
	}


	private func checkFields() -> Bool
	{
		var success = true
		clearErrors()
		if exisiting.textEdit.text == nil || (exisiting.textEdit.text?.isEmpty)!
		{
			exisiting.invalid.alpha = 1
			exisiting.fieldFrame.borderColor = UIColor.red
			success = false
		}
		if newPW.textEdit.text == nil || (newPW.textEdit.text?.isEmpty)! || !isValid(.passwd, newPW.textEdit.text!)
		{
			newPW.invalid.alpha = 1
			newPW.fieldFrame.borderColor = UIColor.red
			success = false
		}
		if verifyPW.textEdit.text == nil || (verifyPW.textEdit.text?.isEmpty)! || verifyPW.textEdit.text != newPW.textEdit.text
		{
			verifyPW.invalid.alpha = 1
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
//		else
//		{
//			newPW.invalid.alpha = 1
//			newPW.fieldFrame.borderColor = .red
//		}
	}

	@objc func doGenerate(_ sender: UITapGestureRecognizer)
	{
		if isValid(.passwd, newPW.textEdit.text!) && ((newPW.textEdit.text != nil && !(newPW.textEdit.text?.isEmpty)!) || (verifyPW.textEdit.text != nil && !(verifyPW.textEdit.text?.isEmpty)!))
		{
			OperationQueue.main.addOperation
			{
				myAlertOKCancel(self, title: R.string.txtPass, message: R.string.overw, okAction: {
					let (passwd, formatted) = self.store.makePassword()
					self.newPW.textEdit.text = passwd
					self.verifyPW.textEdit.text = passwd
					self.store.myAlert(title: R.string.txtPass, message: "", attributedMessage: formatted, viewController: self)
				}, cancelAction: {
				}, completion: {
				})
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
