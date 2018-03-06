//
//  CartViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-28.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class CartViewController: UIViewController
{
//	@IBOutlet weak var cellLabel: UILabel!
	//MARK: Properties
	@IBOutlet weak var tableView: UITableView!
	//@IBOutlet weak var tableCell: UITableViewCell!
//	@IBOutlet weak var cellLabel: UILabel!
	@IBOutlet weak var navBar: UINavigationBar!
//	@IBOutlet weak var table: UITableView!
	@IBOutlet weak var navTitle: UINavigationItem!
	@IBOutlet weak var navClose: UIBarButtonItem!
	@IBOutlet weak var navHelp: UIBarButtonItem!

	let cellID = "cartCell"
	private var contents = ["Apple", "Apricot", "Banana", "Blueberry", "Cantaloupe", "Cherry",
				  "Clementine", "Coconut", "Cranberry", "Fig", "Grape", "Grapefruit",
				  "Kiwi fruit", "Lemon", "Lime", "Lychee", "Mandarine", "Mango",
				  "Melon", "Nectarine", "Olive", "Orange", "Papaya", "Peach",
				  "Pear", "Pineapple", "Raspberry", "Strawberry"]
	
	
	override func viewDidLoad()
	{
        super.viewDidLoad()

		if #available(iOS 11.0, *)
		{
			navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		}
		else
		{
			navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
		}
		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
		navClose.title = FontAwesome.close.rawValue
		navigationItem.title = R.string.cart

		//tableView.dataSource = self//done in sb
    }
	

	@IBAction func navCloseAct(_ sender: Any)
	{
		self.dismiss(animated: false, completion: nil)
	}
	@IBAction func navHelpAct(_ sender: Any)
	{
	}

}

extension CartViewController: UITableViewDataSource, UITableViewDelegate
{
	func numberOfSections(in tableView: UITableView) -> Int
	{
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return contents.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		//		guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? TableViewCell else
		//		{
		//			fatalError("table dequeue error")
		//		}
		let cell = tableView.dequeueReusableCell(withIdentifier: cellID/*, for: indexPath*/) as! CartViewCell
		let text = contents[indexPath.row]
		cell.setup(string: text)
		//cell.cellLabel.text = text
		//cell.textLabel?.text = text//.cellLabel?.text = text
		return cell
	}

}
