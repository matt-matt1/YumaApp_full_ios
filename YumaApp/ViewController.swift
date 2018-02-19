//
//  ViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-01-29.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate
{
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


////////////////////////////////////////////////////// Overrides
	override func viewDidLoad()
	{
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
	
	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
	{
//		print("\(targetContentOffset.pointee.x) \(view.frame.width) \(Int(ceil(targetContentOffset.pointee.x / view.frame.width)))")
//		pageControl.currentPage = Int(ceil(targetContentOffset.pointee.x / view.frame.width))
		moveToNextPage()
	}
	
//	override func viewDidAppear()
//	{
//
//	}
	
	override func didReceiveMemoryWarning()
	{
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	
//////////////////////////////////////////////////////MARK: My Methods
	func makeSlides()
	{
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
		SVSlider.subviews.forEach({ 	$0.removeFromSuperview() 	})
		//SVSlider.subviews.map({ 	$0.removeFromSuperview() 	})
		//SVSlider.translatesAutoresizingMaskIntoConstraints = false
		for (index, slide) in slides.enumerated()
		{
		//(slides as NSArray).enumerateObjects { (slide, index) -> Void in
			let imageView = UIImageView()
			imageView.image = UIImage(named: slide.image)		//set the imageView with the imageName in this slide
			imageView.contentMode = .scaleAspectFit
			let xPos = self.view.frame.width * CGFloat(index)	//calculate x depending upon slide index
			imageView.frame = CGRect(x: xPos, y: -200, width: self.SVSlider.frame.width, height: self.SVSlider.frame.height)						//set the frame as 250 pixels less??????
			SVSlider.contentSize.width = SVSlider.frame.width * CGFloat(index + 1)	//add slide image to scrollview
			SVSlider.contentMode = UIViewContentMode.scaleAspectFit
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
	
	func putCaptions()
	{
		let caption1 = UILabel()
		caption1.text = "hello"//slides[current].caption1
		caption1.frame = CGRect(x: 10, y: -200, width: caption1.frame.width, height: caption1.frame.height)
		SVView.addSubview(caption1)
	}
	
	func setupPageControl()
	{
		let appearance = UIPageControl.appearance()
		appearance.pageIndicatorTintColor = R.color.YumaYel
		appearance.currentPageIndicatorTintColor = R.color.YumaRed
		//appearance.backgroundColor = UIColor.darkGray
		//pageControl.bottomAnchor.constraint(equalTo: SVSlider.bottomAnchor).isActive = true
		pageControl.bottomAnchor.constraint(equalTo: SVSlider.topAnchor).isActive = true
	}

	func addGesturesToBtns()
	{
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
		//for index in 0..<slides.count
		//{
		//	SVSlider[index]
		//}
	}
	
//////////////////////////////////////////////////////objc Methods
	@objc func slideAction(_ sender: UITapGestureRecognizer)
	{
		//let selName = NSClassFromString(slides[(sender.view?.tag)!].target)
		//let selName = slides[(sender.view?.tag)!].target
//		let selName = slides[(sender.view?.tag)!]
		//let dest = slides[current].target
		//NSObject.perform(Selector(selName))
		//selName.callMethodDirectly()
	}
	
	@objc func moveToNextPage()
	{
		current += 1
		if current == slides.count
		{
			current = 0
		}
		let ScrollToX: CGFloat = CGFloat(current * Int(SVSlider.frame.width))
		self.SVSlider.setContentOffset(CGPoint(x: ScrollToX, y: self.SVSlider.frame.origin.y), animated: true)
		putCaptions()
		pageControl.currentPage = current
	}
	@objc func moveToPrevPage()
	{
		current -= 1
		if current == slides.count
		{
			current = 0
		}
		let ScrollToX: CGFloat = CGFloat(current * Int(SVSlider.frame.width))
		self.SVSlider.setContentOffset(CGPoint(x: ScrollToX, y: self.SVSlider.frame.origin.y), animated: true)
		putCaptions()
		pageControl.currentPage = current
	}

	// function which is triggered when handleTap is called
	//@objc func handleTap(_ sender: UITapGestureRecognizer)
	//{
	//	print("Hello World")
	//	PrintersBtn.backgroundColor = UIColor.green
	//}

	@objc func gotoLogin(_ sender: UITapGestureRecognizer)
	{
		sender.view?.backgroundColor = R.color.YumaRed
		UIView.animate(withDuration: 1, animations:
			{
				sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		})
		self.present(LoginViewController(), animated: false, completion: (() -> Void)?
			{
				sender.view?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
				sender.view?.backgroundColor = UIColor.white
			})
	}
	@objc func gotoCart(_ sender: UITapGestureRecognizer)
	{
		sender.view?.backgroundColor = R.color.YumaRed
		UIView.animate(withDuration: 1, animations:
			{
				sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
			})
		self.present(MyAccountViewController(), animated: false, completion: (() -> Void)?
			{
				sender.view?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
				sender.view?.backgroundColor = UIColor.white
			})
	}
	@objc func gotoEN(_ sender: UITapGestureRecognizer)
	{
		sender.view?.backgroundColor = R.color.YumaRed
		UIView.animate(withDuration: 1, animations:
			{
				sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		})
		let webPage = WebpageViewController()
		//webPage.setTitle(string: R.string.en)
		webPage.pageTitle = R.string.en
		//webPage.loadWebpage(URLstring: R.string.enweb)
		webPage.pageURL = R.string.enweb
		self.present(webPage, animated: true, completion: (() -> Void)?
			{
				sender.view?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
				sender.view?.backgroundColor = UIColor.white
			})
	}
	@objc func gotoAbout(_ sender: UITapGestureRecognizer)
	{
		sender.view?.backgroundColor = R.color.YumaRed
		UIView.animate(withDuration: 1, animations:
			{
				sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		})
		let webPage = WebpageViewController()
		webPage.pageTitle = R.string.about
		webPage.pageURL = R.string.aboutweb
		self.present(webPage, animated: true, completion: (() -> Void)?
			{
				sender.view?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
				sender.view?.backgroundColor = UIColor.white
			})
	}
	@objc func gotoQC(_ sender: UITapGestureRecognizer)
	{
		sender.view?.backgroundColor = R.color.YumaRed
		UIView.animate(withDuration: 1, animations:
			{
				sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		})
		let webPage = WebpageViewController()
		webPage.pageTitle = R.string.qc
		webPage.pageURL = R.string.qcweb
		self.present(webPage, animated: true, completion: (() -> Void)?
			{
				sender.view?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
				sender.view?.backgroundColor = UIColor.white
			})
	}
	@objc func gotoContact(_ sender: UITapGestureRecognizer)
	{
		sender.view?.backgroundColor = R.color.YumaRed
		UIView.animate(withDuration: 1, animations:
			{
				sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		})
		let mySegue: ContactUsViewController = ContactUsViewController()
		self.present(mySegue, animated: false, completion: (() -> Void)?
			{
				sender.view?.backgroundColor = UIColor.white
				sender.view?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
			})
	}
	@objc func gotoPrinters(_ sender: UITapGestureRecognizer)
	{
		guard sender.view != nil else { return }
		if sender.state == .ended {      // Move the view down and to the right when tapped.
		//	let animator = UIViewPropertyAnimator(duration: 0.2, curve: .easeInOut, animations: {
		//		sender.view!.center.x += 100
		//		sender.view!.center.y += 100
		//	})
		//	animator.startAnimation()
			sender.view?.backgroundColor = R.color.YumaRed
			UIView.animate(withDuration: 1, animations:
			{
				sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
			})
//			self.present(collection, animated: false, completion: (() -> Void)?
//			{
//				sender.view?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//				sender.view?.backgroundColor = UIColor.white
//			})
			self.present(PrintersViewController(), animated: false, completion: (() -> Void)?
				{
					sender.view?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
					sender.view?.backgroundColor = UIColor.white
				})
		}
	}
	@objc func gotoLaptops(_ sender: UITapGestureRecognizer)
	{
		sender.view?.backgroundColor = R.color.YumaRed
		UIView.animate(withDuration: 1, animations:
		{
			sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		})
		//let alertController = UIAlertController(title: nil, message: "You tapped at \(sender.location(in: self.view))", preferredStyle: .alert)
		//alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { _ in }))
		//self.present(alertController, animated: true, completion: nil)
		//let story = UIStoryboard(name: "Laptops", bundle: nil)
//		let vc:UIViewController = (R.story.laps).instantiateViewController(withIdentifier: "LaptopsVC")
		//story.instantiateInitialViewController() as! UIViewController
		//let vc = story.instantiateViewController(withIdentifier: "LaptopsVC") as UIViewController
//		present(vc, animated: true, completion: nil)
		self.present(LaptopsViewController(), animated: false, completion: (() -> Void)?
		{
			sender.view?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
			sender.view?.backgroundColor = UIColor.white
		})
//		self.present(vc, animated: true, completion: (() -> Void)? {
//			sender.view?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//			sender.view?.backgroundColor = UIColor.white
//			})
	}
	@objc func gotoServices(_ sender: UITapGestureRecognizer)
	{
		sender.view?.backgroundColor = R.color.YumaRed
		UIView.animate(withDuration: 1, animations:
		{
			sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		})
		print ("gotoServices")
	}
	@objc func gotoToners(_ sender: UITapGestureRecognizer)
	{
		sender.view?.backgroundColor = R.color.YumaRed
		UIView.animate(withDuration: 1, animations:
		{
			sender.view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		})
		print ("gotoToners")
	}
	
//	func switchToViewController(identifier: String, useModal: Bool) {
//		let viewController = self.storyboard?.instantiateViewController(withIdentifier: identifier) as UIViewController!
//		if useModal == true {
//			self.showDetailViewController(viewController!, sender: self)
//		}
//		else {
//			self.navigationController?.setViewControllers([viewController!], animated: false)
//		}
//	}
	
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


//////////////////////////////////////////////////////MARK: My Extentions

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


//typealias GradientPoints = (startPoint: CGPoint, endPoint: CGPoint)
//
//enum GradientOrientation
//{
//	case topRightBottomLeft
//	case topLeftBottomRight
//	case horizontal
//	case vertical
//
//	var startPoint: CGPoint
//	{
//		return points.startPoint
//	}
//
//	var endPoint: CGPoint
//	{
//		return points.endPoint
//	}
//
//	var points: GradientPoints
//	{
//		switch self
//		{
//		case .topRightBottomLeft:
//			return (CGPoint.init(x: 0.0, y: 1.0), CGPoint.init(x: 1.0, y: 0.0))
//		case .topLeftBottomRight:
//			return (CGPoint.init(x: 0.0, y: 0.0), CGPoint.init(x: 1, y: 1))
//		case .horizontal:
//			return (CGPoint.init(x: 0.0, y: 0.5), CGPoint.init(x: 1.0, y: 0.5))
//		case .vertical:
//			return (CGPoint.init(x: 0.0, y: 0.0), CGPoint.init(x: 0.0, y: 1.0))
//		}
//	}
//}
//
//extension UIView {
//
//	func applyGradient(withColours colours: [UIColor], locations: [NSNumber]? = nil)
//	{
//		let gradient: CAGradientLayer = CAGradientLayer()
//		gradient.frame = self.bounds
//		gradient.colors = colours.map { 	$0.cgColor 	}
//		gradient.locations = locations
//
//		let shape = CAShapeLayer()
//		shape.lineWidth = 2
//		shape.path = UIBezierPath(rect: self.bounds).cgPath
//		shape.strokeColor = UIColor.black.cgColor
//		shape.fillColor = UIColor.clear.cgColor
//		gradient.mask = shape
//
//		self.layer.insertSublayer(gradient, at: 0)
////		self.layer.borderWidth = 2
////		self.layer.borderColor = R.color.YumaDRed.cgColor
////		self.layer.cornerRadius = 3
//	}
//
//	func applyGradient(withColours colours: [UIColor], gradientOrientation orientation: GradientOrientation)
//	{
//		let shape = CAShapeLayer()
//		shape.lineWidth = 2
//		shape.path = UIBezierPath(rect: self.bounds).cgPath
//		shape.strokeColor = UIColor.black.cgColor
//		shape.fillColor = UIColor.clear.cgColor
//		self.layer.cornerRadius = 3
//		self.layer.insertSublayer(shape, at: 0)
//
////		let gradient: CAGradientLayer = CAGradientLayer()
////		gradient.frame = self.bounds
////		gradient.colors = colours.map { 	$0.cgColor 	}
////		gradient.startPoint = orientation.startPoint
////		gradient.endPoint = orientation.endPoint
////		self.layer.insertSublayer(gradient, at: 0)
//
////		let gradient2: CAGradientLayer = CAGradientLayer()
////		gradient2.frame = self.bounds
////		gradient2.colors = colours.map { 	$0.cgColor 	}
////		gradient2.startPoint = orientation.endPoint
////		gradient2.endPoint = orientation.startPoint
////		let shape2 = CAShapeLayer()
////		shape2.lineWidth = 2
////		shape2.path = UIBezierPath(rect: self.bounds).cgPath
////		shape2.strokeColor = UIColor.black.cgColor
////		shape2.fillColor = UIColor.clear.cgColor
////		gradient2.mask = shape2
////		self.layer.insertSublayer(gradient2, at: 0)
//	}
//}


//@IBDesignable
//class GradientButton: UIButton
//{
//	let gradientLayer = CAGradientLayer()
//	
//	@IBInspectable
//	var topGradientColor: UIColor?
//	{
//		didSet
//		{
//			setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)
//		}
//	}
//	
//	@IBInspectable
//	var bottomGradientColor: UIColor?
//	{
//		didSet
//		{
//			setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)
//		}
//	}
//	
//	private func setGradient(topGradientColor: UIColor?, bottomGradientColor: UIColor?)
//	{
//		if let topGradientColor = topGradientColor, let bottomGradientColor = bottomGradientColor
//		{
//			gradientLayer.frame = bounds
//			gradientLayer.colors = [topGradientColor.cgColor, bottomGradientColor.cgColor]
//			gradientLayer.borderColor = layer.borderColor
//			gradientLayer.borderWidth = layer.borderWidth
//			gradientLayer.cornerRadius = layer.cornerRadius
//			layer.insertSublayer(gradientLayer, at: 0)
//		}
//		else
//		{
//			gradientLayer.removeFromSuperlayer()
//		}
//	}

	
//	let gradientBorderLayer = CAGradientLayer()
//
//	@IBInspectable
//	var topGradientBorderColor: UIColor?
//	{
//		didSet
//		{
//			addGradienBorder(topGradientBorderColor: topGradientBorderColor, bottomGradientBorderColor: bottomGradientBorderColor, width: gradientBorderWidth)
//		}
//	}
//	
//	@IBInspectable
//	var bottomGradientBorderColor: UIColor?
//	{
//		didSet
//		{
//			addGradienBorder(topGradientBorderColor: topGradientBorderColor, bottomGradientBorderColor: bottomGradientBorderColor, width: gradientBorderWidth)
//		}
//	}
//	
//	@IBInspectable
//	var gradientBorderWidth: CGFloat
//	{
//		didSet
//		{
//			addGradienBorder(topGradientBorderColor: topGradientBorderColor, bottomGradientBorderColor: bottomGradientBorderColor, width: gradientBorderWidth)
//		}
//	}
//
//	
//	func addGradienBorder(topGradientBorderColor: UIColor?, bottomGradientBorderColor: UIColor?, width: CGFloat)
//	{
//		if let topGradientBorderColor = topGradientBorderColor, let bottomGradientBorderColor = bottomGradientBorderColor
//		{
//			gradientBorderLayer.frame = CGRect(origin: .zero, size: self.bounds.size)
//			gradientBorderLayer.startPoint = CGPoint(x:0.0, y:0.5)
//			gradientBorderLayer.endPoint = CGPoint(x:1.0, y:0.5)
//			gradientBorderLayer.colors = [topGradientBorderColor.cgColor, bottomGradientBorderColor.cgColor]
//			
//			let shapeLayer = CAShapeLayer()
//			shapeLayer.lineWidth = width
//			shapeLayer.path = UIBezierPath(rect: self.bounds).cgPath
//			shapeLayer.fillColor = nil
//			shapeLayer.strokeColor = UIColor.black.cgColor
//			gradientBorderLayer.mask = shapeLayer
//			
//			layer.addSublayer(gradientLayer)
//		}
//	}
//}


extension UIView
{
	@IBInspectable
	var borderWidth: CGFloat
	{
		get
		{
			return layer.borderWidth
		}
		set
		{
			layer.borderWidth = newValue
		}
	}
	
	@IBInspectable
	var borderColor: UIColor?
	{
		get
		{
			if let color = layer.borderColor
			{
				return UIColor(cgColor: color)
			}
			return nil
		}
		set
		{
			if let color = newValue
			{
				layer.borderColor = color.cgColor
			}
			else
			{
				layer.borderColor = nil
			}
		}
	}
	
	@IBInspectable
	var cornerRadius: CGFloat
	{
		get
		{
			return layer.cornerRadius
		}
		set
		{
			layer.cornerRadius = newValue
		}
	}
	
	@IBInspectable
	var shadowRadius: CGFloat
	{
		get
		{
			return layer.shadowRadius
		}
		set
		{
			layer.shadowRadius = newValue
		}
	}
	
	@IBInspectable
	var shadowOpacity: Float
	{
		get
		{
			return layer.shadowOpacity
		}
		set
		{
			layer.shadowOpacity = newValue
		}
	}
	
	@IBInspectable
	var shadowOffset: CGSize
	{
		get
		{
			return layer.shadowOffset
		}
		set
		{
			layer.shadowOffset = newValue
		}
	}
	
	@IBInspectable
	var shadowColor: UIColor?
	{
		get
		{
			if let color = layer.shadowColor
			{
				return UIColor(cgColor: color)
			}
			return nil
		}
		set {
			if let color = newValue
			{
				layer.shadowColor = color.cgColor
			}
			else
			{
				layer.shadowColor = nil
			}
		}
	}
}


extension CALayer
{
	func addBackgroundGradient(colors: [UIColor] = [UIColor.red,UIColor.blue], isVertical: Bool)
	{
		let gradientLayer = CAGradientLayer()
		gradientLayer.frame = CGRect(origin: .zero, size: self.bounds.size)
		if isVertical
		{
			gradientLayer.startPoint = CGPoint(x:0.0, y:0.0)
			gradientLayer.endPoint = CGPoint(x:0.0, y:1.0)
		}
		else
		{
			gradientLayer.startPoint = CGPoint(x:0.0, y:0.5)
			gradientLayer.endPoint = CGPoint(x:1.0, y:0.5)
		}
		if self.cornerRadius > 0
		{
			gradientLayer.cornerRadius = self.cornerRadius
		}
		gradientLayer.colors = colors.map({$0.cgColor})

		self.addSublayer(gradientLayer)
	}

	func addGradienBorder(colors: [UIColor] = [UIColor.red,UIColor.blue], width: CGFloat = 1, isVertical: Bool)
	{
		let gradientLayer = CAGradientLayer()
		gradientLayer.frame =  CGRect(origin: .zero, size: self.bounds.size)
		if isVertical
		{
			gradientLayer.startPoint = CGPoint(x:0.0, y:0.0)
			gradientLayer.endPoint = CGPoint(x:0.0, y:1.0)
		}
		else
		{
			gradientLayer.startPoint = CGPoint(x:0.0, y:0.5)
			gradientLayer.endPoint = CGPoint(x:1.0, y:0.5)
		}
		if self.cornerRadius > 0
		{
			gradientLayer.cornerRadius = self.cornerRadius
		}
		gradientLayer.colors = colors.map({$0.cgColor})
		
		let shapeLayer = CAShapeLayer()
		shapeLayer.lineWidth = width
		shapeLayer.path = UIBezierPath(rect: self.bounds).cgPath
		shapeLayer.fillColor = nil
		shapeLayer.strokeColor = UIColor.black.cgColor
		gradientLayer.mask = shapeLayer
		
		self.addSublayer(gradientLayer)
	}
}


extension UINavigationBar
{
	func applyNavigationGradient(colors: [UIColor], isVertical: Bool = false)
	{
		var frameAndStatusBar: CGRect = self.bounds
		frameAndStatusBar.size.height += 20 // add 20 to account for the status bar
		
		if (isVertical)
		{
			setBackgroundImage(UINavigationBar.gradientV(size: frameAndStatusBar.size, colors: colors), for: .default)
		}
		else
		{
			setBackgroundImage(UINavigationBar.gradientH(size: frameAndStatusBar.size, colors: colors), for: .default)
		}
	}
	
	static func gradientH(size : CGSize, colors : [UIColor]) -> UIImage?
	{
		let cgcolors = colors.map { 	$0.cgColor 	}
		UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
		guard let context = UIGraphicsGetCurrentContext() else { 	return nil 	}
		defer { 	UIGraphicsEndImageContext() 	}
		var locations: [CGFloat] = [0.0, 1.0]
		guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: cgcolors as NSArray as CFArray, locations: &locations) else { 	return nil 	}
		context.drawLinearGradient(gradient, start: CGPoint(x: 0.0, y: 0.0), end: CGPoint(x: size.width, y: 0.0), options: [])
		return UIGraphicsGetImageFromCurrentImageContext()
	}

	static func gradientV(size : CGSize, colors : [UIColor]) -> UIImage?
	{
		let cgcolors = colors.map { 	$0.cgColor 	}
		UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
		guard let context = UIGraphicsGetCurrentContext() else { 	return nil 	}
		defer { 	UIGraphicsEndImageContext() 	}
		var locations: [CGFloat] = [0.0, 1.0]
		guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: cgcolors as NSArray as CFArray, locations: &locations) else { 	return nil 	}
		context.drawLinearGradient(gradient, start: CGPoint(x: 0.0, y: 0.0), end: CGPoint(x: 0.0, y: size.height), options: [])
		return UIGraphicsGetImageFromCurrentImageContext()
	}
}
