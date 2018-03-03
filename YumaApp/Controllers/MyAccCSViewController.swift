//
//  MyAccCSViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-15.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class MyAccCSViewController: UIViewController
{
	@IBOutlet weak var navBar: UINavigationBar!

	override func viewDidLoad() {
        super.viewDidLoad()

		if #available(iOS 11.0, *) {
			navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		} else {
			navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
		}
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
