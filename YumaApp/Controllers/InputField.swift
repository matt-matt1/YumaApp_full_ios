//
//  InputField.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-05-06.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

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
		view.backgroundColor = UIColor.gray
		return view
	}()
	var containerHeight: Int = 50
	var textEditLeft: Int = 10
	let textEdit: UITextField =
	{
		let view = UITextField()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.clear
		view.textColor = R.color.YumaRed
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


	// MARK: Overrides
	override init(frame: CGRect)
	{
		super.init(frame: frame)
		drawField()
	}


	// MARK: Methods
	private func drawField()
	{
		addSubview(fieldFrame)
		fieldFrame.addSubview(label)
		container.addSubview(textEdit)
		fieldFrame.addSubview(container)
		fieldFrame.addSubview(invalid)
		fieldFrame.addConstraintsWithFormat(format: "H:|-\(fieldFrameLeft)-[v0(\(labelMaxWidth))]-\(gap)-[v1]-\(fieldFrameRight)-|", views: label, container)
		container.addConstraintsWithFormat(format: "H:|-\(textEditLeft)-[v0]-\(textEditRight)-|", views: textEdit)
		container.addConstraint(NSLayoutConstraint(item: textEdit, attribute: .centerY, relatedBy: .equal, toItem: container, attribute: .centerY, multiplier: 1, constant: 0))
		fieldFrame.addConstraintsWithFormat(format: "H:|-\(fieldFrameLeft)-[v0]-\(fieldFrameRight)-|", views: invalid)
//		fieldFrame.addConstraintsWithFormat(format: "V:|-\(fieldFrameTop)-[v0]-\(invalidGapTop)-[v1(\(invalidHeight))]-\(invalidGapBottom)-\(fieldFrameBottom)-|", views: label, invalid)
		fieldFrame.addConstraintsWithFormat(format: "V:|-\(fieldFrameTop)-[v0]-\(invalidGapTop)-[v1(\(invalidHeight))]-\(invalidGapBottom)-|", views: label, invalid)
		fieldFrame.addConstraintsWithFormat(format: "V:|-\(fieldFrameTop)-[v0(\(containerHeight))]", views: container)
		container.addConstraintsWithFormat(format: "V:|[v0]|", views: textEdit)
		fieldFrame.addConstraint(NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: container, attribute: .centerY, multiplier: 1, constant: 0))
		fieldFrame.addConstraint(NSLayoutConstraint(item: textEdit, attribute: .centerY, relatedBy: .equal, toItem: container, attribute: .centerY, multiplier: 1, constant: 0))
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		super.init(coder: aDecoder)
		//fatalError("init(coder:) has not been implemented")
	}

}
