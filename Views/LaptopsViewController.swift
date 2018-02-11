//
//  LaptopsViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-10.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit
import Foundation

class LaptopsViewController: UIViewController, UIScrollViewDelegate
{
	@IBOutlet weak var navBar: UINavigationBar!
	@IBOutlet weak var navTitle: UINavigationItem!
	@IBOutlet weak var navClose: UIBarButtonItem!
	@IBOutlet weak var navHelp: UIBarButtonItem!
	@IBOutlet weak var backgroundImage: UIImageView!
	@IBOutlet weak var pageControl: UIPageControl!
	@IBOutlet weak var scrollView: UIScrollView!
	
	var laptopsDictionary: NSDictionary?
	var cartDictionary: NSDictionary?

	
	override func viewWillAppear(_ animated: Bool)
	{
		navTitle.title = R.string.laptops
		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
	}
	
	override func viewDidLoad()
	{
        super.viewDidLoad()
		//obtain array of products in cat laqptops
		let sv = UIViewController.displaySpinner(onView: self.view)
		WebServices.getLaptops() {
			(result, message, status) in
			if status
			{
				let Details = result as? WebServices
				self.laptopsDictionary = Details?.Data
				UIViewController.removeSpinner(spinner: sv)
				self.setSlider()
			}
			else
			{
				UIViewController.removeSpinner(spinner: sv)
				print("error with getLaptops")
			}
		}
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

	
	@IBAction func addToCartBtnAct(_ sender: Any)
	{
		//get current item
		//add proditem to cart array
		//cartDictionary.
	}
	
	@IBAction func closeView(sender: AnyObject)
	{
		self.dismiss(animated: true, completion: nil)
	}


	func setSlider()
	{
		scrollView.delegate = self
		scrollView.frame = view.frame
		scrollView.showsHorizontalScrollIndicator = false
		
		scrollView.subviews.forEach({ 	$0.removeFromSuperview() 	})
//		for (index, slide) in (laptopsDictionary?.enumerated())!
//		{
//			//(slides as NSArray).enumerateObjects { (slide, index) -> Void in
//			let aSlide = ProductViewController()
//			aSlide.prodName.text = laptopsDictionary![index]?["name"]
//			let xPos = self.view.frame.width * CGFloat(index)	//calculate x depending upon slide index
//			aSlide.frame = CGRect(x: xPos, y: -200, width: self.scrollView.frame.width, height: self.scrollView.frame.height)						//set the frame as 250 pixels less??????
//			scrollView.contentSize.width = scrollView.frame.width * CGFloat(index + 1)	//add slide image to scrollview
//			scrollView.addSubview(aSlide)
//
//			//add tap function to slide
//			//let selName = NSClassFromString(slide.target)
//			aSlide.isUserInteractionEnabled = true
//			aSlide.tag = index
//			let tapImage = UITapGestureRecognizer(target: self, action: #selector(slideAction(_:)))
//			aSlide.addGestureRecognizer(tapImage)
//			//imageView.tag = self.start selName
//		}

		pageControl.numberOfPages = (laptopsDictionary?.count)!
		//var laptops: Set<Laptop> = []
		let value = laptopsDictionary!["products"] as? [String : AnyObject]
		let count = value?.count
		for (key, value) in laptopsDictionary!
		{
			print("\(key)=\(value)")
		}
//		if let laptops = laptopsDictionary!["products"] as! [String : Any]
//		{
//			let a = laptops.customMirror
//		}
	}

}
