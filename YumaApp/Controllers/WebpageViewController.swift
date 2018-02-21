//
//  WebpageViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-02-11.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class WebpageViewController: UIViewController, UIWebViewDelegate
{
	@IBOutlet weak var navBar: UINavigationBar!
	@IBOutlet weak var navTitle: UINavigationItem!
	@IBOutlet weak var navClose: UIBarButtonItem!
	@IBOutlet weak var navHelp: UIBarButtonItem!
	//@IBOutlet weak var webView: WKWebView!//Use of undeclared type 'WKWebView'
	@IBOutlet weak var webView: UIWebView!
	
	var pageTitle: String = ""
	var pageURL: String = ""
	
	
	override func viewDidAppear(_ animated: Bool)
	{
		self.navigationItem.title = self.pageTitle
		navTitle.title = self.pageTitle
		webView.loadRequest(URLRequest(url: URL(string: self.pageURL)!))
	}
	
	
	override func viewDidLoad()
	{
        super.viewDidLoad()
		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
        webView.delegate = self
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

	@IBAction func closeView(sender: AnyObject)
	{
		self.dismiss(animated: true, completion: nil)
	}
	
	
//	func loadWebpage(URLstring: String)
//	{
//		if let requestURL = URL(string: URLstring)
//		{
//			let request = URLRequest(url: requestURL)
//			webView.loadRequest(request)
//		}
//	}
	func loadWebpage(URLstring: String)
	{
		self.pageURL = URLstring
//		if let requestURL = URL(string: URLstring)
//		{
//			let request = URLRequest(url: requestURL)
//			webView.loadRequest(request)
//		}
	}

	func setTitle(string: String)
	{
//		if let title = String(string?)
//		{
			self.pageTitle = string
//		}
	}
	
}
