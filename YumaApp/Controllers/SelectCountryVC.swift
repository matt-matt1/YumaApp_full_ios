//
//  SelectCountryVC.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-05-25.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


class SelectCountryVC: UIViewController//, UITableViewDataSource, UITableViewDelegate
{
	let cellId = "selectCounty"
	var initalDone = false
	var tableView: UITableView!
	var searchBox: UISearchBar =
	{
		let view = UISearchBar()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.isUserInteractionEnabled = false
//		view.showsCancelButton = true
		view.showsBookmarkButton = false
//		view.searchBarStyle = UISearchBarStyle.default
		view.placeholder = "\(R.string.action_search) \(R.string.country)"
		view.tintColor = R.color.YumaRed
		view.showsSearchResultsButton = false
		return view
	}()
//	let searchControl: UISearchController =
//	{
//		let view = UISearchController(searchResultsController: nil)
//		view.obscuresBackgroundDuringPresentation = false
//		view.searchBar.placeholder = R.string.select
//		return view
//	}()
	var find: String?
	var isSearching = false
	var records: [Country] = []//[String : Int]?
	var filtered: [Country] = []//[String : Int]?
	static var selectedRow = IndexPath(row: 0, section: 0)
//	{
//		didSet
//		{
//			OperationQueue.main.addOperation
//			{
//				self.tableView.scrollToRow(at: self.selectedRow, at: .middle, animated: true)
//			}
//		}
//	}
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
	var defaultCountryId: Int? = nil
	var defaultCountry: String? = nil
	let titleLabel: UILabel =
	{
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = R.color.YumaRed
		view.text = "Title"
//		view.cornerRadius = 20
		view.clipsToBounds = true
		view.layer.masksToBounds = true
		view.textColor = UIColor.white
		view.textAlignment = .center
		return view
	}()
	let buttonSingle: UIButton =
	{
		let view = UIButton()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.setTitle(R.string.cont.uppercased(), for: .normal)
		view.titleLabel?.shadowOffset = CGSize(width: 2, height: 2)
		view.titleLabel?.shadowRadius = 3
		view.titleLabel?.textColor = UIColor.white
		view.setTitleShadowColor(R.color.YumaDRed, for: .normal)
		view.backgroundColor = /*R.color.YumaYel*/R.color.YumaRed.withAlphaComponent(0.8)
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
		//		view.shadowOpacity = 0.9
		//		view.titleEdgeInsets = UIEdgeInsets(top: 2, left: 10, bottom: 2, right: 10)
		return view
	}()
	let backgroundAlpha: CGFloat = 0.7
	let titleBarHeight: CGFloat = 50
	let buttonHeight: CGFloat = 42
	let searchBoxHeight: CGFloat = 40
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
	let store = DataStore.sharedInstance
	
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		dialogWidth = min(max(view.frame.width/2, minWidth), maxWidth)
		dialogHeight = min(max(view.frame.height/2, minHeight), maxHeight)
		self.view.backgroundColor = R.color.YumaRed.withAlphaComponent(backgroundAlpha)
		records.removeAll()
//		records = [:]
//		for c in store.countries
//		{
//			if c.name != nil && c.id != nil
//			{
//				records![c.name![store.myLang].value!] = c.id!
//			}
//		}
		records = store.countries
//		filtered = nil
//		searchControl.searchResultsUpdater = self
		definesPresentationContext = true
//		navigationItem.searchController = searchControl
		drawTitle()
		drawSearch()
		drawTable()
		drawButton()
		
		let str = "V:|[v0(\(titleBarHeight))][v1(\(searchBoxHeight))][v2]-5-[v3(\(buttonHeight))]-5-|"
		dialogWindow.addConstraintsWithFormat(format: str, views: titleLabel, searchBox, tableView, buttonSingle)
		
		drawDialog()
//		OperationQueue.main.addOperation
//		{
//			tableView.scrollToRow(at: self.selectedRow, at: .middle, animated: true)
//		}
	}


	override func viewDidLayoutSubviews()
	{
		super.viewDidLayoutSubviews()
//		tableView.reloadData()
//		self.tableView.scrollToRow(at: SelectCountryVC.selectedRow, at: .middle, animated: true)
	}


	func drawTitle()
	{
		titleLabel.text = "\(R.string.select) \(R.string.country)"
		titleLabel.font = UIFont.systemFont(ofSize: 21)
		dialogWindow.addSubview(titleLabel)
		dialogWindow.addConstraintsWithFormat(format: "H:|[v0]|", views: titleLabel)
		dialogWindow.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0, constant: titleBarHeight))
	}
	
	
	func drawSearch()
	{
		filtered = store.countries
		dialogWindow.addSubview(searchBox)
//		searchBox.translatesAutoresizingMaskIntoConstraints = false
		searchBox.delegate = self
		searchBox.becomeFirstResponder()
		searchBox.returnKeyType = UIReturnKeyType.done
//		dialogWindow.addConstraintsWithFormat(format: "H:|-3-[v0(25)]-2-[v1]-2-[v2(25)]|", views: buttonPrev, pageControl, buttonNext)
//		dialogWindow.addConstraint(NSLayoutConstraint(item: buttonPrev, attribute: .centerY, relatedBy: .equal, toItem: pageControl, attribute: .centerY, multiplier: 1, constant: 0))
//		dialogWindow.addConstraint(NSLayoutConstraint(item: buttonNext, attribute: .centerY, relatedBy: .equal, toItem: pageControl, attribute: .centerY, multiplier: 1, constant: 0))
		dialogWindow.addConstraintsWithFormat(format: "H:|[v0]|", views: searchBox)
	}
	
	
	func drawTable()
	{
		tableView = UITableView()
		tableView.dataSource = self
		tableView.delegate = self
		tableView.register(SelectCountryCell.self, forCellReuseIdentifier: cellId)
//		tableView.showsVerticalScrollIndicator = false
//		tableView.showsHorizontalScrollIndicator = false
		tableView.backgroundColor = UIColor.white
		dialogWindow.addSubview(tableView)
		dialogWindow.addConstraintsWithFormat(format: "H:|[v0]|", views: tableView)
	}
	
	
	func drawButton()
	{
//		buttonSingle.setTitle(R.string.dismiss.uppercased(), for: .normal)
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


	func findCountryObject(fromName: String) -> Country?
	{
		if isSearching
		{
			for c in filtered
			{
				if c.name != nil && store.valueById(object: c.name!, id: store.myLang) == fromName//c.name?[store.myLang].value == fromName
				{
					return c
				}
			}
		}
		else
		{
			for c in store.countries
			{
				if c.name != nil && store.valueById(object: c.name!, id: store.myLang) == fromName//c.name?[store.myLang].value == fromName
				{
					return c
				}
			}
		}
		return nil
	}


	func findCountryObject(fromId: Int) -> Country?
	{
		if isSearching
		{
			for c in filtered
			{
				if c.id == fromId
				{
					return c
				}
			}
		}
		else
		{
			for c in store.countries
			{
				if c.id == fromId
				{
					return c
				}
			}
		}
		return nil
	}

	
	func findCountryObject(fromRow: Int) -> Country?
	{
		if isSearching
		{
			for i in 0 ..< filtered.count
			{
				if i == fromRow
				{
					return filtered[i]
				}
			}
		}
		else
		{
			for i in 0 ..< store.countries.count
			{
				if i == fromRow
				{
					return store.countries[i]
				}
			}
		}
		return nil
	}


	// MARK: Actions
	@objc func buttonSingleTapped(_ sender: UITapGestureRecognizer)
	{
		self.dismiss(animated: true, completion: nil)
		NotificationCenter.default.post(name: AddressExpandedViewController.selectCountry, object: findCountryObject(fromRow: SelectCountryVC.selectedRow.row))
//		if records != nil
//		{
//			for (k, v) in records!
//			{
//				if v == SelectCountryVC.selectedRow.row+1
//				{
//					NotificationCenter.default.post(name: AddressExpandedViewController.selectCountry, object: (k,v))
//					break
//				}
//			}
//		}
	}

}



extension SelectCountryVC: UITableViewDataSource, UITableViewDelegate
{
	func numberOfSections(in tableView: UITableView) -> Int
	{
		return 1
	}


	// MARK: UITableViewDataSource
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		if isSearching
		{
			return filtered.count
		}
		return store.countries.count
//		return (filtered != nil && isSearching) ? filtered!.count : (records != nil) ? records!.count : 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! SelectCountryCell
		cell.setupViews()
		let obj = findCountryObject(fromRow: indexPath.row)
		if obj != nil
		{
			cell.titleLabel.text = store.valueById(object: (obj?.name)!, id: store.myLang)//obj?.name?[store.myLang].value
			if indexPath == SelectCountryVC.selectedRow
			{
				cell.titleLabel.textColor = UIColor.white
				cell.contentView.backgroundColor = R.color.YumaRed
			}
			else
			{
				cell.contentView.backgroundColor = UIColor.white
				cell.titleLabel.textColor = UIColor.darkGray
			}
		}
		else
		{
			cell.titleLabel.text = "not yet"
		}

		
//		if isSearching
//		{
//			cell.setupViews()
//			for (k, v) in filtered!
//			{
//				if v == indexPath.row+1
//				{
//					if defaultCountry == k// && SelectCountryVC.selectedRow.row != v
//					{	// highlight last selected country
//						SelectCountryVC.selectedRow = IndexPath(row: v-1, section: 0)
//						cell.titleLabel.textColor = UIColor.white
//						cell.contentView.backgroundColor = R.color.YumaRed
//					}
//					else
//					{
//						cell.contentView.backgroundColor = UIColor.white
//						cell.titleLabel.textColor = UIColor.darkGray
//					}
//					cell.titleLabel.text = k
//					cell.tag = v
//					break
//				}
//			}
//		}
//		else
//		{
//			cell.setupViews()
//			for (k, v) in records!
//			{
//				if v == indexPath.row+1
//				{
//					if defaultCountry == k// && SelectCountryVC.selectedRow.row != v-1
//					{
//						SelectCountryVC.selectedRow = IndexPath(row: v-1, section: 0)
//						cell.titleLabel.textColor = UIColor.white
//						cell.contentView.backgroundColor = R.color.YumaRed
//					}
//					else
//					{
//						cell.contentView.backgroundColor = UIColor.white
//						cell.titleLabel.textColor = UIColor.darkGray
//					}
//					cell.titleLabel.text = k
//					cell.tag = v
//					break
//				}
//			}
//		}
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
	{
		if SelectCountryVC.selectedRow.row > -1
		{	// unhighlight row hightlighted before
			if let cell = tableView.cellForRow(at: SelectCountryVC.selectedRow) as? SelectCountryCell
			{
				cell.contentView.backgroundColor = UIColor.clear
				cell.titleLabel.textColor = UIColor.darkGray
			}
		}
		if let cell = tableView.cellForRow(at: indexPath) as? SelectCountryCell
		{
			SelectCountryVC.selectedRow = indexPath
			UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
				cell.titleLabel.textColor = UIColor.white
				cell.contentView.backgroundColor = R.color.YumaRed
			}, completion: { (finished) in
				cell.titleLabel.textColor = UIColor.white
				cell.contentView.backgroundColor = R.color.YumaRed
			})
		}
	}

}



extension SelectCountryVC: UISearchBarDelegate, UISearchResultsUpdating
{
	// MARK: UISearchResultsUpdating
	func updateSearchResults(for searchController: UISearchController)
	{
		find = searchController.searchBar.text
		self.tableView.reloadData()
	}

	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
	{
//		if searchBar == searchBox
//		{
			if searchBar.text == nil || (searchBar.text?.isEmpty)!
			{
				isSearching = false
				view.endEditing(true)
			}
			else
			{
//				isSearching = true
				filtered.removeAll()
//				filtered = [:]
				filtered = store.countries.filter({ (country) -> Bool in
//					return (country.name?[store.myLang].value?.lowercased().contains(searchText.lowercased()))!
					return (store.valueById(object: country.name!, id: store.myLang)?.lowercased().contains(searchText.lowercased()))!
				})
//				records = data.filter({$0 == text})
				let _ = filtered.sorted { (a, b) -> Bool in
					(store.valueById(object: a.name!, id: store.myLang)!)/*a.name?[store.myLang].value)!*/ < (store.valueById(object: b.name!, id: store.myLang)!)/*b.name?[store.myLang].value)!*/
				}
				isSearching = (filtered.count == 0) ? false : true
			}
			tableView.reloadData()
//		}
	}

	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
	{
		isSearching = true
	}

	func searchBarTextDidEndEditing(_ searchBar: UISearchBar)
	{
		isSearching = false
	}

	func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
	{
		isSearching = false
	}

	func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
	{
		isSearching = false
	}

}
