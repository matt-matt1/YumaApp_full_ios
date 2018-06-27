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
	@IBOutlet weak var allStack: UIStackView!
	@IBOutlet weak var allView: UIView!
	@IBOutlet weak var closeView: UIView!
	@IBOutlet weak var closeIcon: UILabel!
	@IBOutlet weak var activityLabel: UILabel!
//	@IBOutlet weak var navBar: UINavigationBar!
//	@IBOutlet weak var navTitle: UINavigationItem!
//	@IBOutlet weak var navClose: UIBarButtonItem!
//	@IBOutlet weak var navHelp: UIBarButtonItem!
	//@IBOutlet weak var webView: WKWebView!//Use of undeclared type 'WKWebView'
	@IBOutlet weak var webView: UIWebView!
	@IBOutlet weak var activitySpinner: UIActivityIndicatorView!
	
	var pageTitle: String = ""
	var pageURL: String = ""
	//private var activitySpinner = UIActivityIndicatorView()
	
	
	override func viewDidAppear(_ animated: Bool)
	{
		//progress.translatesAutoresizingMaskIntoConstraints = false
		//progress.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		//progress.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		activitySpinner.tintColor = R.color.YumaRed
		activitySpinner.hidesWhenStopped = true
		if #available(iOS 11.0, *)
		{
			allStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		}
		else
		{
			allStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
		}
		self.navigationItem.title = self.pageTitle
		//navTitle.title = (pageTitle == "") ? R.string.our_bus : pageTitle
		activityLabel.text = (pageTitle == "") ? R.string.our_bus : pageTitle
		closeIcon.font = R.font.FontAwesomeOfSize(pointSize: 22)
		closeIcon.text = FontAwesome.times.rawValue//.windowCloseO.rawValue
		if Reachability.isConnectedToNetwork()
		{
			webView.delegate = self
			if pageURL == ""
			{
				webView.loadRequest(URLRequest(url: URL(string: R.string.our_web)!))
			}
			else
			{
				webView.loadRequest(URLRequest(url: URL(string: self.pageURL)!))
			}
		}
		else
		{
			myAlertOnlyDismiss(self, title: R.string.internet, message: R.string.no_connect)
//			let alert = UIAlertController(title: R.string.internet, message: R.string.no_connect, preferredStyle: .alert)
//			alert.addAction(UIAlertAction(title: R.string.dismiss, style: .default, handler: nil))
//			self.present(alert, animated: false, completion: {
//				self.dismiss(animated: false, completion: nil)
//			})
		}
	}
	
	func webViewDidStartLoad(_ webView: UIWebView)
	{
		activitySpinner.startAnimating()
//		let alert = UIAlertController()
//		alert.title = R.string.err
//		alert.message = "start"
//		alert.show(self, sender: self)
	}
	
	func webViewDidFinishLoad(_ webView: UIWebView)
	{
		activitySpinner.stopAnimating()
		activityLabel.isHidden = true
	}
	
	func webView(_ webView: UIWebView, didFailLoadWithError error: Error)
	{
		activitySpinner.stopAnimating()
//		let alert = UIAlertController()
//		alert.title = R.string.err
//		alert.message = error.localizedDescription
//		alert.show(self, sender: self)
		//view.addSubview(alert)
	}
	
	
	override func viewDidLoad()
	{
        super.viewDidLoad()
//		if #available(iOS 11.0, *) {
//			navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//		} else {
//			navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
//		}
//		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
		closeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeView(sender:))))
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
