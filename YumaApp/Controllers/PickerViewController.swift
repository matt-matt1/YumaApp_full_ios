//
//  PickerViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-04-09.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController
{
	@IBOutlet var backgroundView: UIView!
	@IBOutlet weak var dialog: UIView!
	@IBOutlet weak var titleLbl: UILabel!
//	@IBOutlet weak var pickerView: UIPickerView!
	@IBOutlet weak var button: UIButton!
	@IBOutlet weak var buttonContainer: UIView!
//	@IBOutlet weak var buttonBackground: UIView!
//	@IBOutlet weak var buttonLabel: UILabel!
	//var onSelected: ((_ data: String) -> ())?
	var noteName = Notification.Name("")
	
	
    override func viewDidLoad()
	{
        super.viewDidLoad()
		NSLayoutConstraint.activate([
			view.centerXAnchor.constraint(equalTo: dialog.centerXAnchor),
			view.centerYAnchor.constraint(equalTo: dialog.centerYAnchor),
		])
		button.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 3.6, isVertical: true)
    }


//	override func viewDidLayoutSubviews()
//	{
//		super.viewDidLayoutSubviews()
//	}

	override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	@IBAction func buttonAct(_ sender: UIButton)
	{
//		NotificationCenter.default.post(name: NSNotification.Name.gotNameFromPopup, object: self)
		//onSelected
		DataStore.sharedInstance.flexView(view: sender)
		self.dismiss(animated: false, completion: nil)
	}

}


extension PickerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		return R.array.help_cart_guide.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "helpCellId", for: indexPath)
		return cell
	}
	
	//
}
