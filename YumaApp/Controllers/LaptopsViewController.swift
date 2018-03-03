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
	@IBOutlet weak var add2CartBtn: GradientButton!
	@IBOutlet weak var leftLabel: UILabel!
	@IBOutlet weak var centerLabel: UILabel!
	@IBOutlet weak var rightLabel: UILabel!
	
	var laptopsDictionary: NSDictionary?
	var cartDictionary: NSDictionary?

	
	override func viewWillAppear(_ animated: Bool)
	{
		navTitle.title = R.string.laptops
	}
	
	override func viewDidLoad()
	{
        super.viewDidLoad()
		if #available(iOS 11.0, *) {
			navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		} else {
			navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
		}
		navBar.applyNavigationGradient(colors: [R.color.YumaRed, R.color.YumaDRed], isVertical: true)
		add2CartBtn.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		refresh()
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
		_ = value?.count
		for (key, value) in laptopsDictionary!
		{
			print("\(key)=\(value)")
		}
//		if let laptops = laptopsDictionary!["products"] as! [String : Any]
//		{
//			let a = laptops.customMirror
//		}
	}
	
	func refresh()
	{
		let sv = UIViewController.displaySpinner(onView: self.view)
		leftLabel.text = ""
		centerLabel.text = "\(R.string.updating) ..."
		rightLabel.text = ""
		pageControl.isHidden = true
		PSWebServices.getPrinters(completionHandler: { (printers) in
			UIViewController.removeSpinner(spinner: sv)
			//		PSWebServices.getPrinters2(completionHandler: { (printers) in
			//			UIViewController.removeSpinner(spinner: sv)
			//print("got \(printers) printers")
			
			//UILabel.text must be used from main thread only
			self.leftLabel.text = " \(R.string.updated)"
			self.centerLabel.text = FontAwesome.repeat.rawValue
			self.centerLabel.font = R.font.FontAwesomeOfSize(pointSize: 30)
			let date = Date()
			let df = DateFormatter()
			df.locale = Locale(identifier: "en_CA")
			df.dateFormat = "dd MMM YYYY  h:mm:ss a"
			self.rightLabel.text = "\(df.string(from: date)) "
			self.pageControl.isHidden = false
			//self.haveJSON(printers)
		})
	}
	
}
