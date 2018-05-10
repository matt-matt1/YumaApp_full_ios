//
//  ActivityIndicator.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-02.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

/// Cusotm Activity Indicator can be used by implementing this protocol
public protocol ActivityIndicatorView {
	/// View of the activity indicator
	var view: UIView { get }
	
	/// Show activity indicator
	func show()
	
	/// Hide activity indicator
	func hide()
}

/// Factory protocol to create new ActivityIndicatorViews. Meant to be implemented when creating custom activity indicator.
public protocol ActivityIndicatorFactory {
	func create() -> ActivityIndicatorView
}

/// Default ActivityIndicatorView implementation for UIActivityIndicatorView
extension UIActivityIndicatorView: ActivityIndicatorView {
	public var view: UIView {
		return self
	}
	
	public func show() {
		self.startAnimating()
	}
	
	public func hide() {
		self.stopAnimating()
	}
}

/// Default activity indicator factory creating UIActivityIndicatorView instances
@objcMembers
open class DefaultActivityIndicator: ActivityIndicatorFactory {
	/// activity indicator style
	open var style: UIActivityIndicatorViewStyle
	/// activity indicator color
	open var color: UIColor?
	
	/// Create a new ActivityIndicator for UIActivityIndicatorView
	///
	/// - style: activity indicator style
	/// - color: activity indicator color
	public init(style: UIActivityIndicatorViewStyle = .gray, color: UIColor? = nil) {
		self.style = style
		self.color = color
	}
	
	/// create ActivityIndicatorView instance
	open func create() -> ActivityIndicatorView {
		let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: style)
		activityIndicator.color = color
		activityIndicator.hidesWhenStopped = true
		
		return activityIndicator
	}
}
