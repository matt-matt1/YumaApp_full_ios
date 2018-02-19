//
//  MyAccAddressViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-18.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class MyAccAddressViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
	let store = DataStore.sharedInstance
	var addresses: [Address] = []
	
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		return addresses.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddressCell", for: indexPath) as! MyAccAddrCell
		//cell.backgroundColor = indexPath.item % 2 == 0 ? .red : .green
		let page = addresses[indexPath.item]
		cell.aliasField.text = page.alias
		cell.addressField.text = R.formatAddress(page)
		return cell
	}
	
	@IBOutlet weak var buttonLeft: GradientButton!
	@IBOutlet weak var collView: UICollectionView!
	@IBOutlet weak var buttonRight: GradientButton!
	@IBOutlet weak var navHelp: UIBarButtonItem!
	@IBOutlet weak var navClose: UIBarButtonItem!
	@IBOutlet weak var navTitle: UINavigationItem!
	@IBOutlet weak var navBar: UINavigationItem!

	
	override func viewDidLoad()
	{
        super.viewDidLoad()

        collView.delegate = self
		collView.dataSource = self
    }

    override func didReceiveMemoryWarning()
	{
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	@IBAction func navCloseAct(_ sender: Any)
	{
	}
	@IBAction func navHelpAct(_ sender: Any)
	{
	}
	@IBAction func buttonLeftAct(_ sender: Any)
	{
	}
	@IBAction func buttonRightAct(_ sender: Any)
	{
	}
	/*
	@IBAction func buttonRightAct(_ sender: Any) {
	}
	// MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
