//
//  SelectCountryVC.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-05-25.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


class SelectCountryVC: UIViewController
{
	var noteName = Notification.Name("")
	let cellId = "selectCounty"
	var initalDone = false
	var tableView: UITableView!
//	var dataSource?
//	var searchControl: UISearchController!
//	var searchControl: UISearchController =
//	{
//		let view = UISearchController(searchResultsController: nil)
//		view.searchBar.placeholder = "\(R.string.search_hint) \(R.string.country)"
//		view.searchBar.tintColor = R.color.YumaRed
//		view.searchBar.autocapitalizationType = .none
//		return view
//	}()
//	var searchBox: UISearchBar!
	var searchBox: UISearchBar =
	{
		let view = UISearchBar()
		view.translatesAutoresizingMaskIntoConstraints = false
//		view.isUserInteractionEnabled = false
//		view.showsCancelButton = true
		view.showsBookmarkButton = false
//		view.searchBarStyle = UISearchBarStyle.default
		view.placeholder = "\(R.string.search_hint) \(R.string.country)"
		view.tintColor = R.color.YumaRed
		view.autocapitalizationType = .none
		view.showsSearchResultsButton = false
		return view
	}()
//	var find: String?
	var isSearching = false
//	private var isRemovingTextWithBackspace = true
	var filtered: [Country] = []
	static var selectedRow = IndexPath(row: 0, section: 0)
	let dialogWindow: UIView =
	{
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.isUserInteractionEnabled = true
		view.backgroundColor = UIColor.white
		view.cornerRadius = 20
		view.shadowColor = R.color.YumaDRed.withAlphaComponent(0.5)
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
		view.shadowOpacity = 0.5
		view.shadowOffset = CGSize(width: 1, height: 1)
		return view
	}()
	let buttonLeft: GradientButton =
	{
		let view = GradientButton()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.setTitle(R.string.cancel.uppercased(), for: .normal)
		view.titleLabel?.shadowOffset = CGSize(width: 2, height: 2)
		view.titleLabel?.shadowRadius = 3
		view.titleLabel?.textColor = UIColor.white
		view.setTitleShadowColor(R.color.YumaDRed, for: .normal)
		//view.widthAnchor.constraint(equalToConstant: 200).isActive = true
		view.backgroundColor = R.color.YumaRed.withAlphaComponent(0.8)
		view.cornerRadius = 3
		view.shadowColor = UIColor.darkGray
		view.shadowOffset = CGSize(width: 1, height: 1)
		view.shadowRadius = 3
		view.borderColor = R.color.YumaDRed
		view.borderWidth = 1
		//		view.shadowOpacity = 0.9
		let titleShadow: NSShadow =
		{
			let view = NSShadow()
			view.shadowColor = UIColor.black
			//			view.shadowRadius = 3
			view.shadowOffset = CGSize(width: 1, height: 1)
			return view
		}()
		view.setAttributedTitle(NSAttributedString(string: view.title(for: .normal)!, attributes: [NSAttributedStringKey.font : UIFont(name: "AvenirNext-DemiBold", size: 17)!, NSAttributedStringKey.shadow : titleShadow]), for: .normal)
		view.layer.addBackgroundGradient(colors: [R.color.YumaRed, R.color.YumaYel], isVertical: true)
		view.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 3.6, isVertical: true)
		return view
	}()
	let buttonRight: GradientButton =
	{
		let view = GradientButton()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.setTitle(R.string.cont.uppercased(), for: .normal)
		view.titleLabel?.shadowOffset = CGSize(width: 2, height: 2)
		view.titleLabel?.shadowRadius = 3
		view.titleLabel?.textColor = UIColor.white
		view.setTitleShadowColor(R.color.YumaDRed, for: .normal)
		//view.widthAnchor.constraint(equalToConstant: 200).isActive = true
		view.backgroundColor = R.color.YumaRed.withAlphaComponent(0.8)
		view.cornerRadius = 3
		view.shadowColor = UIColor.darkGray
		view.shadowOffset = CGSize(width: 1, height: 1)
		view.shadowRadius = 3
		//		view.layer.addBackgroundGradient(colors: [R.color.YumaRed, R.color.YumaYel], isVertical: true)
		//		view.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		view.borderColor = R.color.YumaDRed
		view.borderWidth = 1
		//		view.shadowOpacity = 0.9
		let titleShadow: NSShadow =
		{
			let view = NSShadow()
			view.shadowColor = UIColor.black
			//			view.shadowRadius = 3
			view.shadowOffset = CGSize(width: 1, height: 1)
			return view
		}()
		view.setAttributedTitle(NSAttributedString(string: view.title(for: .normal)!, attributes: [NSAttributedStringKey.font : UIFont(name: "AvenirNext-DemiBold", size: 17)!, NSAttributedStringKey.shadow : titleShadow]), for: .normal)
		view.layer.addBackgroundGradient(colors: [R.color.YumaRed, R.color.YumaYel], isVertical: true)
		view.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		return view
	}()
//	let buttonSingle: GradientButton =
//	{
//		let view = GradientButton()
//		view.translatesAutoresizingMaskIntoConstraints = false
//		view.setTitle(R.string.cont.uppercased(), for: .normal)
//		view.titleLabel?.shadowOffset = CGSize(width: 2, height: 2)
//		view.titleLabel?.shadowRadius = 3
//		view.titleLabel?.textColor = UIColor.white
//		view.setTitleShadowColor(R.color.YumaDRed, for: .normal)
//		view.topGradientColor = R.color.YumaRed
//		view.bottomGradientColor = R.color.YumaYel
//		view.cornerRadius = 3
//		view.shadowColor = UIColor.darkGray
//		view.shadowOffset = CGSize(width: 1, height: 1)
//		view.shadowRadius = 3
//		view.borderColor = R.color.YumaDRed
//		view.borderWidth = 1
//		let titleShadow: NSShadow =
//		{
//			let view = NSShadow()
//			view.shadowColor = UIColor.black
//			//			view.shadowRadius = 3
//			view.shadowOffset = CGSize(width: 1, height: 1)
//			return view
//		}()
//		view.setAttributedTitle(NSAttributedString(string: view.title(for: .normal)!, attributes: [NSAttributedStringKey.font : UIFont(name: "AvenirNext-DemiBold", size: 18)!, NSAttributedStringKey.shadow : titleShadow]), for: .normal)
//		return view
//	}()
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
//		records.removeAll()
//		records = store.countries
//		searchBox = searchControl.searchBar
		
		drawTitle()
		drawSearch()
		drawTable()
		drawButton()
		
		let str = "V:|[v0(\(titleBarHeight))][v1(\(searchBoxHeight))][v2]-5-[v3(\(buttonHeight))]-5-|"
//		dialogWindow.addConstraintsWithFormat(format: str, views: titleLabel, searchControl.searchBar, tableView, buttonSingle)
//		dialogWindow.addConstraintsWithFormat(format: str, views: titleLabel, searchBox, tableView, buttonSingle)
		dialogWindow.addConstraintsWithFormat(format: str, views: titleLabel, searchBox, tableView, buttonLeft)
//		let str = "V:|[v0(\(titleBarHeight))][v1]-5-[v2(\(buttonHeight))]-5-|"
//		dialogWindow.addConstraintsWithFormat(format: str, views: titleLabel, tableView, buttonSingle)

		drawDialog()
//		DispatchQueue.main.asyncAfter(deadline: .now()+0.1, execute:
//		{
//			self.tableView.reloadData()
//			if SelectCountryVC.selectedRow.row < self.tableView.numberOfRows(inSection: 0)
//			{
//				self.tableView.scrollToRow(at: SelectCountryVC.selectedRow, at: .middle, animated: true)
//			}
//		})
	}


	override func viewDidLayoutSubviews()
	{
		super.viewDidLayoutSubviews()
//		tableView.reloadData()
		var i = 0
		for c in store.countries
		{
			if defaultCountry == store.valueById(object: c.name!, id: store.myLang)
			{
				SelectCountryVC.selectedRow = IndexPath(row: i, section: 0)
				if SelectCountryVC.selectedRow.row < self.tableView.numberOfRows(inSection: 0)
				{
					self.tableView.scrollToRow(at: SelectCountryVC.selectedRow, at: .middle, animated: false)
				}
			}
			i += 1
		}
//		self.tableView.scrollToRow(at: SelectCountryVC.selectedRow, at: .middle, animated: true)
//		let _ = titleLabel.addBackgroundGradient(colors: [R.color.YumaDRed.cgColor, R.color.YumaRed.cgColor], isVertical: true)
		titleLabel.text = "\(R.string.select.uppercased()) \(R.string.country.uppercased())"
//		titleLabel.font = UIFont.systemFont(ofSize: 21)
		let _ = buttonLeft.addBackgroundGradient(colors: [R.color.YumaRed.cgColor, R.color.YumaYel.cgColor], isVertical: true)
		buttonLeft.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		let _ = buttonRight.addBackgroundGradient(colors: [R.color.YumaRed.cgColor, R.color.YumaYel.cgColor], isVertical: true)
		buttonRight.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
//		let _ = buttonSingle.addBackgroundGradient(colors: [R.color.YumaRed.cgColor, R.color.YumaYel.cgColor], isVertical: true)
//		buttonSingle.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 3.6, isVertical: true)
	}


	func drawTitle()
	{
		dialogWindow.addSubview(titleLabel)
		dialogWindow.addConstraintsWithFormat(format: "H:|[v0]|", views: titleLabel)
		dialogWindow.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0, constant: titleBarHeight))
	}
	
	
	func drawSearch()
	{
		filtered = store.countries
//		searchControl = UISearchController(searchResultsController: nil)
//		searchControl.searchResultsUpdater = self
//		searchControl.dimsBackgroundDuringPresentation = false
//		definesPresentationContext = true
//		dialogWindow.addSubview(searchControl.searchBar)
//		searchControl.searchBar.delegate = self
//		searchControl.searchBar.becomeFirstResponder()
//		searchControl.searchBar.returnKeyType = .done
		dialogWindow.addSubview(searchBox)
		searchBox.delegate = self
		searchBox.becomeFirstResponder()
		searchBox.returnKeyType = UIReturnKeyType.done
		
		dialogWindow.addConstraintsWithFormat(format: "H:|[v0]|", views: searchBox)
//		dialogWindow.addConstraintsWithFormat(format: "H:|[v0]|", views: searchControl.searchBar)
	}
	
	
	func drawTable()
	{
		tableView = UITableView()
		tableView.dataSource = self
		tableView.delegate = self
//		tableView.tableHeaderView = searchControl.searchBar
		tableView.register(SelectCountryCell.self, forCellReuseIdentifier: cellId)
//		tableView.showsVerticalScrollIndicator = false
//		tableView.showsHorizontalScrollIndicator = false
		tableView.backgroundColor = UIColor.white
		dialogWindow.addSubview(tableView)
		dialogWindow.addConstraintsWithFormat(format: "H:|[v0]|", views: tableView)
	}
	
	
	func drawButton()
	{
		buttonLeft.setTitle(R.string.dismiss.uppercased(), for: .normal)
		buttonRight.setTitle(R.string.complete.uppercased(), for: .normal)
		dialogWindow.addSubview(buttonLeft)
		dialogWindow.addSubview(buttonRight)
		dialogWindow.addConstraintsWithFormat(format: "H:|-20-[v0(\(dialogWidth/3))]", views: buttonLeft)
		dialogWindow.addConstraintsWithFormat(format: "H:[v0(\(dialogWidth/3))]-20-|", views: buttonRight)
		dialogWindow.addConstraint(NSLayoutConstraint(item: buttonLeft, attribute: .centerY, relatedBy: .equal, toItem: buttonRight, attribute: .centerY, multiplier: 1, constant: 0))
		dialogWindow.addConstraintsWithFormat(format: "V:[v0(\(buttonHeight))]-5-|", views: buttonLeft)
		dialogWindow.addConstraintsWithFormat(format: "V:[v0(\(buttonHeight))]-5-|", views: buttonRight)
		buttonLeft.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonLeftTapped(_:))))
		buttonRight.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonRightTapped(_:))))
//		dialogWindow.addSubview(buttonSingle)
//		dialogWindow.addConstraint(NSLayoutConstraint(item: buttonSingle, attribute: .width, relatedBy: .equal, toItem: dialogWindow, attribute: .width, multiplier: 0, constant: dialogWidth / 2))
//		dialogWindow.addConstraint(NSLayoutConstraint(item: buttonSingle, attribute: .centerX, relatedBy: .equal, toItem: dialogWindow, attribute: .centerX, multiplier: 1, constant: 0))
//		dialogWindow.addConstraint(NSLayoutConstraint(item: buttonSingle, attribute: .height, relatedBy: .equal, toItem: dialogWindow, attribute: .height, multiplier: 0, constant: buttonHeight))
//		buttonSingle.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonSingleTapped(_:))))
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
				if c.name != nil && store.valueById(object: c.name!, id: store.myLang) == fromName
				{
					return c
				}
			}
		}
		else
		{
			for c in store.countries
			{
				if c.name != nil && store.valueById(object: c.name!, id: store.myLang) == fromName
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
			for i in 0..<filtered.count
			{
				if i == fromRow
				{
					return filtered[i]
				}
			}
		}
		else
		{
			for i in 0..<store.countries.count
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
	@objc func buttonLeftTapped(_ sender: UITapGestureRecognizer)
	{
		store.flexView(view: buttonLeft)
		self.dismiss(animated: true, completion: nil)
	}
	
	@objc func buttonRightTapped(_ sender: UITapGestureRecognizer)
//	@objc func buttonSingleTapped(_ sender: UITapGestureRecognizer)
	{
		self.dismiss(animated: true, completion: nil)
//		print("notify -posting to:\(noteName)")
		if defaultCountry != nil
		{
			if let object = findCountryObject(fromName: defaultCountry!)//(fromRow: SelectCountryVC.selectedRow.row)
			{
	//			defaultCountry = store.valueById(object: (object.name)!, id: store.myLang)
				NotificationCenter.default.post(name: AddressExpandedViewController.selectCountry, object: object)
	//			NotificationCenter.default.post(name: noteName, object: object)
			}
			else
			{
				NotificationCenter.default.post(name: AddressExpandedViewController.selectCountry, object: nil)
	//			NotificationCenter.default.post(name: noteName, object: nil)
			}
		}
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
//		if isSearching
//		{
//			return filtered.count
//		}
//		return store.countries.count
//		return (isSearching) ? filtered.count : store.countries.count
		return filtered.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! SelectCountryCell
		cell.setupViews()
		let obj = findCountryObject(fromRow: indexPath.row)
		if obj != nil
		{
			let name = store.valueById(object: (obj?.name)!, id: store.myLang)
			cell.titleLabel.text = name
			cell.tag = (obj?.id)!+10
			if name == defaultCountry || defaultCountryId == cell.tag-10//indexPath == SelectCountryVC.selectedRow //&& isSearching
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
//		else
//		{
//			cell.titleLabel.text = "not yet"
//		}
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
	{
		searchBox.resignFirstResponder()
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
//			if !isSearching
//			{
			defaultCountry = cell.titleLabel.text
			defaultCountryId = cell.tag-10
				SelectCountryVC.selectedRow = indexPath
				UIView.animate(withDuration: 0.25, delay: 0, options: [], animations: {
					cell.titleLabel.textColor = UIColor.white
					cell.contentView.backgroundColor = R.color.YumaRed
				}, completion: { (finished) in
					cell.titleLabel.textColor = UIColor.white
					cell.contentView.backgroundColor = R.color.YumaRed
				})
//			}
		}
	}

}



extension SelectCountryVC: UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate
{
	// MARK: UISearchResultsUpdating
	func updateSearchResults(for searchController: UISearchController)
	{
//		find = searchController.searchBar.text
		self.tableView.reloadData()
	}

//	func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
//	{
//		self.isRemovingTextWithBackspace = (NSString(string: searchBar.text!).replacingCharacters(in: range, with: text).count == 0)
//		return true
//	}

	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
	{
//		if isSearching
//		{
//			searchBarShouldBeginEditing = searchBar.isFirstResponder
//		}
//		if searchText.count == 0 && !isRemovingTextWithBackspace
//		{
////			NSLog("Has clicked on clear!")
//			print("Has clicked on clear!")
//		}
//		if !searchBar.isFirstResponder
//		{
//			shouldBeginEditing = false
//		}
//		else if (searchBar.text?.isEmpty)!
//		{
//			performSelector(onMainThread: "resignFirstResponder", with: nil, waitUntilDone: true, modes: nil)
//		}
//		if searchBar == searchBox
//		{
			if searchBar.text == nil || (searchBar.text?.isEmpty)!
			{
				isSearching = false
				filtered = store.countries
//				view.endEditing(true)
			}
			else
			{
				filtered.removeAll()
				filtered = store.countries.filter({ (country) -> Bool in
					return (store.valueById(object: country.name!, id: store.myLang)?.lowercased().contains(searchText.lowercased()))!
				})
				let _ = filtered.sorted { (a, b) -> Bool in
					(store.valueById(object: a.name!, id: store.myLang)!) < (store.valueById(object: b.name!, id: store.myLang)!)
				}
				isSearching = (filtered.count == 0) ? false : true
			}
			tableView.reloadData()
//		}
	}
	
//	@objc func makeSearchBarFirstResponder(_ sender: UISearchBar)
//	{
//		sender.becomeFirstResponder()
//	}

	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
	{
//		searchBar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(makeSearchBarFirstResponder(_:))))
		searchBar.becomeFirstResponder()
//		print("searchBarTextDidBeginEditing")//fires on start typing
		isSearching = true
	}

	func searchBarTextDidEndEditing(_ searchBar: UISearchBar)
	{
//		print("searchBarTextDidEndEditing")//fires on delete all characters
		isSearching = false
	}

	func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
	{
//		searchBar.text = ""
		print("searchBarCancelButtonClicked")
		isSearching = false
	}

	func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
	{
		print("searchBarSearchButtonClicked")
		isSearching = false
	}

}
