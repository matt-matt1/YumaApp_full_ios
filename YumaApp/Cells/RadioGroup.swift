//
//  RadioGroup.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-05-05.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


struct RadioGroupRow
{
	let labelText: 				String?
	let textAttribute: 			NSAttributedString?
	let gap: 					CGFloat?
	let labelTapAlertMessage: 	String?
	let leftMargin: 			CGFloat?
	let rightMargin: 			CGFloat?
	let radioButtonBehind: 		Bool?
	let radioButtonOuterColor: 	UIColor?
	let radioButtonInnerColor: 	UIColor?
}

class RadioGroup: NSObject
{
	/// An array of the rows (type is RadioGroupRow)
	var rows: [RadioGroupRow] = []
	/// The default selected row, if nil the first row is selected
	var defaultRow: RadioGroupRow?
	/// Default height of each row inclusive - default value is 40
	var rowHeight = 40
	/// The gap between the label and the radio button - default value is 10
	var gap: CGFloat = 10
	/// Group left margin (between left edge of screen and each label/radio button) - default value is 100
	var leftGroupMargin: CGFloat? = 100
	/// Group right margin (between each radio button/label and right edge of screen) - default value is 10
	var rightGroupMargin: CGFloat? = 10
	/// Radio button size - default value is 30
	var radioButtonSize: Int = 30
	/// Radio button inner (next to selected label) size - default value is 15
	var radioSelectSize: Int = 15
	private let replace: UIView =
	{
		let view = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.clear
		view.layer.cornerRadius = view.frame.width / 2
		return view
	}()
	private let blankCircle: UIView =
	{
		let view = UIView(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.clear
		view.layer.cornerRadius = view.frame.width / 2
		return view
	}()
	private let innerCircle: UIView =
	{
		let view = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.clear
		view.layer.cornerRadius = view.frame.width / 2
		return view
	}()


	/// Put Table of items into a UIView
	func draw() -> UIView
	{
		let output = UIView()
		var y = 0
		if rows.count > 0
		{
			for row in rows
			{
				let lbl = UILabel()
				lbl.translatesAutoresizingMaskIntoConstraints = false
				lbl.textAlignment = .left
				if row.labelText != nil
				{
					lbl.text = row.labelText
				}
				if row.textAttribute != nil
				{
					lbl.attributedText = row.textAttribute
				}
				lbl.sizeToFit()
				output.addSubview(lbl)
				let sw = UISwitch()
				sw.translatesAutoresizingMaskIntoConstraints = false
				sw.isHidden = true
				if defaultRow != nil
				{
					if defaultRow?.labelText == row.labelText
					{
						sw.isOn = true
					}
				}
				else if y == 0
				{
					sw.isOn = true
				}
				let radio = UIView(frame: CGRect(x: 0, y: 0, width: CGFloat(radioButtonSize + 5), height: CGFloat(radioButtonSize + 5)))
				radio.translatesAutoresizingMaskIntoConstraints = false
				let replace = UILabel()
				replace.translatesAutoresizingMaskIntoConstraints = false
				if row.radioButtonOuterColor != nil
				{
					replace.textColor = row.radioButtonOuterColor
				}
				replace.font = R.font.FontAwesomeOfSize(pointSize: radioButtonSize)
				replace.text = sw.isOn ? FontAwesome.dotCircleO.rawValue : FontAwesome.circleO.rawValue
				radio.addSubview(sw)
				radio.addSubview(replace)
//				radio.addSubview(blankCircle)
////				output.addConstraintsWithFormat(format: "H:[v0]", views: blankCircle)
////				output.addConstraintsWithFormat(format: "V:[v0]", views: blankCircle)
//				radio.addConstraint(NSLayoutConstraint(item: blankCircle, attribute: .centerY, relatedBy: .equal, toItem: radio, attribute: .centerY, multiplier: 1, constant: 0))
//				radio.addConstraint(NSLayoutConstraint(item: blankCircle, attribute: .centerX, relatedBy: .equal, toItem: radio, attribute: .centerX, multiplier: 1, constant: 0))
//				if sw.isOn
//				{
//					radio.addSubview(innerCircle)
////					output.addConstraintsWithFormat(format: "H:[v0]", views: innerCircle)
////					output.addConstraintsWithFormat(format: "V:[v0]", views: innerCircle)
//					radio.addConstraint(NSLayoutConstraint(item: innerCircle, attribute: .centerY, relatedBy: .equal, toItem: radio, attribute: .centerY, multiplier: 1, constant: 0))
//					radio.addConstraint(NSLayoutConstraint(item: innerCircle, attribute: .centerX, relatedBy: .equal, toItem: radio, attribute: .centerX, multiplier: 1, constant: 0))
//				}
				radio.addGestureRecognizer(UITapGestureRecognizer(target: RadioGroup.self, action: #selector(RadioGroup.onChange(_:))))
				output.addSubview(radio)
				var str = "H:"
				if leftGroupMargin != nil
				{
					str += "|-\(leftGroupMargin!)-"
				}
				str += "[v0]-\(row.gap ?? 20)-[v1]"
				if rightGroupMargin != nil
				{
					str += "-\(rightGroupMargin!)-|"
				}
				if row.radioButtonBehind != nil && row.radioButtonBehind!
				{
					output.addConstraintsWithFormat(format: str, views: lbl, radio)
				}
				else
				{
					output.addConstraintsWithFormat(format: str, views: radio, lbl)
				}
				output.addConstraintsWithFormat(format: "V:|-\(y)-[v0]", views: radio)
				output.addConstraintsWithFormat(format: "V:|-\(y)-[v0]", views: lbl)
				radio.addConstraint(NSLayoutConstraint(item: replace, attribute: .centerX, relatedBy: .equal, toItem: radio, attribute: .centerX, multiplier: 1, constant: 0))
				radio.addConstraint(NSLayoutConstraint(item: replace, attribute: .centerY, relatedBy: .equal, toItem: radio, attribute: .centerY, multiplier: 1, constant: 0))
				output.addConstraint(NSLayoutConstraint(item: lbl, attribute: .centerY, relatedBy: .equal, toItem: radio, attribute: .centerY, multiplier: 1, constant: 0))
				y += rowHeight
			}
		}
		return output
	}
	
	@objc func onChange(_ sender: UIView)
	{
		let abcd = "abcd"
		if let sw = sender.subviews.last as? UISwitch
		{
			if sw.isOn
			{
				return
			}
			else
			{
				sw.isOn = true
				let group = (sw.superview?.superview) as! UIView
					for row in group.subviews
					{
						if let rowSw = row.subviews.last as? UISwitch
						{
							rowSw.isOn = false
						}
					}
			}
		}
	}
}
