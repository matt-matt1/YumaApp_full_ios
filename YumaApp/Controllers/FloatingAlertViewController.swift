//
//  FloatingAlertViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-06-29.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class FloatingAlertViewController: UIViewController
{
	let floatingAlert: UIView =
	{
		let view = UIView(frame: .zero)
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.darkGray
		view.cornerRadius = 25
		view.shadowColor = UIColor.darkGray
		view.shadowOffset = .zero
		view.shadowRadius = 5
		view.shadowOpacity = 0.5
		return view
	}()
	let floatingMessage: UILabel =
	{
		let view = UILabel(frame: .zero)
		view.translatesAutoresizingMaskIntoConstraints = false
		view.textColor = UIColor.white
		view.font = UIFont(name: "AvenirNext-DemiBold", size: 15)
		return view
	}()
	var horzSpacing: CGFloat = 50
	var maxHorzSpace: CGFloat = 40
	var vertSpacing: CGFloat = 50
	var maxVertSpace: CGFloat = 18
	var startTopMultiplier: CGFloat = 0.71
	var midTopMultiplier: CGFloat = 0.75
	var endTopMultiplier: CGFloat = 0.79
	var horzEdgeGap: CGFloat = 50
	var maxHorzEdgeGap: CGFloat = 30
	var maxHeight: CGFloat = 40
	var startAlpha: CGFloat = 0.2
	var endAlpha: CGFloat = 0
	var midAlpha: CGFloat = 1


	override func viewDidLoad()
	{
        super.viewDidLoad()

		horzSpacing = min(view.frame.width/5, maxHorzSpace)
		horzEdgeGap = min(view.frame.width/5, maxHorzEdgeGap)
		vertSpacing = min(view.frame.height/3, maxVertSpace)
		floatingAlert.cornerRadius = ((2 * vertSpacing) + floatingMessage.font.pointSize + 1) / 2
		floatingAlert.addSubview(floatingMessage)
		floatingAlert.addConstraintsWithFormat(format: "H:|-\(horzSpacing)-[v0]-\(horzSpacing)-|", views: floatingMessage)
		floatingAlert.addConstraintsWithFormat(format: "V:|-\(vertSpacing)-[v0]-\(vertSpacing)-|", views: floatingMessage)
        view.addSubview(floatingAlert)
		floatingAlert.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horzEdgeGap).isActive = true
		floatingAlert.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horzEdgeGap).isActive = true
		floatingAlert.topAnchor.constraint(equalTo: view.topAnchor, constant: startTopMultiplier * view.frame.height).isActive = true
		floatingAlert.heightAnchor.constraint(equalToConstant: (2 * vertSpacing) + floatingMessage.font.pointSize + 2).isActive = true
		floatingAlert.alpha = startAlpha
	}

	override func viewDidAppear(_ animated: Bool)
	{
		super.viewDidAppear(animated)
		UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseInOut,], animations: {
			self.floatingAlert.frame = CGRect(x: self.floatingAlert.frame.origin.x, y: self.view.frame.height * self.midTopMultiplier, width: self.floatingAlert.frame.width, height: self.floatingAlert.frame.height)
			self.floatingAlert.alpha = self.midAlpha
		}) { (_) in
			UIView.animate(withDuration: 2, delay: 2, options: [.curveEaseInOut,], animations: {
				self.floatingAlert.frame = CGRect(x: self.floatingAlert.frame.origin.x, y: self.view.frame.height * self.endTopMultiplier, width: self.floatingAlert.frame.width, height: self.floatingAlert.frame.height)
				self.floatingAlert.alpha = self.endAlpha
			})
		}
    }

    override func didReceiveMemoryWarning()
	{
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
