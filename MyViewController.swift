//
//  MyViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-22.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class MyViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
	@IBOutlet weak var collView: UICollectionView!
	
	override func viewDidLoad()
	{
        super.viewDidLoad()

		collView?.register(UINib(nibName: "MyViewController", bundle: nil), forCellWithReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning()
	{
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
	
	let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
	var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48"]
	
	
	// MARK: - UICollectionViewDataSource protocol
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		return self.items.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionViewCell
		cell.myLabel.text = self.items[indexPath.item]
		cell.backgroundColor = UIColor.cyan
		return cell
	}
	
	// MARK: - UICollectionViewDelegate protocol
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
	{
		print("You selected cell #\(indexPath.item)!")
	}

}
