//
//  R.story.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-06-18.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


extension R
{
	struct story
	{
		static let main = UIStoryboard(name: "Main", bundle: nil)
		static let launchScreen = UIStoryboard(name: "LaunchScreen", bundle: nil)
		static let laps = UIStoryboard(name: "Laptops", bundle: nil)
		
		//static let main = _R.storyboard.main()
		
		//		static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
		//			return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
		//		}
		//
		//		static func main(_: Void = ()) -> UIKit.UIStoryboard {
		//			return UIKit.UIStoryboard(resource: R.storyboard.main)
		//		}
		
		fileprivate init() {}
	}

}
