//
//  HeaderController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-06.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class HeaderController: UIView, NibFileOwnerLoadable {

	var showGoBack: Bool = true
	
	@IBOutlet var wholeView: UIView!
	@IBOutlet weak var backBtnOutlet: UIButton!
	@IBOutlet weak var titleLbl: UILabel!
	@IBOutlet weak var mainView: UIView!
	@IBOutlet weak var shadowView: UIView!
	@IBAction func backBtnAction(_ sender: Any) {
		if showGoBack {
			//self.dismiss(animated: true, completion: nil)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		loadNibContent()
	}
	
	func setTitle(title: String) {
		titleLbl.text = title
	}
	
	func getTitle() -> String {
		return titleLbl.text!
	}
	
	func setBack(can: Bool) {
		showGoBack = can
		backBtnOutlet.isEnabled = can
	}
	
	func isBackAllowed() -> Bool {
		return showGoBack
	}
	
	func disallowBack() {
		showGoBack = false
		backBtnOutlet.isEnabled = false
	}
	
	func allowBack() {
		showGoBack = true
		backBtnOutlet.isEnabled = true
	}
	/*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

public protocol NibFileOwnerLoadable: class {
	static var nib: UINib { get }
}

public extension NibFileOwnerLoadable where Self: UIView {
	
	static var nib: UINib {
		return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
	}
	
	func instantiateFromNib() -> UIView? {
		let view = Self.nib.instantiate(withOwner: self, options: nil).first as? UIView
		return view
	}
	
	func loadNibContent() {
		guard let view = instantiateFromNib() else {
			fatalError("Failed to instantiate nib \(Self.nib)")
		}
		view.translatesAutoresizingMaskIntoConstraints = false
		self.addSubview(view)
		let views = ["view": view]
		let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|", options: .alignAllLastBaseline, metrics: nil, views: views)
		let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", options: .alignAllLastBaseline, metrics: nil, views: views)
		addConstraints(verticalConstraints + horizontalConstraints)
	}
}

