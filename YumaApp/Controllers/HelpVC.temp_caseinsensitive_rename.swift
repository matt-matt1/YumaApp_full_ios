//
//  helpVC.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-09.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//
//https://medium.com/@brianclouser/swift-3-creating-a-custom-view-from-a-xib-ecdfe5b3a960

import UIKit


class HelpVC: UIView
{
	@IBOutlet var allView: UIView!
	@IBOutlet weak var pageControl: UIPageControl!
	@IBOutlet weak var upperImage: UIImageView!
	@IBOutlet weak var title: UILabel!
	@IBOutlet weak var message: UILabel!
	@IBOutlet weak var lowerImage: UIImageView!
	@IBOutlet weak var buttonLeft: UIButton!
	@IBOutlet weak var buttonsView: UIView!
	@IBOutlet weak var buttonRight: UIButton!
	@IBOutlet weak var buttonsStack: UIStackView!
	@IBOutlet weak var elementsStack: UIStackView!
	@IBOutlet weak var container: UIView!


	override init(frame: CGRect)
	{
		super.init(frame: frame)
		commonInit()
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		super.init(coder: aDecoder)
		commonInit()
	}
	
	private func commonInit()
	{
		Bundle.main.loadNibNamed("HelpVC", owner: self, options: nil)
		addSubview(allView)
		allView.frame = self.bounds
		allView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
	}
}
