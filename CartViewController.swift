//
//  CartViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-28.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UITableViewDataSource
{
	var contents = ["Apple", "Apricot", "Banana", "Blueberry", "Cantaloupe", "Cherry",
				  "Clementine", "Coconut", "Cranberry", "Fig", "Grape", "Grapefruit",
				  "Kiwi fruit", "Lemon", "Lime", "Lychee", "Mandarine", "Mango",
				  "Melon", "Nectarine", "Olive", "Orange", "Papaya", "Peach",
				  "Pear", "Pineapple", "Raspberry", "Strawberry"]
	
//	func numberOfSections(in tableView: UITableView) -> Int
//	{
//		return 1
//	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return contents.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! TableViewCell
		cell.cellLabel.text = contents[indexPath.row]
		return cell
	}
	
	@IBOutlet weak var navBar: UINavigationBar!
	@IBOutlet weak var table: UITableView!
	@IBOutlet weak var navTitle: UINavigationItem!
	@IBOutlet weak var navClose: UIBarButtonItem!
	@IBOutlet weak var navHelp: UIBarButtonItem!
	
	
	override func viewDidLoad()
	{
        super.viewDidLoad()

		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
		navClose.title = FontAwesome.close.rawValue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	

	@IBAction func navCloseAct(_ sender: Any)
	{
		self.dismiss(animated: false, completion: nil)
	}
	@IBAction func navHelpAct(_ sender: Any)
	{
	}
	/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
