//
//  ContactUsViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-04.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class ContactUsViewController: UIViewController {
	
	//	var myCustomView: UserCoinView?
	
	//	override func viewDidLayoutSubviews() {
	//		super.viewDidLayoutSubviews()
	//		if myCustomView == nil { // make it only once
	//			myCustomView = Bundle.mainBundle().loadNibNamed("UserCoinView", owner: self, options: nil).first as? UserCoinView
	//myCustomView.frame = ...
	//				self.view.addSubview(myCustomView) // you can omit 'self' here
	// if your app support both Portrait and Landscape orientations
	// you should add constraints here
	//		}
	//	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		
		//let header = UINib(nibName: "myHeader", bundle: nil).instantiate(withOwner: nil, options: nil) as! YumaHeader
		//let headerView: header = header(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 280, width: UIScreen.main.bounds.size.width, height: 280))
		
		//let headerView = Bundle.main.loadNibNamed("header", owner: self, options: nil)?.first as? SectionHeaderView
		//headerView?.frame = CGRect(x:0, y: 0, width: view.frame.width, height: 50.0)
		let mainStack = UIStackView()
		mainStack.axis = UILayoutConstraintAxis.vertical
		mainStack.distribution = UIStackViewDistribution.fill
		mainStack.spacing = 0
		
		//let header = UITableView()
		//header.register(UINib(nibName: "myheader", bundle: nil), forHeaderFooterViewReuseIdentifier: "myheader")
//		let titleStack = UIStackView()
//		titleStack.backgroundColor = UIColor.red
//		titleStack.axis = UILayoutConstraintAxis.horizontal
//		titleStack.distribution = UIStackViewDistribution.fill
//		titleStack.spacing = 16
//
//		let label = UILabel()
//		label.font = UIFont(name: "FontAwesome", size: 40)
//		label.text = FontAwesome.chevronCircleLeft.rawValue
//		label.backgroundColor = UIColor.red
//		//label.textColor = UIColor!.yellow
//		label.layoutMargins.left = 8.0
//		label.layoutMargins.top = 16
//		label.layoutMargins.bottom = 16
//		//label.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
//		//label.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
//
//		let label2 = UILabel()
//		label2.font = UIFont(name: label.font.fontName, size: 26)
//		label2.text = "Contact Us"
//		//label2.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
//		//label2.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
//
//		titleStack.addArrangedSubview(label)
//		titleStack.addArrangedSubview(label2)
//		label.centerYAnchor.constraint(equalTo: titleStack.centerYAnchor).isActive = true
//		label2.centerYAnchor.constraint(equalTo: titleStack.centerYAnchor).isActive = true
//		titleStack.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
//		titleStack.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
//
//		mainStack.addArrangedSubview(titleStack)
		
		//let YumaHeader = UIView()
		//YumaHeader.addSubview(UINib(nibName: "YumaHeader", bundle: Bundle.main))
		//mainStack.addArrangedSubview(YumaHeader)
		//mainStack.addArrangedSubview(header)
		//mainStack.addSubview(headerView)
		let blank = UIView()
		blank.backgroundColor = R.color.YumaRed
		mainStack.addArrangedSubview(blank)
		mainStack.translatesAutoresizingMaskIntoConstraints = false
		mainStack.backgroundColor = UIColor.blue
		
		self.view.addSubview(mainStack)
		//view.backgroundColor = UIColor.green
		mainStack.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
		
		mainStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
	}
	
	@IBAction func closeView(sender: AnyObject)
	{
		self.dismiss(animated: true, completion: nil)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		//let dest = segue.destination as! ContactUsViewController
		// Pass the selected object to the new view controller.
	}
	
	
//	func tableView(_ tableView: UITableView, viewForHeaderFooterInSection section: Int) -> UIView? {
//		let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MyHeader") as! MyHeader
//		headerView.label.text = "Contact"
//		return headerView
//	}
}

