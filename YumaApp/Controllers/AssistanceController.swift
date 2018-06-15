//
//  Assistance.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-05-06.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

private let reuseIdentifier = "helpCell"

class Assistance: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate
{
	var array: [String] = []
	var myCollectionView: UICollectionView!
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
//		view.cornerRadius = 20
//		view.clipsToBounds = true
		let titleShadow: NSShadow =
		{
			let view = NSShadow()
			view.shadowColor = UIColor.black
			view.shadowOffset = CGSize(width: 1, height: 1)
			return view
		}()
		view.attributedText = NSAttributedString(string: view.text!, attributes: [NSAttributedStringKey.font : UIFont(name: "AvenirNext-Bold", size: 20)!, NSAttributedStringKey.shadow : titleShadow])
		view.font = UIFont(name: "ArialRoundedMTBold", size: 20)
		view.shadowColor = UIColor.black
		view.shadowRadius = 3
		view.shadowOffset = CGSize(width: 1, height: 1)
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
	let buttonPrev: UILabel =
	{
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.text = " \(FontAwesome.caretLeft.rawValue) "
		view.font = R.font.FontAwesomeOfSize(pointSize: 24)
		return view
	}()
	let buttonNext: UILabel =
	{
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.text = " \(FontAwesome.caretRight.rawValue) "
		view.font = R.font.FontAwesomeOfSize(pointSize: 24)
		return view
	}()
	let backgroundAlpha: CGFloat = 0.7
	let titleBarHeight: CGFloat = 50
	let buttonHeight: CGFloat = 42
	let pageControl: UIPageControl =
	{
		let view = UIPageControl()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.currentPage = 0
		view.pageIndicatorTintColor = R.color.YumaYel
		view.currentPageIndicatorTintColor = R.color.YumaRed
		view.isUserInteractionEnabled = false
		return view
	}()
	let pageControlHeight: CGFloat = 40
	let stack: UIStackView =
	{
		let view = UIStackView()
		return view
	}()
	let minWidth: CGFloat = 300
	let maxWidth: CGFloat = 600
	let minHeight: CGFloat = 300
	let maxHeight: CGFloat = 600
	var collectionViewHeight: CGFloat = 0
	var dialogWidth: CGFloat = 0
	var dialogHeight: CGFloat = 0
	
	
    override func viewDidLoad()
	{
        super.viewDidLoad()

		dialogWidth = min(max(view.frame.width/2, minWidth), maxWidth)
		dialogHeight = min(max(view.frame.height/2, minHeight), maxHeight)
		if array.count == 0
		{
			array = R.array.help_cart_guide
		}
		buttonPrev.textColor = UIColor.lightGray
		buttonNext.textColor = UIColor.lightGray
		self.view.backgroundColor = R.color.YumaRed.withAlphaComponent(backgroundAlpha)

		drawTitle()
		drawStack()
		drawCollection()
		drawButton()

		let str = "V:|[v0(\(titleBarHeight))][v1(\(pageControlHeight))][v2][v3(\(buttonHeight))]-5-|"
		dialogWindow.addConstraintsWithFormat(format: str, views: titleLabel, buttonPrev, myCollectionView, buttonSingle)

		drawDialog()
    }


	override func viewDidLayoutSubviews()
	{
		super.viewDidLayoutSubviews()
		let _ = buttonSingle.addBackgroundGradient(colors: [R.color.YumaRed.cgColor, R.color.YumaYel.cgColor], isVertical: true)
		buttonSingle.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 3.6, isVertical: true)
	}


	func drawTitle()
	{
		titleLabel.text = title//R.string.help
//		titleLabel.font = UIFont.systemFont(ofSize: 21)
		dialogWindow.addSubview(titleLabel)
		dialogWindow.addConstraintsWithFormat(format: "H:|[v0]|", views: titleLabel)
		dialogWindow.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0, constant: titleBarHeight))
	}


	func drawStack()
	{
		pageControl.numberOfPages = array.count
		dialogWindow.addSubview(pageControl)
		dialogWindow.addSubview(buttonPrev)
		dialogWindow.addSubview(buttonNext)
		if pageControl.numberOfPages > 1
		{
			buttonNext.textColor = R.color.YumaRed
		}
		buttonPrev.isUserInteractionEnabled = true
		buttonPrev.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(doPrev(_:))))
		buttonNext.isUserInteractionEnabled = true
		buttonNext.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(doNext(_:))))
		dialogWindow.addConstraintsWithFormat(format: "H:|-3-[v0(25)]-2-[v1]-2-[v2(25)]|", views: buttonPrev, pageControl, buttonNext)
		dialogWindow.addConstraint(NSLayoutConstraint(item: buttonPrev, attribute: .centerY, relatedBy: .equal, toItem: pageControl, attribute: .centerY, multiplier: 1, constant: 0))
		dialogWindow.addConstraint(NSLayoutConstraint(item: buttonNext, attribute: .centerY, relatedBy: .equal, toItem: pageControl, attribute: .centerY, multiplier: 1, constant: 0))
	}


	func drawCollection()
	{
		let layout = UICollectionViewFlowLayout()
		collectionViewHeight = dialogHeight-titleBarHeight-pageControlHeight-buttonHeight-10
		layout.itemSize = CGSize(width: dialogWidth, height: collectionViewHeight)
		layout.scrollDirection = .horizontal
		
		myCollectionView = UICollectionView(frame: CGRect(x: 38, y: 0, width: Int(dialogWidth), height: Int(collectionViewHeight)), collectionViewLayout: layout)
		myCollectionView.dataSource = self
		myCollectionView.delegate = self
		myCollectionView.register(AssistanceCell.self, forCellWithReuseIdentifier: reuseIdentifier)
		myCollectionView.showsVerticalScrollIndicator = false
		myCollectionView.showsHorizontalScrollIndicator = false
		myCollectionView.isPagingEnabled = true
		myCollectionView.backgroundColor = UIColor.white
		
		dialogWindow.addSubview(myCollectionView)
		dialogWindow.addConstraintsWithFormat(format: "H:|[v0]|", views: myCollectionView)
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
	
	@objc func doPrev(_ sender: AnyObject)
	{
		if pageControl.currentPage > 0
		{
			pageControl.currentPage -= 1
			myCollectionView.scrollToItem(at: IndexPath(item: pageControl.currentPage, section: 0), at: .centeredHorizontally, animated: true)
			let page = pageControl.currentPage
			buttonPrev.textColor = page == 0 ? UIColor.lightGray : R.color.YumaRed
			buttonNext.textColor = page < array.count-1 ? R.color.YumaRed : UIColor.lightGray
		}
	}
	
	@objc func doNext(_ sender: AnyObject)
	{
		if pageControl.currentPage < array.count
		{
			pageControl.currentPage += 1
			myCollectionView.scrollToItem(at: IndexPath(item: pageControl.currentPage, section: 0), at: .centeredHorizontally, animated: true)
			let page = pageControl.currentPage
			buttonPrev.textColor = page == 0 ? UIColor.lightGray : R.color.YumaRed
			buttonNext.textColor = page < array.count-1 ? R.color.YumaRed : UIColor.lightGray
		}
	}


	// MARK: Method
	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
	{
		pageControl.currentPage = Int(targetContentOffset.pointee.x/dialogWindow.frame.width)
		let page = pageControl.currentPage
		buttonPrev.textColor = page == 0 ? UIColor.lightGray : R.color.YumaRed
		buttonNext.textColor = page < array.count-1 ? R.color.YumaRed : UIColor.lightGray
	}


	// MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		return array.count
    }


	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AssistanceCell
		cell.titleLabel.text = array[indexPath.item]
        return cell
    }


	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
	{
		return 0
	}


	// MARK: UICollectionViewDelegate

}
