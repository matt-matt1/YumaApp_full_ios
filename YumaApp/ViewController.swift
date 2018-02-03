//
//  ViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-01-29.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class ViewController: UIViewController/*, UIPageViewControllerDataSource*/ {

	let dummy_string = NSLocalizedString("str_key", comment: "str_value")
	let welcomeMessage = NSLocalizedString("welcome.message", comment: "")
	let welcomeName = String(format: NSLocalizedString("welcome.withName", comment: ""), locale: NSLocale.current, "Alice")
	let progress = String(format: NSLocalizedString("copy.progress", comment: ""), locale: NSLocale.current, 4, 23)
	
	let YumaRed = UIColor(red: 0.66666666669999997, green: 0.0, blue: 0.094117647060000004, alpha: 1)
	let YumaYel = UIColor(red: 0.99942404029999998, green: 0.98555368190000003, blue: 0.0, alpha: 1)

	@IBOutlet weak var ICIcon: UILabel!
	@IBOutlet weak var ICText: UILabel!
	
	var slides: [Slide] = []
	let slide1 = Slide(id: 1, image: "home-slider-printers", 	caption1: "Laser Printers", 	caption2: "", 		target: "")
	let slide2 = Slide(id: 2, image: "home-slider-cartridges", 	caption1: "Toner Cartridges", 	caption2: "that last", target: "")
	let slide3 = Slide(id: 3, image: "home-slider-laptops", 	caption1: "Laptop Computers", 	caption2: "", 		target: "")
//	var images = ["home-slider-printers", "home-slider-cartridges", "home-slider-laptops"]
	var pageViewController: UIPageViewController?
	var currentIndex: Int = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		slides.append(slide1)
		slides.append(slide2)
		slides.append(slide3)
		
/*
		createPageViewController();
		setupPageControl();
		
		Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.next(_:)), userInfo: nil, repeats: true)
*/
	}
/*
	@objc func next(_ timer: Timer) {
		currentIndex += 1
		//if currentIndex == images.count-1 {
		if currentIndex == slides.count-1 {
			currentIndex = 0
		}
		pageViewController?.goToNextPage()
	}
*/
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
/*
	func createPageViewController() {
		
		let pageController = self.storyboard?.instantiateViewController(withIdentifier: "PageController") as! UIPageViewController
		
		pageController.dataSource = self
		
		if slides.count > 0 {
		//if images.count > 0 {
			
			let firstController = getItemController(0)!
			let startingViewControllers = [firstController]
			
			pageController.setViewControllers(startingViewControllers, direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
		}
		pageViewController = pageController
		addChildViewController(pageViewController!)
		self.view.addSubview(pageViewController!.view)
		pageViewController!.didMove(toParentViewController: self)
	}

	func setupPageControl() {
		let appearance = UIPageControl.appearance()
		appearance.pageIndicatorTintColor = UIColor.gray
		appearance.currentPageIndicatorTintColor = UIColor.white
		appearance.backgroundColor = UIColor.darkGray
	}
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
		let itemController = viewController as! ItemViewController
		if itemController.itemIndex > 0 {
			return getItemController(itemController.itemIndex-1)
		}
		return nil
	}
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		let itemController = viewController as! ItemViewController
		if itemController.itemIndex+1 < slides.count {
		//if itemController.itemIndex+1 < images.count {
			return getItemController(itemController.itemIndex+1)
		}
		return nil

//		let currentIndex = images.index(of: viewController)!
//		let nextIndex = abs((currentIndex + 1) % images.count)
//		return images[nextIndex]
	}
	
	func presentationCount(for pageViewController: UIPageViewController) -> Int {
		return slides.count
		//return images.count
	}
	
	func presentationIndex(for pageViewController: UIPageViewController) -> Int {
		return 0
	}
	
	func currentControllerIndex() -> UIViewController? {
		if (self.pageViewController?.viewControllers?.count)! > 0 {
			return self.pageViewController?.viewControllers![0]
		}
		return nil
	}
	
	func getItemController(_ itemIndex: Int) -> ItemViewController? {
		if itemIndex < slides.count {
		//if itemIndex < images.count {
			let pageItemController = self.storyboard?.instantiateViewController(withIdentifier: "ItemController") as! ItemViewController
			//pageItemController.itemIndex = itemIndex
			pageItemController.imageName = slides[itemIndex].image
			//pageItemController.imageName = images[itemIndex]
			return pageItemController
		}
		return nil
	}
*/
}
/*
extension UIPageViewController {
	func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
		if let currentViewController = viewControllers?[0] {
			if let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentViewController) {
				setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
			}
		}
	}
}
*/
