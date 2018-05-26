//
//  SelectCountryVC.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-05-25.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


class SelectCountryVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchResultsUpdating
{
	let cellId = "selectCounty"
	var tableView: UITableView!
//	var searchBox: UISearchBar!//UISearchController!
	var find: String?
	var isSearching = false
	var records: [String : Int]?
	var selectedRow: IndexPath?
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
		view.cornerRadius = 20
		view.clipsToBounds = true
		view.textColor = UIColor.white
		view.textAlignment = .center
		view.layer.masksToBounds = true
		view.clipsToBounds = true
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
	let searchBox: UISearchBar =
	{
		let view = UISearchBar()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.isUserInteractionEnabled = false
		return view
	}()
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
		records?.removeAll()
		records = [:]
		for c in store.countries
		{
			if c.name != nil && c.id != nil
			{
				records![c.name![store.myLang].value!] = c.id!
			}
		}
		drawTitle()
		drawSearch()
		drawTable()
		drawButton()
		
		let str = "V:|[v0(\(titleBarHeight))][v1(\(searchBoxHeight))][v2][v3(\(buttonHeight))]-5-|"
		dialogWindow.addConstraintsWithFormat(format: str, views: titleLabel, searchBox, tableView, buttonSingle)
		
		drawDialog()
	}
	
	
	func drawTitle()
	{
		titleLabel.text = R.string.help
		titleLabel.font = UIFont.systemFont(ofSize: 21)
		dialogWindow.addSubview(titleLabel)
		dialogWindow.addConstraintsWithFormat(format: "H:|[v0]|", views: titleLabel)
		dialogWindow.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0, constant: titleBarHeight))
	}
	
	
	func drawSearch()
	{
		dialogWindow.addSubview(searchBox)
		searchBox.returnKeyType = UIReturnKeyType.done
//		dialogWindow.addConstraintsWithFormat(format: "H:|-3-[v0(25)]-2-[v1]-2-[v2(25)]|", views: buttonPrev, pageControl, buttonNext)
//		dialogWindow.addConstraint(NSLayoutConstraint(item: buttonPrev, attribute: .centerY, relatedBy: .equal, toItem: pageControl, attribute: .centerY, multiplier: 1, constant: 0))
//		dialogWindow.addConstraint(NSLayoutConstraint(item: buttonNext, attribute: .centerY, relatedBy: .equal, toItem: pageControl, attribute: .centerY, multiplier: 1, constant: 0))
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
		if records != nil && selectedRow != nil
		{
			for (k, v) in records!
			{
				if v == selectedRow?.row
				{
					NotificationCenter.default.post(name: AddressExpandedViewController.selectCountry, object: (k,v))
					break
				}
			}
		}
	}


	func numberOfSections(in tableView: UITableView) -> Int
	{
		return 1
	}


	// MARK: UITableViewDataSource
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
//		if records != nil
//		{
//			return records!.count
//		}
//		return 0
		return records != nil ? records!.count : 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! SelectCountryCell
		if records != nil
		{
			cell.setupViews()
			for (k, v) in records!
			{
				if v == indexPath.row
				{
					cell.titleLabel.text = k
					break
				}
			}
		}
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
	{
		if selectedRow != nil && (selectedRow?.row)! > -1 && records != nil && (selectedRow?.row)! < (records?.count)!
		{
			tableView.cellForRow(at: selectedRow!)?.contentView.backgroundColor = UIColor.white
		}
		selectedRow = indexPath
		let cell = tableView.cellForRow(at: indexPath)!
		UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
			cell.contentView.backgroundColor = R.color.YumaRed
			cell.textLabel?.textColor = UIColor.white
		}, completion: { (finished) in
			cell.contentView.backgroundColor = R.color.YumaRed
			cell.textLabel?.textColor = UIColor.white
//			cell.contentView.backgroundColor = UIColor.clear
//			cell.textLabel?.textColor = UIColor.darkGray
		})
	}

	
	// MARK: UISearchResultsUpdating
	func updateSearchResults(for searchController: UISearchController)
	{
		find = searchController.searchBar.text
//		query.query = searchController.searchBar.text
//		let curSearchId = searchId
//		movieIndex.search(query, block: { (data, error) -> Void in
//			if (curSearchId <= self.displayedSearchId) || (error != nil) {
//				return // Newest query already displayed or error
//			}
//			self.displayedSearchId = curSearchId
//			self.loadedPage = 0 // Reset loaded page
//			// Decode JSON
//			guard let hits = content!["hits"] as? [[String: AnyObject]] else { return }
//			guard let nbPages = content!["nbPages"] as? UInt else { return }
//			self.nbPages = nbPages
//			&nbsp;var tmp = [MovieRecord]()
//			for hit in hits {
//				tmp.append(MovieRecord(json: hit))
//			}
//			// Reload view with the new data
//			self.movies = tmp
//			self.tableView.reloadData()
//		})
//		++self.searchId
	}

	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
	{
		if searchBar == searchBox
		{
			if searchBar.text == nil || (searchBar.text?.isEmpty)!
			{
				isSearching = false
				view.endEditing(true)
				tableView.reloadData()
			}
			else
			{
				isSearching = true
				records?.removeAll()
				records = [:]
				for (k, v) in records!
				{
					if k.contains(searchText)
					{
						records![k] = v
					}
				}
//				records = data.filter({$0 == text})
				tableView.reloadData()
			}
		}
	}
}
