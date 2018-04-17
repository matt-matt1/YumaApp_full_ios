//
//  MyAccOHViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-17.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class MyAccOHViewController: UIViewController
{
	@IBOutlet weak var navBar: UINavigationBar!
	@IBOutlet weak var navTitle: UINavigationItem!
	@IBOutlet weak var navClose: UIBarButtonItem!
	@IBOutlet weak var navHelp: UIBarButtonItem!
	
	
    override func viewDidLoad()
	{
        super.viewDidLoad()

//		if #available(iOS 11.0, *) {
//			navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//		} else {
//			navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
//		}
		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
		navHelp.title = FontAwesome.questionCircle.rawValue
		navHelp.setTitleTextAttributes([NSAttributedStringKey.font : R.font.FontAwesomeOfSize(pointSize: 21)], for: .normal)
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
	
}
