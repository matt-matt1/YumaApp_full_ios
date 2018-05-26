//
//  MenuCell.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-05-02.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


class MenuCell: BaseCell
{
	var ticked: [Int] = []
	var menuCell: MenuCell?
	let iconView: UILabel =
	{
		let view = UILabel()
		view.textColor = R.color.YumaRed
		return view
	}()
	let tick: UILabel =
	{
		let view = UILabel()
		view.textColor = R.color.YumaYel
		view.alpha = 0.15
		view.text = FontAwesome.check.rawValue
		view.font = R.font.FontAwesomeOfSize(pointSize: 20)
		return view
	}()
	let separator: UILabel =
	{
		let view = UILabel()
		view.textColor = UIColor.darkGray
		view.text = FontAwesome.chevronRight.rawValue
		view.font = R.font.FontAwesomeOfSize(pointSize: 20)
		return view
	}()
//	let iconView: UIImageView =
//	{
//		let view = UIImageView()
//		view.image = UIImage(named: "home")
//		return view
//	}()
	//	override var isHighlighted: Bool
	//		{
	//		didSet
	//		{
	//			print("123")
	//			//iconView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
	//		}
	//	}
	override var isSelected: Bool
		{
			didSet
			{
				//iconView.tintColor = isSelected ? R.color.YumaYel : R.color.YumaRed
				//iconView.alpha = isSelected ? 1 : 0.3
				iconView.textColor = isSelected ? R.color.YumaYel : R.color.YumaRed
			}
		}
	
	
	override init(frame: CGRect)
	{
		super.init(frame: frame)
		menuCell = self
		setupViews()
	}
	
	override func setupViews()
	{
		super.setupViews()
		
		addSubview(iconView)
		addConstraintsWithFormat(format: "H:[v0(28)]", views: iconView)
		addConstraintsWithFormat(format: "V:[v0(28)]", views: iconView)
		addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
		addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
		addSubview(separator)
		addConstraintsWithFormat(format: "H:[v0]", views: separator)
		addConstraintsWithFormat(format: "V:[v0]", views: separator)
		addConstraint(NSLayoutConstraint(item: separator, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0))
		addConstraint(NSLayoutConstraint(item: separator, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
		addSubview(tick)
		tick.font = R.font.FontAwesomeOfSize(pointSize: Int(self.frame.height))
		addConstraintsWithFormat(format: "H:[v0]", views: tick)
		addConstraintsWithFormat(format: "V:[v0]", views: tick)
		addConstraint(NSLayoutConstraint(item: tick, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
		addConstraint(NSLayoutConstraint(item: tick, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
