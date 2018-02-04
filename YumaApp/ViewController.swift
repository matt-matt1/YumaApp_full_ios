//
//  ViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-01-29.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

	let dummy_string = NSLocalizedString("str_key", comment: "str_value")
	let welcomeMessage = NSLocalizedString("welcome.message", comment: "")
	let welcomeName = String(format: NSLocalizedString("welcome.withName", comment: ""), locale: NSLocale.current, "Alice")
	let progress = String(format: NSLocalizedString("copy.progress", comment: ""), locale: NSLocale.current, 4, 23)
	
	let YumaRed = UIColor(red: 0.66666666669999997, green: 0.0, blue: 0.094117647060000004, alpha: 1)
	let YumaYel = UIColor(red: 0.99942404029999998, green: 0.98555368190000003, blue: 0.0, alpha: 1)

	@IBOutlet weak var pageControl: UIPageControl!
	@IBOutlet weak var SVView: UIView!
	@IBOutlet weak var SVSlider: UIScrollView!
	@IBOutlet weak var LoginBtn: UIView!
	@IBOutlet weak var CartBtn: UIView!
	@IBOutlet weak var ENBtn: UIView!
	@IBOutlet weak var AboutBtn: UIView!
	@IBOutlet weak var QCBtn: UIView!
	@IBOutlet weak var ContactBtn: UIView!
	@IBOutlet weak var PrintersBtn: UIView!
	@IBOutlet weak var LaptopsBtn: UIView!
	@IBOutlet weak var ServicesBtn: UIView!
	@IBOutlet weak var TonersBtn: UIView!
	
	var slides: [Slide] = []
	var current: Int = 0

	
	override func viewDidLoad() {
		super.viewDidLoad()
		makeSlides()
		//setupPageControl()
/*
		createPageViewController();
*/
		addGesturesToBtns()
	}
	
	func makeSlides() {
		SVSlider.delegate = self			//the delegate function will be in this class
		SVSlider.frame = view.frame			//scrollView frame is the same size as the entire view
		SVSlider.isPagingEnabled = true		//enable scrolling by page (slide)
		SVSlider.showsHorizontalScrollIndicator = false
		let slide1 = Slide(id: 1, image: "home-slider-printers", 	caption1: "Laser Printers", 	caption2: "", 		target: "gotoPrinters:", 	width: 1110, 	height: 638)
		let slide2 = Slide(id: 2, image: "home-slider-cartridges", 	caption1: "Toner Cartridges", 	caption2: "that last", target: "gotoToners:", 	width: 1110, 	height: 638)
		let slide3 = Slide(id: 3, image: "home-slider-laptops", 	caption1: "Laptop Computers", 	caption2: "", 		target: "gotoLaptops:", 	width: 1110, 	height: 638)
		slides.append(slide1)
		slides.append(slide2)
		slides.append(slide3)
		SVSlider.translatesAutoresizingMaskIntoConstraints = false
		for (index, slide) in slides.enumerated() {
		//(slides as NSArray).enumerateObjects { (slide, index) -> Void in
			let imageView = UIImageView()
			imageView.image = UIImage(named: slide.image)		//set the imageView with the imageName in this slide
			imageView.contentMode = .scaleAspectFit
			let xPos = self.view.frame.width * CGFloat(index)	//calculate x depending upon slide index
			imageView.frame = CGRect(x: xPos, y: -250, width: self.SVSlider.frame.width, height: self.SVSlider.frame.height)						//set the frame as 250 pixels less??????
			SVSlider.contentSize.width = SVSlider.frame.width * CGFloat(index + 1)	//add slide image to scrollview
			SVSlider.addSubview(imageView)

			//add tap function to slide
			//let selName = NSClassFromString(slide.target)
			imageView.tag = index
			let tapImage = UITapGestureRecognizer(target: self, action: #selector(slideAction(_:)))
			imageView.addGestureRecognizer(tapImage)
			//imageView.tag = self.start selName
			imageView.isUserInteractionEnabled = true
		}
		Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
		let swipeLeft = UISwipeGestureRecognizer()
		swipeLeft.addTarget(self, action: #selector(moveToNextPage))
		swipeLeft.direction = .left
		SVSlider.addGestureRecognizer(swipeLeft)
		let swipeRight = UISwipeGestureRecognizer()
		swipeRight.addTarget(self, action: #selector(moveToPrevPage))
		swipeRight.direction = .right
		SVSlider.addGestureRecognizer(swipeRight)
	}
	
	@objc func slideAction(_ sender: UITapGestureRecognizer) {
		//let selName = NSClassFromString(slides[(sender.view?.tag)!].target)
		let selName = slides[(sender.view?.tag)!].target
		//let dest = slides[current].target
		NSObject.perform(Selector(selName))
	}
	
	@objc func moveToNextPage() {
		current += 1
		if current == slides.count {
			current = 0
		}
		let ScrollToX: CGFloat = CGFloat(current * Int(SVSlider.frame.width))
		self.SVSlider.setContentOffset(CGPoint(x: ScrollToX, y: self.SVSlider.frame.origin.y), animated: true)
		putCaptions()
		pageControl.currentPage = current
	}
	
	@objc func moveToPrevPage() {
		current -= 1
		if current == slides.count {
			current = 0
		}
		let ScrollToX: CGFloat = CGFloat(current * Int(SVSlider.frame.width))
		self.SVSlider.setContentOffset(CGPoint(x: ScrollToX, y: self.SVSlider.frame.origin.y), animated: true)
		putCaptions()
		pageControl.currentPage = current
	}
	
	func putCaptions() {
		let caption1 = UILabel()
		caption1.text = "hello"//slides[current].caption1
		caption1.frame = CGRect(x: 10, y: -200, width: caption1.frame.width, height: caption1.frame.height)
		SVView.addSubview(caption1)
	}
	
	func setupPageControl() {
		let appearance = UIPageControl.appearance()
		appearance.pageIndicatorTintColor = YumaYel
		appearance.currentPageIndicatorTintColor = YumaRed
		//appearance.backgroundColor = UIColor.darkGray
		//pageControl.bottomAnchor.constraint(equalTo: SVSlider.bottomAnchor).isActive = true
		pageControl.bottomAnchor.constraint(equalTo: SVSlider.topAnchor).isActive = true
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// function which is triggered when handleTap is called
	//@objc func handleTap(_ sender: UITapGestureRecognizer) {
	//	print("Hello World")
	//	PrintersBtn.backgroundColor = UIColor.green
	//}

	func addGesturesToBtns() {
		let tapPrinters = UITapGestureRecognizer(target: self, action: #selector(gotoPrinters(_:)))
		PrintersBtn.addGestureRecognizer(tapPrinters)
		PrintersBtn.isUserInteractionEnabled = true
		let tapLaptops = UITapGestureRecognizer(target: self, action: #selector(gotoLaptops(_:)))
		LaptopsBtn.addGestureRecognizer(tapLaptops)
		LaptopsBtn.isUserInteractionEnabled = true
		let tapServices = UITapGestureRecognizer(target: self, action: #selector(gotoServices(_:)))
		ServicesBtn.addGestureRecognizer(tapServices)
		ServicesBtn.isUserInteractionEnabled = true
		let tapToners = UITapGestureRecognizer(target: self, action: #selector(gotoToners(_:)))
		TonersBtn.addGestureRecognizer(tapToners)
		TonersBtn.isUserInteractionEnabled = true
		let tapEN = UITapGestureRecognizer(target: self, action: #selector(gotoEN(_:)))
		ENBtn.addGestureRecognizer(tapEN)
		ENBtn.isUserInteractionEnabled = true
		let tapAbout = UITapGestureRecognizer(target: self, action: #selector(gotoAbout(_:)))
		AboutBtn.addGestureRecognizer(tapAbout)
		AboutBtn.isUserInteractionEnabled = true
		let tapQC = UITapGestureRecognizer(target: self, action: #selector(gotoQC(_:)))
		QCBtn.addGestureRecognizer(tapQC)
		QCBtn.isUserInteractionEnabled = true
		let tapContact = UITapGestureRecognizer(target: self, action: #selector(gotoContact(_:)))
		ContactBtn.addGestureRecognizer(tapContact)
		ContactBtn.isUserInteractionEnabled = true
		let tapLogin = UITapGestureRecognizer(target: self, action: #selector(gotoLogin(_:)))
		LoginBtn.addGestureRecognizer(tapLogin)
		LoginBtn.isUserInteractionEnabled = true
		let tapCart = UITapGestureRecognizer(target: self, action: #selector(gotoCart(_:)))
		CartBtn.addGestureRecognizer(tapCart)
		CartBtn.isUserInteractionEnabled = true
		//SVSlider.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(slides[current].target)))
		//for index in 0..<slides.count {
		//	SVSlider[index]
		//}
	}
	
	@objc func gotoPrinters(_ sender: UITapGestureRecognizer) {
		guard sender.view != nil else { return }
		if sender.state == .ended {      // Move the view down and to the right when tapped.
		//	let animator = UIViewPropertyAnimator(duration: 0.2, curve: .easeInOut, animations: {
		//		sender.view!.center.x += 100
		//		sender.view!.center.y += 100
		//	})
		//	animator.startAnimation()
		}
		sender.view?.backgroundColor = YumaRed
		UIView.animate(withDuration: 1, animations: {
			sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		})
		print("gotoPrinters")
	}
	@objc func gotoLaptops(_ sender: UITapGestureRecognizer) {
		sender.view?.backgroundColor = YumaRed
		UIView.animate(withDuration: 1, animations: {
			sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		})
		let alertController = UIAlertController(title: nil, message: "You tapped at \(sender.location(in: self.view))", preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { _ in }))
		self.present(alertController, animated: true, completion: nil)
		print ("gotoLaptops")
	}
	@objc func gotoServices(_ sender: UITapGestureRecognizer) {
		sender.view?.backgroundColor = YumaRed
		UIView.animate(withDuration: 1, animations: {
			sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
			})
		print ("gotoServices")
	}
	@objc func gotoToners(_ sender: UITapGestureRecognizer) {
		sender.view?.backgroundColor = YumaRed
		UIView.animate(withDuration: 1, animations: {
			sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		})
		print ("gotoToners")
	}
	@objc func gotoEN(_ sender: UITapGestureRecognizer) {
		sender.view?.backgroundColor = YumaRed
		UIView.animate(withDuration: 1, animations: {
			sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		})
		print ("gotoEN")
	}
	@objc func gotoAbout(_ sender: UITapGestureRecognizer) {
		sender.view?.backgroundColor = YumaRed
		UIView.animate(withDuration: 1, animations: {
			sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		})
		print ("gotoAbout")
	}
	@objc func gotoQC(_ sender: UITapGestureRecognizer) {
		sender.view?.backgroundColor = YumaRed
		UIView.animate(withDuration: 1, animations: {
			sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		})
		print ("gotoQC")
	}
	@objc func gotoContact(_ sender: UITapGestureRecognizer) {
		sender.view?.backgroundColor = YumaRed
		UIView.animate(withDuration: 1, animations: {
			sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		})
		print ("gotoContact")
	}
	@objc func gotoLogin(_ sender: UITapGestureRecognizer) {
		sender.view?.backgroundColor = YumaRed
		UIView.animate(withDuration: 1, animations: {
			sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		})
		print ("gotoLogin")
	}
	@objc func gotoCart(_ sender: UITapGestureRecognizer) {
		sender.view?.backgroundColor = YumaRed
		UIView.animate(withDuration: 1, animations: {
			sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		})
		print ("gotoCart")
	}
}

