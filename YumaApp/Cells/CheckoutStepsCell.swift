//
//  CheckoutStepsCell.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-05-02.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


class CheckoutStepsCell: UICollectionViewCell
{
	let store = DataStore.sharedInstance
	var space: CGFloat = 20
	var curr = 1
	var done: [Int] = []
	let label: UILabel =
	{
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.textColor = UIColor.darkGray
		return view
	}()
	let boldLabel: UILabel =
	{
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.textColor = UIColor.darkGray
		view.font = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
		return view
	}()
	let signoutLabel: UILabel =
	{
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.textColor = R.color.YumaRed
		view.shadowColor = R.color.YumaYel
		view.shadowOffset = CGSize(width: 1, height: 1)
		view.shadowRadius = 3
		view.shadowOpacity = 0.1
		view.textAlignment = .center
		view.text = R.string.SignOut
		view.font = UIFont.systemFont(ofSize: 30)
		return view
	}()
	let cont: UIButton/*GradientButton*/ =
	{
		let view = UIButton()/*GradientButton()*/
		view.translatesAutoresizingMaskIntoConstraints = false
		view.setTitle(R.string.cont.uppercased(), for: .normal)
		view.titleLabel?.shadowOffset = CGSize(width: 2, height: 2)
		view.titleLabel?.shadowRadius = 3
		view.titleLabel?.textColor = UIColor.white
		view.setTitleShadowColor(R.color.YumaDRed, for: .normal)
		view.widthAnchor.constraint(equalToConstant: 200).isActive = true
		view.backgroundColor = R.color.YumaRed
		//view.topGradientColor = R.color.YumaRed
		//view.bottomGradientColor = R.color.YumaYel
		view.cornerRadius = 3
		view.shadowColor = UIColor.darkGray
		view.shadowOffset = CGSize(width: 1, height: 1)
		view.shadowRadius = 3
		view.layer.addBackgroundGradient(colors: [R.color.YumaRed, R.color.YumaYel], isVertical: true)
		view.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		view.borderColor = R.color.YumaDRed
		view.borderWidth = 1
		view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(doCont(_:))))
		return view
	}()
	let button: UIButton =
	{
		let view = UIButton()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.titleLabel?.shadowOffset = CGSize(width: 2, height: 2)
		view.titleLabel?.shadowRadius = 3
		view.titleLabel?.textColor = UIColor.white
		view.setTitleShadowColor(R.color.YumaDRed, for: .normal)
		view.widthAnchor.constraint(equalToConstant: 200).isActive = true
		view.backgroundColor = R.color.YumaRed
		//view.topGradientColor = R.color.YumaRed
		//view.bottomGradientColor = R.color.YumaYel
		view.cornerRadius = 3
		view.shadowColor = UIColor.darkGray
		view.shadowOffset = CGSize(width: 1, height: 1)
		view.shadowRadius = 3
		view.layer.addBackgroundGradient(colors: [R.color.YumaRed, R.color.YumaYel], isVertical: true)
		view.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		view.borderColor = R.color.YumaDRed
		view.borderWidth = 1
		view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(doCont(_:))))
		return view
	}()
	
	
	// MARK: Overrides
	override init(frame: CGRect)
	{
		super.init(frame: frame)
		setupContents(0)
	}
	
	
	// MARK: Methods
	func setupContents(_ index: Int)
	{
		space = max(20, self.frame.height/6)
		subviews.forEach { (view) in
			view.removeFromSuperview()
		}
		setupBackground()
		switch index {
		case 1:
			drawStep2Addreses()
			break
		case 2:
			drawStep3Shipping()
			break
		case 3:
			drawStep4Payment()
			break
		case 0:
			drawStep1Personal()
			break
		default:
			drawStep1Personal()
			break
		}
		addSubview(cont)
		addConstraintsWithFormat(format: "H:[v0]", views: cont)
		addConstraintsWithFormat(format: "V:[v0(50)]-15-|", views: cont)
		addConstraint(NSLayoutConstraint(item: cont, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
		cont.isUserInteractionEnabled = true
		cont.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(doCont(_:))))
	}
	
	
	private func setupBackground()
	{
		let bg = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
		bg.translatesAutoresizingMaskIntoConstraints = false
		bg.backgroundColor = UIColor.lightGray
		addSubview(bg)
		addConstraintsWithFormat(format: "H:|[v0]|", views: bg)
		addConstraintsWithFormat(format: "V:|[v0]|", views: bg)
		let panel = UIView()
		panel.translatesAutoresizingMaskIntoConstraints = false
		panel.backgroundColor = UIColor.white
		panel.shadowColor = UIColor.darkGray
		panel.shadowOffset = .zero
		panel.shadowRadius = 5
		panel.shadowOpacity = 1
		addSubview(panel)
		addConstraintsWithFormat(format: "H:|-5-[v0]-5-|", views: panel)
		addConstraintsWithFormat(format: "V:|-50-[v0]", views: panel)
		NSLayoutConstraint.activate([
			panel.topAnchor.constraint(equalTo: topAnchor),
			panel.bottomAnchor.constraint(equalTo: bottomAnchor),
			])
	}
	
	
	private func drawStep1Personal()
	{
		curr = 1
		addSubview(signoutLabel)
		addConstraintsWithFormat(format: "H:|[v0]|", views: signoutLabel)
		//addConstraint(NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
		//addConstraint(NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
		//addConstraint(NSLayoutConstraint(item: label, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0))
		if store.customer != nil && !(store.customer?.email.isEmpty)!
		{
			done.append(1)
			addSubview(label)
			addSubview(boldLabel)
			//addConstraintsWithFormat(format: "H:|-\(space)-[v0]-\(space)-[v1]", views: label, boldLabel)
			addConstraintsWithFormat(format: "H:|-10-[v0]", views: label)
			addConstraintsWithFormat(format: "H:|-20-[v0]", views: boldLabel)
			addConstraintsWithFormat(format: "V:|-10-[v0(50)]-10-[v1(50)]-\(space)-[v2]", views: label, boldLabel, signoutLabel)
			//addConstraintsWithFormat(format: "V:|-\(space)", views: boldLabel)
			label.text = R.string.logAs
			if !(store.customer?.lastname.isEmpty)! && !(store.customer?.firstname.isEmpty)!
			{
				boldLabel.text = "\((store.customer?.firstname)!) \((store.customer?.lastname)!)"
			}
			else if !(store.customer?.id_gender?.isEmpty)! && !(store.customer?.firstname.isEmpty)!
			{
				boldLabel.text = "\(Int((store.customer?.id_gender)!) == 1 ? R.string.mr : R.string.mrs)) \((store.customer?.lastname)!)"
			}
			else if !(store.customer?.company?.isEmpty)!
			{
				boldLabel.text = store.customer?.company
			}
			else
			{
				boldLabel.text = store.customer?.email
			}
			//addConstraintsWithFormat(format: "V:|-100-[v0(50)]", views: signoutLabel)
			signoutLabel.text = R.string.SignOut
			addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(doSignout(_:))))
		}
		else	//	Not logged in
		{
			signoutLabel.text = R.string.login
			addSubview(signoutLabel)
			//button.addSubview(signoutLabel)
			//button.setTitle(R.string.login.uppercased(), for: .normal)
			//addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(doLogin(_:))))
			//			button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(doLogin)))
			//signoutLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(doLogin)))
			signoutLabel.isUserInteractionEnabled = true
			signoutLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(doLogin(_:))))
			let lineOr = UILabel()
			lineOr.translatesAutoresizingMaskIntoConstraints = false
			lineOr.text = "  \(R.string.or)  "
			lineOr.textColor = UIColor.darkGray
			lineOr.backgroundColor = UIColor.white
			let line = UIView()
			line.translatesAutoresizingMaskIntoConstraints = false
			line.backgroundColor = UIColor.lightGray
			let switchView = UISwitch()
			switchView.translatesAutoresizingMaskIntoConstraints = false
			switchView.tintColor = R.color.YumaRed
			switchView.onTintColor = R.color.YumaRed
			let switchLbl = UILabel()
			switchLbl.text = R.string.without
			switchLbl.translatesAutoresizingMaskIntoConstraints = false
			switchLbl.textColor = UIColor.darkGray
			switchLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(doWithoutMore(_:))))
			let switchRow = UIStackView(arrangedSubviews: [switchView, switchLbl])
			switchRow.translatesAutoresizingMaskIntoConstraints = false
			switchRow.spacing = 10
			//addSubview(button)
			addSubview(line)
			addSubview(lineOr)
			addSubview(switchRow)
			addConstraintsWithFormat(format: "V:|-\(space)-[v0(50)]-\(space)-[v1(1)]-\(space)-[v2]", views: signoutLabel, line, switchRow)
			//addConstraintsWithFormat(format: "H:[v0]", views: button)
			addConstraintsWithFormat(format: "V:[v0]", views: lineOr)
			addConstraintsWithFormat(format: "H:|-\(space)-[v0]-\(space)-|", views: line)
			addConstraintsWithFormat(format: "H:[v0]", views: lineOr)
			addConstraintsWithFormat(format: "H:|-100-[v0]-10-|", views: switchRow)
			//addConstraint(NSLayoutConstraint(item: switchRow, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
			addConstraint(NSLayoutConstraint(item: lineOr, attribute: .centerY, relatedBy: .equal, toItem: line, attribute: .centerY, multiplier: 1, constant: 0))
			addConstraint(NSLayoutConstraint(item: lineOr, attribute: .centerX, relatedBy: .equal, toItem: line, attribute: .centerX, multiplier: 1, constant: 0))
			//			addConstraint(NSLayoutConstraint(item: button, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
		}
		//		addSubview(cont)
		//		addConstraintsWithFormat(format: "H:[v0]", views: cont)
		//		addConstraintsWithFormat(format: "V:[v0(50)]-15-|", views: cont)
		//		addConstraint(NSLayoutConstraint(item: cont, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
		//		cont.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(doCont(_:))))
	}
	
	
	private func drawStep2Addreses()
	{
		subviews.forEach { (view) in
			view.removeFromSuperview()
		}
		setupBackground()
		curr = 2
		let collectionView: UICollectionView =
		{
			let layout = UICollectionViewFlowLayout()
			let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
			view.backgroundColor = UIColor.white
			view.register(Addr2CollectionViewCell.self, forCellWithReuseIdentifier: "AddrCellId")
			return view
		}()
		
		addSubview(label)
		label.text = R.string.chk2
		addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: label)
		addConstraintsWithFormat(format: "V:|-10-[v0(50)]", views: label)
		addSubview(collectionView)
		addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: collectionView)
		addConstraintsWithFormat(format: "V:|-100-[v0(50)]-80-|", views: collectionView)
		//		addSubview(cont)
		//		addConstraintsWithFormat(format: "H:[v0]", views: cont)
		//		addConstraintsWithFormat(format: "V:[v0(50)]-15-|", views: cont)
		//		addConstraint(NSLayoutConstraint(item: cont, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
	}
	
	
	private func drawStep3Shipping()
	{
		subviews.forEach { (view) in
			view.removeFromSuperview()
		}
		setupBackground()
		curr = 3
		addSubview(label)
		label.text = "\(R.string.select) \(R.string.chk3)"
		addConstraintsWithFormat(format: "H:|-10-[v0]", views: label)
		addConstraintsWithFormat(format: "V:|-10-[v0(50)]", views: label)
		
		let radios = RadioGroup()
		radios.rightGroupMargin = nil
		for method in store.carriers
		{
			radios.rows.append(RadioGroupRow(labelText: method.name, textAttribute: NSAttributedString(string: method.name!, attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray]), gap: nil, labelTapAlertMessage: nil, leftMargin: nil, rightMargin: nil, radioButtonBehind: nil, radioButtonOuterColor: R.color.YumaRed, radioButtonInnerColor: R.color.YumaRed))
		}
		let table = radios.draw()
		addSubview(table)
		addConstraintsWithFormat(format: "H:|-10-[v0]", views: table)
		addConstraintsWithFormat(format: "V:|-75-[v0]", views: table)
	}
	
	
	private func drawStep4Payment()
	{
		subviews.forEach { (view) in
			view.removeFromSuperview()
		}
		setupBackground()
		curr = 4
		addSubview(label)
		label.text = "\(R.string.select) \(R.string.chk4)"
		addConstraintsWithFormat(format: "H:|-10-[v0]", views: label)
		addConstraintsWithFormat(format: "V:|-10-[v0(50)]", views: label)
		
		let radios = RadioGroup()
		for method in store.currencies	////>?????
		{
			radios.rows.append(RadioGroupRow(labelText: method.name, textAttribute: NSAttributedString(string: method.name!, attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray]), gap: nil, labelTapAlertMessage: nil, leftMargin: nil, rightMargin: nil, radioButtonBehind: nil, radioButtonOuterColor: R.color.YumaRed, radioButtonInnerColor: R.color.YumaRed))
		}
		let table = radios.draw()
		addSubview(table)
		addConstraintsWithFormat(format: "H:|-10-[v0]", views: table)
		addConstraintsWithFormat(format: "V:|-75-[v0]", views: table)
		addSubview(cont)
		addConstraintsWithFormat(format: "H:[v0]", views: cont)
		addConstraintsWithFormat(format: "V:[v0(50)]-15-|", views: cont)
		addConstraint(NSLayoutConstraint(item: cont, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
	}
	
	
	required init?(coder aDecoder: NSCoder)
	{
		super.init(coder: aDecoder)
		setupContents(0)
	}
	
	
	// MARK: Actions
	@objc func doCont(_ sender: UITapGestureRecognizer)
	{
		print(R.string.cont)
		switch curr
		{
		case 1:
			if done.contains(4)
			{
				print("complete")
			}
			else if done.contains(3)
			{
				drawStep4Payment()
			}
			else if done.contains(2)
			{
				drawStep3Shipping()
			}
			else
			{
				drawStep2Addreses()
			}
			break
		case 2:
			if done.contains(4)
			{
				print("complete")
			}
			else if done.contains(3)
			{
				drawStep4Payment()
			}
			else
			{
				drawStep3Shipping()
			}
			break
		case 3:
			if done.contains(4)
			{
				print("complete")
			}
			else if done.contains(3)
			{
				drawStep4Payment()
			}
			break
		case 4:
			if done.contains(4)
			{
				print("complete")
			}
			else
			{
				print("error: should be complete")
			}
			break
		default:
			print("error: CheckoutStepsCell - continue out of range")
			break
		}
	}
	
	
	@objc func doWithoutMore(_ sender: UITapGestureRecognizer)
	{
		print(R.string.withoutMore)
		let checkoutCollection = CheckoutCollection()
		OperationQueue.main.addOperation
			{
				let alert = 					UIAlertController(title: nil, message: R.string.withoutMore, preferredStyle: .alert)
				let coloredBG = 				UIView()
				let blurFx = 					UIBlurEffect(style: .dark)
				let blurFxView = 				UIVisualEffectView(effect: blurFx)
				alert.titleAttributes = 		[NSAttributedString.StringAttribute(key: .foregroundColor, value: R.color.YumaRed)]
				alert.messageAttributes = 		[NSAttributedString.StringAttribute(key: .foregroundColor, value: UIColor.darkGray)]
				alert.view.superview?.backgroundColor = R.color.YumaRed
				alert.view.shadowColor = 		R.color.YumaDRed
				alert.view.shadowOffset = 		.zero
				alert.view.shadowRadius = 		5
				alert.view.shadowOpacity = 		1
				alert.view.backgroundColor = 	R.color.YumaYel
				alert.view.cornerRadius = 		15
				coloredBG.backgroundColor = 	R.color.YumaRed
				coloredBG.alpha = 				0.4
				coloredBG.frame = 				checkoutCollection.view.bounds
				checkoutCollection.view.addSubview(coloredBG)
				blurFxView.frame = 				checkoutCollection.view.bounds
				blurFxView.alpha = 				0.5
				blurFxView.autoresizingMask = 	[.flexibleWidth, .flexibleHeight]
				checkoutCollection.view.addSubview(blurFxView)
				alert.addAction(UIAlertAction(title: R.string.dismiss.uppercased(), style: .default, handler: { (action) in
					coloredBG.removeFromSuperview()
					blurFxView.removeFromSuperview()
				}))
				checkoutCollection.present(alert, animated: true, completion:
					{
				})
		}
	}
	
	
	@objc func doSignout(_ sender: UITapGestureRecognizer)
	{
		print(R.string.SignOut)
		let checkoutCollection = CheckoutCollection()
		store.logout(checkoutCollection, presentingViewController: checkoutCollection.self)
	}
	
	
	@objc func doLogin(_ sender: AnyObject)
	{
		print(R.string.login)
		//let checkoutCollection = CheckoutCollection()
		let view = sender.view as UIView
		store.flexView(view: view)
		//		sender.view?.backgroundColor = R.color.YumaRed
//		let spin = UIViewController.displaySpinner(onView: self.contentView/*checkoutCollection.view*/)
		//		UIView.animate(withDuration: 1, animations:
		//			{
		//				sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		//		})
		//		let root = CheckoutCollection(collectionViewLayout: UICollectionViewFlowLayout())
		//		root.present(LoginViewController(), animated: false, completion: (() -> Void)?
		//			{
		//				UIViewController.removeSpinner(spinner: spin)
		//				//				sender.view?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
		//				//				sender.view?.backgroundColor = UIColor.white
		//			})
		//self.present
	}
}



extension CheckoutStepsCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		return store.addresses.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddrCellId", for: indexPath) as! Addr2CollectionViewCell
		cell.aliasEdit.text = store.addresses[indexPath.item].alias
		cell.addressEdit.text = store.formatAddress(store.addresses[indexPath.item])
		return cell
	}
	
}
