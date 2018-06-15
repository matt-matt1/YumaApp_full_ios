//
//  MyAccOHViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-17.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


class MyAccOHViewController: UIViewController
{
	let store = DataStore.sharedInstance
	let cellId = "OHCell"
	let stackAll: UIStackView =
	{
		let view = UIStackView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.axis = .vertical
		return view
	}()
	var navBar: UINavigationBar =
	{
		let view = UINavigationBar()
		view.backgroundColor = R.color.YumaDRed
		return view
	}()
	let navTitle: UINavigationItem =
	{
		let view = UINavigationItem()
		return view
	}()
	var navClose: UIBarButtonItem =
	{
		let view = UIBarButtonItem()
		view.image = Awesome.solid.times.asImage(size: 24)
		view.action = #selector(navCloseAct(_:))
		view.style = UIBarButtonItemStyle.plain
		return view
	}()
	var navHelp: UIBarButtonItem =
	{
		let view = UIBarButtonItem()
		view.image = Awesome.solid.questionCircle.asImage(size: 24)
		view.action = #selector(navHelpAct(_:))
		view.style = UIBarButtonItemStyle.plain
		return view
	}()
	let viewOuter: UIView =
	{
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.lightGray
		return view
	}()
	let stackPanel: UIStackView =
	{
		let view = UIStackView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.lightGray
		return view
	}()
	let viewPanel: UIView =
	{
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.white
		view.shadowColor = UIColor.darkGray
		view.shadowOffset = .zero
		view.shadowRadius = 5
		view.shadowOpacity = 1
		return view
	}()
	let stackWindow: UIStackView =
	{
		let view = UIStackView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.white
//		view.shadowColor = UIColor.darkGray
//		view.shadowOffset = .zero
//		view.shadowRadius = 5
//		view.shadowOpacity = 0.8
//		view.layer.shadowColor = UIColor.darkGray.cgColor
//		view.layer.shadowOffset = .zero
//		view.layer.shadowRadius = 5
//		view.layer.shadowOpacity = 0.8
		return view
	}()
	let topGap: UIView =
	{
		let view = UIView()
//		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.white
		return view
	}()
	let myCollection: UICollectionView =
	{
		let layout = UICollectionViewFlowLayout()
		layout.sectionInset = UIEdgeInsets(top: 20, left: 8, bottom: 20, right: 8)
		layout.itemSize = CGSize(width: 162, height: 200)
		let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.white
		return view
	}()
	let errorWrap: UIView =
	{
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.white
		return view
	}()
	let errorView: UIView =
	{
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.init(hex: "#FDDFC9")
		view.shadowColor = UIColor.darkGray
		view.shadowOffset = .zero
		view.shadowRadius = 5
		view.shadowOpacity = 0.8
		view.borderColor = UIColor.red
		view.borderWidth = 1
		return view
	}()
	let errorView2: UIView =
	{
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	let errorMsg: UILabel =
	{
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.textColor = R.color.YumaRed
		view.text = R.string.noOrderHist
		view.font = UIFont.systemFont(ofSize: 15)
		return view
	}()
//	override var isSelected: Bool
//	{
//		didSet
//		{
//			if self.isSelected
//			{
//				self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
//				self.contentView.backgroundColor = UIColor.red
//				self.tickImageView.isHidden = false
//			}
//			else
//			{
//				self.transform = CGAffineTransform.identity
//				self.contentView.backgroundColor = UIColor.gray
//				self.tickImageView.isHidden = true
//			}
//		}
//	}


	override func viewDidLoad()
	{
        super.viewDidLoad()

		view.backgroundColor = UIColor.lightGray
		setNavigation()
		setViews()
		setCollection()
    }

	override func viewDidLayoutSubviews()
	{
		super.viewDidLayoutSubviews()
		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
//		viewPanel.bottomAnchor.constraint(equalTo: myCollection.bottomAnchor, constant: 100).isActive = true
	}

	override func viewWillAppear(_ animated: Bool)
	{
		super.viewWillAppear(animated)
//		if let index = self.myCollection.indexPathsForSelectedItems.indexPathForSelectedRow
//		{
//			self.myCollection.deselectRowAtIndexPath(index, animated: true)
//		}
	}

	override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


	// MARK: Methods
	fileprivate func setViews()
	{
		viewPanel.addSubview(stackWindow)
		stackWindow.topAnchor.constraint(equalTo: viewPanel.topAnchor, constant: 10).isActive = true
		stackWindow.leadingAnchor.constraint(equalTo: viewPanel.leadingAnchor, constant: 5).isActive = true
		stackWindow.bottomAnchor.constraint(equalTo: viewPanel.bottomAnchor, constant: -5).isActive = true
		stackWindow.trailingAnchor.constraint(equalTo: viewPanel.trailingAnchor, constant: -5).isActive = true

		stackPanel.addSubview(viewPanel)
		viewPanel.topAnchor.constraint(equalTo: stackPanel.topAnchor, constant: 0).isActive = true
		viewPanel.leadingAnchor.constraint(equalTo: stackPanel.leadingAnchor, constant: 0).isActive = true
		viewPanel.bottomAnchor.constraint(equalTo: stackPanel.bottomAnchor, constant: -50).isActive = true
		viewPanel.trailingAnchor.constraint(equalTo: stackPanel.trailingAnchor, constant: 0).isActive = true

		viewOuter.addSubview(stackPanel)
		stackPanel.topAnchor.constraint(equalTo: viewOuter.topAnchor, constant: 0).isActive = true
		stackPanel.leadingAnchor.constraint(equalTo: viewOuter.leadingAnchor, constant: 5).isActive = true
		stackPanel.bottomAnchor.constraint(equalTo: viewOuter.bottomAnchor, constant: -5).isActive = true
		stackPanel.trailingAnchor.constraint(equalTo: viewOuter.trailingAnchor, constant: -5).isActive = true

		stackAll.addArrangedSubview(viewOuter)

		view.addSubview(stackAll)
		if #available(iOS 11.0, *) {
			stackAll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		} else {
//			navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
			let topMargin = stackAll.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0)
			topMargin.priority = UILayoutPriority(rawValue: 250)
			topMargin.isActive = true
			let top20 = stackAll.topAnchor.constraint(equalTo: view.topAnchor, constant: 20)
			top20.priority = UILayoutPriority(rawValue: 750)
			top20.isActive = true
		}
		stackAll.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: 0).isActive = true
		stackAll.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: 0).isActive = true
		stackAll.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor, constant: 0).isActive = true
	}


	func setNavigation()
	{
		navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
		navBar.setItems([navTitle], animated: false)
		navBar.tintColor = UIColor.white
		stackAll.addArrangedSubview(navBar)
		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
		navBar.topItem?.title = R.string.OrdHist.capitalized
		navClose = UIBarButtonItem(barButtonSystemItem: .stop, target: nil, action: #selector(navCloseAct(_:)))
		navTitle.leftBarButtonItems = [navClose]
		navTitle.rightBarButtonItems = [navHelp]
	}

	
	fileprivate func setCollection()
	{
		if store.orders.count > 0
		{
			myCollection.deselectAllItems()
			myCollection.delegate = self as UICollectionViewDelegate
			myCollection.dataSource = self
			myCollection.register(MyAccOH_Cell.self, forCellWithReuseIdentifier: cellId)
			//		stackWindow.addArrangedSubview(topGap)
			stackWindow.addArrangedSubview(myCollection)
		}
		else
		{
			errorView2.addSubview(errorMsg)
			errorMsg.topAnchor.constraint(equalTo: errorView2.topAnchor, constant: 5).isActive = true
			errorMsg.leadingAnchor.constraint(equalTo: errorView2.leadingAnchor, constant: 8).isActive = true
			errorMsg.bottomAnchor.constraint(equalTo: errorView2.bottomAnchor, constant: -5).isActive = true
			errorMsg.trailingAnchor.constraint(equalTo: errorView2.trailingAnchor, constant: -8).isActive = true
			errorView.addSubview(errorView2)
			errorView2.topAnchor.constraint(equalTo: errorView.topAnchor, constant: 10).isActive = true
			errorView2.leadingAnchor.constraint(equalTo: errorView.leadingAnchor, constant: 8).isActive = true
			errorView2.bottomAnchor.constraint(equalTo: errorView.bottomAnchor, constant: -10).isActive = true
			errorView2.trailingAnchor.constraint(equalTo: errorView.trailingAnchor, constant: -8).isActive = true
			errorWrap.addSubview(errorView)
			errorView.topAnchor.constraint(equalTo: errorWrap.topAnchor, constant: 5).isActive = true
			errorView.leadingAnchor.constraint(equalTo: errorWrap.leadingAnchor, constant: 8).isActive = true
			//			errorView.bottomAnchor.constraint(equalTo: errorWrap.bottomAnchor, constant: -3).isActive = true
			errorView.heightAnchor.constraint(equalToConstant: 60 + errorMsg.font.pointSize)
			errorView.trailingAnchor.constraint(equalTo: errorWrap.trailingAnchor, constant: -8).isActive = true
			stackWindow.addArrangedSubview(errorWrap)
//			errorWrap.topAnchor.constraint(equalTo: stackWindow.topAnchor, constant: 15).isActive = true
//			errorWrap.leadingAnchor.constraint(equalTo: stackWindow.leadingAnchor, constant: 3).isActive = true
//			errorWrap.bottomAnchor.constraint(equalTo: stackWindow.bottomAnchor, constant: -3).isActive = true
//			errorWrap.trailingAnchor.constraint(equalTo: stackWindow.trailingAnchor, constant: -3).isActive = true
		}
	}


	// MARK: Actions
	@IBAction func navCloseAct(_ sender: Any)
	{
		self.dismiss(animated: false, completion: nil)
	}
	@IBAction func navHelpAct(_ sender: Any)
	{
		let viewC = Assistance()
		viewC.array = R.array.help_my_account_order_history_guide
		viewC.title = "\(R.string.OrdHist.capitalized) \(R.string.help.capitalized)"
		viewC.modalTransitionStyle = .crossDissolve
		viewC.modalPresentationStyle = .overCurrentContext
		self.present(viewC, animated: true, completion: nil)
	}
	
}
