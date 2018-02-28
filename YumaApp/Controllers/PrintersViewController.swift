//
//  PrintersViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-05.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class PrintersViewController: UIViewController
{
	@IBOutlet weak var backgroungImage: UIImageView!
	@IBOutlet weak var pageControll: UIPageControl!
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var navBar: UINavigationBar!
	@IBOutlet weak var labelLeft: UILabel!
	@IBOutlet weak var labelCenter: UILabel!
	@IBOutlet weak var labelRight: UILabel!
	@IBOutlet weak var add2CartBtn: GradientButton!
	var printersDictionary: NSDictionary?
	var products: NSDictionary?
	var store = DataStore.sharedInstance
	

	override func viewDidLoad()
	{
        super.viewDidLoad()
		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
		add2CartBtn.layer.addGradienBorder(colors: [R.color.YumaYel, R.color.YumaRed], width: 4, isVertical: true)
		refresh()
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

	
	@IBAction func addToCartBtnAct(_ sender: Any) {
	}


	@IBAction func closeView(sender: AnyObject)
	{
		self.dismiss(animated: true, completion: nil)
	}
	
	func refresh()
	{
		let sv = UIViewController.displaySpinner(onView: self.view)
		labelLeft.text = ""
		labelCenter.text = "\(R.string.updating) ..."
		labelRight.text = ""
		pageControll.isHidden = true
//		store.callGetPrinters2(completion:
		store.callGetPrinters(completion:
//		store.getPrinters3(completion:
			{
			(printers) in
//		PSWebServices.getPrinters(completionHandler: { (printers) in
			UIViewController.removeSpinner(spinner: sv)
//		PSWebServices.getPrinters2(completionHandler: { (printers) in
			//print("got \(printers) printers")
			
			//UILabel.text must be used from main thread only
			self.labelLeft.text = " \(R.string.updated)"
			self.labelCenter.text = FontAwesome.repeat.rawValue
			self.labelCenter.font = R.font.FontAwesomeOfSize(pointSize: 30)
			let date = Date()
			let df = DateFormatter()
			df.locale = Locale(identifier: "en_CA")
			df.dateFormat = "dd MMM YYYY  h:mm:ss a"
			self.labelRight.text = "\(df.string(from: date)) "
			self.pageControll.isHidden = false
			//self.haveJSON(printers)
			}
		)
	}

//	func haveJSON(_ printers: [aProduct])
//	{
//		print(printers)
//	}

}
