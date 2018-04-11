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
	@IBOutlet weak var pickerView: UIPickerView!
	@IBOutlet weak var button: UIButton!
	var formatter: Int
	{
		get {
			return pickerView.selectedRow(inComponent: 0)
		}
	}
	
	
    override func viewDidLoad()
	{
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	@IBAction func buttonAct(_ sender: Any)
	{
		NotificationCenter.default.post(name: NSNotification.Name.gotNameFromPopup, object: self)
		self.dismiss(animated: false, completion: nil)
	}
	

}
