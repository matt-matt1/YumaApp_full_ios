//
//  XibView.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-05.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

@IBDesignable
class XibView: UIView {

	var contentView: UIView?
	@IBInspectable var nibName: String?
	
	override func awakeFromNib() {
		super.awakeFromNib()
		xibSetup()
	}
	
	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		xibSetup()
		contentView?.prepareForInterfaceBuilder()
	}
	
	func xibSetup() {
		guard let view = loadViewFromNib() else { return }
		view.frame = bounds
		view.autoresizingMask =
			[.flexibleWidth, .flexibleHeight]
		addSubview(view)
		contentView = view
	}
	
	func loadViewFromNib() -> UIView? {
		guard let nibName = nibName else { return nil }
		let bundle = Bundle(for: type(of: self))
		let nib = UINib(nibName: nibName, bundle: bundle)
		return nib.instantiate(
			withOwner: self,
			options: nil).first as? UIView
	}
}


protocol LoadViewFromNib {
	
	func loadViewFromNib(withName: String) -> UIView?
}

extension LoadViewFromNib {
	
	func loadViewFromNib(withName: String) -> UIView? {
		let nibName = withName
		let bundle = Bundle(for: type(of: self) as! AnyClass)
		let nib = UINib(nibName: nibName, bundle: bundle)
		return nib.instantiate(withOwner: self, options: nil).first as? UIView
	}
}
