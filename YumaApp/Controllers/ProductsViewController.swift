//
//  ProductsViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-03.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController
{
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var navBar: UINavigationBar!
	@IBOutlet weak var navTitle: UINavigationItem!
	@IBOutlet weak var navClose: UIBarButtonItem!
	@IBOutlet weak var navHelp: UIBarButtonItem!
	@IBOutlet weak var backgroungImage: UIImageView!
	@IBOutlet weak var pageControl: UIPageControl!
	@IBOutlet weak var labelLeft: UILabel!
	@IBOutlet weak var labelCenter: UILabel!
	@IBOutlet weak var labelRight: UILabel!
	@IBOutlet weak var add2CartBtn: GradientButton!
	var store = DataStore.sharedInstance
	let cellID = "productCell"
	var pageTitle: String = R.string.prod
	var pageImage: UIImage = #imageLiteral(resourceName: "logo")
	
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		if #available(iOS 11.0, *)
		{
			navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		}
		else
		{
			navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
		}
		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
		add2CartBtn.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		navTitle.title = pageTitle
		backgroungImage.image = pageImage
		refresh()
		labelCenter.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(refresh)))
	}
	
	override func viewDidAppear(_ animated: Bool)
	{
		//let headerView: header = header(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 280, width: UIScreen.main.bounds.size.width, height: 280))
		
		//let headerView = Bundle.main.loadNibNamed(\"header\", owner: self, options: nil)?.first as? SectionHeaderView
		//headerView?.frame = CGRect(x:0, y: 0, width: view.frame.width, height: 50.0)
		//		let mainStack = UIStackView()
		//		mainStack.axis = UILayoutConstraintAxis.vertical
		//		mainStack.distribution = UIStackViewDistribution.fill
		//		mainStack.spacing = 0
		//
		//		let titleStack = UIStackView()
		//		titleStack.axis = UILayoutConstraintAxis.horizontal
		//		titleStack.distribution = UIStackViewDistribution.fill
		//		titleStack.backgroundColor = R.color.YumaRed
		//
		//		let back = UIButton()
		//		let backLabel = UILabel()
		//		backLabel.text = FontAwesome.chevronCircleLeft.rawValue
		//		backLabel.font = UIFont(name: "FontAwesome", size: 40)
		//		backLabel.textColor = R.color.YumaYel
		//		backLabel.shadowColor = R.color.YumaDRed
		//		backLabel.shadowOffset = CGSize(width: 1, height: 1)
		//		backLabel.translatesAutoresizingMaskIntoConstraints = false
		//		backLabel.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
		//		//backLabel.widthAnchor.constraint(equalToConstant: titleStack.frame.width).isActive = true
		//		backLabel.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
		//		back.addSubview(backLabel)
		//
		//		titleStack.addSubview(back)
		//
		//		let label = UILabel()
		//		label.text = R.string.printers
		//		label.textColor = R.color.YumaYel
		//		label.backgroundColor = R.color.YumaRed
		//label.widthAnchor.constraint(equalToConstant: titleStack.frame.width).isActive = true
		//label.widthAnchor.constraint(equalToConstant: 20.0).isActive = true
		//label.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
		
		//		titleStack.addSubview(label)
		//
		//		mainStack.addArrangedSubview(titleStack)
		//		//mainStack.addSubview(headerView)
		//		mainStack.translatesAutoresizingMaskIntoConstraints = false
		//		mainStack.backgroundColor = UIColor.white
		//
		//		self.view.addSubview(mainStack)
		//		view.backgroundColor = UIColor.white
		//		mainStack.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
		//		mainStack.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
		//		mainStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
		//		titleStack.centerXAnchor.constraint(equalTo: mainStack.centerXAnchor).isActive = true
		//		titleStack.topAnchor.constraint(equalTo: mainStack.topAnchor).isActive = true
		//		titleStack.widthAnchor.constraint(equalTo: mainStack.widthAnchor).isActive = true
	}
	
	override func viewWillAppear(_ animated: Bool)
	{
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
	}
	
	@IBAction func closeView(sender: AnyObject)
	{
		self.dismiss(animated: true, completion: nil)
	}
	
	@IBAction func navHelpAct(_ sender: Any)
	{
	}
	
	@objc func refresh()
	{
		let sv = UIViewController.displaySpinner(onView: self.view)
		labelLeft.text = ""
		labelCenter.text = "\(R.string.updating) ..."
		labelRight.text = ""
		pageControl.isHidden = true
		let completeionFunc: (Any) -> Void =
		{
			(products) in

			UIViewController.removeSpinner(spinner: sv)
			self.labelLeft.text = " \(R.string.updated)"
			self.labelCenter.text = FontAwesome.repeat.rawValue
			self.labelCenter.font = R.font.FontAwesomeOfSize(pointSize: 21)
			let date = Date()
			let df = DateFormatter()
			df.locale = Locale(identifier: "en_CA")
			df.dateFormat = "dd MMM YYYY  h:mm:ss a"
			self.labelRight.text = "\(df.string(from: date)) "
			self.pageControl.isHidden = false
			self.pageControl.numberOfPages = self.store.products.count
			//put results into product cells
			print("found \(self.store.products.count) products")
			self.collectionView.collectionViewLayout.invalidateLayout()
		}
		switch pageTitle
		{
		case R.string.printers:
			store.callGetPrinters(completion: completeionFunc)
			break
		case R.string.laptops:
			store.callGetLaptops(completion: completeionFunc)
			break
		case R.string.toners:
			store.callGetToners(completion: completeionFunc)
			break
		case R.string.services:
			store.callGetServices(completion: completeionFunc)
			break
		default:
			print("bad instantantion of products VC")
		}
	}
	
}


extension ProductsViewController: UICollectionViewDataSource, UICollectionViewDelegate
{
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		return store.products.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ProductViewCell
		cell.page = store.products[indexPath.item]
		return cell
	}
	
	
}
