//
//  HelpCell.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-21.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class HelpCell: UIView
{
	var TopImage: UIImageView =
	{
		let view = UIImageView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.contentMode = .scaleAspectFit
		return view
	}()
	var TextLine: UILabel =
	{
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	
	override init(frame: CGRect)
	{
		super.init(frame: frame)
		TextLine.backgroundColor = R.color.AppleBlue
		self.addSubview(TextLine)
		NSLayoutConstraint.activate([
			TextLine.leftAnchor.constraint(equalTo: self.leftAnchor),
			TextLine.rightAnchor.constraint(equalTo: self.rightAnchor),
			TextLine.topAnchor.constraint(equalTo: self.topAnchor),
			TextLine.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			])
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
