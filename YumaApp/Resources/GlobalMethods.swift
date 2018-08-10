//
//  MD5Method.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-06-18.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit
import OHHTTPStubs


/// Disconnects network activity
//https://github.com/AliSoftware/OHHTTPStubs/wiki/Usage-Examples
func networkActivityDisconnect() //-> OHHTTPStubsResponse
{
	stub(condition: isHost("yumatechnical.com")) 	{ 	_ in
		let notConnectedError = NSError(domain: NSURLErrorDomain, code: URLError.notConnectedToInternet.rawValue)
		return OHHTTPStubsResponse(error:notConnectedError)
	}
}
func networkActivityMakeResponseSlow()
{
	stub(condition: isHost("yumatechnical.com")) 	{ 	_ in
		return OHHTTPStubsResponse().responseTime(OHHTTPStubsDownloadSpeed3G)/*(data: NSData() as Data, statusCode: 200, headers: nil)*/
//			.responseTime(OHHTTPStubsDownloadSpeed3G)
	}
//	stub(condition: { (urlRequest) -> Bool in
//		return true
//	}) { (urlRequest2) -> OHHTTPStubsResponse in
//		return OHHTTPStubsResponse.init()
//	}
}


/// Returns a string coded with MD5 technology
func md5(_ string: String) -> String
{
	let context = UnsafeMutablePointer<CC_MD5_CTX>.allocate(capacity: 1)
	var digest = Array<UInt8>(repeating:0, count:Int(CC_MD5_DIGEST_LENGTH))
	CC_MD5_Init(context)
	CC_MD5_Update(context, string, CC_LONG(string.lengthOfBytes(using: String.Encoding.utf8)))
	CC_MD5_Final(&digest, context)
	context.deallocate()
	var hexString = ""
	for byte in digest
	{
		hexString += String(format:"%02x", byte)
	}
	return hexString
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



/// Display an alert dialog where the only choice is DISMISS - dismissAction closure done on press
func myAlertOnlyDismiss(_ self: UIViewController, title: String, message: String, dismissTitle: String? = nil, dismissAction: (() -> Void)? = nil, completion: (() -> Void)? = nil)
{
	myAlertDialog(self, title: title, message: message, cancelTitle: (dismissTitle != nil) ? dismissTitle : R.string.dismiss.uppercased(), cancelAction: dismissAction, okTitle: nil, okAction: nil, completion: completion)
}


/// Display an alert dialog where the only choices are OK & Cancel - okAction closure done on OK press - cancelAction closure done on CANCEL press
func myAlertOKCancel(_ self: UIViewController, title: String, message: String, okAction: (() -> Void)?, cancelAction: (() -> Void)? = nil, completion: (() -> Void)? = nil)
{
	myAlertDialog(self, title: title, message: message, cancelTitle: R.string.cancel.uppercased(), cancelAction: cancelAction, okTitle: R.string.ok.uppercased(), okAction: okAction, completion: completion)
}


/// Complete Alert method to issue a dialog with a specific title, message and button names (with their respective actions)
func myAlertDialog(_ self: 			UIViewController,
				   title: 			String,
				   message: 		String,
				   cancelTitle: 	String? = 		R.string.cancel.uppercased(),
				   cancelAction: 	(() -> Void)? = nil,
				   okTitle: 		String? = 		R.string.ok.uppercased(),
				   okAction: 		(() -> Void)? = nil,
				   completion: 		(() -> Void)? = nil)
{
	OperationQueue.main.addOperation
		{
			let alert = 					UIAlertController(title: title, message: message, preferredStyle: .alert)
			let coloredBG = 				UIView()
			let blurFx = 					UIBlurEffect(style: .dark)
			let blurFxView = 				UIVisualEffectView(effect: blurFx)
			alert.titleAttributes = 		[NSAttributedString.StringAttribute(key: .foregroundColor, value: R.color.YumaRed)]
			alert.messageAttributes = 		[NSAttributedString.StringAttribute(key: .foregroundColor, value: UIColor.darkGray)]
			alert.view.superview?.backgroundColor = R.color.YumaRed
			alert.view.shadowColor = 		R.color.YumaDRed
			alert.view.shadowOffset = 		.zero
			alert.view.shadowRadius = 		5
			alert.view.shadowOpacity = 		1
			alert.view.backgroundColor = 	R.color.YumaYel
			alert.view.cornerRadius = 		15
			coloredBG.backgroundColor = 	R.color.YumaRed
			coloredBG.alpha = 				0.4
			coloredBG.frame = 				self.view.bounds
			self.view.addSubview(coloredBG)
			blurFxView.frame = 				self.view.bounds
			blurFxView.alpha = 				0.5
			blurFxView.autoresizingMask = 	[.flexibleWidth, .flexibleHeight]
			self.view.addSubview(blurFxView)
			alert.addAction(UIAlertAction(title: cancelTitle/*R.string.cancel.uppercased()*/, style: .default, handler:
				{ 	(action) in
					coloredBG.removeFromSuperview()
					blurFxView.removeFromSuperview()
					if cancelAction != nil
					{
						cancelAction!()
					}
			}))
			if okTitle != nil && okAction != nil
			{
				alert.addAction(UIAlertAction(title: okTitle/*R.string.ok.uppercased()*/, style: .default, handler:
				{ 	(action) in
					coloredBG.removeFromSuperview()
					blurFxView.removeFromSuperview()
					if okAction != nil
					{
						okAction!()
					}
				}))
			}
			self.present(alert, animated: true, completion:
				{
					if completion != nil
					{
						completion!()
					}
			})
	}
}


func matches(for regex: String, in text: String) -> [String]
{
	do
	{
		let regex = try NSRegularExpression(pattern: regex)
		let results = regex.matches(in: text,
									range: NSRange(text.startIndex..., in: text))
		return results.map {
			String(text[Range($0.range, in: text)!])
		}
	}
	catch let error
	{
		print("invalid regex: \(error.localizedDescription)")
		return []
	}
}


func showVC(_ viewController: UIViewController, completion: (() -> Void)?=nil)
{
	let window = UIApplication.shared.keyWindow
	let rootViewController = window?.rootViewController
	rootViewController?.present(viewController, animated: true, completion: completion != nil ? completion : nil)
}
