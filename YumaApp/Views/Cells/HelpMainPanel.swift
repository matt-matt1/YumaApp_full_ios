//
//  HelpMainPanel.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-21.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


class HelpMainPanel: UIView
{
	@IBOutlet var contentView: UIView!
	@IBOutlet weak var pageControl: UIPageControl!
	@IBOutlet weak var scrollView: UIScrollView!
	
	
	override init(frame: CGRect)
	{
		super.init(frame: frame)
		commonInit()
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		super.init(coder: aDecoder)
		commonInit()
		//fatalError("init(coder:) has not been implemented")
	}
	
	private func commonInit()
	{
		Bundle.main.loadNibNamed("HelpMainPanel", owner: self, options: nil)
		addSubview(contentView)
		contentView.frame = self.bounds
		contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
	}
	
}
