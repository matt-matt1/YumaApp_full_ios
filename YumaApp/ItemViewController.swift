//
//  ItemViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-01-29.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {

	var itemIndex: Int = 0
	var imageName: String = "" {
		didSet {
			if let imageView = contentImageView{
				imageView.image = UIImage(named: imageName)
			}
		}
	}
	@IBOutlet weak var contentImageView: UIImageView!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        contentImageView.image = UIImage(named: imageName)
    }

    override func didReceiveMemoryWarning() {
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

}
