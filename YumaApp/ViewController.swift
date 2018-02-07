//
//  ViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-01-29.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

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
//		let params: Dictionary<String, String> = ["username":"me",
//												  "password":"secret"]
//		let headers: Dictionary<String, String> = ["Content-Type":"application/json",
//												   "Accept":"application/json",
//												   /*"ws_key":"\(R.string.APIkey)"*/]
//		printHTTPdata(url: "\(R.string.WSbase)countries?\(R.string.APIjson)&\(R.string.APIfull)&ws_key=\(R.string.APIkey)", params: params, headers: headers, cache: URLRequest.CachePolicy.reloadIgnoringCacheData)
	}
	
	//override func viewDidAppear() {
		//
	//}
	
	func makeSlides() {
		SVSlider.delegate = self			//the delegate function will be in this class
		SVSlider.frame = view.frame			//scrollView frame is the same size as the entire view
		//SVSlider.isPagingEnabled = true		//enable scrolling by page (slide)
		SVSlider.showsHorizontalScrollIndicator = false
		let slide1 = Slide(id: 1, image: "home-slider-printers", 	caption1: "Laser Printers", 	caption2: "", 		target: "gotoPrinters:", 	width: 1110, 	height: 638/*, 	callMethodDirectly: {gotoPrinters(UITapGestureRecognizer(target: Any?, action: Selector?))}*/)
		let slide2 = Slide(id: 2, image: "home-slider-cartridges", 	caption1: "Toner Cartridges", 	caption2: "that last", target: "gotoToners:", 	width: 1110, 	height: 638/*, 	callMethodDirectly: {}*/)
		let slide3 = Slide(id: 3, image: "home-slider-laptops", 	caption1: "Laptop Computers", 	caption2: "", 		target: "gotoLaptops:", 	width: 1110, 	height: 638/*, 	callMethodDirectly: {}*/)
		slides.append(slide1)
		slides.append(slide2)
		slides.append(slide3)
		SVSlider.subviews.forEach({ $0.removeFromSuperview() })
		//SVSlider.subviews.map({ $0.removeFromSuperview() })
		//SVSlider.translatesAutoresizingMaskIntoConstraints = false
		for (index, slide) in slides.enumerated() {
		//(slides as NSArray).enumerateObjects { (slide, index) -> Void in
			let imageView = UIImageView()
			imageView.image = UIImage(named: slide.image)		//set the imageView with the imageName in this slide
			imageView.contentMode = .scaleAspectFit
			let xPos = self.view.frame.width * CGFloat(index)	//calculate x depending upon slide index
			imageView.frame = CGRect(x: xPos, y: -200, width: self.SVSlider.frame.width, height: self.SVSlider.frame.height)						//set the frame as 250 pixels less??????
			SVSlider.contentSize.width = SVSlider.frame.width * CGFloat(index + 1)	//add slide image to scrollview
			SVSlider.addSubview(imageView)

			//add tap function to slide
			//let selName = NSClassFromString(slide.target)
			imageView.isUserInteractionEnabled = true
			imageView.tag = index
			let tapImage = UITapGestureRecognizer(target: self, action: #selector(slideAction(_:)))
			imageView.addGestureRecognizer(tapImage)
			//imageView.tag = self.start selName
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
		//let selName = slides[(sender.view?.tag)!].target
//		let selName = slides[(sender.view?.tag)!]
		//let dest = slides[current].target
		//NSObject.perform(Selector(selName))
		//selName.callMethodDirectly()
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
		appearance.pageIndicatorTintColor = R.color.YumaYel
		appearance.currentPageIndicatorTintColor = R.color.YumaRed
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
			sender.view?.backgroundColor = R.color.YumaRed
			UIView.animate(withDuration: 1, animations: {
				sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
			})
			self.present(PrintersViewController(), animated: false, completion: (() -> Void)? {
				sender.view?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
				sender.view?.backgroundColor = UIColor.white
				})
		}
	}
	@objc func gotoLaptops(_ sender: UITapGestureRecognizer) {
		sender.view?.backgroundColor = R.color.YumaRed
		UIView.animate(withDuration: 1, animations: {
			sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		})
		//let alertController = UIAlertController(title: nil, message: "You tapped at \(sender.location(in: self.view))", preferredStyle: .alert)
		//alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { _ in }))
		//self.present(alertController, animated: true, completion: nil)
		//let story = UIStoryboard(name: "Laptops", bundle: nil)
		let vc:UIViewController = (R.story.laps).instantiateViewController(withIdentifier: "LaptopsVC")
		//story.instantiateInitialViewController() as! UIViewController
		//let vc = story.instantiateViewController(withIdentifier: "LaptopsVC") as UIViewController
		present(vc, animated: true, completion: nil)
//		self.present(LaptopsVC(), animated: false, completion: (() -> Void)? {
//			sender.view?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//			sender.view?.backgroundColor = UIColor.white
//			})
	}
	@objc func gotoServices(_ sender: UITapGestureRecognizer) {
		sender.view?.backgroundColor = R.color.YumaRed
		UIView.animate(withDuration: 1, animations: {
			sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
			})
		print ("gotoServices")
	}
	@objc func gotoToners(_ sender: UITapGestureRecognizer) {
		sender.view?.backgroundColor = R.color.YumaRed
		UIView.animate(withDuration: 1, animations: {
			sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		})
		print ("gotoToners")
	}
	@objc func gotoEN(_ sender: UITapGestureRecognizer) {
		sender.view?.backgroundColor = R.color.YumaRed
		UIView.animate(withDuration: 1, animations: {
			sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		})
		print ("gotoEN")
	}
	@objc func gotoAbout(_ sender: UITapGestureRecognizer) {
		sender.view?.backgroundColor = R.color.YumaRed
		UIView.animate(withDuration: 1, animations: {
			sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		})
		print ("gotoAbout")
	}
	@objc func gotoQC(_ sender: UITapGestureRecognizer) {
		sender.view?.backgroundColor = R.color.YumaRed
		UIView.animate(withDuration: 1, animations: {
			sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		})
		print ("gotoQC")
	}
	@objc func gotoContact(_ sender: UITapGestureRecognizer) {
		sender.view?.backgroundColor = R.color.YumaRed
		UIView.animate(withDuration: 1, animations: {
			sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		})
		let mySegue: ContactUsViewController = ContactUsViewController()
		self.present(mySegue, animated: false, completion: (() -> Void)? {
			sender.view?.backgroundColor = UIColor.white
			sender.view?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)})
	}
	@objc func gotoLogin(_ sender: UITapGestureRecognizer) {
		sender.view?.backgroundColor = R.color.YumaRed
		UIView.animate(withDuration: 1, animations: {
			sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		})
		self.present(LoginViewController(), animated: false, completion: (() -> Void)? {
			sender.view?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
			sender.view?.backgroundColor = UIColor.white
			})
	}
	@objc func gotoCart(_ sender: UITapGestureRecognizer) {
		sender.view?.backgroundColor = R.color.YumaRed
		UIView.animate(withDuration: 1, animations: {
			sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		})
		print ("gotoCart")
	}
	
	func switchToViewController(identifier: String, useModal: Bool) {
		let viewController = self.storyboard?.instantiateViewController(withIdentifier: identifier) as UIViewController!
		if useModal == true {
			self.showDetailViewController(viewController!, sender: self)
		}
		else {
			self.navigationController?.setViewControllers([viewController!], animated: false)
		}
	}
	
//	func printHTTPdata(url: String, params: Dictionary<String, String>, headers: Dictionary<String, String>, cache: URLRequest.CachePolicy) {
//		//let params: Dictionary<String, String> = [:]
//		var request = URLRequest(url: URL(string: url)!)
//		//request.httpMethod = "POST"
//		request.httpMethod = "GET"
//		request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
//		//request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
//		request.cachePolicy = cache
//		request.timeoutInterval = 20
//		//request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//		for (key, val) in headers {
//			request.addValue(val, forHTTPHeaderField: key)
//		}
//		let session = URLSession.shared
//		let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
//			print(response!)
//			guard let httpRes = response as? HTTPURLResponse, let receivedData = data
//				else {
//					print("error: not a valid http response")
//					return
//			}
//			switch(httpRes.statusCode)
//			{
//			case 200:
//
//				print("response is \(String(describing: response))")
//				do {
//					let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
//					print(json)
//				} catch {
//					print("error serializing JSON: \(error)")
//				}
//				break
//			case 400:
//				
//				break
//			default:
//				print("wallet GET request got response \(httpRes.statusCode)")
//			}
//		})
//		task.resume()
//	}
	
}


//extension NSObject {
//	func tryAddObserver(anObserver: NSObject!,
//						forKeyPath keyPath: String!,
//						options: NSKeyValueObservingOptions,
//						context: UnsafeMutableRawPointer) -> NSString! {}
//}


extension UIViewController
{
	class func displaySpinner(onView : UIView) -> UIView
	{
		let spinnerView = UIView.init(frame: onView.bounds)
		spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
		let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
		ai.startAnimating()
		ai.center = spinnerView.center
		
		DispatchQueue.main.async
		{
			spinnerView.addSubview(ai)
			onView.addSubview(spinnerView)
		}
		
		return spinnerView
	}
	
	class func removeSpinner(spinner :UIView)
	{
		DispatchQueue.main.async
		{
			spinner.removeFromSuperview()
		}
	}
}
