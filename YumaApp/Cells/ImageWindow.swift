//
//  ImageWindow.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-05-18.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

private let reuseIdentifier = "helpCell"

class ImageWindow: UIViewController/*, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout*/, UIGestureRecognizerDelegate
{
	var scrollView: UIScrollView =
	{
		let view = UIScrollView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	let imageView: UIImageView =
	{
		let view = UIImageView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.contentMode = .scaleAspectFit
//		view.contentMode = .center
		return view
	}()
	let dialogWindow: UIView =
	{
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.isUserInteractionEnabled = true
		view.backgroundColor = UIColor.white
		view.cornerRadius = 20
		view.shadowColor = R.color.YumaDRed
		view.shadowRadius = 5
		view.shadowOffset = .zero
		view.shadowOpacity = 1
		return view
	}()
	let titleLabel: UILabel =
	{
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = R.color.YumaRed
		view.text = "Title"
		view.textColor = UIColor.white
		view.textAlignment = .center
		view.layer.masksToBounds = true
		return view
	}()
	let buttonSingle: GradientButton =
	{
		let view = GradientButton()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.setTitle(R.string.close.uppercased(), for: .normal)
		view.titleLabel?.shadowOffset = CGSize(width: 2, height: 2)
		view.titleLabel?.shadowRadius = 3
		view.titleLabel?.textColor = UIColor.white
		view.setTitleShadowColor(R.color.YumaDRed, for: .normal)
		view.backgroundColor = R.color.YumaRed.withAlphaComponent(0.8)
		view.cornerRadius = 3
		view.shadowColor = UIColor.darkGray
		view.shadowOffset = CGSize(width: 1, height: 1)
		view.shadowRadius = 3
		let titleShadow: NSShadow =
		{
			let view = NSShadow()
			view.shadowColor = UIColor.black
			//			view.shadowRadius = 3
			view.shadowOffset = CGSize(width: 1, height: 1)
			return view
		}()
		view.setAttributedTitle(NSAttributedString(string: view.title(for: .normal)!, attributes: [NSAttributedStringKey.font : UIFont(name: "AvenirNext-DemiBold", size: 18)!, NSAttributedStringKey.shadow : titleShadow]), for: .normal)
		view.borderColor = R.color.YumaDRed
		view.borderWidth = 1
		view.shadowOpacity = 0.9
		return view
	}()
	let backgroundAlpha: CGFloat = 0.7
	let titleBarHeight: CGFloat = 50
	let buttonHeight: CGFloat = 42
	let stack: UIStackView =
	{
		let view = UIStackView()
		return view
	}()
	let minWidth: CGFloat = 300
	let maxWidth: CGFloat = 600
	let minHeight: CGFloat = 300
	let maxHeight: CGFloat = 600
	var dialogWidth: CGFloat = 0
	var dialogHeight: CGFloat = 0
	
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		dialogWidth = min(max(view.frame.width/2, minWidth), maxWidth)
		dialogHeight = min(max(view.frame.height/2, minHeight), maxHeight)
		self.view.backgroundColor = R.color.YumaRed.withAlphaComponent(backgroundAlpha)
		
		drawTitle()
		drawImage()
		drawButton()
		
		let str = "V:|[v0(\(titleBarHeight))]-5-[v1]-5-[v2(\(buttonHeight))]-5-|"
		dialogWindow.addConstraintsWithFormat(format: str, views: titleLabel, scrollView, buttonSingle)

		drawDialog()
	}


	override func viewDidLayoutSubviews()
	{
		super.viewDidLayoutSubviews()
		let _ = buttonSingle.addBackgroundGradient(colors: [R.color.YumaRed.cgColor, R.color.YumaYel.cgColor], isVertical: true)
		buttonSingle.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 3.6, isVertical: true)
	}
	
	
	// MARK: Method
	func drawTitle()
	{
		titleLabel.font = UIFont.systemFont(ofSize: 21)
		dialogWindow.addSubview(titleLabel)
		dialogWindow.addConstraintsWithFormat(format: "H:|[v0]|", views: titleLabel)
		dialogWindow.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0, constant: titleBarHeight))
	}


	func drawImage()
	{
		scrollView.addSubview(imageView)
		scrollView.addConstraintsWithFormat(format: "H:|[v0]|", views: imageView)
		scrollView.addConstraintsWithFormat(format: "V:|[v0]|", views: imageView)
		scrollView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: scrollView, attribute: .centerX, multiplier: 1, constant: 0))
		scrollView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: scrollView, attribute: .centerY, multiplier: 1, constant: 0))

		dialogWindow.addSubview(scrollView)
		dialogWindow.addConstraintsWithFormat(format: "H:|[v0]|", views: scrollView)
		scrollView.zoomScale = 1.0
		scrollView.maximumZoomScale = 4.0
		scrollView.minimumZoomScale = 0.1
		scrollView.contentSize = imageView.bounds.size
	}


	func drawButton()
	{
		buttonSingle.setTitle(R.string.dismiss.uppercased(), for: .normal)
		dialogWindow.addSubview(buttonSingle)
		dialogWindow.addConstraint(NSLayoutConstraint(item: buttonSingle, attribute: .width, relatedBy: .equal, toItem: dialogWindow, attribute: .width, multiplier: 0, constant: dialogWidth / 2))
		dialogWindow.addConstraint(NSLayoutConstraint(item: buttonSingle, attribute: .centerX, relatedBy: .equal, toItem: dialogWindow, attribute: .centerX, multiplier: 1, constant: 0))
		dialogWindow.addConstraint(NSLayoutConstraint(item: buttonSingle, attribute: .height, relatedBy: .equal, toItem: dialogWindow, attribute: .height, multiplier: 0, constant: buttonHeight))
		buttonSingle.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonSingleTapped(_:))))
	}


	func drawDialog()
	{
		view.addSubview(dialogWindow)
		view.addConstraint(NSLayoutConstraint(item: dialogWindow, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0, constant: dialogWidth))
		view.addConstraint(NSLayoutConstraint(item: dialogWindow, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0, constant: dialogHeight))
		view.addConstraint(NSLayoutConstraint(item: dialogWindow, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0))
		view.addConstraint(NSLayoutConstraint(item: dialogWindow, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0))
	}


	override func didReceiveMemoryWarning()
	{
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


	// MARK: Actions
	@objc func buttonSingleTapped(_ sender: UITapGestureRecognizer)
	{
		self.dismiss(animated: true, completion: nil)
	}

}
