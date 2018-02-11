//
//  LaptopsViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-10.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class LaptopsViewController: UIViewController {

	@IBOutlet weak var pageControl: UIPageControl!
	@IBOutlet weak var navHelp: UIBarButtonItem!
	@IBOutlet weak var navClose: UIBarButtonItem!
	@IBOutlet weak var navTitle: UINavigationItem!
	@IBOutlet weak var addToCartBtn: GradientButton!
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var backgroundImage: UIImageView!
	@IBOutlet weak var navBar: UINavigationBar!

	
	override func viewWillAppear(_ animated: Bool)
	{
		navTitle.title = R.string.laptops
		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

	@IBAction func addToCartBtnAct(_ sender: Any) {
	}
	
	@IBAction func closeView(sender: AnyObject)
	{
		self.dismiss(animated: true, completion: nil)
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
