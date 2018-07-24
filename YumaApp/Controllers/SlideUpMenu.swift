//
//  SlideUpMenu.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-07-23.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


fileprivate extension Selector
{
	static let expandMenu = #selector(SlideUpMenu.expandMenuButtonAct)
}


class SlideUpMenu: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
//	var spacedMenuItems: [IconPanel] = []
	let iconBarHeight: CGFloat = 50
	let iconBar: UIToolbar =
	{
		let view = UIToolbar()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.barTintColor = UIColor.black
		view.shadowColor = UIColor.darkGray
		view.shadowRadius = 5
		view.shadowOffset = CGSize(width: 0, height: 3)
		view.shadowOpacity = 0.9
		return view
	}()
	let customButton: UIButton =
	{
		let view = UIButton(type: .custom)
		view.titleLabel?.font = UIFont.systemFont(ofSize: 13)
		view.setTitleColor(UIColor.white, for: .normal)
		view.contentEdgeInsets = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
		return view
	}()
	var darkOverlay: UIView =
	{
		let view = UIView()
//		view.backgroundColor = R.color.YumaDRed.withAlphaComponent(0.5)
		view.alpha = 0
		return view
	}()
	let collectionView: UICollectionView =
	{
		let layout = /*CustomFlowLayout()*/UICollectionViewFlowLayout()
		let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
		view.backgroundColor = UIColor.white
		return view
	}()
	var collectionViewHeight: CGFloat = 200
	let cellHeight: CGFloat = 50
	var control: UIControl!
	let maxWidth: CGFloat = 320
	var parent: SwipingController?
//	lazy var swipingController: SwipingController =
//	{
//		let vc = SwipingController()
//		return vc
//	}()


	override init()
	{
		super.init()
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.register(SlideUpMenuCell.self, forCellWithReuseIdentifier: "cellId")
//		menuItems.forEach { (item) in	// Add menu items in order and insert separators, if needed
//			spacedMenuItems.append(item)
//			if item.trailingSeparator != nil && item.trailingSeparator == true
//			{
//				spacedMenuItems.append(IconPanel(id: 0, text: "-", icon: "", target: nil, canFade: false, canAction: false))
//			}
//		}
		control = UIControl()
	}


	// MARK: Methods
	
	func drawIconBar()
	{
		customButton.setImage(Awesome.solid.chevronUp.asImage(size: 30, color: R.color.YumaYel, backgroundColor: .clear), for: .normal)
		customButton.sizeToFit()
		customButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: .expandMenu))
		iconBar.items = [UIBarButtonItem(customView: customButton)]
		if let window = UIApplication.shared.keyWindow
		{
			window.addSubview(iconBar)
			NSLayoutConstraint.activate([
				iconBar.bottomAnchor.constraint(equalTo: window.safeBottomAnchor/*.bottomAnchor*/, constant: -10),
				iconBar.leadingAnchor.constraint(equalTo: window.safeLeadingAnchor/*.leadingAnchor*/, constant: 10),
				iconBar.heightAnchor.constraint(equalToConstant: iconBarHeight),
				iconBar.trailingAnchor.constraint(equalTo: window.safeTrailingAnchor/*.trailingAnchor*/, constant: -10),
				])
//			collectionViewHeight = min(CGFloat(spacedMenuItems.count) * cellHeight, window.frame.height * 0.8)
			collectionViewHeight = min(CGFloat(menuItems.count) * cellHeight, window.frame.height * 0.8)
		}
	}


	// MARK: Actions

	@objc func expandMenuButtonAct()
	{
		if let window = UIApplication.shared.keyWindow
		{
			darkOverlay = UIView(frame: window.frame)
			darkOverlay.backgroundColor = R.color.YumaDRed.withAlphaComponent(0.5)
			darkOverlay.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissDarkOverlay)))
			window.addSubview(darkOverlay)
			window.addSubview(collectionView)
			var y = window.frame.height - collectionViewHeight
			if #available(iOS 11.0, *)
			{
				y = window.safeAreaLayoutGuide.layoutFrame.height - collectionViewHeight + window.safeAreaLayoutGuide.layoutFrame.origin.y
			}
			if #available(iOS 11.0, *)
			{
//				collectionView.frame = CGRect(x: 5 + window.safeAreaLayoutGuide.layoutFrame.origin.x, y: window.safeAreaLayoutGuide.layoutFrame.height, width: min(window.safeAreaLayoutGuide.layoutFrame.width - 10, maxWidth), height: collectionViewHeight)
				collectionView.frame = CGRect(x: 5 + window.safeAreaInsets.left, y: window.frame.height, width: min(window.frame.width - window.safeAreaInsets.left - 10 - window.safeAreaInsets.right, maxWidth), height: collectionViewHeight)
			}
			else
			{
				collectionView.frame = CGRect(x: 5, y: 0, width: window.frame.width - 10, height: collectionViewHeight)
			}
			UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
				self.darkOverlay.alpha = 1
				self.collectionView.frame.origin.y = max(y, 20)	// at least 20px (below status bar)
			}, completion: nil)
		}
	}
	
	@objc func dismissDarkOverlay()
	{
		dismissDarkOverlay2(completion: nil)
	}
	func dismissDarkOverlay2(completion: (() -> Void)?)
	{
		UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
			if let window = UIApplication.shared.keyWindow
			{
				self.darkOverlay.alpha = 0
				self.collectionView.frame.origin.y = window.frame.height
			}
		}) { (comp) in
			if completion != nil
			{
				completion!()
			}
		}
	}
	

	// MARK: UICollectionView Methods
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		return menuItems.count//spacedMenuItems.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! SlideUpMenuCell
		cell.contents = menuItems[indexPath.item]//spacedMenuItems[indexPath.item]
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
	{
		return CGSize(width: collectionView.frame.width, height: cellHeight)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
	{
		return 0
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
	{
		if menuItems[indexPath.item].target != nil//spacedMenuItems[indexPath.item].target != nil
		{
//			let target = menuItems[indexPath.item].target!
//			print(spacedMenuItems[indexPath.item].target!)
			dismissDarkOverlay2(completion: {
//				self.parent!.contactTapped(nil)
//				var a = 3
//				UIApplication.shared.sendAction(self.spacedMenuItems[indexPath.item].target!, to: SwipingController.self, from: nil, for: nil)
//				UIApplication.shared.sendAction(menuItems[indexPath.item].target!, to: SwipingController.self, from: nil, for: nil)
				UIApplication.shared.sendAction(menuItems[indexPath.item].target!, to: self.parent, from: nil, for: nil)
//				DispatchQueue.main.async {
//				let timer = Timer.scheduledTimer(timeInterval: 0.1, target: SwipingController(), selector: self.spacedMenuItems[indexPath.item].target!, userInfo: nil, repeats: false)
//				let timer = Timer.scheduledTimer(timeInterval: 0.1, target: SwipingController(), selector: menuItems[indexPath.item].target!, userInfo: nil, repeats: false)
//				timer.fire()
//				timer.invalidate()
//				}
//				self.control.sendAction(self.spacedMenuItems[indexPath.item].target!, to: SwipingController.self, for: nil)
//				self.control.sendAction(menuItems[indexPath.item].target!, to: SwipingController.self, for: nil)
			})
		}
	}


}
