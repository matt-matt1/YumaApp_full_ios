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
	/// Email address
	case emailAddress
	/// Capitalizes the letter after a full stop (period .)
	case textCapitalizeSentances
	/// Capitalizes the letter after a space
	case textCapitalizeWords
	/// No capitalization is done
	case textCapitalizeNone
	/// Capitalizes all letters
	case textCapitalizeAll
	/// Replaces each characher with a middle dot
	case hiddenLikePassword
	/// Allows only numerials (0-9)
	case numbersOnly
	/// Allows all numerials (0-9) and slash (\), dash (-), dot (.) characters
	case dateOnly
	/// Allows all numerials (0-9) and slash (\), dash (-), dot (.), colon (:) characters
	case dateAndTime
	/// Allows all numerials (0-9) and colon (:) characters
	case timeOnly
}


class InputField: UIView
{
	var placeholder = ""
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
	var textFontSize: CGFloat = 21
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
	var showHideSize = 21
	let eye: UILabel =
	{
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.textAlignment = .center
		view.textColor = R.color.YumaRed
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
		else
		{
			textEdit.isSecureTextEntry = false
		}
		drawField()
	}
	
	init(frame: CGRect, inputType: inputType, hasShowHideIcon: Bool)
	{
		super.init(frame: frame)
		self.displayShowHideIcon = hasShowHideIcon
		textEdit.isSecureTextEntry = false
		switch inputType
		{
		case .emailAddress:
			textEdit.keyboardType = .emailAddress
			textEdit.autocapitalizationType = .none
			break
		case .textCapitalizeAll:
			textEdit.keyboardType = .asciiCapable
			textEdit.autocapitalizationType = .allCharacters
			break
		case .textCapitalizeNone:
			textEdit.keyboardType = .asciiCapable
			textEdit.autocapitalizationType = .none
			break
		case .textCapitalizeSentances:
			textEdit.keyboardType = .asciiCapable
			textEdit.autocapitalizationType = .sentences
			break
		case .textCapitalizeWords:
			textEdit.keyboardType = .asciiCapable
			textEdit.autocapitalizationType = .words
			break
		case .numbersOnly:
			textEdit.keyboardType = .decimalPad
			break
		case .dateOnly:
			textEdit.keyboardType = .phonePad
			break
		case .dateAndTime:
			textEdit.keyboardType = .phonePad
			break
		case .timeOnly:
			textEdit.keyboardType = .phonePad
			break
		case .hiddenLikePassword:
			textEdit.keyboardType = .asciiCapable
			textEdit.autocapitalizationType = .none
			textEdit.isSecureTextEntry = true
			break
		}
		drawField()
	}


	// MARK: Methods
	private func drawField()
	{
		label.adjustsFontSizeToFitWidth = true
		fieldFrame.addSubview(label)
		textEdit.placeholder = self.placeholder
		if textFontSize != 21
		{
			textEdit.font = UIFont.systemFont(ofSize: textFontSize)
		}
		container.addSubview(textEdit)
		if displayShowHideIcon
		{
			eye.text = canSee ? FontAwesome.eyeSlash.rawValue : FontAwesome.eye.rawValue
			eye.isUserInteractionEnabled = true
			eye.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleViewable(_:))))
			if showHideSize != 21
			{
				eye.font = R.font.FontAwesomeOfSize(pointSize: showHideSize)
			}
			container.addSubview(eye)
			container.addConstraintsWithFormat(format: "H:|-\(textEditLeft)-[v0]-\(max(4, textEditRight/3))-[v1(\(showHideSize))]-\(textEditRight)-|", views: textEdit, eye)
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
		fieldFrame.addConstraintsWithFormat(format: "V:|-\(fieldFrameTop)-[v0]-\(invalidGapTop)-[v1(\(invalidHeight))]-\(invalidGapBottom)-|", views: label, invalid)
		fieldFrame.addConstraintsWithFormat(format: "V:|-\(fieldFrameTop)-[v0(\(containerHeight))]", views: container)
		container.addConstraintsWithFormat(format: "V:|[v0]|", views: textEdit)
		fieldFrame.addConstraint(NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: container, attribute: .centerY, multiplier: 1, constant: 0))
		fieldFrame.addConstraint(NSLayoutConstraint(item: textEdit, attribute: .centerY, relatedBy: .equal, toItem: container, attribute: .centerY, multiplier: 1, constant: 0))
		addConstraintsWithFormat(format: "H:|[v0]|", views: fieldFrame)
		addConstraintsWithFormat(format: "V:|[v0]|", views: fieldFrame)
	}


	@objc func toggleViewable(_ sender: AnyObject)
	{
		canSee = !canSee
		eye.text = canSee ? FontAwesome.eyeSlash.rawValue : FontAwesome.eye.rawValue
		textEdit.isSecureTextEntry = canSee ? false : true
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
