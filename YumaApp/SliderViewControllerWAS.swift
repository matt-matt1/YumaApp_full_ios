/*
import UIKit

class SliderViewController: UIViewController, UIScrollViewDelegate {

	var SVSlider: UIScrollView!
	var imageView: UIImageView!

	var pageControl: UIPageControl// = UIPageControl(frame: CGRectMake(50, 300, 200, 20))
	
	var slides: [Slide] = []
	let slide1 = Slide(id: 1, image: "home-slider-printers", 	caption1: "Laser Printers", 	caption2: "", 		target: "", 	width: 1110, 	height: 638)
	let slide2 = Slide(id: 2, image: "home-slider-cartridges", 	caption1: "Toner Cartridges", 	caption2: "that last", target: "", 	width: 1110, 	height: 638)
	let slide3 = Slide(id: 3, image: "home-slider-laptops", 	caption1: "Laptop Computers", 	caption2: "", 		target: "", 	width: 1110, 	height: 638)
	//	var images = ["home-slider-printers", "home-slider-cartridges", "home-slider-laptops"]
	var pageViewController: UIPageViewController?
	var currentIndex: Int = 0
	let interval = 3

	
	//MARK: Initialization
	override init {
		super.init(frame: frame)
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		configurePageControl()
		SVSlider.contentSize = imageView.bounds.size
		//SVSlider.autoresizingMask = UInt8(UIViewAutoresizing.FlexibleWidth.rawValue) | UInt8(UIViewAutoresizing.FlexibleHeight.rawValue)
		SVSlider.delegate = self 
		//scrollView.minimumZoomScale = 0.1
		//scrollView.maximumZoomScale = 4.0
		//scrollView.zoomScale = 1.0
		SVSlider.isPagingEnabled = true
		for index in 0..<slides.count {
			//frame.origin.x = self.SVSlider.frame.size.width * CGFloat(index)
			//frame.size = self.SVSlider.frame.size
			//let subView = UIView(frame: frame)
			//subView.backgroundColor = colors[index]
			//self.SVSlider.addSubview(subView)
		}
		self.SVSlider.contentSize = CGSize(width:self.SVSlider.frame.size.width * 4, height: self.SVSlider.frame.size.height)
		pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControlEvents.valueChanged)
		setupGestureRecognizer()
        }

	func configurePageControl() {
 		self.pageControl.numberOfPages = slides.count
		self.pageControl.translatesAutoresizingMaskIntoConstraints = false
		self.pageControl.currentPage = 0
		self.pageControl.tintColor = UIColor.red
		self.pageControl.pageIndicatorTintColor = UIColor.black
		self.pageControl.currentPageIndicatorTintColor = UIColor.green
		
		let leading = NSLayoutConstraint(item: pageControl, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
		let trailing = NSLayoutConstraint(item: pageControl, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
		let bottom = NSLayoutConstraint(item: pageControl, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)

		view.insertSubview(pageControl, at: 0)
		view.bringSubview(toFront: pageControl)
		view.addConstraints([leading, trailing, bottom])
		self.view.addSubview(pageControl)
	}

	@objc func changePage(sender: AnyObject) -> () {
		let x = CGFloat(pageControl.currentPage) * SVSlider.frame.size.width
		SVSlider.setContentOffset(CGPoint(x:x, y:0), animated: true)
	}

	func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
		let pageNumber = round(SVSlider.contentOffset.x / SVSlider.frame.size.width)
		pageControl.currentPage = Int(pageNumber)
	}

	//func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
	//	return imageView
	//}

	func setupGestureRecognizer() {
		let doubleTap = UITapGestureRecognizer(target: self, action: "handleDoubleTap:")
		doubleTap.numberOfTapsRequired = 2
		SVSlider.addGestureRecognizer(doubleTap)
	}

	func handleDoubleTap(recognizer: UITapGestureRecognizer) {
        
		if (SVSlider.zoomScale > SVSlider.minimumZoomScale) {
			SVSlider.setZoomScale(SVSlider.minimumZoomScale, animated: true)
		} else {
			SVSlider.setZoomScale(SVSlider.maximumZoomScale, animated: true)
		}
	}

}
*/
