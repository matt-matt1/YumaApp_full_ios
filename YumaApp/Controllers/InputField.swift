//
//  InputField.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-05-06.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


enum inputType
{
	case allText
	case hiddenLikePassword
	case dateOnly
	case dateAndTime
	case timeOnly
}


class InputField: UIView
{
	var fieldFrameTop: Int = 5
	var fieldFrameLeft: Int = 10
	let fieldFrame: UIView =
	{
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.borderColor = UIColor.red
		view.borderWidth = 2
		return view
	}()
	let label: UILabel =
	{
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.text = "Label:"
		view.textAlignment = .right
		return view
	}()
	var labelMaxWidth: CGFloat = 100
	var gap: Int = 10
	let container: UIView =
	{
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.lightGray
		return view
	}()
	var containerHeight: Int = 50
	var textEditLeft: Int = 10
	let textEdit: UITextField =
	{
		let view = UITextField()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.clear
		view.tintColor = R.color.YumaRed
		view.textColor = R.color.YumaRed
		view.font = UIFont.systemFont(ofSize: 21)
		view.autocapitalizationType = .none
		view.isSecureTextEntry = true
		return view
	}()
	var textEditRight: Int = 10
	var fieldFrameRight: Int = 10
	let invalid: UILabel =
	{
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.textAlignment = .center
		view.textColor = UIColor.red
		view.text = "invalid"
		return view
	}()
	var invalidGapTop: Int = 5
	var invalidHeight: Int = 25
	var invalidGapBottom: Int = 5
	var fieldFrameBottom: Int = 5
	var inputType: inputType?
	var displayShowHideIcon = false
	let eye: UILabel =
	{
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.textAlignment = .center
		view.textColor = R.color.YumaRed
		//view.text = FontAwesome.eye.rawValue
		view.font = R.font.FontAwesomeOfSize(pointSize: 21)
		return view
	}()
	var canSee = false


	// MARK: Overrides
	override init(frame: CGRect)
	{
		super.init(frame: frame)
		if inputType != nil && inputType == .hiddenLikePassword
		{
			textEdit.isSecureTextEntry = true
		}
		drawField()
	}


	// MARK: Methods
	private func drawField()
	{
		fieldFrame.addSubview(label)
		container.addSubview(textEdit)
		if displayShowHideIcon
		{
			eye.text = canSee ? FontAwesome.eye.rawValue : FontAwesome.eyeSlash.rawValue
			container.addSubview(eye)
			container.addConstraintsWithFormat(format: "H:|-\(textEditLeft)-[v0]-\(textEditRight)-[v1]-2-|", views: textEdit, eye)
			container.addConstraint(NSLayoutConstraint(item: textEdit, attribute: .centerY, relatedBy: .equal, toItem: container, attribute: .centerY, multiplier: 1, constant: 0))
			container.addConstraint(NSLayoutConstraint(item: eye, attribute: .centerY, relatedBy: .equal, toItem: container, attribute: .centerY, multiplier: 1, constant: 0))
		}
		else
		{
			container.addConstraintsWithFormat(format: "H:|-\(textEditLeft)-[v0]-\(textEditRight)-|", views: textEdit)
			container.addConstraint(NSLayoutConstraint(item: textEdit, attribute: .centerY, relatedBy: .equal, toItem: container, attribute: .centerY, multiplier: 1, constant: 0))
		}
		fieldFrame.addSubview(container)
		fieldFrame.addSubview(invalid)
		addSubview(fieldFrame)
		fieldFrame.addConstraintsWithFormat(format: "H:|-\(fieldFrameLeft)-[v0(\(labelMaxWidth))]-\(gap)-[v1]-\(fieldFrameRight)-|", views: label, container)
		fieldFrame.addConstraintsWithFormat(format: "H:|-\(fieldFrameLeft)-[v0]-\(fieldFrameRight)-|", views: invalid)
//		fieldFrame.addConstraintsWithFormat(format: "V:|-\(fieldFrameTop)-[v0]-\(invalidGapTop)-[v1(\(invalidHeight))]-\(invalidGapBottom)-\(fieldFrameBottom)-|", views: label, invalid)
		fieldFrame.addConstraintsWithFormat(format: "V:|-\(fieldFrameTop)-[v0]-\(invalidGapTop)-[v1(\(invalidHeight))]-\(invalidGapBottom)-|", views: label, invalid)
		fieldFrame.addConstraintsWithFormat(format: "V:|-\(fieldFrameTop)-[v0(\(containerHeight))]", views: container)
		container.addConstraintsWithFormat(format: "V:|[v0]|", views: textEdit)
		fieldFrame.addConstraint(NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: container, attribute: .centerY, multiplier: 1, constant: 0))
		fieldFrame.addConstraint(NSLayoutConstraint(item: textEdit, attribute: .centerY, relatedBy: .equal, toItem: container, attribute: .centerY, multiplier: 1, constant: 0))
		addConstraintsWithFormat(format: "H:|[v0]|", views: fieldFrame)
		addConstraintsWithFormat(format: "V:|[v0]|", views: fieldFrame)
	}


	required init?(coder aDecoder: NSCoder)
	{
		super.init(coder: aDecoder)
		//fatalError("init(coder:) has not been implemented")
		if inputType != nil && inputType == .hiddenLikePassword
		{
			textEdit.isSecureTextEntry = true
		}
		drawField()
	}

}
