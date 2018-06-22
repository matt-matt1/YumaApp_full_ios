//
//  MD5Method.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-06-18.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import Foundation


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



import UIKit


/// Display an alert dialog where the only choice is DISMISS - dismissAction closure done on press
func myAlertOnlyDismiss(_ self: UIViewController, title: String, message: String, dismissAction: (() -> Void)? = nil, completion: (() -> Void)? = nil)
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
		alert.addAction(UIAlertAction(title: R.string.dismiss.uppercased(), style: .default, handler:
		{ 	(action) in
			coloredBG.removeFromSuperview()
			blurFxView.removeFromSuperview()
			//								self.dismiss(animated: false, completion: nil)
			if dismissAction != nil
			{
				_ = dismissAction
			}
		}))
		DispatchQueue.main.async
		{
			self.present(alert, animated: true, completion:
			{
				if completion != nil
				{
					_ = completion
				}
			})
		}
	}
}


/// Display an alert dialog where the only choices are OK & Cancel - okAction closure done on OK press - cancelAction closure done on CANCEL press
func myAlertOKCancel(_ self: UIViewController, title: String, message: String, okAction: (() -> Void)?, cancelAction: (() -> Void)? = nil, completion: (() -> Void)? = nil)
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
		alert.addAction(UIAlertAction(title: R.string.ok.uppercased(), style: .default, handler:
		{ 	(action) in
			coloredBG.removeFromSuperview()
			blurFxView.removeFromSuperview()
			if okAction != nil
			{
				_ = okAction
			}
		}))
		alert.addAction(UIAlertAction(title: R.string.cancel.uppercased(), style: .default, handler:
		{ 	(action) in
			coloredBG.removeFromSuperview()
			blurFxView.removeFromSuperview()
			//								self.dismiss(animated: false, completion: nil)
			if cancelAction != nil
			{
				_ = cancelAction
			}
		}))
		self.present(alert, animated: true, completion:
		{
			if completion != nil
			{
				_ = completion
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



