//
//  ProductDetailsViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-07-27.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


class ProductDetailsViewController: UIViewController, UIScrollViewDelegate
{
	let stackAll: UIStackView =
	{
		let view = UIStackView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.axis = .vertical
		view.spacing = 1
		return view
	}()
	let viewOuter: UIView =
	{
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.lightGray
		return view
	}()
	let navigationBar = UINavigationBar()
	let navTitle: UINavigationItem =
	{
		let view = UINavigationItem()
		return view
	}()
	let statusAndNavigationBars: UIView =
	{
		let view = UIView()
		view.backgroundColor = UIColor.lightGray
		view.frame = UIApplication.shared.statusBarFrame
		return view
	}()
	let backButton: UIButton =
	{
		let view = UIButton()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.setImage(Awesome.solid.chevronLeft.asImage(size: 35, color: R.color.YumaYel, backgroundColor: UIColor.clear), for: UIControlState.normal)
		view.setTitleColor(UIColor.white, for: .normal)
		view.setAttributedTitle(NSAttributedString(string: R.string.prodnList, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 15), NSAttributedStringKey.foregroundColor : UIColor.white]), for: .normal)
		view.backgroundColor = UIColor.clear
		view.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
		return view
	}()
	let stackPanel: UIStackView =
	{
		let view = UIStackView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.lightGray
		return view
	}()
	let viewPanel: UIView =
	{
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.white
		view.shadowColor = UIColor.darkGray
		view.shadowOffset = .zero
		view.shadowRadius = 5
		view.shadowOpacity = 1
		return view
	}()
	let scrollView: UIScrollView =
	{
		let view = UIScrollView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.clear
		return view
	}()
	var stack: UIStackView = UIStackView()
	
	let store = DataStore.sharedInstance
	let productsView = ProductsViewController()
	var prod: aProduct!
	let prodImageScroll: UIScrollView =
	{
		let view = UIScrollView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.contentMode = .scaleAspectFit
		//iv.sizeToFit()
		return view
	}()
	let prodImage: UIImageView =
	{
		let iv = UIImageView()
		iv.translatesAutoresizingMaskIntoConstraints = false
		iv.contentMode = .scaleAspectFit
		iv.shadowColor = UIColor.gray
		iv.shadowOffset = CGSize(width: 1, height: 1)
		iv.shadowRadius = 3
		iv.shadowOpacity = 0.75
		//iv.sizeToFit()
		return iv
	}()
	let prodName: UILabel =
	{
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.isUserInteractionEnabled = false
		lbl.lineBreakMode = NSLineBreakMode.byTruncatingHead
		//lbl.adjustsFontSizeToFitWidth = true
		lbl.textAlignment = .center
		lbl.backgroundColor = UIColor.white
		lbl.font = R.font.averinaNextBold16//UIFont.init(name: "AvenirNext-Bold", size: 16)//.boldSystemFont(ofSize: 25)
		lbl.textColor = R.color.YumaRed
		lbl.text = R.string.prodName//"Product Name"
		lbl.shadowColor = R.color.YumaYel
		lbl.shadowOffset = CGSize(width: 1, height: 1)
		lbl.shadowRadius = 4.0
		return lbl
	}()
	let prodPrice: UILabel =
	{
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.font = UIFont.systemFont(ofSize: 18)
		lbl.textAlignment = .center
		lbl.text = R.string.prodPrice//"Product Price"
		lbl.backgroundColor = UIColor.white
		lbl.textColor = UIColor.darkGray
		return lbl
	}()
	let add2cart: UIButton =
	{
		let view = UIButton()
		view.translatesAutoresizingMaskIntoConstraints = false
		let mutableAttributedString = NSMutableAttributedString(attributedString: Awesome.solid.shoppingCart.asAttributedText(fontSize: 26, color: UIColor.white, backgroundColor: UIColor.clear))
		mutableAttributedString.addAttributes([NSAttributedStringKey.shadow : R.shadow.YumaRed5_downright1()], range: NSRange(location: 0, length: mutableAttributedString.length))
		let str = NSAttributedString(string: "     \(R.string.add2cart)", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white, NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 21), NSAttributedStringKey.shadow : R.shadow.YumaRed5_downright1(), NSAttributedStringKey.baselineOffset : 2])
		mutableAttributedString.append(str)
		view.setAttributedTitle(mutableAttributedString, for: .normal)
		view.borderWidth = 2
		view.borderColor = R.color.YumaRed
		view.cornerRadius = 2
		view.backgroundColor = R.color.YumaDYel//UIColor(hex: "f8c03f")
		view.shadowColor = UIColor.darkGray
		view.shadowOffset = CGSize(width: 1, height: 1)
		view.shadowRadius = 5
		view.shadowOpacity = 0.9
		return view
	}()
	var tagsStack: UIStackView =
	{
		let view = UIStackView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.axis = .vertical
		view.spacing = 0
		return view
	}()
	var catsStack: UIStackView =
	{
		let view = UIStackView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.axis = .vertical
		view.spacing = 0
		return view
	}()
	var imagesScroll: UIScrollView =
	{
		let view = UIScrollView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	var imagesStack: UIStackView =
	{
		let view = UIStackView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.axis = .vertical
		view.spacing = 0
		return view
	}()
	
	//	let imageView: UIView =
	//	{
	//		let view = UIView()
	//		view.translatesAutoresizingMaskIntoConstraints = false
	//		return view
	//	}()
	//	let imageFrame: UIView =
	//	{
	//		let view = UIView()
	//		view.translatesAutoresizingMaskIntoConstraints = false
	//		return view
	//	}()
	
	let prodManImage: UIImageView =
	{
		let iv = UIImageView()
		iv.translatesAutoresizingMaskIntoConstraints = false
		//		iv.backgroundColor = UIColor.purple
		iv.contentMode = .scaleAspectFit
		return iv
	}()
	let manufacturerName: UILabel =
	{
		let lab = UILabel()
		lab.translatesAutoresizingMaskIntoConstraints = false
		lab.text = ""//Manufacturer: Yuma"
		lab.textColor = UIColor.darkGray
		return lab
	}()
	var manufacturerStack: UIStackView!
	let descLong: UILabel =
	{
		let lab = UILabel()
		lab.translatesAutoresizingMaskIntoConstraints = false
		lab.text = R.string.prodDesc//"description"
		lab.textColor = UIColor.darkGray
		return lab
	}()
	let descShort: UILabel =
	{
		let lab = UILabel()
		lab.translatesAutoresizingMaskIntoConstraints = false
		lab.text = R.string.prodShortDesc//"short description"
		lab.textColor = UIColor.darkGray
		return lab
	}()
	var combinationsStack: UIStackView =
	{
		let view = UIStackView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.axis = .vertical
		view.spacing = 0
		return view
	}()
	var shareStack: UIStackView =
	{
		let view = UIStackView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.axis = .vertical
		view.spacing = 0
		return view
	}()
	var productOptionValuesStack: UIStackView =
	{
		let view = UIStackView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.axis = .vertical
		view.spacing = 0
		return view
	}()
	//	let imagesView:  UICollectionView =
	//	{
	//		let layout = UICollectionViewFlowLayout()
	//		layout.scrollDirection = .horizontal
	//		layout.minimumLineSpacing = 8
	//		let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
	//		view.translatesAutoresizingMaskIntoConstraints = false
	//		view.backgroundColor = UIColor.red
	//		//		view.isPagingEnabled = true
	//		return view
	//	}()
	
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goBack(_:))))
		view.backgroundColor = UIColor.lightGray
		scrollView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
		scrollView.delegate = self	// enable zomming
		setZoomScale()
		setupZoomGestureRecognizer()
		let swipe = SwipingController()
		swipe.getValues()
		//		prepareCollectionViews()
		prepareTags()
		prepareCats()
		prepareMoreImages()
		drawNavigation()
		placeSubviews()
		if prod != nil
		{
			fillProductDetails()
		}
		else
		{
			navigationBar.topItem?.title = R.string.prodName
		}
		//		print(prod)
	}
	
	override func viewDidAppear(_ animated: Bool)
	{
		super.viewDidAppear(animated)
	}
	
	override func viewDidLayoutSubviews()
	{
		//		scrollView.contentSize.width = scrollView.frame.width
		//		print("scrollView frame=\(scrollView.frame), contentSize=\(scrollView.contentSize)")
		//		print("prodImage frame=\(prodImage.frame)")
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	// MARK: Methods
	
	private func prepareTags()
	{
		if prod.associations != nil && prod.associations!.tags != nil && prod.associations!.tags!.count > 0
		{
			tagsStack = productsView.formTagsView(tagIDs: (prod.associations?.tags)!, maxWidth: view.frame.width, maxHeight: 100)
			tagsStack.distribution = .fill
			tagsStack.alignment = .top
		}
	}
	
	private func prepareCats()
	{
		if prod.associations != nil && prod.associations?.categories != nil && (prod.associations?.categories?.count)! > 0
		{
			catsStack = productsView.formCategoriesView(categorieIDs: (prod.associations?.categories)!)
			catsStack.distribution = .fill
			catsStack.alignment = .top
		}
	}
	
	private func prepareMoreImages()
	{
		if self.prod != nil && self.prod.associations != nil && self.prod.associations?.images != nil
		{
			let productsView = ProductsViewController()
			imagesStack = productsView.formImageViews(imageIDs: (prod.associations?.images)!)
			imagesStack.distribution = .fill
			imagesStack.alignment = .top
			//			imagesStack.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 749), for: UILayoutConstraintAxis.horizontal)
			//			imagesStack.setContentHuggingPriority(UILayoutPriority(rawValue: 760), for: UILayoutConstraintAxis.horizontal)
		}
	}
	
	fileprivate func prepareCollectionViews()
	{
		//		tagsCollectionView.register(ProductTagsCollectionViewCell.self, forCellWithReuseIdentifier: tagsCellId)
		//		tagsCollectionView.delegate = self
		//		tagsCollectionView.dataSource = self
		//		catsCollectionView.register(ProductCategoriesCollectionViewCell.self, forCellWithReuseIdentifier: catsCellId)
		//		catsCollectionView.delegate = self
		//		catsCollectionView.dataSource = self
		//		imagesCollectionView.register(ProductImagesCollectionCell.self, forCellWithReuseIdentifier: imagesCellId)
		//		imagesCollectionView.delegate = self
		//		imagesCollectionView.dataSource = self
		//		combinationsView.register(ProductCombinationsCollectionCell.self, forCellWithReuseIdentifier: combinationsCellId)
		//		combinationsView.delegate = self
		//		combinationsView.dataSource = self
		//		shareView.register(ProductShareCollectionCell.self, forCellWithReuseIdentifier: shareCellId)
		//		shareView.delegate = self
		//		shareView.dataSource = self
		//		productOptionValuesView.register(ProductOptionValuesViewCell.self, forCellWithReuseIdentifier: productOptionValuesCellId)
		//		productOptionValuesView.delegate = self
		//		productOptionValuesView.dataSource = self
	}
	
	func viewForZooming(in scrollView: UIScrollView) -> UIView?
	{
		if prodImageScroll == scrollView
		{
			return prodImage
		}
		return nil
	}
	
	func setZoomScale()
	{
		let imageViewSize = prodImage.bounds.size
		let scrollViewSize = prodImageScroll.bounds.size
		let widthScale = scrollViewSize.width / imageViewSize.width
		let heightScale = scrollViewSize.height / imageViewSize.height
		
		prodImageScroll.minimumZoomScale = min(widthScale, heightScale)
		prodImageScroll.zoomScale = 1.0
	}
	
	func scrollViewDidZoom(_ scrollView: UIScrollView)
	{
		if prodImageScroll == scrollView
		{
			let imageViewSize = prodImage.frame.size
			let scrollViewSize = prodImageScroll.bounds.size
			let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
			let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0

			prodImageScroll.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
		}
	}
	
	func setupZoomGestureRecognizer()
	{
		let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
		doubleTap.numberOfTapsRequired = 2
		prodImageScroll.addGestureRecognizer(doubleTap)
	}
	
	@objc func handleDoubleTap(recognizer: UITapGestureRecognizer)
	{
		if (prodImageScroll.zoomScale > prodImageScroll.minimumZoomScale)
		{
			prodImageScroll.setZoomScale(prodImageScroll.minimumZoomScale, animated: true)
		}
		else
		{
			prodImageScroll.setZoomScale(prodImageScroll.maximumZoomScale, animated: true)
		}
	}
	
	func imageFromLayer(_ layer: CALayer) -> UIImage?
	{
		var gradientImage: UIImage?
		UIGraphicsBeginImageContext(layer.frame.size)
		if let context = UIGraphicsGetCurrentContext()
		{
			layer.render(in: context)
			gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: UIImageResizingMode.stretch)
		}
		UIGraphicsEndImageContext()
		return gradientImage
	}
	
	fileprivate func drawNavigation()
	{
/*		let gradient = CAGradientLayer()
		if #available(iOS 11.0, *)
		{
			gradient.frame = CGRect(x: 0, y: view.safeAreaLayoutGuide.layoutFrame.origin.y, width: view.frame.width, height: view.frame.height==812 ? 44 : 20)
		}
		else
		{
			gradient.frame = CGRect(x: 0, y: view.frame.height==812 ? 44 : 20, width: view.frame.width, height: view.frame.height==812 ? 44 : 20)
		}
		gradient.colors = [R.color.YumaDRed.cgColor, R.color.YumaRed.cgColor]
		gradient.startPoint = CGPoint(x: 0, y: 0)
		gradient.endPoint = CGPoint(x: 0, y: 1)
		if let image = imageFromLayer(gradient)
		{
			navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
		}
*/		navigationBar.shadowColor = UIColor.darkGray
		navigationBar.shadowOffset = CGSize(width: 0, height: 2)
		navigationBar.shadowRadius = 3
		navigationBar.shadowOpacity = 1
		navTitle.setLeftBarButton(UIBarButtonItem(customView: backButton), animated: false)
		navigationBar.setItems([navTitle], animated: false)
		if #available(iOS 11.0, *)
		{
		}
		else
		{
			backButton.topAnchor.constraint(equalTo: navigationBar.topAnchor, constant: 0).isActive = true
			backButton.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 0).isActive = true
		}
		//		navigationBar.translatesAutoresizingMaskIntoConstraints = false
		navTitle.setRightBarButton(UIBarButtonItem(image: Awesome.solid.questionCircle.asImage(size: 30), style: UIBarButtonItemStyle.done, target: self, action: #selector(displayHelp(_:))), animated: true)
/*		if UIDevice.current.orientation == UIDeviceOrientation.portrait || UIDevice.current.orientation == .portraitUpsideDown
		{
			view.insertSubview(statusAndNavigationBars, at: 0)
		}
*/	}
	
//	override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator)
//	{
//		super.willTransition(to: newCollection, with: coordinator)
//		if UIDevice.current.orientation.isLandscape
//		{
//			statusAndNavigationBars.removeFromSuperview()
//		}
//		else
//		{
//			view.insertSubview(statusAndNavigationBars, at: 0)
//		}
//		let gradient = CAGradientLayer()
//		if #available(iOS 11.0, *)
//		{
//			gradient.frame = CGRect(x: 0, y: view.safeAreaLayoutGuide.layoutFrame.origin.y, width: view.frame.width, height: view.frame.height==812 ? 44 : 20)
//		}
//		else
//		{
//			gradient.frame = CGRect(x: 0, y: view.frame.height==812 ? 44 : 20, width: view.frame.width, height: view.frame.height==812 ? 44 : 20)
//		}
//		gradient.colors = [R.color.YumaDRed.cgColor, R.color.YumaRed.cgColor]
//		gradient.startPoint = CGPoint(x: 0, y: 0)
//		gradient.endPoint = CGPoint(x: 0, y: 1)
//		if let image = imageFromLayer(gradient)
//		{
//			navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
//		}
//	}
	
	fileprivate func setViews()
	{
		viewPanel.addSubview(scrollView)
		viewPanel.addConstraintsWithFormat(format: "H:|-5-[v0]-5-|", views: scrollView)
		viewPanel.addConstraintsWithFormat(format: "V:|-0-[v0]-5-|", views: scrollView)
		
		stackPanel.addSubview(viewPanel)
		stackPanel.addConstraintsWithFormat(format: "H:|-0-[v0]-0-|", views: viewPanel)
		stackPanel.addConstraintsWithFormat(format: "V:|-0-[v0]-0-|", views: viewPanel)
		
		viewOuter.addSubview(stackPanel)
		viewOuter.addConstraintsWithFormat(format: "H:|-5-[v0]-5-|", views: stackPanel)
		viewOuter.addConstraintsWithFormat(format: "V:|-0-[v0]-5-|", views: stackPanel)
		
		stackAll.addArrangedSubview(navigationBar)
		stackAll.addArrangedSubview(viewOuter)
		
		view.addSubview(stackAll)
		if #available(iOS 11.0, *) {
			stackAll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		} else {
			let topMargin = stackAll.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0)
			topMargin.priority = UILayoutPriority(rawValue: 250)
			topMargin.isActive = true
			let top20 = stackAll.topAnchor.constraint(equalTo: view.topAnchor, constant: 20)
			top20.priority = UILayoutPriority(rawValue: 750)
			top20.isActive = true
		}
		stackAll.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: 0).isActive = true
		stackAll.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: 0).isActive = true
		stackAll.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor, constant: 0).isActive = true
	}
	
	fileprivate func placeSubviews()
	{
		setViews()
		prodImageScroll.addSubview(prodImage)
		NSLayoutConstraint.activate([
			prodImage.topAnchor.constraint(equalTo: prodImageScroll.topAnchor, constant: 0),
			prodImage.leadingAnchor.constraint(equalTo: prodImageScroll.leadingAnchor, constant: 0),
			prodImage.bottomAnchor.constraint(equalTo: prodImageScroll.bottomAnchor, constant: 0),
			prodImage.trailingAnchor.constraint(equalTo: prodImageScroll.trailingAnchor, constant: 0),
			])
		manufacturerStack = UIStackView(arrangedSubviews: [prodManImage, manufacturerName])
		manufacturerStack.distribution = .fillEqually
		imagesScroll.addSubview(imagesStack)
		NSLayoutConstraint.activate([
			imagesStack.topAnchor.constraint(equalTo: imagesScroll.topAnchor, constant: 0),
			//			imagesStack.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 0),
			imagesStack.bottomAnchor.constraint(equalTo: imagesScroll.bottomAnchor, constant: 0),
			//			imagesStack.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 0)
			])
		stack = UIStackView(arrangedSubviews: [prodImageScroll, /*prodImage,*/ prodName, imagesScroll/*imagesStack*/, add2cart, prodPrice, manufacturerStack, catsStack, tagsStack, descLong, descShort, combinationsStack, shareStack, productOptionValuesStack/*, imagesView*/])
		stack.axis = .vertical
		stack.spacing = 10
		scrollView.addSubview(stack)
		prodImageScroll.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 0).isActive = true
		prodImageScroll.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 0).isActive = true
		prodImageScroll.heightAnchor.constraint(equalToConstant: view.frame.width).isActive = true
		//prodName
		add2cart.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: (view.frame.width - max(260, view.frame.width/3))/2).isActive = true	// centre button with min.width = 260
		add2cart.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: -((view.frame.width - max(260, view.frame.width/3))/2)).isActive = true
		add2cart.heightAnchor.constraint(equalToConstant: 50).isActive = true
		//prodPrice
		manufacturerStack.heightAnchor.constraint(equalToConstant: 40).isActive = true
		//		catsCollectionView.heightAnchor.constraint(equalToConstant: 30).isActive = true//red
		//		tagsStack.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 0).isActive = true
		//		tagsStack.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 0).isActive = true
		//		tagsStack.heightAnchor.constraint(equalToConstant: 50).isActive = true
		//		tagsCollectionView.heightAnchor.constraint(equalToConstant: 30).isActive = true//red
		//descLong
		//descShort
		//		combinationsView.heightAnchor.constraint(equalToConstant: 30).isActive = true//red
		//		shareView.heightAnchor.constraint(equalToConstant: 30).isActive = true//red
		//		productOptionValuesView.heightAnchor.constraint(equalToConstant: 30).isActive = true//red
		//		imagesView.heightAnchor.constraint(equalToConstant: 30).isActive = true//red
		
		stack.leadingAnchor.constraint(equalTo: viewPanel.leadingAnchor, constant: 5).isActive = true
		stack.trailingAnchor.constraint(equalTo: viewPanel.trailingAnchor, constant: -5).isActive = true
		
		scrollView.addConstraintsWithFormat(format: "H:|-0-[v0]-0-|", views: stack)
		scrollView.addConstraintsWithFormat(format: "V:|-20-[v0]-10-|", views: stack)
	}
	
	fileprivate func fillProductDetails()
	{
		if prod.availableForOrder == nil || !prod.availableForOrder!
		{
			add2cart.removeFromSuperview()
		}
		//		self.prodName.text = store.valueById(object: prod.name!, id: store.myLang)
		self.prodName.text = prod.name?[store.myLang].value
		navigationBar.topItem?.title = self.prodName.text//prod.name?[store.myLang].value
		//		navigationBar.topItem?.title = store.valueById(object: prod.name!, id: store.myLang)
		if prod.manufacturerName != nil && !prod.manufacturerName!.isEmpty
		{
			manufacturerName.text = "(\(prod.manufacturerName!))"
		}
		if prod.idManufacturer != nil && prod.idManufacturer! > 0
		{
			let imageName = "\(R.string.URLbase)img/m/\(prod.idManufacturer!).jpg"
			store.getImageFromUrl(url: URL(string: imageName)!, session: URLSession(configuration: .default), completion:
				{
					(data, response, error) in
					
					guard let data = data, error == nil else { return }
					DispatchQueue.main.async()
						{
							//							let i = self.view.tag - 10
							let imageToCache = UIImage(data: data)
							self.store.imageDataCache.setObject(imageToCache!, forKey: imageName as AnyObject)
							self.prodManImage.image = imageToCache
							//view.prodImage.image = UIImage(data: data)
							//self.prod_image = data
							//							if i > 0 && i < self.store.products.count
							//							{
							//								self.store.products[i].associations?.imageData = data
							//							}
					}
			})
		}
		//		descLong.text = prod.description?[store.myLang].value
		descLong.attributedText = (prod.description?[store.myLang].value)?.htmlToAttributedString
		//		descShort.text = prod.descriptionShort?[store.myLang].value
		descShort.attributedText = (prod.descriptionShort?[store.myLang].value)?.htmlToAttributedString
		//		if prod.associations?.images != nil
		//		{
		//			prepareMoreImages()
		//		}
		if prod.associations?.imageData != nil	// maion image
		{
			self.prodImage.image = UIImage(data: (prod.associations?.imageData)!)
		}
		else
		{
			let imgName = prod.associations?.images![0].id//primary image
			var imageName = "\(R.string.URLbase)img/p"
			for ch in imgName!
			{
				imageName.append("/\(ch)")
			}
			imageName.append("/\(imgName ?? "").jpg")
			//			if let imageFromCache = store.imageDataCache.object(forKey: imageName as AnyObject)
			//			{
			//				self.prodImage.image = UIImage(data: (imageFromCache as? Data)!)
			//			}
			//			else
			//			{
			store.getImageFromUrl(url: URL(string: imageName)!, session: URLSession(configuration: .default), completion:
				{
					(data, response, error) in
					
					guard let data = data, error == nil else { return }
					DispatchQueue.main.async()
						{
							let i = self.view.tag - 10
							let imageToCache = UIImage(data: data)
							self.store.imageDataCache.setObject(imageToCache!, forKey: imageName as AnyObject)
							self.prodImage.image = imageToCache
							//view.prodImage.image = UIImage(data: data)
							//self.prod_image = data
							if i > 0 && i < self.store.products.count
							{
								self.store.products[i].associations?.imageData = data
							}
					}
			})
			//			}
		}
		if prod.showPrice != nil && prod.showPrice! /*!= "0"*/ && prod.price != nil && prod.price! > 0
		{
			//let prodPrice = NumberFormatter().number(from: prod.price!)?.doubleValue
			let price = prod.price
			self.prodPrice.text = store.formatCurrency(amount: price! as NSNumber, iso: store.locale)
		}
		else
		{
			self.prodPrice.text = R.string.noPrice
		}
		//		if prod.associations != nil && prod.associations?.categories != nil && (prod.associations?.categories?.count)! > 0
		//		{
		//			catsStack = productsView.formCategoriesView(categorieIDs: (prod.associations?.categories)!)
		//			catsStack.distribution = .fill
		//			catsStack.alignment = .top
		//			//			let stack = formCategoriesView(categorieIDs: (prod.associations?.categories)!)
		//			//			self.categoriesView.addArrangedSubview(formCategoriesView(categorieIDs: (prod.associations?.categories)!))
		//			//			self.categoriesView.translatesAutoresizingMaskIntoConstraints = false
		//			//			NSLayoutConstraint.activate([
		//			//				self.categoriesView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
		//			//				self.categoriesView.trailingAnchor.constraint(lessThanOrEqualTo: self.categoriesView.trailingAnchor, constant: 0)
		//			//				])
		//			//			view.addConstraintsWithFormat(format: "H:|[v0]", views: view.categoriesView)
		//			//			view.addConstraintsWithFormat(format: "V:[v0]", views: view.categoriesView)
		//		}
		//		if prod.associations != nil && prod.associations?.tags != nil && (prod.associations?.tags?.count)! > 0
		//		{
		////			let productsView = ProductsViewController()
		//			self.tagsStack = productsView.formTagsView(tagIDs: (prod.associations?.tags)!, maxWidth: view.frame.width, maxHeight: 100)
		//			self.tagsStack.distribution = .fill
		//			self.tagsStack.alignment = .top
		//			//			self.tagsView.translatesAutoresizingMaskIntoConstraints = false
		//			//			formTagsView2(tagIDs: (prod.associations?.tags)!)
		//			//			self.tagsView.addArrangedSubview(collectionTags)
		//		}
		var attrText: NSAttributedString
		if prod.description != nil && store.valueById(object: prod.description!, id: store.myLang) != nil//prod.description![store.myLang].value != nil
		{
			attrText = try! NSAttributedString(
				data: (store.valueById(object: prod.description!, id: store.myLang)?.data(using: .utf8, allowLossyConversion: true)!)!,//prod.description![store.myLang].value?.data(using: String.Encoding.utf8, allowLossyConversion: true)!)!,
				options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
				documentAttributes: nil)
			self.descLong.attributedText = attrText
			self.descLong.textColor = UIColor.gray
			self.descLong.numberOfLines = 0
			self.descLong.lineBreakMode = NSLineBreakMode.byTruncatingTail
			self.descLong.sizeToFit()
		}
		if prod.descriptionShort != nil && store.valueById(object: prod.descriptionShort!, id: store.myLang) != nil//prod.descriptionShort![store.myLang].value != nil
		{
			attrText = try! NSAttributedString(
				data: (store.valueById(object: prod.descriptionShort!, id: store.myLang)?.data(using: .utf8, allowLossyConversion: true)!)!,//)(prod.descriptionShort![store.myLang].value?.data(using: String.Encoding.utf8, allowLossyConversion: true)!)!,
				options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,],
				documentAttributes: nil)
			self.descShort.attributedText = attrText
			self.descShort.textColor = UIColor.gray
			self.descShort.numberOfLines = 0
			self.descShort.lineBreakMode = NSLineBreakMode.byTruncatingTail
			self.descShort.sizeToFit()
		}
		//				view.linkRewrite = prod.link_rewrite![store.myLang].value!
		if prod.associations != nil && prod.associations?.combinations != nil && (prod.associations?.combinations?.count)! > 0
		{
			//			self.combinationsView.addArrangedSubview(formCombinationView(combinationsIDs: (prod.associations?.combinations)!))
		}
		if prod.associations != nil && prod.associations?.images != nil && (prod.associations?.images?.count)! > 0
		{
			//			self.imagesView.addArrangedSubview(formImageViews(imageIDs: (prod.associations?.images)!))
		}
		if prod.associations != nil && prod.associations?.product_option_values != nil && (prod.associations?.product_option_values?.count)! > 0
		{
			//			self.productOptionValuesView.addArrangedSubview(formProductOptionValues(ValueIDs: (prod.associations?.product_option_values)!))
		}
		add2cart.addTapGestureRecognizer {
			if self.prod.name != nil
			{
				print("TODO: add prod \"\(self.prod.name![self.store.myLang].value!)\" to cart")
			}
			else
			{
				print("TODO: add prod to cart")
			}
		}
	}
	
	
	// MARK: Actions
	
	@objc func goBack(_ sender: UITapGestureRecognizer)
	{
		self.dismiss(animated: true, completion: nil)
	}
	
	@objc func displayHelp(_ sender: UITapGestureRecognizer)
	{
		let viewC = Assistance()
		viewC.array 					= R.array.help_product_details_guide
		viewC.title 					= "\(R.string.prod.capitalized) \(R.string.help.capitalized)"
		viewC.modalTransitionStyle   	= .crossDissolve
		viewC.modalPresentationStyle 	= .overCurrentContext
		self.present(viewC, animated: true, completion: nil)
	}
	
}
