//
//  Entry.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-21.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

@IBDesignable
class Entry: UIView
{
	@IBOutlet var entryEntire: UIView!
	@IBOutlet weak var entryViewInner: UIView!
	@IBOutlet weak var entryLabel: UILabel!
	@IBOutlet weak var entryEdit: UITextField!
	@IBOutlet weak var entryFieldView: UIView!
	@IBOutlet weak var entryPasswordHide: UILabel!
	@IBOutlet weak var entryInvalid: UILabel!
	@IBOutlet weak var entryEditStack: UIStackView!
	@IBOutlet weak var entryView: UIView!
	@IBOutlet weak var entryStack: UIStackView!
	@IBInspectable var entryID: String = ""
	@IBInspectable var labelText: String = ""
	@IBInspectable var placeholderText: String = ""
	@IBInspectable var invalidText: String = ""
	@IBInspectable var labelsWidth: CGFloat = 125
	@IBInspectable var labelFieldSpace: CGFloat = 10
	@IBInspectable var fieldInvalidSpace: CGFloat = 5
	@IBInspectable var labelColor: UIColor = UIColor.black
	@IBInspectable var entryBorderColor: UIColor = UIColor.red
	@IBInspectable var invalidColor: UIColor = UIColor.red
	@IBInspectable var hasPasswordShowHideButton: Bool = false
	@IBInspectable var passwordShowText = ""
	@IBInspectable var passowrdHideText = ""
	@IBInspectable var fieldHeight: CGFloat = 45
	@IBInspectable var fieldTopPadding: CGFloat = 2
	@IBInspectable var fieldLeftPadding: CGFloat = 10
	@IBInspectable var fieldBottomPadding: CGFloat = 2
	@IBInspectable var fieldRightPadding: CGFloat = 10
	@IBInspectable var fieldTextColor: UIColor = .darkGray
	@IBInspectable var entryBorderWidth: CGFloat = 2
	@IBInspectable var fieldBackgroundColor: UIColor = .lightGray
	@IBInspectable var entryTopPadding: CGFloat = 5
	@IBInspectable var entryLeftPadding: CGFloat = 5
	@IBInspectable var entryBottomPadding: CGFloat = 5
	@IBInspectable var entryRightPadding: CGFloat = 5
	let nibName: String? = "Entry"
	var contentView: UIView?
	var showPassword = false


	func xibSetUp()
	{
		guard let view = loadViewFromNib() else { 	return 	}
		view.frame = bounds
		view.autoresizingMask =	[.flexibleWidth, .flexibleHeight]
		addSubview(view)
		contentView = view
		dressXib()
//		view = loadViewFromNib()
//		view.frame = self.bounds
//		view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
//		addSubview(view)
	}
	
	@objc func toggleShowHide(_ sender: Any)
	{
		if showPassword
		{
			entryPasswordHide.text = passwordShowText
			entryEdit.isSecureTextEntry = false
		}
		else
		{
			entryPasswordHide.text = passowrdHideText
			entryEdit.isSecureTextEntry = true
		}
	}
	
	func dressXib()
	{
		// entryID
		entryLabel.text = labelText
		entryLabel.textColor = labelColor
		entryInvalid.text = invalidText
		entryInvalid.textColor = invalidColor
		entryView.layer.borderColor = entryBorderColor.cgColor
		entryView.layer.borderWidth = entryBorderWidth
		if hasPasswordShowHideButton
		{
			entryPasswordHide.text = passowrdHideText
			entryPasswordHide.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleShowHide(_:))))
		}
		//entryEditStack.topAnchor.constraint(equalTo: entryFieldView.topAnchor, constant: fieldTopPadding).isActive = true
		//entryEditStack.leftAnchor.constraint(equalTo: entryFieldView.leftAnchor, constant: fieldLeftPadding).isActive = true
		//entryEditStack.bottomAnchor.constraint(equalTo: entryFieldView.bottomAnchor, constant: fieldBottomPadding).isActive = true
		//entryEditStack.rightAnchor.constraint(equalTo: entryFieldView.rightAnchor, constant: fieldRightPadding).isActive = true
		entryLabel.widthAnchor.constraint(equalToConstant: labelsWidth).isActive = true
		entryEditStack.spacing = labelFieldSpace
		entryStack.spacing = fieldInvalidSpace
		entryEdit.placeholder = placeholderText
		entryView.topAnchor.constraint(equalTo: entryViewInner.topAnchor, constant: entryTopPadding).isActive = true
		entryView.leftAnchor.constraint(equalTo: entryViewInner.leftAnchor, constant: entryLeftPadding).isActive = true
		entryView.bottomAnchor.constraint(equalTo: entryViewInner.bottomAnchor, constant: entryBottomPadding).isActive = true
		//entryView.rightAnchor.constraint(equalTo: entryViewInner.rightAnchor, constant: entryRightPadding).isActive = true
		entryEdit.heightAnchor.constraint(equalToConstant: fieldHeight)
	}
	
	override func awakeFromNib()
	{
		super.awakeFromNib()
		self.xibSetUp()
	}
	
	override func prepareForInterfaceBuilder()
	{
		super.prepareForInterfaceBuilder()
		self.xibSetUp()
		contentView?.prepareForInterfaceBuilder()
	}
	
	func loadViewFromNib() -> UIView?
	{
		guard let nibName = nibName else { 	return nil 	}
		let bundle = Bundle(for: type(of: self))
		let nib = UINib(nibName: nibName, bundle: bundle)
		return nib.instantiate(withOwner: self,	options: nil).first as? UIView
//		let bundle = Bundle(for: type(of: self))
//		let nib = UINib(nibName: nibName, bundle: bundle)
//		let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
//		return view
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		super.init(coder: aDecoder)
		xibSetUp()
	}
	
	override init(frame: CGRect)
	{
		super.init(frame: frame)
		xibSetUp()
	}
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
